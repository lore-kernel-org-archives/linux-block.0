Return-Path: <SRS0=sa6N=XL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A09DC4CEC7
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 02:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3990D20830
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 02:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbfIPCQk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Sep 2019 22:16:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbfIPCQk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Sep 2019 22:16:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 430A33082145;
        Mon, 16 Sep 2019 02:16:40 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.70.39.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D70D55C1D6;
        Mon, 16 Sep 2019 02:16:35 +0000 (UTC)
From:   xiubli@redhat.com
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     mchristi@redhat.com, linux-block@vger.kernel.org,
        Xiubo Li <xiubli@redhat.com>
Subject: [PATCHv2 0/2] blk-mq: Avoid memory reclaim when allocating request map
Date:   Mon, 16 Sep 2019 07:46:29 +0530
Message-Id: <20190916021631.4327-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 16 Sep 2019 02:16:40 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

To make the patch more readable and cleaner I just split them into 2
small ones to address the issue from @Ming Lei, thanks very much.

Changed in V2:
- Addressed the comment from Ming Lei, thanks.

Xiubo Li (2):
  blk-mq: Avoid memory reclaim when allocating request map
  blk-mq: use BLK_MQ_GFP_FLAGS macro instead

 block/blk-mq-tag.c |  5 +++--
 block/blk-mq-tag.h |  5 ++++-
 block/blk-mq.c     | 17 +++++++++--------
 3 files changed, 16 insertions(+), 11 deletions(-)

-- 
2.21.0

