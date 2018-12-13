Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74692C67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3277320851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nTdObpCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3277320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbeLMUcT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:32:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54930 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbeLMUcT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 15:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uqASYVflmEj/kbYkcmUaOFWpF1wUuvvwStrYqNdvTdc=; b=nTdObpCVQZrD1pRWPvYAo7vZq
        EeUwndPx9cYCj+WD9peuNr9Rp3PkIXSvU2pHkTp1E7HNKbzlOKJjOM8ztpHOD9D87Bomj4ql04z//
        LBY478/o8Fi+0mW8sQiJCMicZ2uOfJDtemHKwg+f9GAZyk0/vlySSm3F3Nv+41Z5lpyV8KMEVU7ds
        3TMF0RRbhnU5blqDvwDlEqtWNN7usoYhaCKvxEMzBwNpjWRIllQgZbz1FmcfSdoOPiud47VBsBCVG
        NGuCJSE3k4WL3Zs8ELEFWrRT3TpGtIUAZZ7ZX5h1dcX58HlXQQ5BlUWhd93rPUdzBjf/YoAD4/aQ+
        yMgD4kENQ==;
Received: from 089144198147.atnat0007.highway.a1.net ([89.144.198.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXXec-0005s1-J9; Thu, 13 Dec 2018 20:32:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: misc block cleanups
Date:   Thu, 13 Dec 2018 21:32:07 +0100
Message-Id: <20181213203214.10650-1-hch@lst.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove a few pointless helpers and unused exports.


