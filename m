Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAE3CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 17:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565AB21872
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 17:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HZw1ieI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410010AbfJYRan (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 13:30:43 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36646 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409991AbfJYRam (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 13:30:42 -0400
Received: by mail-io1-f66.google.com with SMTP id c16so3320206ioc.3
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 10:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=XbZUoQCTvXDjEaHzJ+GqZR/yN9QZLq+7qv4wlUb/3Iw=;
        b=HZw1ieI+txxtkja/r+bvUz/SzZtppE/L2lJZGeKvsWIQvaEjHG9Nl8xWAlT2MOtO2j
         xsct/VeNRoHU305FHC3I0MeE7cw9xwkGOcJJekUebNAebimqNA9j/ScOIOxHMPoE2812
         Vc4uw7Jn4gO0Wy85EN9VxjBuvH/lD3cVrNuvWqDIu1VUBMdvHks+9D6X3EtEC+gcQ4Ii
         ihTJFqa10TODyHZTTkWXQ2z2KgrGFU0/O8qC58Fi6kfYZUILjtHO2AgDriCE7mthRnpf
         BVQNuib6ZPZN3pNlF+xX6zaH+Cx9sPGIyDFh/OP3tSQeH/UZoAQ+QW2Bpg1K4smFqAR9
         CA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XbZUoQCTvXDjEaHzJ+GqZR/yN9QZLq+7qv4wlUb/3Iw=;
        b=pJbUvrw3QkvIA301Oh1nUThzDPu33f4NAm/P5rdQaZ/+LMYrvSpVg/NK8SENioSdoo
         VRXWCuiE7UZuN1AhnItPBy3e9ngVF6l89EDZhD1m08og/swCGdGr5em8ASM7AA0+pj7o
         l2bRNKtRcx2LlLRroRelW51ZFsjM0AQU+21to5mOpUUiPR+RXy8/4t42uWYwqfyjNq0Z
         smqJ41rSLTSsRJyTpzZYm0uS12tprHrGbRZR7Rao0LE14YOzchxYaJs/lFCKq3WEN6Zu
         aOlNcmQ/OnfWcbgw94gtOkbFwmYZ4zR3kg4e9usaOKC/FVwPjnH4mX5ffqpqMg5w1n9w
         3IPg==
X-Gm-Message-State: APjAAAVEQBI+IEkPOG+QAhkS/giivINIbBLBBaGVvgWyaZMC+Ab8cs8b
        1vGefOhyWHev0MmxttG9e9bxnK56ssvbCQ==
X-Google-Smtp-Source: APXvYqwsn82uW/7Xvs8QWPabY/Y7GS+m65dxy2znELzUQf9XmYqL8/59XhCXmgIXfoFpAwsLS26FKQ==
X-Received: by 2002:a6b:3b50:: with SMTP id i77mr4995604ioa.241.1572024641210;
        Fri, 25 Oct 2019 10:30:41 -0700 (PDT)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g23sm323674ioe.73.2019.10.25.10.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 10:30:39 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, jannh@google.com
Subject: [PATCHSET v2 0/4] io_uring: add support for accept(4)
Date:   Fri, 25 Oct 2019 11:30:33 -0600
Message-Id: <20191025173037.13486-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series adds support for applications doing async accept()
through io_uring.

Patches 1+2 are just a prep patches, adding support for inheriting a
process file table for commands.

Patch 3 abstracts out __sys_accept4_file(), which is the same as
__sys_accept4(), except it takes a struct file and extra file flags.
Should not have any functional changes.

And finally patch 4 adds support for IORING_OP_ACCEPT. sqe->fd is
the file descriptor, sqe->addr holds a pointer to struct sockaddr,
sqe->addr2 holds a pointer to socklen_t, and finally sqe->accept_flags
holds the flags for accept(4).

The series is against my for-5.5/io_uring-wq tree, and also exists
as a for-5.5/io_uring-test branch. liburing has a basic test case for
this (test/accept.c).

Changes since v1:
- Respin on top of for-5.5/io_uring-wq branch, as io-wq is needed to
  support cancellation of requests.
- Rework files_struct inheritance to avoid cyclic dependencies. Thanks
  to Jann Horn for some great suggestions there.


 fs/io-wq.c                    |  14 +++
 fs/io-wq.h                    |   3 +
 fs/io_uring.c                 | 157 ++++++++++++++++++++++++++++++++--
 include/linux/socket.h        |   3 +
 include/uapi/linux/io_uring.h |   7 +-
 net/socket.c                  |  65 ++++++++------
 6 files changed, 217 insertions(+), 32 deletions(-)

-- 
Jens Axboe


