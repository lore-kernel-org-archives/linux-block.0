Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46040C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 00:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77B22146E
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 00:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="xggxs3Jd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403911AbfBNAQi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:16:38 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:46962 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfBNAQi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 19:16:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id AC3B5AA25C;
        Thu, 14 Feb 2019 01:16:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1550103392; i=@fjfi.cvut.cz;
        bh=ZgX2nu1prNMPmkfY6EX7uBMchoXtJY1ojL8lA0W+e5s=;
        h=From:To:Cc:Subject:Date;
        b=xggxs3Jd0ux2NEbJCIJ4Kr50kHfv6xs+CjDAHrE+lmBN7zWQHxLjQ2IkjGc0zWplV
         tVxta7/pW9i71DjnX53tRsptzRTO1KFPfoCBT2CTnU31wdK7vXQUxiGjKUVcXR46nl
         AiCiTnZCSuuwTmaXCbfCUlHFwUT4qhgRDDb2ZNMY=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id fORW3nzi69Ok; Thu, 14 Feb 2019 01:16:27 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 6F218AA230;
        Thu, 14 Feb 2019 01:16:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 6F218AA230
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 488AB6004E; Thu, 14 Feb 2019 01:16:26 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>
Subject: [PATCH 00/16] sed-opal: fix shadow MBR enable/disable and clean up code
Date:   Thu, 14 Feb 2019 01:15:52 +0100
Message-Id: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch series contains various code cleanup and fixes for Opal SED support.
It's been created by taking a part of the original patch series by Jonas and me
(PATCHv4 block: sed-opal: support shadow MBR done flag and write) [1], as
suggested by Christoph in [2].

The most important patch is the first one where I tried to fix the shadow MBR
enable/disable issue we discussed in [3]. This change goes against Christoph's
original propsal in [4] but I think - in light of the issue and keeping in mind
the planned addition of an IOCTL specifically for toggling the done flag - that
passing just OPAL_TRUE or OPAL_FALSE to set_mbr_done and set_mbr_enable_disable
is more useful and also more understandable. Maybe this change is superfluous if
Scott found the time to submit his take on the fix. (?)

I tried to include all the feedback from the v4 review[1]. I also added some
more trivial changes (11/16 as suggested in [4]) and also 13/16 motivated by the
same idea - that's why I again reached the magical number of 16 patches.

I kept the reviewed-by/acked-by tags where the changes were trivial but I
removed them where I thought a re-review would be useful.

I plan to submit the remaining patches from the original series (these that add
new Opal IOCTLs) after this fix and cleanup is accepted.

I did a brief test toggling shadow MBR and unlocking a locking range. I will try
to do more thorough tests - but I will not get to it before the beginning of the
next week. It would be great if this could get some more testing. Especially the
unlock from suspend part - that's something I don't have set up and I have not
tested.

The series applies on v5.0-rc6.

[1] https://lore.kernel.org/lkml/1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz/
[2] https://lore.kernel.org/lkml/20190204150415.GO31132@infradead.org/
[3] https://lore.kernel.org/lkml/alpine.LRH.2.21.1902072247060.29258@linux.fjfi.cvut.cz/
[4] https://lore.kernel.org/lkml/20190204145244.GJ31132@infradead.org/

David Kozub (12):
  block: sed-opal: fix IOC_OPAL_ENABLE_DISABLE_MBR
  block: sed-opal: fix typos and formatting
  block: sed-opal: close parameter list in cmd_finalize
  block: sed-opal: unify cmd start
  block: sed-opal: unify error handling of responses
  block: sed-opal: reuse response_get_token to decrease code duplication
  block: sed-opal: add token for OPAL_LIFECYCLE
  block: sed-opal: unify retrieval of table columns
  block: sed-opal: use named Opal tokens instead of integer literals
  block: sed-opal: pass steps via argument rather than via opal_dev
  block: sed-opal: don't repeat opal_discovery0 in each steps array
  block: sed-opal: rename next to execute_steps

Jonas Rabenstein (4):
  block: sed-opal: use correct macro for method length
  block: sed-opal: unify space check in add_token_*
  block: sed-opal: print failed function address
  block: sed-opal: split generation of bytestring header and content

 block/opal_proto.h            |   2 +
 block/sed-opal.c              | 716 ++++++++++++++--------------------
 include/uapi/linux/sed-opal.h |   2 +-
 3 files changed, 287 insertions(+), 433 deletions(-)

-- 
2.20.1

