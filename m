Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0CCC433DF
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 15:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7797B207C3
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 15:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WDKmWtAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgEPPei (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 11:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgEPPei (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 11:34:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DD0C05BD09
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 08:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=TscuI6ZdItJwNg+sFWE6TqrPwG9b2eStRieEhO7BWmE=; b=WDKmWtAxvFGPym855lhk+vJh+Y
        NzTpGb7auNcmbMeAgCRIqiaareQ1m+SJU+PfM4X4UhKmGE9eEO3GOOXNi6LIEjh/4S5tBQdWOi88e
        0sgT+y2vIrS1hdBdAKzPA7lWAfOR/DwvJMy2b+B34jVXu3ZAUUqDE1y4x3Zx+a51TiVLI02hoduwZ
        o/oXzfw1tZD8RpB53M6Iqvn1G/s0fH0JihPPZEDqUrwoIcdwnLKHNsg/6Te+B+gyMgtLFjQCJs3dD
        VMKNgidrkrsTy8kTlaJw610hPgWlpAX35S+vsgtZ6v3bBGpripE3iYZU6q/F00cRtwUQYpcXQ98VZ
        vPkKnS4g==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZypd-00050n-4k; Sat, 16 May 2020 15:34:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: avoid a few q_usage_counter roundtrips v2
Date:   Sat, 16 May 2020 17:34:26 +0200
Message-Id: <20200516153430.294324-1-hch@lst.de>
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

Changes since v1:
 - rebased to the lastest for-5.8/block tree with the blk-crypt addition
