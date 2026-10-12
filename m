Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EAA40EBA9;
	Mon, 12 Oct 2026 12:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791809238; cv=none; b=on8GRERwdjk1z1wB/5G8ZOjDSIqKVXfItdwc6PqX6h67Jo8TOKyZGxNiRlCLkzEuG5qQIgCUzU378iVwvexNGZolL7Z0S5W4p1nAPZGJNnrHhV7B885hb0h/eL1YgjisdW+S3PDGDoXiY9h+WocYJLpdOBNsFYjlhCxaYlVd4fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791809238; c=relaxed/simple;
	bh=Mhs3ax/hINqxPEVVgXVJ4W8q+DG17IY3+xWjfK9L6Xw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VD6njJEaYh4Kq1jtKhzFh5315sFcm9oZYqzOL8tL4Wlnjvc1JjXZ27ys920Hg6xQuuTrxqDp9nbwlpfVJIlYokC1XWkaK4dk6ohokeX60OEJ2tVtL1pFoPHRqHs4zYMoOqcu5Awepm2gFk9reaRF9ezZNE1xS9cNkFzbtuWczqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKZulPTr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKZulPTr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB621F0089B;
	Mon, 12 Oct 2026 12:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791809236;
	bh=CJqp91vLCmZU11djrbL3LV8j9Css7TUeJ1VmYQefYEo=;
	h=From:Date:Subject:To:Cc;
	b=hKZulPTrtOS80yeF0nWCZbBznUxZRutslSHruRKTFReDDh6QkY0VEwafd7MGNOkWF
	 286bVrA9umPrui0PFu1yX2MrBbhtTnCOv02vBmaF/5xUjO6z8enZ0WNcXOrZMFm9Dw
	 U0gmzmIqQ4Y+HSp91LD2xsow0HkQKZgi699PItQ+b6w70LLXZpH9GgpGU/DUaoXpZj
	 KD1JdLwuPWc6tBzCnMUMRZfWb2eGaHhoWhhFwySROv7kD8xSsaoAKtxi9+Vh1c9Z/1
	 8Ecal5LoI8V09bQ0l7jExlEv0pmQqHlsVv5rmKmYOtIr9Gw+ZNSyvZkxoYb0ZZ979z
	 nbFkgd6Q3HPLw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 12 Oct 2026 14:47:08 +0200
Subject: [PATCH] loop: remove support for swapping loop fds
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-work-loop-change_fd-v1-1-3cf4ec349bbb@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/z2M2QrCMBBFf6XMsxOaqH3wV0Qky8RGJSkTNyj9d
 zMWfDx3OTNU4kQVDt0MTK9UU8kN9KYDP9p8IUyhMZjeDLrXBt+Fb3gvZcK1P8eAQzT7rdeGdiF
 Ce05MMX1+1uNp5fp0V/IPUcnC2Uro2GY/SiRSJVL1lyqZwLJ8ASaFvnWiAAAA
X-Change-ID: 20261012-work-loop-change_fd-6f253c12e4df
To: Chris Mason <mason@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=10668; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Mhs3ax/hINqxPEVVgXVJ4W8q+DG17IY3+xWjfK9L6Xw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSduXahwnp3q1XhvJTEX4sMxObr7DmxpXLfx5nmRyQnR
 ij5fF0yr6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi5qmMDCt32syWLv/s8r/j
 35KeXDGW8IvaWztsGfqyX07tfz37VRUjwwS5le9rH8YFXpkre27SZ/MXORVLe6Ye1NO5I5/5fsX
 FWWwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

LOOP_CHANGE_FD swaps the backing file of a bound read-only loop device
for another file of the same size. The comment above loop_change_fd()
says this is for installers that want to free the original image and
for HA setups that want to switch to another copy of the image. When we
discussed deprecating it in 2023 (cf. [1]) we found no users at all:
zero hits on codesearch.debian.net, GitHub code search and
cs.android.com. The only things that exercise it are strace, LTP,
stress-ng and blktests. Everyone agreed to drop it. I just never sent
the patch.

Since then we found several more problems with it and all of them are
structural. The ioctl changes what a block device is backed by after a
filesystem has been mounted on it and nothing else in the kernel does
that.

