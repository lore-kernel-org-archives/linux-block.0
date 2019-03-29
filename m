Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5882BC43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 07:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B342173C
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 07:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbfC2HIO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 03:08:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728781AbfC2HIO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 03:08:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 048FD307D90E;
        Fri, 29 Mar 2019 07:08:14 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 433F41EE;
        Fri, 29 Mar 2019 07:08:10 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 00/10] block: enable multi-page bvec for passthrough IO
Date:   Fri, 29 Mar 2019 15:07:53 +0800
Message-Id: <20190329070803.10958-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 29 Mar 2019 07:08:14 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Now the whole IO stack is capable of handling multi-page bvec, and it has
been enabled in the normal FS IO path. However, it isn't done for
passthrough IO.

Without enabling multi-bvec for passthough IO, we won't go ahead for
optimizing related IO paths, such as bvec merging, bio_add_pc_page
simplification.

This patch enables multi-page bvec for passthrough IO. Turns out
bio_add_pc_page() is simpliefied a lot, especially the physical segment
number of passthrough bio is always same with bio.bi_vcnt. Also the
bvec merging inside bio is killed.

blktests(block/029) is added for covering passthough IO path, and this
patchset does pass the new block/029 test.

V3:
	- fix build warning on patch 1 and 7, only the two patches are
	  changed

V2:
	- add new patch of 'block: avoid to break XEN by multi-page bvec'
	- add one new patch to cleanup bio_add_pc_page()
	- add another two new patches for cleanup of mapping bvec to sg
	- most of others are patch style changes


Ming Lei (10):
  block: pass page to xen_biovec_phys_mergeable
  block: avoid to break XEN by multi-page bvec
  block: don't merge adjacent bvecs to one segment in bio
    blk_queue_split
  block: cleanup bio_add_pc_page
  block: check if page is mergeable in one helper
  block: put the same page when adding it to bio
  block: enable multi-page bvec for passthrough IO
  block: remove argument of 'request_queue' from __blk_bvec_map_sg
  block: reuse __blk_bvec_map_sg() for mapping page sized bvec
  block: don't check if adjacent bvecs in one bio can be mergeable

 block/bio.c            | 134 ++++++++++++++++++++++++++++---------------------
 block/blk-merge.c      | 106 +++++++++++++++++++-------------------
 block/blk.h            |   2 +-
 drivers/xen/biomerge.c |   5 +-
 include/linux/bio.h    |   3 ++
 include/xen/xen.h      |   4 +-
 6 files changed, 137 insertions(+), 117 deletions(-)

-- 
2.9.5

