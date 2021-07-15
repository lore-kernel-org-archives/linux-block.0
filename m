Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A637C636C8
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 19:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 406A9613C4
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 19:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245639AbhGOTzm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 15:55:42 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:38614 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344880AbhGOTyi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 15:54:38 -0400
Received: by mail-pg1-f182.google.com with SMTP id h4so7615278pgp.5;
        Thu, 15 Jul 2021 12:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0tDpePIxEktVeo6ztDCtMYeEDnPO5qQ9DWScWNmXcx0=;
        b=KRsIyOYj5O0klvDSwZmR199irTQF5Qpu4ZebWJiLOpAE6MIIMpiag6G5AXDbJ3BVg1
         Jubr0fn6q0A9zSJZ+UcJvrX9sUVBkeQvL8+NiU9mypeDXIslluW5gN59+XnbW3q1ow9n
         NzenzEcndOOj1JtZ6JyIlYXGggquX6Hjdv41vQ1Skb1LWEe2CWRG7R98FNzF5a9hw1Cs
         tEYdGxwBkbayKnAhmScFKW/+vdeJV0cZkXwDHuINX2SRPnBxGktYtuh+gTxQKZ/fK156
         XiRb8ZwV7ER6zS1VKdecsS3gXjQrMF+vQjoHTHZccT/jXzXTL/ZpC8JZOH8CNDz3hET9
         6ABw==
X-Gm-Message-State: AOAM532YHBmwWPxLd75jOs7toYYCN6AP6tuoQWGPr0gkOy1hDLaHxb/T
        Mi6hocJJuuZkRJJvSEFnkGE=
X-Google-Smtp-Source: ABdhPJxcd9wtTZS3CgMVYrHkUpnxIVHIeUmrOux6mIRfLmQCntk4c4XgNAPEIDpQ04luIkhHUkp1aw==
X-Received: by 2002:a63:1d41:: with SMTP id d1mr6212638pgm.199.1626378704063;
        Thu, 15 Jul 2021 12:51:44 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id a4sm7778144pfd.110.2021.07.15.12.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 12:51:43 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/3] block: simple *add_disk*() driver conversions
Date:   Thu, 15 Jul 2021 12:51:38 -0700
Message-Id: <20210715195141.1882285-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As requested by Christoph, I'm going to add a few demo driver
conversions, to show how drivers can manage *add_disk*() error
handling.

I've converted all drivers at this point, but I think it makes sense to
split these conversion up into groups. This is the first group, which
demos trivial changes. This group is larger than this, but this series
with 3 driver examples should suffice to start review on that group type.

If this seems fine and the block changes get merged I can extend this
group later to include all trivial driver conversions. But patch review
on these would help to get started.

Luis Chamberlain (3):
  loop: add error handling support for add_disk()
  null_blk: add error handling support for add_disk()
  nbd: add error handling support for add_disk()

 drivers/block/loop.c          | 9 ++++++++-
 drivers/block/nbd.c           | 6 +++++-
 drivers/block/null_blk/main.c | 3 +--
 3 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.27.0

