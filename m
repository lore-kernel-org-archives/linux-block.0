Return-Path: <SRS0=tJY/=UH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FFCC468BC
	for <linux-block@archiver.kernel.org>; Sat,  8 Jun 2019 16:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5D5214AE
	for <linux-block@archiver.kernel.org>; Sat,  8 Jun 2019 16:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfFHQtP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 8 Jun 2019 12:49:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbfFHQtO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 8 Jun 2019 12:49:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9869130842B1;
        Sat,  8 Jun 2019 16:49:06 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A0FF2A18D;
        Sat,  8 Jun 2019 16:49:01 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 0/2] block: fix page leak by merging to same page
Date:   Sun,  9 Jun 2019 00:48:51 +0800
Message-Id: <20190608164853.10938-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Sat, 08 Jun 2019 16:49:14 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

'pages' retrived by __bio_iov_iter_get_pages() may point to same page,
and finally they can be merged to same page too in bio_add_page(),
then page leak can be caused.

Fixes this issue by dropping the extra page ref.


Ming Lei (2):
  block: introduce 'enum bvec_merge_flags' for __bio_try_merge_page
  block: fix page leak in case of merging to same page

 block/bio.c         | 34 ++++++++++++++++++++++++----------
 fs/iomap.c          |  3 ++-
 fs/xfs/xfs_aops.c   |  3 ++-
 include/linux/bio.h |  9 ++++++++-
 4 files changed, 36 insertions(+), 13 deletions(-)

Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: linux-xfs@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>


-- 
2.20.1

