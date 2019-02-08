Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF87DC169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 17:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E254217D8
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 17:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SMAj0GfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfBHReb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:34:31 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:53203 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfBHReb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 12:34:31 -0500
Received: by mail-it1-f195.google.com with SMTP id r11so5304991itc.2
        for <linux-block@vger.kernel.org>; Fri, 08 Feb 2019 09:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=+ICxFTArJB/ArX+PK+PZ7RAIzt9LoW68IOg9zQU5NKs=;
        b=SMAj0GfKPO3uoWYAMQ//TXD6pxDWiuoaky05YTbC8QwQsh0l8TXRBYBS2JV4YyWDzY
         oxbyw4xiimX9yzcNEhywSPpedoNFnHrgIC+FVxh5KdezXf7lP280aOqE1v2V47nTij0F
         ksRqpKMi1xFsg+3dv253fBIiwN5Jff2h7xBWZB5VMG3+cxbWgzC79XdnrG2KrA71TuQS
         aZMs6e4PiHwsftIjlQLAOnXyIl7vbgpp5wTWlfIqrIEvzrUVntInEH7nT++THKq9ts5K
         s1RlSOWfMQn0N8u7UHtNZt0ctMQYoxQKOgIF4vILSgLtDY3+jOKkYV0+a9ahb4xSJGYa
         BTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+ICxFTArJB/ArX+PK+PZ7RAIzt9LoW68IOg9zQU5NKs=;
        b=JzYv4WJObcxC4hc2Z4rcO/WAzUHHDgEEc6J0kf12OAWOKS9EV74IEB8jDJHQusnK6F
         VNKmbKjMBNbd0qHLc1LEHrlXyr8/Z/8QqNCEveq0FPQMMKB3Ogs7Oekst/upZwOHmPec
         P8tIN2lbR6BpzbouapvgomZDYSyvLBDOWtdxEq7MFj4qAT+Ad29N29QA4p/zJmKEjlPK
         dO86x4QgQPGAERhYTX5vm6zoYsWNIpygA02eciLhSdGdGAc2XqfnAfiPRhMrsKr6Iw+f
         OR4MJi5KfxSh7bfAgu6KEnKih6l99Gh2hDY0hbbfH7/TqH50tn9XMvu5TMiFxL/V5pDz
         ChDQ==
X-Gm-Message-State: AHQUAuaW5iiaja/XyPX5YCNlkmBcxk16ckKs6eyLLVZI5jHCXAAITWV8
        9WjVks3yNGuE/F1+XtidFxRGZ/PN6HXhiQ==
X-Google-Smtp-Source: AHgI3IbsPpJLR/410yFnfqV+Hb2S6/WHgtS7DI6bscfbNreJSp8BJ6SvDrfXLq+cQVdC+BETy/meRA==
X-Received: by 2002:a6b:ec05:: with SMTP id c5mr1340349ioh.279.1549647270327;
        Fri, 08 Feb 2019 09:34:30 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f142sm1522627itc.15.2019.02.08.09.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:34:27 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk
Subject: [PATCHSET v13] io_uring IO interface
Date:   Fri,  8 Feb 2019 10:34:04 -0700
Message-Id: <20190208173423.27014-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Here's v13 of the io_uring project, hot on the heels of v12. v12 had
a few silly regressions due to flipping things around for the SCM
fd passing changes. v13 also decouples the SCM fd management from
how many fixed files we support, so instead of a fairly random 253
file limit, we now impose a 1024 file limit for a file set.

The AF_UNIX scm parts have been split into its own file. This was
needed to prevent issues with CONFIG_UNIX=m, since io_uring is
always builtin.

Nothing major in here apart from that. Go forth and test and review,
so we can hopefully get this queued up sooner rather than later.

The liburing git repo has a full set of man pages for this, though they
could probably still use a bit of polish. I'd also like to see a
io_uring(7) man page to describe the overall design of the project,
expect that in the not-so-distant future. You can clone that here:

git://git.kernel.dk/liburing

Patches are against 5.0-rc5, and can also be found in my io_uring branch
here:

git://git.kernel.dk/linux-block io_uring

Changes since v12:
- Fix release of uid struct at buffer unregister time
- Fix leak of request for poll command on submission time errors
- Allow huge pages for pre-mapped buffers
- Use alloc_skb() instead of __alloc_skb()
- Make max fixed files independent of SCM_MAX_FD (now 1024)
- Use CONFIG_UNIX instead of CONFIG_NET
- Export io_uring_get_socket for CONFIG_UNIX=m
- Add net/unix/scm.c with the helpers io_uring needs
- Disallow registering the io_uring fd to prevent a deadlock
  with !CONFIG_UNIX

 Documentation/filesystems/vfs.txt      |    3 +
 arch/x86/entry/syscalls/syscall_32.tbl |    3 +
 arch/x86/entry/syscalls/syscall_64.tbl |    3 +
 block/bio.c                            |   59 +-
 fs/Makefile                            |    1 +
 fs/block_dev.c                         |   19 +-
 fs/file.c                              |   15 +-
 fs/file_table.c                        |    9 +-
 fs/gfs2/file.c                         |    2 +
 fs/io_uring.c                          | 2796 ++++++++++++++++++++++++
 fs/iomap.c                             |   48 +-
 fs/xfs/xfs_file.c                      |    1 +
 include/linux/bio.h                    |   14 +
 include/linux/blk_types.h              |    1 +
 include/linux/file.h                   |    2 +
 include/linux/fs.h                     |   15 +-
 include/linux/iomap.h                  |    1 +
 include/linux/sched/user.h             |    2 +-
 include/linux/syscalls.h               |    8 +
 include/net/af_unix.h                  |    1 +
 include/uapi/asm-generic/unistd.h      |    8 +-
 include/uapi/linux/io_uring.h          |  142 ++
 init/Kconfig                           |    9 +
 kernel/sys_ni.c                        |    3 +
 net/unix/Kconfig                       |    5 +
 net/unix/Makefile                      |    2 +
 net/unix/af_unix.c                     |   63 +-
 net/unix/garbage.c                     |   68 +-
 net/unix/scm.c                         |  146 ++
 net/unix/scm.h                         |   10 +
 30 files changed, 3291 insertions(+), 168 deletions(-)

-- 
Jens Axboe


