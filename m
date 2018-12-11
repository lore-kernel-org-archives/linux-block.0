Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E83CC07E85
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 14:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023AB2081B
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 14:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sCcbN696"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023AB2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbeLKOH3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:07:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37586 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbeLKOH3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 09:07:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5dmRT6mjPKLSl7oprRiqyqrwnAEpAz9EPITWjtAdDDE=; b=sCcbN696lNsnOJoiZULENsdzD
        hZL/PKG48n1Hip9AQmULlTfwV5UVm5MrbCqeYYFFXyDYwi2ettn6ZZjc/B998B1DUq1fLFCftp0D6
        DkBAc9rvDoEw+dOl9/7fO7XCGyeYVJJnvqoVG+Vz29g2nJBK/Ya0Ov0jlEj8SwOqn6xzjRVv2mMdk
        KdYujNZkVeDJncK/8TFC/qjeCdUZ0cRz+MSrKhiIJK3BYa4d4pno9gJDFrJefR/KPteHF24mEbDcv
        u/QqffB6nLKWy1X8Md53Be3wMzt5GjjubYjPVtqI5xEDLSVNB2Gvr/1w9TJoo57x6u2nImyK3wxZN
        kEGw4j8eQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWih1-0003Nt-QH; Tue, 11 Dec 2018 14:07:23 +0000
Date:   Tue, 11 Dec 2018 06:07:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     axboe@kernel.dk, vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, davem@davemloft.net,
        akpm@linux-foundation.org, nicolas.ferre@microchip.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        adouglas@cadence.com, jank@cadence.com, rafalc@cadence.com
Subject: Re: [PATCH 2/2] scsi: ufs: add inline crypto support to UFS HCD
Message-ID: <20181211140723.GB6576@infradead.org>
References: <20181211095027.GA3316@lvlogina.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211095027.GA3316@lvlogina.cadence.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 11, 2018 at 09:50:27AM +0000, Parshuram Thombare wrote:
> Add real time crypto support to UFS HCD using new device
> mapper 'crypto-ufs'. dmsetup tool can be used to enable
> real time / inline crypto support using device mapper
> 'crypt-ufs'.

Can you point to where in the UFS spec this support is specified?
