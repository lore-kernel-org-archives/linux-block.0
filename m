Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 04/11] fs: add support for allowing applications to pass
 in write life time hints
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com
References: <1497729594-4707-1-git-send-email-axboe@kernel.dk>
 <1497729594-4707-5-git-send-email-axboe@kernel.dk>
 <20170619062706.GC2311@infradead.org>
 <b04642e6-4ecc-f2e8-8184-6fff302d3d0b@kernel.dk>
 <8db675e7-b868-bae1-784a-33cba67d0874@kernel.dk>
 <20170619185805.GC32047@infradead.org>
 <5259a1ba-1c5f-2d89-3b47-3a81cd0a3e4e@kernel.dk>
 <0c3c6a33-77c5-337e-66e0-49fe22d3cc4e@kernel.dk>
Message-ID: <3e6f7b97-8372-b268-f55a-cc88812c1a68@kernel.dk>
Date: Mon, 19 Jun 2017 14:33:41 -0600
MIME-Version: 1.0
In-Reply-To: <0c3c6a33-77c5-337e-66e0-49fe22d3cc4e@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/19/2017 01:10 PM, Jens Axboe wrote:
> On 06/19/2017 01:00 PM, Jens Axboe wrote:
>> On 06/19/2017 12:58 PM, Christoph Hellwig wrote:
>>> On Mon, Jun 19, 2017 at 10:02:09AM -0600, Jens Axboe wrote:
>>>> Actually, one good use case is O_DIRECT on a block device. Since I'm
>>>> not a huge fan of having per-call hints that is only useful for a
>>>> single case, how about we add the hints to the struct file as well?
>>>> For buffered IO, just grab it from the inode. If we have a file
>>>> available, then that overrides the per-inode setting.
>>>
>>> Even for buffered I/O per-fіle would seem more useful to be honest.
>>> For the buffer_head based file systems this could even be done fairly
>>> easily.
>>
>> If I add the per-file hint as well, then anywhere that has the file should
>> just grab it from there. Unless not set, then grab from inode.
>>
>> That does raise an issue with the NONE hint being 0. We can tell right now
>> if NONE was set, or nothing was set. This becomes a problem if we want the
>> file hint to override the inode hint. Should probably just bump the values
>> up by one, so that NONE is 1, SHORT is 2, etc.
> 
> Actually, we don't have to, as long as the file inherits the inode mask.
> Then we can just use the file hint if it differs from the inode hint.

That doesn't work, in case it's cleared, or for checking whether it has
been set or not. Oh well, I added a NOT_SET variant for this. See below
for an incremental that adds support for file write hints as well. Use
the file write hint, if we have it, otherwise use the inode provided
one.

Setting hints on a file propagates to the inode, only if the inode doesn't
currently have a hint set.


