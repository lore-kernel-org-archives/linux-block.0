Return-Path: <SRS0=TT20=RM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B755C43381
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 01:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46352081B
	for <linux-block@archiver.kernel.org>; Sat,  9 Mar 2019 01:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfCIB6e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 20:58:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbfCIB6e (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Mar 2019 20:58:34 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ADF18301E11B;
        Sat,  9 Mar 2019 01:58:33 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA6025D9D4;
        Sat,  9 Mar 2019 01:37:44 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        ris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, Omar Sandoval <osandov@fb.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/6] block: enable multi-page bvec for passthrough IO
Date:   Sat,  9 Mar 2019 09:37:31 +0800
Message-Id: <20190309013737.27741-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Sat, 09 Mar 2019 01:58:33 +0000 (UTC)
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


Ming Lei (6):
  block: pass page to xen_biovec_phys_mergeable
  block: don't merge adjacent bvecs to one segment in bio
    blk_queue_split
  block: check if page is mergeable in one helper
  block: put the same page when adding it to bio
  block: enable multi-page bvec for passthrough IO
  block: don't check if adjacent bvecs in one bio can be mergeable

 block/bio.c            | 121 +++++++++++++++++++++++++++----------------------
 block/blk-merge.c      |  98 ++++++++++++++++++++-------------------
 block/blk.h            |   2 +-
 drivers/xen/biomerge.c |   5 +-
 include/linux/bio.h    |  12 ++++-
 include/xen/xen.h      |   2 +-
 6 files changed, 134 insertions(+), 106 deletions(-)

Cc: ris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: xen-devel@lists.xenproject.org
Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>


-- 
2.9.5

