Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770F9C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 12:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530372133D
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 12:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbfB0Mk0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:40:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:7724 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbfB0Mk0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 07:40:26 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C89E30BA2FC;
        Wed, 27 Feb 2019 12:40:26 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68B435F9D5;
        Wed, 27 Feb 2019 12:40:21 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/4] block: optimize for single-page bvec workloads
Date:   Wed, 27 Feb 2019 20:40:09 +0800
Message-Id: <20190227124013.4828-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 27 Feb 2019 12:40:26 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The 1st patch introduce bvec_nth_page(), so that nth_page() can
be avoided if the bvec is single-page.

The 2nd and 3rd patch adds fast path for single-page bvec case.

The last patch introduces a light-weight helper for iterating over
pages, which may improve __bio_iov_bvec_add_pages(). This patch
is for io_uring.

Thanks,

Ming Lei (4):
  block: introduce bvec_nth_page()
  block: optimize __blk_segment_map_sg() for single-page bvec
  block: optimize blk_bio_segment_split for single-page bvec
  block: introduce mp_bvec_for_each_page() for iterating over page

 block/bio.c          |  7 +++----
 block/blk-merge.c    | 23 +++++++++++++++++------
 include/linux/bvec.h | 16 +++++++++++++---
 3 files changed, 33 insertions(+), 13 deletions(-)

-- 
2.9.5

