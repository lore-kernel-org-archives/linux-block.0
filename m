Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737DDC4360C
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 08:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DCC2086A
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 08:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NZjbw3Ee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbfI3IYN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 04:24:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60420 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729852AbfI3IYN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 04:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=J8ZpJ7IEUIssWYiGn4JUZV8YSFiAwMHHgkpgEGYWdV8=; b=NZjbw3Ee2vq3+F6bt0y2/9Acg
        FuG6ln47Z0WQumAfUL4V/Vn4sSnqGS0NV6v7gbzN7eDvYHbQ/F8+smpGt9hR9LILaB/Hbo2SxE+xe
        Ona4IXBlQVxaNtIbjeWPgaq69gOqfA4EaV1w8DA8ZjTwsUNSWx4Jt14pXpIFimJtmHS3mjUP6yrTA
        OaPv2J1m0cJswjt0EFTCL5zPRiSv9PXl32HVnSRy5AZqj3iiafL4D956QgCeKWAeH3VpyCXfILueg
        jtgaxa8b6g1cLnpZ/uhbU55K9QUQyYVx03gKLpUqp1QF/9s2cR9+HmmiI6sBIex6157njWDFTcEkA
        XmFY4lqZw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iEqya-0002lU-LJ; Mon, 30 Sep 2019 08:24:12 +0000
Date:   Mon, 30 Sep 2019 01:24:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, hch@infradead.org, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, kernel-team@android.com,
        narayan@google.com, dariofreni@google.com, ioffe@google.com,
        jiyong@google.com, maco@google.com
Subject: Re: [PATCH v2] loop: change queue block size to match when using DIO.
Message-ID: <20190930082412.GA9460@infradead.org>
References: <20190828103229.191853-1-maco@android.com>
 <20190904194901.165883-1-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904194901.165883-1-maco@android.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
