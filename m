Return-Path: <SRS0=q1Dd=2J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05276C43603
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 22:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC10C24672
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 22:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="MRTagRrM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfLSWfX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:35:23 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35970 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfLSWfX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Dec 2019 17:35:23 -0500
Received: by mail-pf1-f193.google.com with SMTP id x184so4100865pfb.3
        for <linux-block@vger.kernel.org>; Thu, 19 Dec 2019 14:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YXSmp95bZSD6e2oqnIbkZimcRAcQVtg6Sl9xZBUqcqk=;
        b=MRTagRrMY77+N+UgeI6wPswGdIHG11Vt152fcSESZ/rsA0xgSn+TAkOO0zEjTAL5T9
         dh1wd4HxPo1Yq5g+5jeQhhQWS6GuZ+551bCX0xbzwddLVeG7DPs/WE+qiRGdIVNG95zS
         nNU7noNlyFsqPuI09K17vHy9bUPgLdxqPyIl812z80ndaDjLKtrH6Ybb6mZsjeYFjTox
         F8tL84mTDamPYsB/nh//ivGuluJ+0ymqdKIE3VhF6z0Ro4R4qv7W1R81res0cJgVew6L
         CP3GzpOgHfEFyO9ta0KJWdhsSzjx2JJCToxCnEkAU0H2Ygyy1SH6zIR3z9QPQsUwd0gp
         xQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YXSmp95bZSD6e2oqnIbkZimcRAcQVtg6Sl9xZBUqcqk=;
        b=mq5rGdxdCFP/JKLYY1h8xsPlj+al+xB0duF+XQo3PVe3D6NHyY3YpDx0Ejy+NJCJgM
         P0sTS8N8A24ckFiDoCuLnwEhp+WhF6yQVfE0qGgct+9EP5aa26knSGqI4d5oDO5IpJbt
         H2nl6q8lzLiG5jAQZOqORCxVCg3J2hKTC0hTS2De3TJcaVrpL7GnhbXi+KMtQo1ijerU
         4owsfl4sHkjRWptTFE12FStMMsA1h+C5s6BXTbc9ZzCiH3J3izjshwcyyTpQWZFYp+yh
         BZZnmWKSHCcE5dTj/gHV/BDndLrRIF2yBRp3xufMwgTNbwAd0RxwK7nt1MjIuRSHTdVJ
         wiWw==
X-Gm-Message-State: APjAAAUnaJMcGQXWbeDqo4vPRyLompt6FqnR/+BcnoxQaQNq3iyt+7q9
        +sFzBbDbRU0fnzkDQZx6OFjX5A==
X-Google-Smtp-Source: APXvYqxaUndZSdqiwsbOV9WOukn3D8XNXyad5G3zjNK151TpcCzhhNohtviq/Zqk+0YrMpb19z5NSQ==
X-Received: by 2002:aa7:9522:: with SMTP id c2mr12208014pfp.43.1576794920839;
        Thu, 19 Dec 2019 14:35:20 -0800 (PST)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id s196sm9899239pfs.136.2019.12.19.14.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 14:35:20 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:35:19 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Sun Ke <sunke32@huawei.com>
Cc:     linux-block@vger.kernel.org, osandov@fb.com
Subject: Re: [PATCH blktests v3] nbd/003:add mount and clear_sock test for nbd
Message-ID: <20191219223519.GB830111@vader>
References: <1575115540-69845-1-git-send-email-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575115540-69845-1-git-send-email-sunke32@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Nov 30, 2019 at 08:05:40PM +0800, Sun Ke wrote:
> Add the test case to check nbd device. This test case catches regressions
> fixed by commit 92b5c8f0063e4 "nbd: replace kill_bdev() with
> __invalidate_device() again".
> 
> Establish the nbd connection. Run two processes. The first one do mount
> and umount, and the other one do clear_sock ioctl.
> 
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
> v2 -> v3
> 1. Now only build nbd0 connection, not 15 connections.
> 2. Add the run_cnt to 225.
> 3. Modify some variable names.

mount_clear_sock still seems overly complicated, so I simplified it.
Additionally, we can loop from the C program instead of looping in the
shell script and execing a bunch of times. And, it seems like we can use
the existing _start_nbd_server/_stop_nbd_server helpers now that we're
only using one connection. I made those changes here:
https://github.com/osandov/blktests/commit/ab2472ee1c54f7fc69011815e15515846ae40eea
Would you mind taking a look and ensuring that it still does what you're
trying to do? I seem to have triggered some other sort of deadlock in
NBD with the optimized test.

> ---
>  src/Makefile           |  3 ++-
>  src/mount_clear_sock.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nbd/003          | 55 ++++++++++++++++++++++++++++++++++++++++
>  tests/nbd/003.out      |  1 +
>  4 files changed, 126 insertions(+), 1 deletion(-)
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
> index 0000000..c76cbfe
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
> index 0000000..738928e
> --- /dev/null
> +++ b/tests/nbd/003
> @@ -0,0 +1,55 @@
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
> +run_cnt=225
> +
> +requires() {
> +	_have_nbd && _have_src_program mount_clear_sock
> +}
> +
> +_start_nbd_mount_server() {
> +
> +	fallocate -l $1 "${TMPDIR}/disk"
> +
> +	if [[ "$2"x = "ext4"x ]]; then
> +		mkfs.ext4 "${TMPDIR}/disk" >> "$FULL" 2>&1
> +	else
> +		mkdosfs "${TMPDIR}/disk" >> "$FULL" 2>&1
> +	fi
> +	nbd-server 8000 "${TMPDIR}/disk" >> "$FULL" 2>&1
> +
> +	mkdir -p "${TMPDIR}/mount_point"
> +}
> +
> +_stop_nbd_mount_server() {
> +	pkill -9 -f 8000
> +	rm -f "${TMPDIR}/disk"
> +	rm -rf "${TMPDIR}/mount_point"
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	_start_nbd_mount_server  $disk_capacity $fs_type
> +	nbd-client localhost 8000 /dev/nbd0 >> "$FULL" 2>&1
> +
> +	for ((i = 0; i < $run_cnt; i++))
> +	do
> +		src/mount_clear_sock  "${TMPDIR}/mount_point" /dev/nbd0 $fs_type
> +	done
> +
> +	nbd-client -d /dev/nbd0
> +	_stop_nbd_mount_server
> +}
> diff --git a/tests/nbd/003.out b/tests/nbd/003.out
> new file mode 100644
> index 0000000..aa340db
> --- /dev/null
> +++ b/tests/nbd/003.out
> @@ -0,0 +1 @@
> +Running nbd/003
> -- 
> 2.13.6
> 
