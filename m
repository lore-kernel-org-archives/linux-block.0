Return-Path: <SRS0=Qtc1=YI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805A5ECE58F
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 23:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9F020659
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 23:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="Ppi+BUxN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387885AbfJOXna (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Oct 2019 19:43:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41226 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387852AbfJOXna (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 19:43:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id q7so13463042pfh.8
        for <linux-block@vger.kernel.org>; Tue, 15 Oct 2019 16:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=53D4e9xh+xTS2RL/zhUhHoK11ha02A6AAm45LHx846o=;
        b=Ppi+BUxN0J6Hr/yjzJJ7tf7mFpx1XV4mHkv8a8bKsinq2PlaMWtW0fgi+zm2T2YHi4
         Fk+TKhiz3zd37VV6pm+uo4I4ArigJ/eoEIvIsUm2r4mguAq9yNlimdTPyQP8KBxMGVXH
         VRAs25DgObeEB8YZIUmz0wicC8ZMeaQfci0udplwkfAvUChxWWdv2zS/2KEQvUXT2Koy
         jvbwTiCgQvuPZw7DLEOAOknJKV4mPt2qEs9EZhRSBz+7sdVkUdTX3yzkFrh0kShtpBOQ
         HL97V1QaqypOQYRd1ru1ldr3Ta+BqeBF7RkthDH+p6V4o7gNcL77pJcWQu0ygP3ZvdpO
         ZEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=53D4e9xh+xTS2RL/zhUhHoK11ha02A6AAm45LHx846o=;
        b=HHFPaWl3PAt6kkR0olZpKbduMPWonObFRz91RuVLe40pMhsXkgn8GSNDMQFciLqLsb
         jBAzGeZRfS2LqgcjPJbaBnJ4wDHh1S1i36a3P0bRNY9P1p7PY/gvPz52diYuc2bsaB18
         GJr0Joj+mpqTpW4DQI4bbM7rT8CjPxo9z0nxYB90XEWIYMWIqIu4uF57UZFDzIPTVRaS
         RbEm1ecHlVhnbBDoY8PRgKKbnsSSWNFWyIbPIuC7KXGcshq5USSNt+r93d/cMcRrPjvS
         bQMIWBJKdp1plOshM/0lxxEKv05VcmopqkEyoMXfd8ztZGoRgKUtciNlHOy1Wn06C5vm
         /rgQ==
X-Gm-Message-State: APjAAAUGa8pjkp+v6tktTbNPjezfuTWQoP5XuTgcjZS9Fn/kLE0N3Fuv
        Gbek2nmfcXyIgnj0Eu0UOCnFVj7R0qg=
X-Google-Smtp-Source: APXvYqxFuLNP6RLzwBHRnRn7Q0RXGrGTPt57Es46AvqvEl9qOohBruTxJB6+xfee25thf6pa7vGRlw==
X-Received: by 2002:a63:fd4b:: with SMTP id m11mr20762795pgj.452.1571183009324;
        Tue, 15 Oct 2019 16:43:29 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::2:3e5e])
        by smtp.gmail.com with ESMTPSA id 6sm19769463pgl.40.2019.10.15.16.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 16:43:28 -0700 (PDT)
