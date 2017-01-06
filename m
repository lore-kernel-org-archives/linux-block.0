Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:34199 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752932AbdAFRpr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Jan 2017 12:45:47 -0500
Received: by mail-oi0-f51.google.com with SMTP id 3so440182581oih.1
        for <linux-block@vger.kernel.org>; Fri, 06 Jan 2017 09:45:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170106102330.GB3533@quack2.suse.cz>
References: <148366547505.38941.646379357860772670.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20170106102330.GB3533@quack2.suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 6 Jan 2017 09:45:45 -0800
Message-ID: <CAPcyv4gmvGkAbse619WOBsEd8DDn8Fe4kVJ7r+iYug8DEg+cEg@mail.gmail.com>
Subject: Re: [PATCH] block: fix blk_get_backing_dev_info() crash, use bdev->bd_queue
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@fb.com>, Andi Kleen <ak@linux.intel.com>,
        Rabin Vincent <rabinv@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        Wei Fang <fangwei1@huawei.com>, Christoph Hellwig <hch@lst.de>
Content-Type: multipart/mixed; boundary=001a1130c12277504f054570961e
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--001a1130c12277504f054570961e
Content-Type: text/plain; charset=UTF-8

On Fri, Jan 6, 2017 at 2:23 AM, Jan Kara <jack@suse.cz> wrote:
> On Thu 05-01-17 17:17:55, Dan Williams wrote:
>> The ->bd_queue member of struct block_device was added in commit
>> 87192a2a49c4 ("vfs: cache request_queue in struct block_device") in
>> v3.3. However, blk_get_backing_dev_info() has been using
>> bdev_get_queue() and grabbing the request_queue through the gendisk
>> since before the git era.
>>
>> At final __blkdev_put() time ->bd_disk is cleared while ->bd_queue is
>> not. The queue remains valid until the final put of the parent disk.
>>
>> The following crash signature results from blk_get_backing_dev_info()
>> trying to lookup the queue through ->bd_disk after the final put of the
>> block device. Simply switch bdev_get_queue() to use ->bd_queue directly
>> which is guaranteed to still be valid at invalidate_partition() time.
>>
>>  BUG: unable to handle kernel NULL pointer dereference at 0000000000000568
>>  IP: blk_get_backing_dev_info+0x10/0x20
>>  [..]
>>  Call Trace:
>>   __inode_attach_wb+0x3a7/0x5d0
>>   __filemap_fdatawrite_range+0xf8/0x100
>>   filemap_write_and_wait+0x40/0x90
>>   fsync_bdev+0x54/0x60
>>   ? bdget_disk+0x30/0x40
>>   invalidate_partition+0x24/0x50
>>   del_gendisk+0xfa/0x230
>
> So we have a similar reports of the same problem. E.g.:
>
> http://www.spinics.net/lists/linux-fsdevel/msg105153.html
>
> However I kind of miss how your patch would fix all those cases. The
> principial problem is that inode_to_bdi() called on block device inode
> wants to get the backing_dev_info however on last close of a block device
> we do put_disk() and thus the request queue containing backing_dev_info
> does not have to be around at that time. In your case you are lucky enough
> to have the containing disk still around but that's not the case for all
> inode_to_bdi() users (see e.g. the report I referenced) and your patch
> would change relatively straightforward NULL pointer dereference to rather
> subtle use-after-free issue

True. If there are other cases that don't hold their own queue
reference this patch makes things worse.

> so I disagree with going down this path.

I still think this patch is the right thing to do, but it needs to
come after the wider guarantee that having an active bdev reference
guarantees that the queue and backing_dev_info are still allocated.

> So what I think needs to be done is that we make backing_dev_info
> independently allocated structure with different lifetime rules to gendisk
> or request_queue - definitely I want it to live as long as block device
> inode exists. However it needs more thought what the exact lifetime rules
> will be.

Hmm, why does it need to be separately allocated?

Something like this, passes the libnvdimm unit tests: (non-whitespace
damaged version attached)

