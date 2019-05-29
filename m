Return-Path: <SRS0=nCGH=T5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AEBC28CC0
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 20:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE1E2414F
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 20:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vC5r3d8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfE2U3x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 16:29:53 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36783 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfE2U3w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 16:29:52 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so3071472ioh.3
        for <linux-block@vger.kernel.org>; Wed, 29 May 2019 13:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=UtbQPUgFNUmhmXEEatwgf5ugaH/Cm/lRbF8Ni8Oe5vI=;
        b=vC5r3d8quVXIgCrX8UOiVWJOzPKMpiOhCBUYVGA9G7/ZiaZP9WivbLSVYN86tf43eE
         4mK7FuHcFi9N7VAc92vZB8qJzZqd8T5dH6FZsQfscRKmshfRwVNggUt/kHpss/JXGAe0
         IUAWHRdhlwq41ON3nFw9gPYr6c25uRTaeIKfKArpivB4L60O2d0/vf56TUlyKNo2i4ky
         djUXffm6EJxiRjRNhQGBucc4aU7To+7VqSXbDcpRKspdFe70C3retyMu1yVnHPiCtVIr
         /8LNzzixzIup+X4C29HQqYY6cAzcJ2Nz3nyFL8CZNDbkEYuzQAMF5OepQCY6aEij49n1
         NhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=UtbQPUgFNUmhmXEEatwgf5ugaH/Cm/lRbF8Ni8Oe5vI=;
        b=q0xf2+WGbVWma1k6SJo8HAuDAeMyD597sVdM6z674/0LSMpr/Zm9sNmjIZDKjoSVof
         yawzsmUh84BMCdWVSBJE+BSab0ocmKmFvNYWbseryQREEPb3HxRC4eS69uGVnn5ItZpZ
         ReWb28BMrSnFBnBdkXc8s6rfqI2A4LsHuru/9Fodws/sDFJBQJXU5/cZQUoPFHNh8sXj
         LNQlUwE251Gg/V62u3uoh3YH+X6pYzdsvlmwMLdmFp52oGQX7Vrf0gHEAKCuFinHYugu
         ksiUWFrLfVrNsgBaJTnpf3PFd1Me7m9gQvDBwI7SvvLNNf43X5CPi9gWOCOI6u9mtkYw
         C53Q==
X-Gm-Message-State: APjAAAUm/LGn0hECEJE/0PDyqXHS5ees22tSVhQ4CJHKqBnk2DnL6ViY
        O+Em4miVa0YtAmZ8lmYsPRMa4eCHjqRUGw==
X-Google-Smtp-Source: APXvYqy0uMJD9fhurgFqHv2vg8ochqIKRAl1p+TX6vKoSNCoNwiQBYZC5Y3pyCnIpRMdiktNJEkLPQ==
X-Received: by 2002:a5e:c70c:: with SMTP id f12mr14174865iop.293.1559161791850;
        Wed, 29 May 2019 13:29:51 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k76sm179105ita.6.2019.05.29.13.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:29:51 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCHSET v2 0/3] io_uring: support for linked SQEs
Date:   Wed, 29 May 2019 14:29:45 -0600
Message-Id: <20190529202948.20833-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Here's v2 of the linked SQE patchset. For a full description of this
feature, please refer to the v1 posting:

https://lore.kernel.org/linux-block/20190517214131.5925-1-axboe@kernel.dk/

Changes since v1 are just fixes, and nothing major at that. Some of the
v1 error handling wasn't quite correct, this should be. The liburing
repo contains the link-cp copy implementation using linked SQEs, and
also has a test case that exercises a few of the link combinations.

Patches are against my for-linus branch, but should apply to Linus
master just fine as well.

 block/blk-core.c              |  74 +++++++++-
 block/blk-sysfs.c             |  47 ++----
 block/blk.h                   |   1 +
 drivers/block/loop.c          |  18 +--
 fs/aio.c                      |   9 +-
 fs/block_dev.c                |  25 ++--
 fs/io_uring.c                 | 268 ++++++++++++++++++++++++++--------
 fs/splice.c                   |   8 +-
 include/linux/uio.h           |   4 +-
 include/uapi/linux/io_uring.h |   1 +
 lib/iov_iter.c                |  15 +-
 net/compat.c                  |   3 +-
 net/socket.c                  |   3 +-
 13 files changed, 329 insertions(+), 147 deletions(-)

-- 
Jens Axboe


