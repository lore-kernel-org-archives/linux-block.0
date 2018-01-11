Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:4170 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753843AbeAKLXC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jan 2018 06:23:02 -0500
Subject: Re: blkdev loop UAF
To: Foy <long7573@126.com>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>
References: <654967ea.6cce.160e43379f6.Coremail.long7573@126.com>
 <20180111082441.myaxc2upbjhcucqh@mwanda>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        <security@kernel.org>, <syzkaller@googlegroups.com>,
        <linux-block@vger.kernel.org>
From: Hou Tao <houtao1@huawei.com>
Message-ID: <69a2465f-dd67-6962-4f15-57fa9cbafe4d@huawei.com>
Date: Thu, 11 Jan 2018 19:22:39 +0800
MIME-Version: 1.0
In-Reply-To: <20180111082441.myaxc2upbjhcucqh@mwanda>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

On 2018/1/11 16:24, Dan Carpenter wrote:
> Thanks for your report and the patch.  I am sending it to the
> linux-block devs since it's already public.
> 
> regards,
> dan carpenter

The User-after-free problem is not specific for loop device, it can also
be reproduced on scsi device, and there are more race problems caused by
the race between bdev open and gendisk shutdown [1].

The cause of the UAF problem is that there are two instances of gendisk which share
the same bdev. After the process owning the new gendisk increases bdev->bd_openers,
the other process which owns the older gendisk will find bdev->bd_openers is not zero
and will put the last reference of the older gendisk and cause User-after-free.