diff --git a/block/blk-core.c b/block/blk-core.c
index 7c1a24fb09d8..6742c49b38e4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -378,7 +378,8 @@ EXPORT_SYMBOL(blk_run_queue);

 void blk_put_queue(struct request_queue *q)
 {
-       kobject_put(&q->kobj);
+       if (q)
+               kobject_put(&q->kobj);
 }
 EXPORT_SYMBOL(blk_put_queue);

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 05b553368bb4..7503110e37ff 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -589,12 +589,22 @@ static struct inode *bdev_alloc_inode(struct
super_block *sb)
        return &ei->vfs_inode;
 }

+static void bdev_release(struct work_struct *w)
+{
+       struct block_device *bdev = container_of(w, typeof(*bdev), bd_release);
+       struct bdev_inode *bdi = container_of(bdev, typeof(*bdi), bdev);
+
+       blk_put_queue(bdev->bd_queue);
+       kmem_cache_free(bdev_cachep, bdi);
+}
+
 static void bdev_i_callback(struct rcu_head *head)
 {
        struct inode *inode = container_of(head, struct inode, i_rcu);
-       struct bdev_inode *bdi = BDEV_I(inode);
+       struct block_device *bdev = &BDEV_I(inode)->bdev;

-       kmem_cache_free(bdev_cachep, bdi);
+       /* blk_put_queue needs process context */
+       schedule_work(&bdev->bd_release);
 }

 static void bdev_destroy_inode(struct inode *inode)
@@ -613,6 +623,7 @@ static void init_once(void *foo)
 #ifdef CONFIG_SYSFS
        INIT_LIST_HEAD(&bdev->bd_holder_disks);
 #endif
+       INIT_WORK(&bdev->bd_release, bdev_release);
        inode_init_once(&ei->vfs_inode);
        /* Initialize mutex for freeze. */
        mutex_init(&bdev->bd_fsfreeze_mutex);
