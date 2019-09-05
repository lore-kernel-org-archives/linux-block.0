Return-Path: <SRS0=DC0a=XA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF6CC3A5A5
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 06:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5B621743
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 06:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbfIEGGA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Sep 2019 02:06:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6675 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728267AbfIEGGA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Sep 2019 02:06:00 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DDCE6C072835D2BB6C4E;
        Thu,  5 Sep 2019 14:05:58 +0800 (CST)
Received: from [127.0.0.1] (10.184.194.169) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Sep 2019
 14:05:55 +0800
Subject: Re: [PATCH blktests] nbd/003:add mount and clear_sock test for nbd
To:     Omar Sandoval <osandov@osandov.com>
CC:     <osandov@fb.com>, <linux-block@vger.kernel.org>
References: <1567567949-87156-1-git-send-email-sunke32@huawei.com>
 <20190904174240.GC7452@vader>
From:   "sunke (E)" <sunke32@huawei.com>
Message-ID: <cea59c46-52ba-942a-bab3-bcf0ebeb71c6@huawei.com>
Date:   Thu, 5 Sep 2019 14:05:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190904174240.GC7452@vader>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.194.169]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Thanks for your careful guidance.


ÔÚ 2019/9/5 1:42, Omar Sandoval Ð´µÀ:
> On Wed, Sep 04, 2019 at 11:32:29AM +0800, Sun Ke wrote:
>> Add the test case to check nbd devices.This test case catches regressions
>> fixed by commit 92b5c8f0063e4 "nbd: replace kill_bdev() with
>> __invalidate_device() again".
>>
>> Establish the nbd connection.Run two processes.One do mount and umount,
>> anther one do clear_sock ioctl.
>>
>> Signed-off-by: Sun Ke <sunke32@huawei.com>
> 
> Thanks for the test! A few comments below.
> 
>> ---
>>   src/Makefile      |  3 +-
>>   src/nbdmount.c    | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/nbd/003     | 47 +++++++++++++++++++++++++++++
>>   tests/nbd/003.out |  1 +
>>   tests/nbd/rc      | 22 ++++++++++++++
>>   5 files changed, 161 insertions(+), 1 deletion(-)
>>   create mode 100644 src/nbdmount.c
>>   create mode 100644 tests/nbd/003
>>   create mode 100644 tests/nbd/003.out
>>
>> diff --git a/src/Makefile b/src/Makefile
>> index 917d6f4..f48f264 100644
>> --- a/src/Makefile
>> +++ b/src/Makefile
>> @@ -10,7 +10,8 @@ C_TARGETS := \
>>   	sg/syzkaller1 \
>>   	nbdsetsize \
>>   	loop_change_fd \
>> -	zbdioctl
>> +	zbdioctl \
>> +	nbdmount
> 
> This could use a less generic name.
> 
>>   CXX_TARGETS := \
>>   	discontiguous-io
>> diff --git a/src/nbdmount.c b/src/nbdmount.c
>> new file mode 100644
>> index 0000000..bd77c32
>> --- /dev/null
>> +++ b/src/nbdmount.c
>> @@ -0,0 +1,89 @@
>> +// SPDX-License-Identifier: GPL-3.0+
>> +// Copyright (C) 2019 Sun Ke
>> +
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +
>> +#include <sys/types.h>
>> +#include <sys/stat.h>
>> +#include <fcntl.h>
>> +
>> +#include <linux/nbd.h>
>> +#include <assert.h>
>> +#include <sys/wait.h>
>> +#include <unistd.h>
>> +#include <string.h>
>> +#include <sys/ioctl.h>
>> +#include <sys/mount.h>
>> +#include <linux/fs.h>
>> +
>> +struct mount_para
>> +{
>> +	char *mp;
>> +	char *dev;
>> +	char *fs;
>> +};
>> +
>> +struct mount_para para;
> 
> Get rid of this structure and global variable, just pass the fields to
> ops_nbd().
> 
>> +static int nbd_fd = -1;
> 
> Same here, this doesn't really need to be global.
> 
>> +void setup_nbd(char *dev)
>> +{
>> +	nbd_fd = open(dev, O_RDWR);
>> +	if (nbd_fd < 0 ) {
>> +		printf("open the nbd failed\n");
> 
> Instead of printf(), do:
> 
> 		perror("open");
> 
>> +	}
>> +}
>> +
>> +void teardown_nbd(void)
>> +{
>> +	close(nbd_fd);
>> +}
> 
> Fold these two trival functions (setup_nbd() and teardown_nbd()) into
> main().
> 
>> +void clear_sock(void)
>> +{
>> +	int err;
>> +
>> +	err = ioctl(nbd_fd, NBD_CLEAR_SOCK, 0);
>> +	assert(!err);
>> +}
> 
> perror("ioctl")
> 
>> +void mount_nbd(char *dev, char *mp, char *fs)
>> +{
>> +	mount(dev, mp, fs, 2 | 16, 0);
> 
> What are these flags?      ^^^^^^
> 
>> +	umount(mp);
>> +}
>> +
>> +void ops_nbd(void)
>> +{
>> +	int i;
>> +
>> +	fflush(stdout);
> 
> What is this fflush() here for?
> 
>> +	for (i=0; i < 2; i++) {
>> +		if (fork() == 0) {
>> +			if (i == 0) {
>> +				mount_nbd(para.dev, para.mp, para.fs);
>> +				exit(0);
>> +			}
>> +			if (i == 1) {
>> +				clear_sock();
>> +				exit(0);
>> +			}
>> +		}
>> +	}
> 
> This shouldn't be a loop. You can do:
> 
> if (fork() == 0) {
> 	mount_nbd(dev, mp, fs);
> 	exit(0);
> }
> if (fork() == 0) {
> 	clear_sock(fd);
> 	exit(0);
> }
> 
>> +	while(wait(NULL) > 0)
>> +		continue;
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
> 
> Check argc and print a usage message here, please:
> 
> if (argc != 4) {
> 	fprintf(stderr, "usage: $0 MOUNTPOINT DEV FS");
> 	return EXIT_FAILURE;
> }
> 
>> +	para.mp = argv[1];
>> +	para.dev = argv[2];
>> +	para.fs = argv[3];
>> +
>> +	setup_nbd(para.dev);
>> +	ops_nbd();
>> +	teardown_nbd();
>> +
>> +	return 0;
>> +}
>> diff --git a/tests/nbd/003 b/tests/nbd/003
>> new file mode 100644
>> index 0000000..1c2dcea
>> --- /dev/null
>> +++ b/tests/nbd/003
>> @@ -0,0 +1,47 @@
>> +#!/bin/bash
>> +
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2019 Sun Ke
>> +#
>> +# Test nbd device resizing. Regression test for patch
>> +#
>> +# 2b5c8f0063e4 ("nbd: replace kill_bdev() with __invalidate_device() again")
>> +
>> +. tests/nbd/rc
>> +
>> +DESCRIPTION="resize a connected nbd device"
>> +QUICK=1
>> +
>> +fs_type=ext4
>> +disk_capacity=256M
>> +run_cnt=1
>> +
>> +requires() {
>> +	_have_nbd && _have_src_program nbdmount
>> +}
>> +
>> +test() {
>> +	echo "Running ${TEST_NAME}"
>> +	for i in $(seq 0 15)
> 
> As documented in the new test template:
> 
> 	Use bash for loops instead of seq. E.g., for ((i = 0; i < 10; i++)), not
> 	for i in $(seq 0 9).
> 
>> +	do
>> +		_start_nbd_mount_server  $disk_capacity $fs_type
>> +		nbd-client localhost 800$i /dev/nbd$i >> "$FULL" 2>&1
> 
> So the test creates 15 nbd connections, runs the test on all of them,
> then tears them down? Would it work to only use one connection and just
> repeat the test 15 times? That way you can keep track of the nbd-client
> process to kill instead of having to use pkill later down.
> 
>> +		if [ "$?" -ne "0" ]; then
> 
> Also from the new test template:
> 
> 	Use the bash [[ ]] form of tests instead of [ ].
> 
>> +			echo "nbd$i connnect failed"
>> +		fi
>> +	done
>> +
>> +	for j in $(seq 0 $run_cnt)
>> +	do
>> +		for i in $(seq 0 15)
>> +		do
>> +			src/nbdmount  "${TMPDIR}/$i" /dev/nbd$i $fs_type
> 
> Also from the new test template:
> 
> 	Always quote variable expansions unless the variable is a number or inside of
> 	a [[ ]] test.
> 
>> +		done
>> +	done	
> 
>> +
>> +	for i in $(seq 0 15)
>> +	do
>> +		nbd-client -d /dev/nbd$i
>> +		_stop_nbd_mount_server
>> +	done
>> +}
>> diff --git a/tests/nbd/003.out b/tests/nbd/003.out
>> new file mode 100644
>> index 0000000..aa340db
>> --- /dev/null
>> +++ b/tests/nbd/003.out
>> @@ -0,0 +1 @@
>> +Running nbd/003
>> diff --git a/tests/nbd/rc b/tests/nbd/rc
>> index 9d0e3d1..eb7ff24 100644
>> --- a/tests/nbd/rc
>> +++ b/tests/nbd/rc
>> @@ -76,3 +76,25 @@ _stop_nbd_server() {
>>   	rm -f "${TMPDIR}/nbd.pid"
>>   	rm -f "${TMPDIR}/export"
>>   }
>> +
>> +
>> +_start_nbd_mount_server() {
>> +
>> +	fallocate -l $1 "${TMPDIR}/mnt_$i"
>> +
>> +	if [ "$2"x = "ext4"x ];
>> +	then
>> +		mkfs.ext4 "${TMPDIR}/mnt_$i" >> "$FULL" 2>&1
>> +	else
>> +		mkdosfs "${TMPDIR}/mnt_$i" >> "$FULL" 2>&1
>> +	fi
>> +	nbd-server 800$i "${TMPDIR}/mnt_$i" >> "$FULL" 2>&1
>> +
>> +	mkdir -p "${TMPDIR}/$i"
>> +}
>> +
>> +_stop_nbd_mount_server() {
>> +	pkill -9 -f 800$i
>> +	rm -f "${TMPDIR}/mnt_$i"
>> +	rm -rf "${TMPDIR}/$i"
>> +}
> 
> These helpers are using a variable ($i) that happens to be set by the
> calling function. That's really icky. Just fold these into your test
> case, we can make them generic helpers if someone else needs them.
> 
> .
> 