(1) It creates a lock order cycle.

    loop_change_fd() is the only loop operation that calls
    disk_force_media_change() on a bound device while a filesystem can
    be mounted on it. loop_configure() calls it before the device is
    bound and __loop_clr_fd() after the last opener is gone. And it
    calls it with lo->lo_mutex held.

    Since v6.6 disk_force_media_change() doesn't just bump the disk
    sequence number. It calls bdev_mark_dead() which calls into the
    holder, i.e., fs_bdev_mark_dead(), which takes sb->s_umount of
    every superblock on that device. So LOOP_CHANGE_FD gives us:

        lo_mutex -> s_umount

    Mounting a filesystem takes s_umount in sget_fc() and then opens
    the block device in setup_bdev_super(). That takes
    disk->open_mutex and calls lo_open() which takes lo_mutex:

        s_umount -> open_mutex -> lo_mutex

    That's a cycle. Lockdep reports it as soon as LOOP_CHANGE_FD is
    used on a device that has a filesystem mounted on it. This was
    recently hit with erofs where LOOP_CHANGE_FD raced with umount and
    a concurrent open of the loop device. And it is a real deadlock:
    the mounter holds s_umount and waits for open_mutex, the opener
    holds open_mutex and waits in lo_open() for lo_mutex, and the
    LOOP_CHANGE_FD caller holds lo_mutex and waits in
    fs_bdev_mark_dead() for that superblock.

    Note that we went through the block layer in v6.7 to guarantee
    that s_umount is never taken under open_mutex. LOOP_CHANGE_FD is
    the reverse direction and it was simply never considered.

(2) The use-case it was added for doesn't work anymore.

    fs_bdev_mark_dead() shuts the filesystem down. For ext4, xfs and
    btrfs that means ->shutdown() is called and the mounted filesystem
    returns -EIO from then on. So swapping the image under a mounted
    filesystem can't work for any filesystem that implements shutdown.
    It only survives on erofs because erofs deliberately doesn't
    implement ->shutdown() and ->remove_bdev(). Commit 69139a62a918
    ("erofs: open via dedicated fs bdev helpers") explicitly cites
    loop_change_fd() as the reason why it shouldn't. IOW, an ioctl
    without users dictates what a filesystem is allowed to do on
    device removal.

    And it never worked on partitions. disk_force_media_change() only
    acts on disk->part0 so a filesystem mounted on loop0p1 isn't told
    anything when the image under it is swapped.

(3) It can create superblock pin cycles.

    loop_validate_file() only guards against loop-on-loop recursion.
    It doesn't stop LOOP_CHANGE_FD from pointing a bound device at a
    file on the filesystem that is mounted from that very device, or
    two devices at files on each other's filesystems, or a device at a
    file on a fuse mount whose passthrough backing file lives on the
    loop mount. Static setups can't form these cycles because the
    backing file is opened before the filesystem on top of it exists.
    LOOP_CHANGE_FD is the only block layer path where the edge is
    added afterwards.

    The result is a cycle of superblocks: the backing file pins the
    mount, the mount pins the superblock, the superblock holds the
    device open and the device holds the backing file. umount detaches
    the mounts but nothing ever frees them and the mount namespace
    they live in leaks with them. This is not a cycle of mounts so
    nothing in mount teardown can break it. It's root-only, but it is
    a permanent leak that can't be undone.

(4) It makes filesystem stacking dynamic.

    s_stack_depth assumes that the dependencies between filesystems
    are fixed when a filesystem is mounted. With LOOP_CHANGE_FD the
    image of a mounted filesystem can be moved onto another filesystem
    at any later time, so a loop-mounted filesystem is at stacking
    depth 0 no matter what its image ends up on. That is the hole in
    the stacking deadlock discussion for fanotify pre-content events
    (cf. [2]).

The partition handling of LOOP_CHANGE_FD has been broken since v7.1
and nobody noticed until Daan ran into it in August (cf. [3]). That's
about the level of use this ioctl sees.

So let's remove it. LOOP_CHANGE_FD now returns -EOPNOTSUPP.

[1]: https://lore.kernel.org/r/20231023-biberbau-spatzen-282ccea0825a@brauner
     https://lore.kernel.org/r/20231024-entfuhr-sachbezogen-aab33dec4087@brauner
[2]: https://lore.kernel.org/r/CAOQ4uxi2Mx4ZB48DhQJWOvt6UBur3LnrkttgRjo72U4+Cu81iQ@mail.gmail.com
     https://lore.kernel.org/r/20260617-vorfahren-haften-nullnummer-b0d6fccadae3@brauner
[3]: https://lore.kernel.org/r/20260806-b4-loop-nbd-stale-partitions-v1-1-67bb75a8d7be@amutable.com

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/block/loop.c | 112 ++-------------------------------------------------
 1 file changed, 4 insertions(+), 108 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 758c20678bf6..aabaaacdb4fa 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -105,7 +105,7 @@ static DEFINE_MUTEX(loop_validate_mutex);
  *
  * Since loop_validate_file() traverses on other "struct loop_device" if
  * is_loop_device() is true, we need a global lock for serializing concurrent
