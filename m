Return-Path: <SRS0=VeZL=7M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37ECC433DF
	for <linux-block@archiver.kernel.org>; Sat, 30 May 2020 11:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD121207D5
	for <linux-block@archiver.kernel.org>; Sat, 30 May 2020 11:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N2YQTqrv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgE3Lgr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 May 2020 07:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgE3Lgr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 May 2020 07:36:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8A7C03E969;
        Sat, 30 May 2020 04:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=axOm4GLmN5NeB+/I0JpsLpwQ02+6ZNLa0uMCcEPWY7o=; b=N2YQTqrvXL526n56S8g3o1XfXU
        XPm5ACsSEPBKL/eC/+aiOqhd9b3ntxVDxgutgHo7kaR4Ar6ATJTlJKi5Bf+4MBlh3liBIyZPEOPtH
        pO9FMJHrxkQqC/6Znv1wbqQxeHBbcBjmyQBaqY07EX8wcGP1N/F5fPzyg6atYOfp0P+i1aC6QOcbo
        An6SzceLQSgNroC7ZVkl5I97hBjCQrtjScG/6BXgTWr3vEHhQ5e0L5cMmO7TJFH2G3OOlDO+mpLpF
        S1HkBA0U2U+1TgpSv2ZDeWtkECIXfwYQf8msO5Q3MzdbrruIVzfaNRICPvQpHdicn/P7mxrjfRujf
        xaZUbu1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jezn4-0006wv-QP; Sat, 30 May 2020 11:36:38 +0000
Date:   Sat, 30 May 2020 04:36:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zheng Bin <zhengbin13@huawei.com>
Cc:     hch@infradead.org, axboe@kernel.dk, bvanassche@acm.org,
        jaegeuk@kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        houtao1@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH v2 2/2] block: make function 'kill_bdev' static
Message-ID: <20200530113638.GA26675@infradead.org>
References: <20200530114032.125678-1-zhengbin13@huawei.com>
 <20200530114032.125678-3-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530114032.125678-3-zhengbin13@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 30, 2020 at 07:40:32PM +0800, Zheng Bin wrote:
> kill_bdev does not have any external user, so make it static.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