@@ -1268,6 +1279,8 @@ static int __blkdev_get(struct block_device
*bdev, fmode_t mode, int for_part)
        mutex_lock_nested(&bdev->bd_mutex, for_part);
        if (!bdev->bd_openers) {
                bdev->bd_disk = disk;
+               if (!blk_get_queue(disk->queue))
+                       goto out_clear;
                bdev->bd_queue = disk->queue;
                bdev->bd_contains = bdev;

@@ -1288,7 +1301,6 @@ static int __blkdev_get(struct block_device
*bdev, fmode_t mode, int for_part)
                                        disk_put_part(bdev->bd_part);
                                        bdev->bd_part = NULL;
                                        bdev->bd_disk = NULL;
-                                       bdev->bd_queue = NULL;
                                        mutex_unlock(&bdev->bd_mutex);
                                        disk_unblock_events(disk);
                                        put_disk(disk);
@@ -1364,7 +1376,6 @@ static int __blkdev_get(struct block_device
*bdev, fmode_t mode, int for_part)
        disk_put_part(bdev->bd_part);
        bdev->bd_disk = NULL;
        bdev->bd_part = NULL;
-       bdev->bd_queue = NULL;
        if (bdev != bdev->bd_contains)
                __blkdev_put(bdev->bd_contains, mode, 1);
        bdev->bd_contains = NULL;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index dc0478c07b2a..f084e4a2198b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -488,6 +488,7 @@ struct block_device {
        int                     bd_fsfreeze_count;
        /* Mutex for freeze */
        struct mutex            bd_fsfreeze_mutex;
+       struct work_struct      bd_release;
 };

 /*

--001a1130c12277504f054570961e
Content-Type: text/x-patch; charset=US-ASCII; name="bdev-queue-lifetime.patch"
Content-Disposition: attachment; filename="bdev-queue-lifetime.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ixm3aqqt0

ZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay1jb3JlLmMgYi9ibG9jay9ibGstY29yZS5jCmluZGV4IDdj
MWEyNGZiMDlkOC4uNjc0MmM0OWIzOGU0IDEwMDY0NAotLS0gYS9ibG9jay9ibGstY29yZS5jCisr
KyBiL2Jsb2NrL2Jsay1jb3JlLmMKQEAgLTM3OCw3ICszNzgsOCBAQCBFWFBPUlRfU1lNQk9MKGJs
a19ydW5fcXVldWUpOwogCiB2b2lkIGJsa19wdXRfcXVldWUoc3RydWN0IHJlcXVlc3RfcXVldWUg
KnEpCiB7Ci0Ja29iamVjdF9wdXQoJnEtPmtvYmopOworCWlmIChxKQorCQlrb2JqZWN0X3B1dCgm
cS0+a29iaik7CiB9CiBFWFBPUlRfU1lNQk9MKGJsa19wdXRfcXVldWUpOwogCmRpZmYgLS1naXQg
YS9mcy9ibG9ja19kZXYuYyBiL2ZzL2Jsb2NrX2Rldi5jCmluZGV4IDA1YjU1MzM2OGJiNC4uNzUw
MzExMGUzN2ZmIDEwMDY0NAotLS0gYS9mcy9ibG9ja19kZXYuYworKysgYi9mcy9ibG9ja19kZXYu
YwpAQCAtNTg5LDEyICs1ODksMjIgQEAgc3RhdGljIHN0cnVjdCBpbm9kZSAqYmRldl9hbGxvY19p
bm9kZShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiKQogCXJldHVybiAmZWktPnZmc19pbm9kZTsKIH0K
IAorc3RhdGljIHZvaWQgYmRldl9yZWxlYXNlKHN0cnVjdCB3b3JrX3N0cnVjdCAqdykKK3sKKwlz
dHJ1Y3QgYmxvY2tfZGV2aWNlICpiZGV2ID0gY29udGFpbmVyX29mKHcsIHR5cGVvZigqYmRldiks
IGJkX3JlbGVhc2UpOworCXN0cnVjdCBiZGV2X2lub2RlICpiZGkgPSBjb250YWluZXJfb2YoYmRl
diwgdHlwZW9mKCpiZGkpLCBiZGV2KTsKKworCWJsa19wdXRfcXVldWUoYmRldi0+YmRfcXVldWUp
OworCWttZW1fY2FjaGVfZnJlZShiZGV2X2NhY2hlcCwgYmRpKTsKK30KKwogc3RhdGljIHZvaWQg
YmRldl9pX2NhbGxiYWNrKHN0cnVjdCByY3VfaGVhZCAqaGVhZCkKIHsKIAlzdHJ1Y3QgaW5vZGUg
Kmlub2RlID0gY29udGFpbmVyX29mKGhlYWQsIHN0cnVjdCBpbm9kZSwgaV9yY3UpOwotCXN0cnVj
dCBiZGV2X2lub2RlICpiZGkgPSBCREVWX0koaW5vZGUpOworCXN0cnVjdCBibG9ja19kZXZpY2Ug
KmJkZXYgPSAmQkRFVl9JKGlub2RlKS0+YmRldjsKIAotCWttZW1fY2FjaGVfZnJlZShiZGV2X2Nh
Y2hlcCwgYmRpKTsKKwkvKiBibGtfcHV0X3F1ZXVlIG5lZWRzIHByb2Nlc3MgY29udGV4dCAqLwor
CXNjaGVkdWxlX3dvcmsoJmJkZXYtPmJkX3JlbGVhc2UpOwogfQogCiBzdGF0aWMgdm9pZCBiZGV2
X2Rlc3Ryb3lfaW5vZGUoc3RydWN0IGlub2RlICppbm9kZSkKQEAgLTYxMyw2ICs2MjMsNyBAQCBz
dGF0aWMgdm9pZCBpbml0X29uY2Uodm9pZCAqZm9vKQogI2lmZGVmIENPTkZJR19TWVNGUwogCUlO
SVRfTElTVF9IRUFEKCZiZGV2LT5iZF9ob2xkZXJfZGlza3MpOwogI2VuZGlmCisJSU5JVF9XT1JL
KCZiZGV2LT5iZF9yZWxlYXNlLCBiZGV2X3JlbGVhc2UpOwogCWlub2RlX2luaXRfb25jZSgmZWkt
PnZmc19pbm9kZSk7CiAJLyogSW5pdGlhbGl6ZSBtdXRleCBmb3IgZnJlZXplLiAqLwogCW11dGV4
X2luaXQoJmJkZXYtPmJkX2ZzZnJlZXplX211dGV4KTsKQEAgLTEyNjgsNiArMTI3OSw4IEBAIHN0
YXRpYyBpbnQgX19ibGtkZXZfZ2V0KHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYsIGZtb2RlX3Qg
bW9kZSwgaW50IGZvcl9wYXJ0KQogCW11dGV4X2xvY2tfbmVzdGVkKCZiZGV2LT5iZF9tdXRleCwg
Zm9yX3BhcnQpOwogCWlmICghYmRldi0+YmRfb3BlbmVycykgewogCQliZGV2LT5iZF9kaXNrID0g
ZGlzazsKKwkJaWYgKCFibGtfZ2V0X3F1ZXVlKGRpc2stPnF1ZXVlKSkKKwkJCWdvdG8gb3V0X2Ns
ZWFyOwogCQliZGV2LT5iZF9xdWV1ZSA9IGRpc2stPnF1ZXVlOwogCQliZGV2LT5iZF9jb250YWlu
cyA9IGJkZXY7CiAKQEAgLTEyODgsNyArMTMwMSw2IEBAIHN0YXRpYyBpbnQgX19ibGtkZXZfZ2V0
KHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYsIGZtb2RlX3QgbW9kZSwgaW50IGZvcl9wYXJ0KQog
CQkJCQlkaXNrX3B1dF9wYXJ0KGJkZXYtPmJkX3BhcnQpOwogCQkJCQliZGV2LT5iZF9wYXJ0ID0g
TlVMTDsKIAkJCQkJYmRldi0+YmRfZGlzayA9IE5VTEw7Ci0JCQkJCWJkZXYtPmJkX3F1ZXVlID0g
TlVMTDsKIAkJCQkJbXV0ZXhfdW5sb2NrKCZiZGV2LT5iZF9tdXRleCk7CiAJCQkJCWRpc2tfdW5i
bG9ja19ldmVudHMoZGlzayk7CiAJCQkJCXB1dF9kaXNrKGRpc2spOwpAQCAtMTM2NCw3ICsxMzc2
LDYgQEAgc3RhdGljIGludCBfX2Jsa2Rldl9nZXQoc3RydWN0IGJsb2NrX2RldmljZSAqYmRldiwg
Zm1vZGVfdCBtb2RlLCBpbnQgZm9yX3BhcnQpCiAJZGlza19wdXRfcGFydChiZGV2LT5iZF9wYXJ0
KTsKIAliZGV2LT5iZF9kaXNrID0gTlVMTDsKIAliZGV2LT5iZF9wYXJ0ID0gTlVMTDsKLQliZGV2
LT5iZF9xdWV1ZSA9IE5VTEw7CiAJaWYgKGJkZXYgIT0gYmRldi0+YmRfY29udGFpbnMpCiAJCV9f
YmxrZGV2X3B1dChiZGV2LT5iZF9jb250YWlucywgbW9kZSwgMSk7CiAJYmRldi0+YmRfY29udGFp
bnMgPSBOVUxMOwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9mcy5oIGIvaW5jbHVkZS9saW51
eC9mcy5oCmluZGV4IGRjMDQ3OGMwN2IyYS4uZjA4NGU0YTIxOThiIDEwMDY0NAotLS0gYS9pbmNs
dWRlL2xpbnV4L2ZzLmgKKysrIGIvaW5jbHVkZS9saW51eC9mcy5oCkBAIC00ODgsNiArNDg4LDcg
QEAgc3RydWN0IGJsb2NrX2RldmljZSB7CiAJaW50CQkJYmRfZnNmcmVlemVfY291bnQ7CiAJLyog
TXV0ZXggZm9yIGZyZWV6ZSAqLwogCXN0cnVjdCBtdXRleAkJYmRfZnNmcmVlemVfbXV0ZXg7CisJ
c3RydWN0IHdvcmtfc3RydWN0CWJkX3JlbGVhc2U7CiB9OwogCiAvKgo=
--001a1130c12277504f054570961e--
