Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B633C10F14
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7462E2077C
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 07:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbfDWHP7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:15:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbfDWHP6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 03:15:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB73C30917AF;
        Tue, 23 Apr 2019 07:15:58 +0000 (UTC)
Received: from localhost (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC9695D71E;
        Tue, 23 Apr 2019 07:15:55 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] block: enable multi-page bvec for bio integrity
Date:   Tue, 23 Apr 2019 15:15:48 +0800
Message-Id: <20190423071550.20806-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 23 Apr 2019 07:15:58 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The 1st patch enables multi-page bvec for bio integrity meta data.

The 2nd patch simplifies bio_integrity_prep() via multi-page bvec.

Thanks,

Ming Lei (2):
  block: integrity: enable multi-page bvec for bio integrity
  block: integrity: simplify bio_integrity_prep

 block/bio-integrity.c | 55 ++++++++++++++++-----------------------------------
 block/bio.c           | 25 -----------------------
 block/blk.h           | 26 ++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 63 deletions(-)

-- 
2.9.5