diff --git a/fs/fcntl.c b/fs/fcntl.c
index 113b78c11631..34ca821767a0 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -247,12 +247,16 @@ static long fcntl_rw_hint(struct file *file, unsigned int cmd,
 			  u64 __user *ptr)
 {
 	struct inode *inode = file_inode(file);
+	u64 old_hint, hint;
 	long ret = 0;
-	u64 hint;
 
 	switch (cmd) {
 	case F_GET_RW_HINT:
-		hint = mask_to_write_hint(inode->i_flags, S_WRITE_LIFE_SHIFT);
+		if (file->f_write_hint != WRITE_LIFE_NOT_SET)
+			hint = file->f_write_hint;
+		else
+			hint = mask_to_write_hint(inode->i_flags,
+							S_WRITE_LIFE_SHIFT);
 		if (put_user(hint, ptr))
 			ret = -EFAULT;
 		break;
@@ -267,7 +271,15 @@ static long fcntl_rw_hint(struct file *file, unsigned int cmd,
 		case WRITE_LIFE_MEDIUM:
 		case WRITE_LIFE_LONG:
 		case WRITE_LIFE_EXTREME:
-			inode_set_write_hint(inode, hint);
+			spin_lock(&file->f_lock);
+			file->f_write_hint = hint;
+			spin_unlock(&file->f_lock);
+
+			/* Only propagate hint to inode, if no hint is set */
+			old_hint = mask_to_write_hint(inode->i_flags,
+							S_WRITE_LIFE_SHIFT);
+			if (old_hint == WRITE_LIFE_NOT_SET)
+				inode_set_write_hint(inode, hint);
 			ret = 0;
 			break;
 		default:
diff --git a/fs/inode.c b/fs/inode.c
index defb015a2c6d..e4a4e123d52b 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -134,7 +134,7 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 
 	inode->i_sb = sb;
 	inode->i_blkbits = sb->s_blocksize_bits;
-	inode->i_flags = 0;
+	inode->i_flags = S_WRITE_LIFE_MASK;
 	atomic_set(&inode->i_count, 1);
 	inode->i_op = &empty_iops;
 	inode->i_fop = &no_open_fops;
diff --git a/fs/open.c b/fs/open.c
index cd0c5be8d012..3fe0c4aa7d27 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -759,6 +759,7 @@ static int do_dentry_open(struct file *f,
 	     likely(f->f_op->write || f->f_op->write_iter))
 		f->f_mode |= FMODE_CAN_WRITE;
 
+	f->f_write_hint = WRITE_LIFE_NOT_SET;
 	f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
 
 	file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8720251cc153..e81bdb8ec189 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -859,6 +859,7 @@ struct file {
 	 * Must not be taken from IRQ context.
 	 */
 	spinlock_t		f_lock;
+	unsigned int		f_write_hint;
 	atomic_long_t		f_count;
 	unsigned int 		f_flags;
 	fmode_t			f_mode;
@@ -1902,7 +1903,9 @@ enum rw_hint {
 	WRITE_LIFE_SHORT = RWH_WRITE_LIFE_SHORT,
 	WRITE_LIFE_MEDIUM = RWH_WRITE_LIFE_MEDIUM,
 	WRITE_LIFE_LONG = RWH_WRITE_LIFE_LONG,
-	WRITE_LIFE_EXTREME = RWH_WRITE_LIFE_EXTREME
+	WRITE_LIFE_EXTREME = RWH_WRITE_LIFE_EXTREME,
+
+	WRITE_LIFE_NOT_SET = 7,
 };
 
 static inline unsigned int write_hint_to_mask(enum rw_hint hint,
@@ -1917,12 +1920,25 @@ static inline enum rw_hint mask_to_write_hint(unsigned int mask,
 	return (mask >> shift) & 0x7;
 }
 
-static inline unsigned int inode_write_hint(struct inode *inode)
+static inline enum rw_hint inode_write_hint(struct inode *inode)
 {
-	if (inode)
-		return mask_to_write_hint(inode->i_flags, S_WRITE_LIFE_SHIFT);
+	enum rw_hint ret = WRITE_LIFE_NONE;
 
-	return 0;
+	if (inode) {
+		ret = mask_to_write_hint(inode->i_flags, S_WRITE_LIFE_SHIFT);
+		if (ret == WRITE_LIFE_NOT_SET)
+			ret = WRITE_LIFE_NONE;
+	}
+
+	return ret;
+}
+
+static inline enum rw_hint file_write_hint(struct file *file)
+{
+	if (file->f_write_hint != WRITE_LIFE_NOT_SET)
+		return file->f_write_hint;
+
+	return inode_write_hint(file_inode(file));
 }
 
 /*
@@ -3097,9 +3113,7 @@ static inline bool io_is_direct(struct file *filp)
 
 static inline int iocb_flags(struct file *file)
 {
-	struct inode *inode = file_inode(file);
 	int res = 0;
-
 	if (file->f_flags & O_APPEND)
 		res |= IOCB_APPEND;
 	if (io_is_direct(file))
@@ -3108,13 +3122,8 @@ static inline int iocb_flags(struct file *file)
 		res |= IOCB_DSYNC;
 	if (file->f_flags & __O_SYNC)
 		res |= IOCB_SYNC;
-	if (mask_to_write_hint(inode->i_flags, S_WRITE_LIFE_SHIFT)) {
-		enum rw_hint hint;
-
-		hint = mask_to_write_hint(inode->i_flags, S_WRITE_LIFE_SHIFT);
-		res |= write_hint_to_mask(hint, IOCB_WRITE_LIFE_SHIFT);
-	}
 
+	res |= write_hint_to_mask(file->f_write_hint, IOCB_WRITE_LIFE_SHIFT);
 	return res;
 }
 

-- 
Jens Axboe
