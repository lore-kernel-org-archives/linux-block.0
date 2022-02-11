Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FED8C433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 06:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239269AbiBKGsn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 01:48:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345105AbiBKGsm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 01:48:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B59B10EA
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 22:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rMfJfegGX5AJEF26lFiYMvpySU0Fpwib6wG7bqcuSoE=; b=N/c/QoaS7Gzu7alNIFktgY23hx
        v00UpyGRSfJYeM3rD18K+f6519uqmEnuMpcS+H+aLIniG1AXENlOHSdxkdDpJiy9HSynR8fxx0gwG
        BzMV/8e0tUyuBRa2253KZJiXUDy/7Ps5djT/Ck1TKOWV0Qk5MRFk01zP0YRPHAOMtku0mSGPCJU/m
        sxcqiQuNkw5Fv30h4zMpJ2bz8ALPwOujdNtnDa0fOg2ieoePM++x1X7Ivvn0+YcCoZKCnczpiuqKP
        ip9uiDP/ru6Xt99IAmc7ruDpPOEo4qqR2cLtsdqGM6PqTNBzVFGGJ7eGTvDdrnt0tUwoldr7K/lOi
        8k+Xx6rQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIPjP-0060VS-48; Fri, 11 Feb 2022 06:48:35 +0000
Date:   Thu, 10 Feb 2022 22:48:35 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 01/14] dm: rename split functions
Message-ID: <YgYGw2Uk0PEjE/d7@infradead.org>
References: <20220210223832.99412-1-snitzer@redhat.com>
 <20220210223832.99412-2-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210223832.99412-2-snitzer@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 10, 2022 at 05:38:19PM -0500, Mike Snitzer wrote:
> Rename __split_and_process_bio to dm_split_and_process_bio.
> Rename __split_and_process_non_flush to __split_and_process_bio.
> 
> Also fix a stale comment and whitespace.
> 
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
