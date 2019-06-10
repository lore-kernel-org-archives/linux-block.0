Return-Path: <SRS0=HnxX=UJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732A8C282DD
	for <linux-block@archiver.kernel.org>; Mon, 10 Jun 2019 09:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1CD20679
	for <linux-block@archiver.kernel.org>; Mon, 10 Jun 2019 09:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388218AbfFJJC3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jun 2019 05:02:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388190AbfFJJC3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jun 2019 05:02:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 60827C057EC6;
        Mon, 10 Jun 2019 09:02:24 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F48E60C64;
        Mon, 10 Jun 2019 09:02:19 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V3 0/2] block: fix page leak by merging to same page
Date:   Mon, 10 Jun 2019 17:02:13 +0800
Message-Id: <20190610090215.14412-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 10 Jun 2019 09:02:29 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

'pages' retrived by __bio_iov_iter_get_pages() may point to same page,
and finally they can be merged to the same page in bio_add_page(), then
page leak can be caused because bio_release_pages() only drops the page
ref once.

Fixes this issue by dropping the extra page ref.

V3:
	- avoid to call __bio_try_merge_page() two times
	- add comment on the two new flags

V2:
	- V1 breaks multi-page merge, and fix it and only put the page ref
	if the added page is really the 'same page' 


Ming Lei (2):
  block: introduce 'enum bvec_merge_flags' for __bio_try_merge_page
  block: fix page leak in case of merging to same page

 block/bio.c         | 32 ++++++++++++++++++++++----------
 fs/iomap.c          |  3 ++-
 fs/xfs/xfs_aops.c   |  3 ++-
 include/linux/bio.h | 22 +++++++++++++++++++++-
 4 files changed, 47 insertions(+), 13 deletions(-)

Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: linux-xfs@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>
-- 
2.20.1