- * loop_configure()/loop_change_fd()/__loop_clr_fd() calls.
+ * loop_configure()/__loop_clr_fd() calls.
  */
 static int loop_global_lock_killable(struct loop_device *lo, bool global)
 {
@@ -537,109 +537,6 @@ static int loop_check_backing_file(struct file *file)
 	return 0;
 }
 
-/*
- * loop_change_fd switched the backing store of a loopback device to
- * a new file. This is useful for operating system installers to free up
- * the original file and in High Availability environments to switch to
- * an alternative location for the content in case of server meltdown.
- * This can only work if the loop device is used read-only, and if the
- * new backing store is the same size and type as the old backing store.
- */
-static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
-			  unsigned int arg)
-{
-	struct file *file = fget(arg);
-	struct file *old_file;
-	unsigned int memflags;
-	int error;
-	bool partscan;
-	bool is_loop;
-
-	if (!file)
-		return -EBADF;
-
-	error = loop_check_backing_file(file);
-	if (error) {
-		fput(file);
-		return error;
-	}
-
-	/* suppress uevents while reconfiguring the device */
-	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
-
-	is_loop = is_loop_device(file);
-	error = loop_global_lock_killable(lo, is_loop);
-	if (error)
-		goto out_putf;
-	error = -ENXIO;
-	if (lo->lo_state != Lo_bound)
-		goto out_err;
-
-	/* the loop device has to be read-only */
-	error = -EINVAL;
-	if (!(lo->lo_flags & LO_FLAGS_READ_ONLY))
-		goto out_err;
-
-	error = loop_validate_file(file, bdev);
-	if (error)
-		goto out_err;
-
-	old_file = lo->lo_backing_file;
-
-	error = -EINVAL;
-
-	/* size of the new backing store needs to be the same */
-	if (lo_calculate_size(lo, file) != lo_calculate_size(lo, old_file))
-		goto out_err;
-
-	/*
-	 * We might switch to direct I/O mode for the loop device, write back
-	 * all dirty data the page cache now that so that the individual I/O
-	 * operations don't have to do that.
-	 */
-	vfs_fsync(file, 0);
-
-	/* and ... switch */
-	disk_force_media_change(lo->lo_disk);
-	memflags = blk_mq_freeze_queue(lo->lo_queue);
-	mapping_set_gfp_mask(old_file->f_mapping, lo->old_gfp_mask);
-	loop_assign_backing_file(lo, file);
-	loop_update_dio(lo);
-	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
-	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
-	loop_global_unlock(lo, is_loop);
-
-	/*
-	 * Flush loop_validate_file() before fput(), for l->lo_backing_file
-	 * might be pointing at old_file which might be the last reference.
-	 */
-	if (!is_loop) {
-		mutex_lock(&loop_validate_mutex);
-		mutex_unlock(&loop_validate_mutex);
-	}
-	/*
-	 * We must drop file reference outside of lo_mutex as dropping
-	 * the file ref can take open_mutex which creates circular locking
-	 * dependency.
-	 */
-	fput(old_file);
-	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
-	if (partscan)
-		loop_reread_partitions(lo);
-
-	error = 0;
-done:
-	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
-	return error;
-
-out_err:
-	loop_global_unlock(lo, is_loop);
-out_putf:
-	fput(file);
-	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
-	goto done;
-}
-
 /* loop sysfs attributes */
 
 static ssize_t loop_attr_show(struct device *dev, char *page,
@@ -1215,12 +1112,11 @@ static int loop_clr_fd(struct loop_device *lo)
 
 	/*
 	 * Since lo_ioctl() is called without locks held, it is possible that
-	 * loop_configure()/loop_change_fd() and loop_clr_fd() run in parallel.
+	 * loop_configure() and loop_clr_fd() run in parallel.
 	 *
 	 * Therefore, use global lock when setting Lo_rundown state in order to
 	 * make sure that loop_validate_file() will fail if the "struct file"
-	 * which loop_configure()/loop_change_fd() found via fget() was this
-	 * loop device.
+	 * which loop_configure() found via fget() was this loop device.
 	 */
 	err = loop_global_lock_killable(lo, true);
 	if (err)
@@ -1566,7 +1462,7 @@ static int lo_ioctl(struct block_device *bdev, blk_mode_t mode,
 		return loop_configure(lo, mode, bdev, &config);
 	}
 	case LOOP_CHANGE_FD:
-		return loop_change_fd(lo, bdev, arg);
+		return -EOPNOTSUPP;
 	case LOOP_CLR_FD:
 		return loop_clr_fd(lo);
 	case LOOP_SET_STATUS:

---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261012-work-loop-change_fd-6f253c12e4df