Date:   Tue, 15 Oct 2019 16:43:27 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Sun Ke <sunke32@huawei.com>
Cc:     osandov@fb.com, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests v2] nbd/003:add mount and clear_sock test for nbd
Message-ID: <20191015234327.GC483958@vader>
References: <1568702991-69027-1-git-send-email-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568702991-69027-1-git-send-email-sunke32@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 17, 2019 at 02:49:51PM +0800, Sun Ke wrote:
> Add the test case to check nbd devices.This test case catches regressions
> fixed by commit 92b5c8f0063e4 "nbd: replace kill_bdev() with
> __invalidate_device() again".
> 
> Establish the nbd connection.Run two processes.One do mount and umount,
> anther one do clear_sock ioctl.
> 
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
>  src/Makefile           |  3 ++-
>  src/mount_clear_sock.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nbd/003          | 66 ++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nbd/003.out      |  1 +
>  4 files changed, 137 insertions(+), 1 deletion(-)
>  create mode 100644 src/mount_clear_sock.c
>  create mode 100644 tests/nbd/003
>  create mode 100644 tests/nbd/003.out
> 
> diff --git a/src/Makefile b/src/Makefile
> index 917d6f4..acd7327 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -10,7 +10,8 @@ C_TARGETS := \
>  	sg/syzkaller1 \
>  	nbdsetsize \
>  	loop_change_fd \
> -	zbdioctl
> +	zbdioctl \
> +	mount_clear_sock
>  
>  CXX_TARGETS := \
>  	discontiguous-io
> diff --git a/src/mount_clear_sock.c b/src/mount_clear_sock.c
> new file mode 100644
> index 0000000..f6eef5a
> --- /dev/null
> +++ b/src/mount_clear_sock.c
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-3.0+
> +// Copyright (C) 2019 Sun Ke
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +
> +#include <linux/nbd.h>
> +#include <assert.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +#include <sys/mount.h>
> +#include <linux/fs.h>
> +
> +void clear_sock(int fd)
> +{
> +	int err;
> +
> +	err = ioctl(fd, NBD_CLEAR_SOCK, 0);
> +	if (err) {
> +		perror("ioctl");
> +	}
> +}
> +
> +void mount_nbd(char *dev, char *mp, char *fs)
> +{
> +	mount(dev, mp, fs, MS_NOSUID | MS_SYNCHRONOUS, 0);
> +	umount(mp);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	if (argc != 4) {
> +		fprintf(stderr, "usage: $0 MOUNTPOINT DEV FS");
> +		return EXIT_FAILURE;
> +	}
> +
> +	char *mp = argv[1];
> +	char *dev = argv[2];
> +	char *fs = argv[3];
> +	
> +	static int fd = -1;
> +
> +	fd = open(dev, O_RDWR);
> +	if (fd < 0 ) {
> +		perror("open");
> +	}
> +
> +	if (fork() == 0) {
> +		mount_nbd(dev, mp, fs);
> +		exit(0);
> +	}
> +	if (fork() == 0) {
> +		clear_sock(fd);
> +		exit(0);
> +	}
> +	while(wait(NULL) > 0)
> +		continue;
> +	
> +	close(fd);
> +
> +	return 0;
> +}
> diff --git a/tests/nbd/003 b/tests/nbd/003
> new file mode 100644
> index 0000000..45093aa
> --- /dev/null
> +++ b/tests/nbd/003
> @@ -0,0 +1,66 @@
> +#!/bin/bash
> +
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2019 Sun Ke
> +#
> +# Test nbd device resizing. Regression test for patch 
> +#
> +# 2b5c8f0063e4 ("nbd: replace kill_bdev() with __invalidate_device() again")
> +
> +
> +DESCRIPTION="resize a connected nbd device"
> +QUICK=1
> +
> +fs_type=ext4
> +disk_capacity=256M
> +run_cnt=1
> +
> +requires() {
> +	_have_nbd && _have_src_program mount_clear_sock
> +}
> +
> +_start_nbd_mount_server() {
> +
> +	fallocate -l $1 "${TMPDIR}/mnt_$i"
> +
> +	if [[ "$2"x = "ext4"x ]]; then
> +		mkfs.ext4 "${TMPDIR}/mnt_$i" >> "$FULL" 2>&1
> +	else
> +		mkdosfs "${TMPDIR}/mnt_$i" >> "$FULL" 2>&1
> +	fi
> +	nbd-server 800$i "${TMPDIR}/mnt_$i" >> "$FULL" 2>&1
> +
> +	mkdir -p "${TMPDIR}/$i"
> +}
> +
> +_stop_nbd_mount_server() {
> +	pkill -9 -f 800$i
> +	rm -f "${TMPDIR}/mnt_$i"
> +	rm -rf "${TMPDIR}/$i"
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +	for ((i = 0; i < 15; i++))
> +	do
> +		_start_nbd_mount_server  $disk_capacity $fs_type
> +		nbd-client localhost 800$i /dev/nbd$i >> "$FULL" 2>&1
> +		if [[ "$?" -ne "0" ]]; then
> +			echo "nbd$i connnect failed" 
> +		fi 
> +	done
> +
> +	for ((j = 0; j < $run_cnt; j++))
> +	do
> +		for ((i = 0; i < 15; i++))
> +		do
> +			src/mount_clear_sock  "${TMPDIR}/$i" /dev/nbd$i $fs_type
> +		done
> +	done	
> +
> +	for ((i = 0; i < 15; i++))
> +	do
> +		nbd-client -d /dev/nbd$i
> +		_stop_nbd_mount_server
> +	done
> +}

Sorry for the delay, it's been a busy few weeks.

I'm still not seeing why it's necessary to create 15 connections. You
create 15 devices one by one, run the test on each one, one by one, and
tear them down, one by one. This is not parallelized, so why is it
faster to have 15 devices than just one?