I had proposed a patch for the problem, but it's still an incomplete fix for the race
between gendisk shutdown and bdev opening.

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 4a181fc..5ecdb9f 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1510,6 +1510,11 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
                if (bdev->bd_bdi == &noop_backing_dev_info)
                        bdev->bd_bdi = bdi_get(disk->queue->backing_dev_info);
        } else {
+               if (bdev->bd_disk != disk) {
+                       ret = -ENXIO;
+                       goto out_unlock_bdev;
+               }
+
                if (bdev->bd_contains == bdev) {
                        ret = 0;
                        if (bdev->bd_disk->fops->open)


As far as I know, Jan Kara is working on these problems. So, Jan, any suggestions ?

Regards
Tao

[1]: https://www.spinics.net/lists/linux-block/msg20066.html

> On Thu, Jan 11, 2018 at 03:51:06PM +0800, Foy wrote:
>> BUG:
>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>> index 4a181fc..db919a9 100644
>> --- a/fs/block_dev.c
>> +++ b/fs/block_dev.c
>> @@ -1430,12 +1430,15 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
>>   restart:
>>  
>>         ret = -ENXIO;
>> +       //2. Process C: loop_control_ioctl ==> LOOP_CTL_REMOVE ==> idr_remove 
>> +       //3. Process B: get_gendisk ==> get_gendisk ==> kobj_lookup ==> loop_probe ==> loop_add, get a new disk(2)
>>         disk = get_gendisk(bdev->bd_dev, &partno);
>>         if (!disk)
>>                 goto out;
>>         owner = disk->fops->owner;
>>  
>>         disk_block_events(disk);
>> +       //1. Process A get the disk(1),before the mutex_lock_nested.And then be scheduled 
>>         mutex_lock_nested(&bdev->bd_mutex, for_part);
>>         if (!bdev->bd_openers) {
>>                 bdev->bd_disk = disk;
>> @@ -1524,14 +1527,17 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
>>                         if (ret)
>>                                 goto out_unlock_bdev;
>>                 }
>> +               //5. Process A disk(1) will be free,because disk(1)'s refs == 1
>>                 /* only one opener holds refs to the module and disk */
>>                 put_disk(disk);
>>                 module_put(owner);
>>         }
>> +       //4. Process B: bdev->bd_openers != 0
>>         bdev->bd_openers++;
>>         if (for_part)
>>                 bdev->bd_part_count++;
>>         mutex_unlock(&bdev->bd_mutex);
>> +       //6. Process A the disk(1) will be use
>>         disk_unblock_events(disk);
>>         return 0;
>>
>>
>>
>>
>> Patch:
>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>> index 4a181fc..1f5c7bf 100644
>> --- a/fs/block_dev.c
>> +++ b/fs/block_dev.c
>> @@ -1526,13 +1526,15 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
>>  }
>>  /* only one opener holds refs to the module and disk */
>>  put_disk(disk);
>> +disk = NULL;
>>  module_put(owner);
>>  }
>>  bdev->bd_openers++;
>>  if (for_part)
>>  bdev->bd_part_count++;
>>  mutex_unlock(&bdev->bd_mutex);
>> -disk_unblock_events(disk);
>> +if (disk)
>> +disk_unblock_events(disk);
>>  return 0;
>>  
>>   out_clear:
>>
>>
>>
>>
>> Crash:
>> ==================================================================
>> BUG: KASAN: use-after-free in disk_unblock_events+0x4b/0x50 block/genhd.c:1657
>> Read of size 8 at addr ffff880035c273f8 by task syz-executor6/21165
>>
>>
>> CPU: 0 PID: 21165 Comm: syz-executor6 Not tainted 4.15.0-rc6 #18
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:17 [inline]
>>  dump_stack+0x104/0x1c5 lib/dump_stack.c:53
>>  print_address_description+0x6e/0x280 mm/kasan/report.c:252
>>  kasan_report_error mm/kasan/report.c:351 [inline]
>>  kasan_report+0x254/0x340 mm/kasan/report.c:409
>>  disk_unblock_events+0x4b/0x50 block/genhd.c:1657
>>  __blkdev_get+0x5f5/0xdb0 fs/block_dev.c:1535
>>  blkdev_get+0x338/0x9e0 fs/block_dev.c:1591
>>  blkdev_open+0x1bd/0x240 fs/block_dev.c:1749
>>  do_dentry_open+0x682/0xd80 fs/open.c:752
>>  vfs_open+0x107/0x220 fs/open.c:866
>>  do_last fs/namei.c:3379 [inline]
>>  path_openat+0x1051/0x3220 fs/namei.c:3519
>>  do_filp_open+0x25b/0x3b0 fs/namei.c:3554
>>  do_sys_open+0x4ab/0x650 fs/open.c:1059
>>  entry_SYSCALL_64_fastpath+0x1f/0x96
>> RIP: 0033:0x40cd41
>> RSP: 002b:00007ff1c06e5780 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
>> RAX: ffffffffffffffda RBX: 000000000071bf58 RCX: 000000000040cd41
>> RDX: 0000000000000000 RSI: 0000000000080102 RDI: 00007ff1c06e5830
>> RBP: 00000000000001e4 R08: 000000000000ffff R09: 0000000000000000
>> R10: 0000000020024400 R11: 0000000000000293 R12: 00000000006efe00
>> R13: 00000000ffffffff R14: 00007ff1c06e66d4 R15: 0000000000000002
>>
>>
>> Allocated by task 21138:
>>  set_track mm/kasan/kasan.c:459 [inline]
>>  kasan_kmalloc+0xa9/0xd0 mm/kasan/kasan.c:551
>>  kmem_cache_alloc_node_trace+0x153/0x280 mm/slub.c:2780
>>  kmalloc_node include/linux/slab.h:537 [inline]
>>  kzalloc_node include/linux/slab.h:699 [inline]
>>  __alloc_disk_node+0xab/0x490 block/genhd.c:1400
>>  loop_add+0x42f/0xa00 drivers/block/loop.c:1808
>>  loop_control_ioctl+0x11c/0x450 drivers/block/loop.c:1940
>>  vfs_ioctl fs/ioctl.c:46 [inline]
>>  do_vfs_ioctl+0x18b/0x13c0 fs/ioctl.c:686
>>  SYSC_ioctl fs/ioctl.c:701 [inline]
>>  SyS_ioctl+0x7e/0xb0 fs/ioctl.c:692
>>  entry_SYSCALL_64_fastpath+0x1f/0x96
>>
>>
>> Freed by task 21165:
>>  set_track mm/kasan/kasan.c:459 [inline]
>>  kasan_slab_free+0x71/0xc0 mm/kasan/kasan.c:524
>>  slab_free_hook mm/slub.c:1391 [inline]
>>  slab_free_freelist_hook mm/slub.c:1412 [inline]
>>  slab_free mm/slub.c:2968 [inline]
>>  kfree+0xe2/0x2c0 mm/slub.c:3899
>>  disk_release+0x300/0x3c0 block/genhd.c:1249
>>  device_release+0x76/0x200 drivers/base/core.c:814
>>  kobject_cleanup lib/kobject.c:648 [inline]
>>  kobject_release lib/kobject.c:677 [inline]
>>  kref_put include/linux/kref.h:70 [inline]
>>  kobject_put+0x13d/0x230 lib/kobject.c:694
>>  put_disk+0x1f/0x30 block/genhd.c:1465
>>  __blkdev_get+0x560/0xdb0 fs/block_dev.c:1528
>>  blkdev_get+0x338/0x9e0 fs/block_dev.c:1591
>>  blkdev_open+0x1bd/0x240 fs/block_dev.c:1749
>>  do_dentry_open+0x682/0xd80 fs/open.c:752
>>  vfs_open+0x107/0x220 fs/open.c:866
>>  do_last fs/namei.c:3379 [inline]
>>  path_openat+0x1051/0x3220 fs/namei.c:3519
>>  do_filp_open+0x25b/0x3b0 fs/namei.c:3554
>>  do_sys_open+0x4ab/0x650 fs/open.c:1059
>>  entry_SYSCALL_64_fastpath+0x1f/0x96
>>
>>
>> The buggy address belongs to the object at ffff880035c26e80
>>  which belongs to the cache kmalloc-2048 of size 2048
>> The buggy address is located 1400 bytes inside of
>>  2048-byte region [ffff880035c26e80, ffff880035c27680)
>> The buggy address belongs to the page:
>> page:0000000003af101f count:1 mapcount:0 mapping:          (null) index:0x0 compound_mapcount: 0
>> flags: 0x100000000008100(slab|head)
>> raw: 0100000000008100 0000000000000000 0000000000000000 00000001000f000f
>> raw: ffffea0000946a00 0000000200000002 ffff880035c02d80 0000000000000000
>> page dumped because: kasan: bad access detected
>>
>>
>> Memory state around the buggy address:
>>  ffff880035c27280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>  ffff880035c27300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>> ffff880035c27380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>                                                                 ^
>>  ffff880035c27400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>  ffff880035c27480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ==================================================================
>>
>>
>>
>>
>>
> 
> 
>> #include <stdio.h>
>> #include <string.h>
>> #include <errno.h>
>> #include <stdlib.h>
>> #include <unistd.h>
>> #include <fcntl.h>
>> #include <pthread.h>
>> #include <arpa/inet.h>
>> #include <sys/types.h>
>> #include <sys/socket.h>
>> #include <sys/syscall.h>
>> #include <sys/mman.h>
>> #include <sys/time.h>
>> #include <sys/resource.h>
>> #include <netinet/in.h>
>> #include <netinet/udp.h>
>> #include <netinet/ip.h>
>> #include <linux/xfrm.h>
>> #include <linux/netlink.h>
>> #include <linux/loop.h>
>> #include <stdarg.h>
>> #include <stdbool.h>
>> #include <stddef.h>
>> #include <sys/prctl.h>
>> #include <sys/time.h>
>> #include <sys/resource.h>
>>
>> #define false 0
>> #define true 1
>> int controlfd;
>> int count = 0;
>>
>> #define ERR_EXIT1(m) \
>>         do \
>>         { \
>>                 perror(m); \
>>                 exit(EXIT_FAILURE); \
>>         } while(0)
>>
>> #define ERR_EXIT(m) \
>>         do \
>>         { \
>>                 perror(m); \
>>         } while(0)
>>
>> void send_fd(int sock_fd, int send_fd) {
>> 	int ret;
>> 	struct msghdr msg;
>> 	struct cmsghdr *p_cmsg;
>> 	struct iovec vec;
>> 	char cmsgbuf[CMSG_SPACE(sizeof(send_fd) * 253)];
>> 	printf("cmsgbuf size:%d \n", sizeof(cmsgbuf));
>> 	int *p_fds;
>> 	char sendchar = 0;
>> 	int i;
>> 	msg.msg_control = cmsgbuf;
>> 	msg.msg_controllen = sizeof(cmsgbuf);
>> 	p_cmsg = CMSG_FIRSTHDR(&msg);
>> 	p_cmsg->cmsg_level = SOL_SOCKET;
>> 	p_cmsg->cmsg_type = SCM_RIGHTS;
>> 	p_cmsg->cmsg_len = CMSG_LEN(sizeof(send_fd) * 253);
>> 	p_fds = (int *) CMSG_DATA(p_cmsg);
>> 	for (i = 0; i < 253; i++) {
>> 		p_fds[i] = send_fd; // ??????????????????????????????????????????????????????
>> 	}
>>
>> 	msg.msg_name = NULL;
>> 	msg.msg_namelen = 0;
>> 	msg.msg_iov = &vec;
>> 	msg.msg_iovlen = 1; //??????????????????????????????????????????1?????????
>> 	msg.msg_flags = 0;
>>
>> 	vec.iov_base = &sendchar;
>> 	vec.iov_len = sizeof(sendchar);
>> 	while (1) {
>> 		ret = sendmsg(sock_fd, &msg, 0);
>> 		if (ret != 1)
>> 			ERR_EXIT("sendmsg");
>> 	}
>> }
>>
>> int recv_fd(const int sock_fd) {
>> 	int ret;
>> 	struct msghdr msg;
>> 	char recvchar;
>> 	struct iovec vec;
>> 	int recv_fd;
>> 	char cmsgbuf[CMSG_SPACE(sizeof(recv_fd))];
>> 	struct cmsghdr *p_cmsg;
>> 	int *p_fd, i;
>> 	vec.iov_base = &recvchar;
>> 	vec.iov_len = sizeof(recvchar);
>> 	msg.msg_name = NULL;
>> 	msg.msg_namelen = 0;
>> 	msg.msg_iov = &vec;
>> 	msg.msg_iovlen = 1;
>> 	msg.msg_control = cmsgbuf;
>> 	msg.msg_controllen = sizeof(cmsgbuf);
>> 	msg.msg_flags = 0;
>>
>> 	p_fd = (int *) CMSG_DATA(CMSG_FIRSTHDR(&msg));
>> 	*p_fd = -1;
>> 	while (1) {
>> 		ret = recvmsg(sock_fd, &msg, 0);
>> 		if (ret < 0) {
>> 			char buff[256];
>> 			snprintf(buff, "recvmsg11: sock_fd:%d ret:%d", sock_fd, ret);
>> 			ERR_EXIT(buff);
>> 		}
>>
>> 		p_cmsg = CMSG_FIRSTHDR(&msg);
>> 		if (p_cmsg == NULL)
>> 			ERR_EXIT("no passed fd");
>>
>> 		p_fd = (int *) CMSG_DATA(p_cmsg);
>> 		for (i = 0; i < 253; i++) {
>> 			close(p_fd[i]);
>> 		}
>> 	}
>> 	recv_fd = *p_fd;
>> 	if (recv_fd == -1)
>> 		ERR_EXIT("no passed fd");
>>
>> 	return recv_fd;
>> }
>>
>> int test_main(void) {
>> 	int sockfds[2];
>> 	/* ??????unix????????????????????????????????????????????????????????????????????????????????????????????????
>> 	 * ?????????????????????socketpair???????????????socket()?????? */
>> 	if (socketpair(PF_UNIX, SOCK_STREAM, 0, sockfds) < 0)
>> 		ERR_EXIT("socketpair");
>>
>> 	pid_t pid;
>> 	pid = fork();
>> 	if (pid == -1)
>> 		ERR_EXIT("fork");
>> 	/* ??????????????????????????????????????????????????????????????????
>> 	 * ??????????????????????????????????????????????????????????????????????????????????????? */
>> 	if (pid > 0) {
>> 		close(sockfds[1]);
>> 		int fd = recv_fd(sockfds[0]);
>> 		char buf[1024] = { 0 };
>> 		read(fd, buf, sizeof(buf));
>> 	} else if (pid == 0) {
>> 		close(sockfds[0]);
>> 		int fd;
>> 		fd = open("test.txt", O_RDONLY);
>> 		if (fd == -1)
>> 			ERR_EXIT("open");
>> 		send_fd(sockfds[1], fd);
>> 	}
>> 	return 0;
>> }
>>
>> int main(int argc, char *argv[]) {
>> 	int ret;
>> 	int child_pid;
>> 	int fd;
>> 	int loop_index;
>> 	if (argc >= 2) {
>> 		loop_index = atoi(argv[1]);
>> 	} else {
>> 		loop_index = 9;
>> 	}
>> 	child_pid = fork();
>> 	if (child_pid) {
>> 		child_pid = fork();
>> 		if (child_pid) {
>> 			child_pid = fork();
>> 			child_pid = fork();
>> 			while (1) {
>> 				count++;
>> 				count = count * 2;
>> 			}
>> 		} else {
>> 			test_main();
>> 		}
>> 	}
>> 	child_pid = fork();
>>
>> 	if (child_pid) {
>> 		printf("pid:%d nice:%d \n", getpid(), getpriority(PRIO_PROCESS, getpid()));
>> 		controlfd = open("/dev/loop-control", O_RDWR);
>> 		while (controlfd >= 0) {
>> 			ret = ioctl(controlfd, LOOP_CTL_ADD, loop_index);
>> 			ret = ioctl(controlfd, LOOP_CTL_REMOVE, loop_index);
>> 		}
>> 		close(controlfd);
>> 	} else {
>> 		child_pid = fork();
>> 		printf("pid:%d  nice:%d \n", getpid(), getpriority(PRIO_PROCESS, getpid()));
>> 		char name[100];
>> 		memset(name, 0, 100);
>> 		snprintf(name, 100, "/dev/loop%d", loop_index);
>> 		if (child_pid) {
>> 			prctl(PR_SET_NAME, "ppp");
>> 			setpriority(PRIO_PROCESS, getpid(), 0);
>> 			while (1) {
>> 				fd = open(name, O_RDONLY);
>> 				if (fd <= 0) {
>> 					continue;
>> 				}
>> 				ret = close(fd);
>> 			}
>> 		} else {
>> 			child_pid = fork();
>> 			prctl(PR_SET_NAME, "ccc");
>> 			setpriority(PRIO_PROCESS, getpid(), -5);
>> 			while (1) {
>> 				fd = open(name, O_RDONLY);
>> 				if (fd <= 0) {
>> 					continue;
>> 				}
>> 				ret = close(fd);
>> 			}
>> 		}
>> 	}
>> }
> 
> 
> 
> 
> .
> 
