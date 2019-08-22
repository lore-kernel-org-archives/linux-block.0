Return-Path: <SRS0=L3Py=WS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87633C3A59D
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 07:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642E3233A0
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 07:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbfHVH7h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Aug 2019 03:59:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731267AbfHVH7h (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Aug 2019 03:59:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7CBC9C028329;
        Thu, 22 Aug 2019 07:59:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.70.39.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 174575D6A7;
        Thu, 22 Aug 2019 07:59:34 +0000 (UTC)
From:   xiubli@redhat.com
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     mchristi@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        Xiubo Li <xiubli@redhat.com>
Subject: [PATCH 0/2 v3] nbd: fix possible page fault for nbd disk
Date:   Thu, 22 Aug 2019 13:29:21 +0530
Message-Id: <20190822075923.11996-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 22 Aug 2019 07:59:37 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

V3:
- fix the case that when the NBD_CFLAG_DESTROY_ON_DISCONNECT bit is not
  set.
- add "nbd: rename the runtime flags as NBD_RT_ prefixed"


Xiubo Li (2):
  nbd: rename the runtime flags as NBD_RT_ prefixed
  nbd: fix possible page fault for nbd disk

 drivers/block/nbd.c | 108 +++++++++++++++++++++++++++++---------------
 1 file changed, 71 insertions(+), 37 deletions(-)

-- 
2.21.0

