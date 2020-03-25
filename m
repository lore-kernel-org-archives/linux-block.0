Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE7CC1975A
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 11:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D852420714
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 11:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AuTx60vO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgCYLFw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 07:05:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57758 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgCYLFw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 07:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=jtGeoif8k2AnPWl1XaVgcc0OPG9LRuIsRIpPAMGAOo8=; b=AuTx60vOq3OD/rBhCPi2ZE/G7/
        cbc2dyBAIp3dJXMvxHC+WcBSqdTEOsZe/HdH6Qb8Zp6GMGosEw+41N40+LrcSM0Hiz+IrBR0xCiye
        3PCzhGJkbCik5oEdne8MwrLzUOd/d61mhnqgwITBmwAR/uA0Nfn+IcbYv2mSw2ela1SB4ftBF67Hd
        UI8k0J1ozt+PhfxV7bYYdlDY3QBbS5Uf291R/zoa7CTeYfsJvqZN9XV9+niZBw4rkI44gFr4tzcWr
        xbp/ffaI9AeGW5MqvG5AVVuAB4mfdMoOzHm3R0iM0FFKas/3bezQhUnvGXPVqX8QiJ1IEMHL8SBip
        FVOEhsFg==;
Received: from 213-225-10-87.nat.highway.a1.net ([213.225.10.87] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH3r5-0001sA-7e; Wed, 25 Mar 2020 11:05:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: decruft genhd.h
Date:   Wed, 25 Mar 2020 12:03:30 +0100
Message-Id: <20200325110338.1029232-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series tries to move as much out of genhd.h that doesn't really
belong there.
