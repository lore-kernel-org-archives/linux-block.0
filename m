Return-Path: <SRS0=xOsI=XD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC93C433EF
	for <linux-block@archiver.kernel.org>; Sun,  8 Sep 2019 19:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F9220828
	for <linux-block@archiver.kernel.org>; Sun,  8 Sep 2019 19:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfIHTGa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Sep 2019 15:06:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbfIHTG3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 8 Sep 2019 15:06:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 894F93086268;
        Sun,  8 Sep 2019 19:06:29 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F1BA5D9D3;
        Sun,  8 Sep 2019 19:06:29 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 035DD18089C8;
        Sun,  8 Sep 2019 19:06:28 +0000 (UTC)
Date:   Sun, 8 Sep 2019 15:06:28 -0400 (EDT)
From:   Jan Stancek <jstancek@redhat.com>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, systemd-devel@lists.freedesktop.org,
        Jan Stancek <jstancek@redhat.com>
Message-ID: <339755031.10549626.1567969588805.JavaMail.zimbra@redhat.com>
In-Reply-To: <87v9u3xf5q.fsf@mail.parknet.co.jp>
References: <fc8878aeefea128c105c49671b2a1ac4694e1f48.1567468225.git.jstancek@redhat.com> <87v9u3xf5q.fsf@mail.parknet.co.jp>
Subject: Re: [PATCH] fat: fix corruption in fat_alloc_new_dir()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.17.163, 10.4.195.18]
Thread-Topic: fix corruption in fat_alloc_new_dir()
Thread-Index: ghqM+SI1e2ScMnP+PLqiL5bw6YNxSw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Sun, 08 Sep 2019 19:06:29 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



----- Original Message -----
> Jan Stancek <jstancek@redhat.com> writes:
> 
> > sb_getblk does not guarantee that buffer_head is uptodate. If there is
> > async read running in parallel for same buffer_head, it can overwrite
> > just initialized msdos_dir_entry, leading to corruption:
> >   FAT-fs (loop0): error, corrupted directory (invalid entries)
> >   FAT-fs (loop0): Filesystem has been set read-only
> >
> > This can happen for example during LTP statx04, which creates loop
> > device, formats it (mkfs.vfat), mounts it and immediately creates
> > a new directory. In parallel, systemd-udevd is probing new block
> > device, which leads to async read.
> >
> >   do_mkdirat                      ksys_read
> >    vfs_mkdir                       vfs_read
> >     vfat_mkdir                      __vfs_read
> >      fat_alloc_new_dir               new_sync_read
> >        /* init de[0], de[1] */        blkdev_read_iter
> >                                        generic_file_read_iter
> >                                         generic_file_buffered_read
> >                                          blkdev_readpage
> >                                           block_read_full_page
> >
> > Faster reproducer (based on LTP statx04):
> >
> > int main(void)
> > {
> > 	int i, j, ret, fd, loop_fd, ctrl_fd;
> > 	int loop_num;
> > 	char loopdev[256], tmp[256], testfile[256];
> >
> > 	mkdir("/tmp/mntpoint", 0777);
> > 	for (i = 0; ; i++) {
> > 		printf("Iteration: %d\n", i);
> > 		sprintf(testfile, "/tmp/test.img.%d", getpid());
> >
> > 		ctrl_fd = open("/dev/loop-control", O_RDWR);
> > 		loop_num = ioctl(ctrl_fd, LOOP_CTL_GET_FREE);
> > 		close(ctrl_fd);
> > 		sprintf(loopdev, "/dev/loop%d", loop_num);
> >
> > 		fd = open(testfile, O_WRONLY|O_CREAT|O_TRUNC, 0600);
> > 		fallocate(fd, 0, 0, 256*1024*1024);
> > 		close(fd);
> >
> > 		fd = open(testfile, O_RDWR);
> > 		loop_fd = open(loopdev, O_RDWR);
> > 		ioctl(loop_fd, LOOP_SET_FD, fd);
> > 		close(loop_fd);
> > 		close(fd);
> >
> > 		sprintf(tmp, "mkfs.vfat %s", loopdev);
> > 		system(tmp);
> > 		mount(loopdev, "/tmp/mntpoint", "vfat", 0, NULL);
> >
> > 		for (j = 0; j < 200; j++) {
> > 			sprintf(tmp, "/tmp/mntpoint/testdir%d", j);
> > 			ret = mkdir(tmp, 0777);
> > 			if (ret) {
> > 				perror("mkdir");
> > 				break;
> > 			}
> > 		}
> >
> > 		umount("/tmp/mntpoint");
> > 		loop_fd = open(loopdev, O_RDWR);
> > 		ioctl(loop_fd, LOOP_CLR_FD, fd);
> > 		close(loop_fd);
> > 		unlink(testfile);
> >
> > 		if (ret)
> > 			break;
> > 	}
> >
> > 	return 0;
> > }
> >
> > Issue triggers within minute on HPE Apollo 70 (arm64, 64GB RAM, 224 CPUs).
> 
> Using the device while mounting same device doesn't work reliably like
> this race. (getblk() is intentionally used to get the buffer to write
> new data.)

Are you saying this is expected even if 'usage' is just read?

> 
> mount(2) internally opens the device by EXCL mode, so I guess udev opens
> without EXCL (I dont know if it is intent or not).

I gave this a try and added O_EXCL to udev-builtin-blkid.c. My system had trouble
booting, it was getting stuck on mounting LVM volumes.

So, I'm not sure how to move forward here. 

Regards,
Jan
