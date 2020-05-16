Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4817C433E0
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 18:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 970D72065C
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 18:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KY10aY/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgEPS2I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 14:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726341AbgEPS2I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 14:28:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8652AC05BD09
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 11:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=+Lj+jeStFlkqtjs+cBpBldaZquGLhgTz5HuGi4ZaxwQ=; b=KY10aY/u3gQAW3/c8LUibeVpFo
        8WbvS6SuMb1SE7opoZG1VlYpIcaKGmgzsW/ZStYGQ5Zth4Z20eHuxQvOiK0l+Mz8+jX6smCCcSwly
        qDX2aDOO+Lk8i/ivHtNtIOqwy51Duuur0jaytjxHjmcyA25uQc7JpzVo5O1jqc91KI0ocfr1wyrUe
        nipo7H+70nbPy4wuQBmR1B3kydraPrZSyomiCG794+FBhdSUBudAgCEd2ntwtyW4qwjbrgWXQazuY
        UjPJAR9Qn736IbaaKePi4fW4MRZaeKZnWsv8/CishkwdS8q0iJjYYDVFFV8DFQWCGT+6OGdqaxlQS
        0jrp3OUg==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ja1XY-0007na-8W; Sat, 16 May 2020 18:28:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: avoid a few q_usage_counter roundtrips v3
Date:   Sat, 16 May 2020 20:27:57 +0200
Message-Id: <20200516182801.482930-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

the way we track reference on q_usage_counter is a little weird at the
moment, in that we often have to grab another reference in addition to
the current one.  This small series reshuffles that to avoid the extra
references in the normal I/O path.

Changes since v2:
 - increase the q_usage_counter critical section a bit in
   blk_mq_alloc_request_hctx

Changes since v1:
 - rebased to the lastest for-5.8/block tree with the blk-crypt addition
