Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7FCC433ED
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 09:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 315B9613AA
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 09:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343772AbhESJF4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 05:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbhESJFw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 05:05:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA58C06175F;
        Wed, 19 May 2021 02:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zBkfqq3Cl+5VcyHVVpkvJleAwcPn5Np0z5JWO/WWWeU=; b=A6JCB8cuU6/HW5uid1ZKE3jcEj
        MEibxE1Ik5QPDPIK+0uYCss8T1mLgEZr0YOAT7Ez7Ssi2fSWNxZdWu8N5wcxIPBpupPgAhGbH5+Es
        e/rM14g2DWuYp9N56YLW8zxq5VIVpNBLe894pf2EkvDfY8GtICDDSQrGdtDPipNO577lA5if3fOfv
        X2fuF4gZPqvOMh52ZCrU2bBnO3+wqWJlqF0VslrH2X2Yy4OjaAZR8ZHJhbBePpfkCVRmcntRGrTdq
        oLneMyXBwNqS1VvNy4AHDOvX3T9x7TpUnZagS6RJxGc9Es2dInnj3ei1C1d1We+93XkMzFt/lYi/9
        DfZDG+hg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljI6J-00Emzj-G9; Wed, 19 May 2021 09:02:59 +0000
Date:   Wed, 19 May 2021 10:02:47 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: Re: [PATCH v2 2/3] block/Kconfig: Whitespace and indentation cleanups
Message-ID: <YKTUN62HAgSQlFo2@infradead.org>
References: <20210519085615.12101-1-juergh@canonical.com>
 <20210519085615.12101-3-juergh@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519085615.12101-3-juergh@canonical.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 19, 2021 at 10:56:14AM +0200, Juerg Haefliger wrote:
> Replace multiple whitespaces with a tab and make the help text indendation
> 1 tab + 2 spaces which seems to be the convention.
> 
> Signed-off-by: Juerg Haefliger <juergh@canonical.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
