Return-Path: <SRS0=Zyuh=RU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3ACC4360F
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 10:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6092085A
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 10:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfCQKBU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Mar 2019 06:01:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbfCQKBU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Mar 2019 06:01:20 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D470B302454F;
        Sun, 17 Mar 2019 10:01:19 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D34711A922;
        Sun, 17 Mar 2019 10:01:16 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        ris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, Omar Sandoval <osandov@fb.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2 00/10] block: enable multi-page bvec for passthrough IO
Date:   Sun, 17 Mar 2019 18:01:02 +0800
Message-Id: <20190317100112.8106-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Sun, 17 Mar 2019 10:01:20 +0000 (UTC)
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

	https://marc.info/?l=linux-block&m=155175063417139&w=2

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
 include/xen/xen.h      |   2 +-
 6 files changed, 135 insertions(+), 117 deletions(-)

Cc: ris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: xen-devel@lists.xenproject.org
Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>


-- 
2.9.5

