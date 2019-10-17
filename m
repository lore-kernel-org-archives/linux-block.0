Return-Path: <SRS0=WMYH=YK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DC4ECE58D
	for <linux-block@archiver.kernel.org>; Thu, 17 Oct 2019 21:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F3C21D7C
	for <linux-block@archiver.kernel.org>; Thu, 17 Oct 2019 21:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NLu/eh3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732272AbfJQV3S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Oct 2019 17:29:18 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41809 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503626AbfJQV3G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Oct 2019 17:29:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id t10so1746980plr.8
        for <linux-block@vger.kernel.org>; Thu, 17 Oct 2019 14:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=tMeBvPAu/snFk/ZPJWMF475l7uZR3V3Ts1VuHVs/VKw=;
        b=NLu/eh3BWYTcxSFuHGsdclWdtfMJT0RPjUDj6O5pS4MGhEn3zHAkNItvNhrYPVoYJh
         rNuJ4g57itm5nkqCm1dYE76Lw1+jH03fm0WAwEb8eOvfELFpBrvxQ3kJ1D7gJ33P8vN8
         IO4gzbRNkjJZM1dPT4vmGkYjE1JijsUXYqLDPvmFSgZIquw0peU6TxBS4zlj6tyVOX9r
         Qy4d25g/gKSYibLcAdCJiVwjRy7b16STj7rUijFQxFKlMoulT6YVtDNHMKs5il1gC7df
         u6zjmqEieBy2n8JWuBTgrkefLDWCyG+nx3eoTiFBZggT4CONZf2VEHmnIDBtOsGSd5A1
         gUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tMeBvPAu/snFk/ZPJWMF475l7uZR3V3Ts1VuHVs/VKw=;
        b=HfxUXyI6TxdnTRLI2oLBXwdcEL2kx+0y9j4goA/dt3ktC9luA77bkNR5ex/kjHJ2Je
         q7YpPHD52afkdmN3AYB2a1dKAb/vC5vf2c+ivUzi36/25YNIE3vgp2cQT4xWAct5/0WA
         jzFs20tb2NcapT/4iGFueJyMqp0v1ZKT5lf4mBdCTiCmY11ZQWAhu5uSMEO0QK5LLv9s
         q474lHeGwICNNuNr78NIcVLzn16z0uc+WBq4fGa4nl3wSExIyNAFbCnSIevkSK9U9VHv
         YmUNU/k0+u072Smbvl9EfK/UflBU3SSUqnfa4oGHrFLh8jChVEIdNIfxQoksWHVoSDsw
         4oog==
X-Gm-Message-State: APjAAAWIucpAeo0ZjqObv0jeepTI0vtypZCYaXcq8fVd8BFTl1SGhA3A
        ZAx46aMDrNqVrrQupYvN8Zan5FosU91XjA==
X-Google-Smtp-Source: APXvYqzH19pzf1njnqDSZUlOEXjG7OVdD3B2eEfJIrre2dWVOCMwE4Y23nsYa+FocLtp8QtjpHqwTw==
X-Received: by 2002:a17:902:a618:: with SMTP id u24mr6057295plq.112.1571347744548;
        Thu, 17 Oct 2019 14:29:04 -0700 (PDT)
Received: from x1.thefacebook.com ([2620:10d:c090:180::e2ce])
        by smtp.gmail.com with ESMTPSA id w6sm4296446pfw.84.2019.10.17.14.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 14:29:03 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org
Subject: [PATCHSET] io_uring: add support for accept(4)
Date:   Thu, 17 Oct 2019 15:28:55 -0600
Message-Id: <20191017212858.13230-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series adds support for applications doing async accept()
through io_uring.

Patch 1 is just a prep patch, adding support for inheriting a process
file table for commands.

Patch 2 abstracts out __sys_accept4_file(), which is the same as
__sys_accept4(), except it takes a struct file and extra file flags.
Should not have any functional changes.

And finally patch 3 adds support for IORING_OP_ACCEPT. sqe->fd is
the file descriptor, sqe->addr holds a pointer to struct sockaddr,
sqe->addr2 holds a pointer to socklen_t, and finally sqe->accept_flags
holds the flags for accept(4).

The series is against my for-5.5/io_uring tree, and also exists
as a for-5.5/io_uring-test branch. I've got a test case for this
that I haven't pushed to liburing yet, will do so shortly.

 fs/io_uring.c                 | 56 ++++++++++++++++++++++++++++--
 include/linux/socket.h        |  3 ++
 include/uapi/linux/io_uring.h |  7 +++-
 net/socket.c                  | 65 ++++++++++++++++++++++-------------
 4 files changed, 103 insertions(+), 28 deletions(-)

-- 
Jens Axboe


