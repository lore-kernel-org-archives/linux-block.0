Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F533C43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 13:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DD5204EC
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 13:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YRynHYb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfEANtU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 09:49:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34016 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfEANtU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 09:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g5SBuBrFMGg32KJdT9Vbx40L/R/VL3WYcZUFCpuAUdY=; b=YRynHYb7NZwS2FEN9DGTdnStW
        WaBX8AvssCryR77QeKfwwFNvBDMo9O3l8iyrUsrZuRol+/fxG9UvRtYltpPmAVBvV231CWuU7CdHI
        7ifkyi18FCXUtKK19kkqMTObgdsYkHK8urKx7k4erra64n09FXg7aOGRK/bv4TS1HVFAAs1f3SAvh
        XFBbMW5U1mOqvFc4hC+TabITIjsQG3NC/x4g8mEg/emDqva8EKYDA5lFp//bEHAxbNv6uZs/7Ywz6
        D1w+lbfm/8MIGYFTsYjTlfsAsXSmJxv/xYXoOYG/suUutI89bcQvIVBD4BUe7FY5lLfaNapBcgYT0
        RUtbt/2JA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLpbp-0006P1-7G; Wed, 01 May 2019 13:49:17 +0000
Date:   Wed, 1 May 2019 06:49:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH 0/3] block: sed-opal: add support for shadow MBR done
 flag and write
Message-ID: <20190501134917.GC24132@infradead.org>
References: <1556666459-17948-1-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556666459-17948-1-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> I successfully tested toggling the MBR done flag and writing the shadow MBR
> using some tools I hacked together[4] with a Samsung SSD 850 EVO drive.

Can you submit the tool to util-linux so that we get it into distros?
