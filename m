Return-Path: <SRS0=Ukdl=Y7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96293C43331
	for <linux-block@archiver.kernel.org>; Thu,  7 Nov 2019 18:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63200218AE
	for <linux-block@archiver.kernel.org>; Thu,  7 Nov 2019 18:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uSwSIu3i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfKGS31 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Nov 2019 13:29:27 -0500
Received: from mail-io1-f43.google.com ([209.85.166.43]:45897 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfKGS31 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Nov 2019 13:29:27 -0500
Received: by mail-io1-f43.google.com with SMTP id v17so2307324iol.12
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2019 10:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HJ6blu+3MdHCZSqzHwnGqq+edALzGJ4W/C6wCN+SPF0=;
        b=uSwSIu3i+Q0lXFCLe4gVVNryZ/qMeS+Kl92owubLTByFfr3VLQnd5CD9dJ6lTRiCwY
         /ZDi1QRA246N9lxqhiU7TWrtXG7iJ2Tg/PqmELsNcNBLwLktmKgP3A4WoXtwZ51d551r
         rvPtk13l4wRk8VIB/f+MqcFgIAdnqifk507JlCUxGl0+exRb8oujh8nHdrcIn6FmvjRh
         300Stx406UQJRfoY/cRPCMANLbnxAhLuRI3DpLap/qHLNtMVYcViTiqwm0erCN1hiANh
         gRUYX0kbnuFXadAzWdvAMR73nJxoQNIKQhfH6cFHHx7QbUEwSeLvwYWOwb1FrMXPoQvR
         Plog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HJ6blu+3MdHCZSqzHwnGqq+edALzGJ4W/C6wCN+SPF0=;
        b=WkBqT4g34UETXMi+BISswUm/f1V0SznlMJ6l1FvS3mK0kuTStRqf7JFl3kdfydQIoc
         KLKjx42qWHBHtM7/XcuIDM/j1bZiIOTYV16nZuorqaOa+SRSrmDzOQkB/mDGniK3g7Bt
         3xN8Xs5vokPe2lChSKFu9xMaHlT4kNVXG9CunLviekIkI0wWw2DLigOQHGtJvOPNSC7z
         VhSfe5buxUql42ggPCUYB4Bq5Qy3gjFJCfjk0MNXX6g60D+IqqlJ8ScXVTGLaSMAozym
         3mAEN2X2t15/n3yPemNBqDfzTpy7O7Bl9NeEgj4xV1DUKGqi2KNP4hJXKRNsBnef0PR4
         HbIA==
X-Gm-Message-State: APjAAAXB9gPHUIzLlAssxe0BPLZp6F9TSklOsAixH2K1R5nJ2kn3ezkK
        wuU0K7qekdmYNXnC6bOoOcpQzQ==
X-Google-Smtp-Source: APXvYqwjR3d3jrav3OdcnP1VqPQagGkJ41Rl6pkozAOPwRJCvTasalbrzqWDE6nvd9+jXRG1TlAACg==
X-Received: by 2002:a5d:870c:: with SMTP id u12mr4882220iom.95.1573151365363;
        Thu, 07 Nov 2019 10:29:25 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p6sm243727iog.55.2019.11.07.10.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 10:29:23 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCHSET v2 0/3] io_uring/io-wq: support unbounded work
Date:   Thu,  7 Nov 2019 11:29:17 -0700
Message-Id: <20191107182920.21196-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is v2 of this patchset, but this one takes a different approach. I
wasn't that crazy about adding a separate io-wq so each io_ring needs to
have two, so this one instead adds specific support to io-wq for bounded
and unbounded work. io_wq_create() now takes both limits, and any user of
this must set work->flags |= IO_WQ_WORK_UNBOUND to queue unbounded work.
By default, work is assumed to be bounded.

Patch 1 is just a cleanup I found while doing this, patch 2 adds the
necessary io-wq support, and patch 3 is now much simpler and basically
just adds the switch table from before without having to do anything else.

 fs/io-wq.c    | 242 ++++++++++++++++++++++++++++++++++----------------
 fs/io-wq.h    |   4 +-
 fs/io_uring.c |  22 ++++-
 3 files changed, 184 insertions(+), 84 deletions(-)

-- 
Jens Axboe


