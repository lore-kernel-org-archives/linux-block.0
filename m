Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D65C43219
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 10:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8271B206A3
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 10:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfDZKpa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:45:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfDZKp3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 06:45:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9FCDE3082B4D;
        Fri, 26 Apr 2019 10:45:29 +0000 (UTC)
Received: from localhost (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E1385DAAF;
        Fri, 26 Apr 2019 10:45:26 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] block/iov_iter: fix two issues related with BIO_NO_PAGE_REF
Date:   Fri, 26 Apr 2019 18:45:19 +0800
Message-Id: <20190426104521.30602-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 26 Apr 2019 10:45:29 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Fix two issues related with BIO_NO_PAGE_REF, both are introduced
recently in for-5.2/block.

Ming Lei (2):
  block: fix handling for BIO_NO_PAGE_REF
  iov_iter: fix iov_iter_type

 fs/block_dev.c      | 3 ++-
 include/linux/uio.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.9.5

