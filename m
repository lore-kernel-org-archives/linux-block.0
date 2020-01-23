Return-Path: <SRS0=CgA1=3M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE24C2D0DB
	for <linux-block@archiver.kernel.org>; Thu, 23 Jan 2020 09:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426F922522
	for <linux-block@archiver.kernel.org>; Thu, 23 Jan 2020 09:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgAWJRU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jan 2020 04:17:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36136 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgAWJRU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jan 2020 04:17:20 -0500
Received: from [154.119.55.242] (helo=canonical.com)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <stefan.bader@canonical.com>)
        id 1iuYc0-00076J-FJ; Thu, 23 Jan 2020 09:17:18 +0000
From:   Stefan Bader <stefan.bader@canonical.com>
To:     linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Tyler Hicks <tyler.hicks@canonical.com>
Subject: [PATCH 0/1] Handle NULL make_request_fn in generic_make_request()
Date:   Thu, 23 Jan 2020 11:17:12 +0200
Message-Id: <20200123091713.12623-1-stefan.bader@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In ff36ab34583a "dm: remove request-based logic from make_request_fn wrapper",
device creation became a 2 stage process. In the first stage, the block
device is created which has a queue set up but no mapping function set.
This is done in the second stage, when the mapping table is supplied. At
that stage the device can become either multi-queue/request based or
doing the mapping on the bio level.

So right now, it is possible to crash the kernel by doing a
- dmsetup create --notable <name>
- mount /dev/dm-<minor> <somewhere>

While this may also need to be some fixing up in the device-
mapper codebase, it also should be handled from the block core as
allocating a queue can potentially be done separate from assigning a
mapping function.
There is already one check for not having set up a queue for a device,
so this just adds an additional check for make_request_fn being unset
before trying to further submit the requests.

-Stefan

Stefan Bader (1):
  blk/core: Gracefully handle unset make_request_fn

 block/blk-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.17.1

