Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FEEC432C0
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 09:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C79206E0
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 09:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fwZ5Cn/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfLCJjN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:39:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60924 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfLCJjN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Dec 2019 04:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=teCkK7MSpLgjvNrN7QuEm0fHfePvpKKwXi264dKeH4A=; b=fwZ5Cn/Dy3Vmdywoxmuh0tetH
        a/WL8cUYMsoXfMcbxeFUALB94gzUn5VpF5Cy+OghgX4ZdRFL8AFWCmrokJm6tFp0eq1gx7ToIYwdm
        29Lnw0EPkX9AUOSSgERD1JbfjatM36OQQJ80BTwUeMy8Yib2Tte0N2y/ro7Us1kitp2C7MIP5zA2o
        2HKSfiGGvQ6G9KgPvJMoNYY6/XYbu+Zj02H9ag0TOb2oy3HDBIBez2YQhgeGttybJpROMwKSe6XLi
        HC0mrhi9UPijwqSwKdJi/R+Ps39DlF+wvi6GtT6RRg4qhGm1doBjkK8bgD4LZwNCKBgQvx/UyYAOz
        bheh985yA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ic4eF-0001zo-4q; Tue, 03 Dec 2019 09:39:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hans Holmberg <hans@owltronix.com>, linux-block@vger.kernel.org
Subject: avoid out of bounds zone bitmap access
Date:   Tue,  3 Dec 2019 10:39:00 +0100
Message-Id: <20191203093908.24612-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series (against your for-linus branch) fixes a problem where updates
to the zone information in the queue is not atomic, leading to a possible
out of bounds access.  Please take a look and let me know if you think
if this is ok for 5.5.
