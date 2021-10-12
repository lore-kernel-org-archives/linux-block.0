Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1BCC433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 10:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B46876101D
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 10:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbhJLKsA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 06:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbhJLKr7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 06:47:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BABC061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 03:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=PVWBpMLNVEc+CCfK/9i8qAoS2XWAU8Hbl2CIXgajesU=; b=fhqgMVocMQRU6uEIxc9JgtfsYF
        EwPCHp6iEd7Sy0eCdFQHpBmW++y4EONQe8EXK/wsfJ1Xh1eZuS9A00leHfPZtcuCzmVxvnvxl/ZVF
        rcjLKbe1IbZ2Bmma5izCwXX60zdmPDUzs5cOuoMDaGkJjbEmP3RwPhnrPsiHbPcbaR+IblvjCD4Zu
        UUaDkv83nIo7eM1AEw3jNl8cIiuwVU1DxPqpwY23tFiMEVPwHeIcqgpV0hKIsDuN2ER1cJ8TNLTY2
        m7mu5tsoruPtc9JWeukMw1mH/ghFYcwId7nZUGM05g1mCo+N6u++PLoAZJ6Q7RcU0L2xkDc4ETQHR
        rkAG3iZA==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maFHG-006QUN-PL; Tue, 12 Oct 2021 10:45:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: small block layer ioctl cleanups
Date:   Tue, 12 Oct 2021 12:44:47 +0200
Message-Id: <20211012104450.659013-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series cleans up a few minors bits in the ioctl path.
