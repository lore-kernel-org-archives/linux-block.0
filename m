Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHSET v2] Add support for write life time hints
From: Jens Axboe <axboe@kernel.dk>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Martin Petersen <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@infradead.org>,
 fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-block <linux-block@vger.kernel.org>
References: <1497412919-19400-1-git-send-email-axboe@kernel.dk>
 <yq160fyvah7.fsf@oracle.com> <d3e724ea-38f8-213f-a9ce-f78adc028e47@kernel.dk>
 <20170614160127.GA30644@infradead.org> <yq1shj2tv1z.fsf@oracle.com>
 <20382261-3180-41F0-B959-9181C2FF4BAA@dilger.ca>
 <9e152ed7-ed49-bb62-902c-0daac7646a86@kernel.dk>
 <48A74D71-9765-4881-B337-761FE66757BB@dilger.ca>
 <d83b67c8-e4d6-d450-5cc2-4f0f56961443@kernel.dk>
Message-ID: <47c6fb6d-d672-a230-890f-68c1db22e277@kernel.dk>
Date: Wed, 14 Jun 2017 22:38:23 -0600
MIME-Version: 1.0
In-Reply-To: <d83b67c8-e4d6-d450-5cc2-4f0f56961443@kernel.dk>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 06/14/2017 09:57 PM, Jens Axboe wrote:
> On 06/14/2017 09:53 PM, Andreas Dilger wrote:
>> On Jun 14, 2017, at 9:26 PM, Jens Axboe <axboe@kernel.dk> wrote:
>>> On Wed, Jun 14, 2017 at 5:39 PM, Andreas Dilger <adilger@dilger.ca> wrote:
>>>> On Jun 14, 2017, at 10:04 AM, Martin K. Petersen <martin.petersen@oracle.com> wrote:
>>>>> Christoph,
>>>>>
>>>>>> I think what Martin wants (or at least what I'd want him to want) is
>>>>>> to define a few REQ_* bits that mirror the RWF bits, use that to
>>>>>> transfer the information down the stack, and then only translate it
>>>>>> to stream ids in the driver.
>>>>>
>>>>> Yup. If we have enough space in the existing flags that's perfect (I
>>>>> lost count after your op/flag shuffle).
>>>>
>>>> Just to clarify, does this mean that Jens' "lifetime" hints are going to
>>>> be independent of separate "stream ID" values in the future (needing a
>>>> similar, but independent, set of fields for stream IDs, or will they
>>>> both be implemented using a common transport in the kernel (i.e. both
>>>> share a single set of fields in the inode/bio/etc?
>>>
>>> There's no reason they can't coexist. Now that bio->bi_stream is gone
>>> and we just have the flags, if we want to expose separate "real" stream
>>> IDs, then we could later re-introduce that. It'd be pretty trivial to
>>> just use the most pertinent information on the driver side.
>>>
>>> From my perspective, all I really care about is the 4 hints. It's a
>>> simple enough interface that applications can understand and use it, and
>>> we don't need any management of actual stream IDs. I think that has the
>>> highest chance of success. Modifying an application to use it is
>>> trivial, even something like RocksDB (if you havehad to make changes
>>> to RocksDB, you'll get this).
>>
>> If this is really to be only flags, rather than a hybrid of flags and IDs
>> (as I had thought), then it probably makes sense to limit the inode usage
>> to a few bits in i_flags using S_LIFETIME_* values rather than a separate
>> 16-bit i_stream field, which can be used for the actual stream IDs later.
> 
> Christoph alluded to that as well. And yes, if we are contemplating
> something else later on, then that does make more sense. I'll make that
> change.

Easy enough to do, see attached incremental patch. Only issue is that we
then have to lock the inode, and use the atomic flag setting. I'm assuming
that's safe to do from that path. We only need to grab the lock if the
hint changes, which is basically never should.


diff --git a/fs/inode.c b/fs/inode.c
index bd8bf44f3f31..db5914783a71 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -149,7 +149,6 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	inode->i_blocks = 0;
 	inode->i_bytes = 0;
 	inode->i_generation = 0;
-	inode->i_write_hint = 0;
 	inode->i_pipe = NULL;
 	inode->i_bdev = NULL;
 	inode->i_cdev = NULL;
diff --git a/fs/read_write.c b/fs/read_write.c
index 9cb2314efca3..70f8764ae117 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -675,6 +675,7 @@ EXPORT_SYMBOL(iov_shorten);
 static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
 		loff_t *ppos, int type, int flags)
 {
+	struct inode *inode = file_inode(filp);
 	struct kiocb kiocb;
 	ssize_t ret;
 
@@ -688,12 +689,19 @@ static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
 		kiocb.ki_flags |= IOCB_DSYNC;
 	if (flags & RWF_SYNC)
 		kiocb.ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
-	if (flags & RWF_WRITE_LIFE_MASK) {
-		struct inode *inode = file_inode(filp);
+	if ((flags & RWF_WRITE_LIFE_MASK) ||
+	    (inode->i_flags & S_WRITE_LIFE_MASK)) {
+		unsigned int hint, iflags;
 
-		inode->i_write_hint = (flags & RWF_WRITE_LIFE_MASK) >>
-					RWF_WRITE_LIFE_SHIFT;
-		kiocb.ki_flags |= inode->i_write_hint << IOCB_WRITE_LIFE_SHIFT;
+		hint = (flags & RWF_WRITE_LIFE_MASK) >> RWF_WRITE_LIFE_SHIFT;
+		iflags = hint << S_WRITE_LIFE_SHIFT;
+
+		if ((inode->i_flags & S_WRITE_LIFE_MASK) != iflags) {
+			inode_lock(inode);
+			inode_set_flags(inode, iflags, iflags);
+			inode_unlock(inode);
+		}
+		kiocb.ki_flags |= hint << IOCB_WRITE_LIFE_SHIFT;
 	}
 	kiocb.ki_pos = *ppos;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 63798b67fcfe..929f1fc088c6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -270,10 +270,10 @@ struct writeback_control;
 #define IOCB_WRITE		(1 << 6)
 
 /*
- * Steal 4-bits for stream information, this allows 16 valid streams
+ * Steal 3 bits for stream information, this allows 8 valid streams
  */
 #define IOCB_WRITE_LIFE_SHIFT	7
-#define IOCB_WRITE_LIFE_MASK	(BIT(7) | BIT(8) | BIT(9) | BIT(10))
+#define IOCB_WRITE_LIFE_MASK	(BIT(7) | BIT(8) | BIT(9))
 
 struct kiocb {
 	struct file		*ki_filp;
@@ -603,7 +603,6 @@ struct inode {
 	struct timespec		i_ctime;
 	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
 	unsigned short          i_bytes;
-	unsigned short		i_write_hint;
 	unsigned int		i_blkbits;
 	blkcnt_t		i_blocks;
 
@@ -668,14 +667,6 @@ struct inode {
 	void			*i_private; /* fs or device private pointer */
 };
 
-static inline unsigned int inode_write_hint(struct inode *inode)
-{
-	if (inode)
-		return inode->i_write_hint;
-
-	return 0;
-}
-
 static inline unsigned int i_blocksize(const struct inode *node)
 {
 	return (1 << node->i_blkbits);
@@ -1849,6 +1840,17 @@ struct super_operations {
 #endif
 
 /*
+ * Expected life time hint of a write for this inode. This maps directly
+ * to the RWF_WRITE_LIFE_* hints
+ */
+#define S_WRITE_LIFE_SHIFT	14	/* 16384, next bit */
+#define S_WRITE_LIFE_MASK	0x1c000	/* bits 14..16 */
+#define S_WRITE_LIFE_SHORT	(1 << S_WRITE_LIFE_SHIFT)
+#define S_WRITE_LIFE_MEDIUM	(2 << S_WRITE_LIFE_SHIFT)
+#define S_WRITE_LIFE_LONG	(3 << S_WRITE_LIFE_SHIFT)
+#define S_WRITE_LIFE_EXTREME	(4 << S_WRITE_LIFE_SHIFT)
+
+/*
  * Note that nosuid etc flags are inode-specific: setting some file-system
  * flags just means all the inodes inherit those flags by default. It might be
  * possible to override it selectively if you really wanted to with some
@@ -1894,6 +1896,15 @@ static inline bool HAS_UNMAPPED_ID(struct inode *inode)
 	return !uid_valid(inode->i_uid) || !gid_valid(inode->i_gid);
 }
 
+static inline unsigned int inode_write_hint(struct inode *inode)
+{
+	if (inode)
+		return (inode->i_flags & S_WRITE_LIFE_MASK) >>
+				S_WRITE_LIFE_SHIFT;
+
+	return 0;
+}
+
 /*
  * Inode state bits.  Protected by inode->i_lock
  *
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 58b7ee06b380..b68dc74236c1 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -362,10 +362,10 @@ struct fscrypt_key {
 #define RWF_SYNC			0x00000004 /* per-IO O_SYNC */
 
 /*
- * Data life time write flags, steal 4 bits for that
+ * Data life time write flags, steal 3 bits for that
  */
 #define RWF_WRITE_LIFE_SHIFT		4
-#define RWF_WRITE_LIFE_MASK		0x000000f0 /* 4 bits of stream ID */
+#define RWF_WRITE_LIFE_MASK		0x00000070 /* 3 bits of stream ID */
 #define RWF_WRITE_LIFE_SHORT		(1 << RWF_WRITE_LIFE_SHIFT)
 #define RWF_WRITE_LIFE_MEDIUM		(2 << RWF_WRITE_LIFE_SHIFT)
 #define RWF_WRITE_LIFE_LONG		(3 << RWF_WRITE_LIFE_SHIFT)

-- 
Jens Axboe
