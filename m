Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652A8C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 13:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1298C2086A
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 13:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b0wBYHbo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1298C2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbeKPXUb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:20:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38146 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeKPXUa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 18:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tC4WcQyru9JMJQunGnHC7o/XkDdg568IhN1Z146fpaI=; b=b0wBYHboJNZVinogyJdWr2lFy
        KxXkO77kl2TUXGsPQHcGZZg7/nfPxmRGnd8sPex9bv5PoRw2ZayTs+r7RZWd3zgpegNfeL9ZFgmWd
        Iot5/6fxX9IEf7CHPe6AIk1R9xq54vvvNXO4qw38SoBkB0/Kj1qbPWX3IT96KIpWThQfIv6FMGsxl
        sFOXdaik40A8rscF7ISud9Iew9ZQp8a1ZkyTFajmuWFNyQ7E2Kiap7gHnMy07Oy+NnSWMds6Zibgr
        QBDimFsUWFLHRXjSoKyTRkYXAyDoYEaP6n+kv60DfhalEV2eeCIrIwDtDjZDuF7VppBNBg+1JczPE
        8RgtD6pMA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNdqy-0004v8-Bf; Fri, 16 Nov 2018 13:08:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>
Cc:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: provide slaves/holders links for multipath devices
Date:   Fri, 16 Nov 2018 14:08:03 +0100
Message-Id: <20181116130805.16225-1-hch@lst.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

a while ago Thadeu reported installer problems because nvme multipath
didn't provide slaves/holders links for the underlying devices.

This is because for one Tejun said the API shall not be used for new
users, but also because it currently hangs off the block_device
structure, which has a too short lifetime.

This series ignores Tejuns advice given that these links are the
defacto API for stacked block devices, moves the tracking to struct
hd_struct, and makes it work on NVMe multipath.
