Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254D5C43141
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 09:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEEF7205ED
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 09:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oPcwxuvw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfLCJSc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:18:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55202 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCJSb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Dec 2019 04:18:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mncTdC3bi6g7uGZj3L4BQKcRgD4roM2koGsZFEDiYz8=; b=oPcwxuvwGM/QMpde4ZdeKhJlO
        psfMx3FhUNY5gN0mo2JnGOai9kGf8a+E777vewUkj2PbR8MCcCszG9JZcADjLuVZzoH5D82QmbGRc
        YAi/gg+CCzXu6fMR8TzqgrZcYWEh7GKPNgzjlis1NFJ0/cklX9M5vrTcoyembXThj/dyFxiLEH/fX
        OHKMLXFmQHXyNmVAw2YAoXsJeevYWFZ5OVr2QJ1d4aGHsz3Vr06ODZgbHXo3aQZaVYBxnnFKdBdOe
        tPOQV/UDOcs4BMpVVO9yKYSjNkeJFO0dglNMcAaGX+zIIYb6nPMhgVO1FUkpDyxCZab0yZR/hCmlW
        j0prc2k+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ic4K8-0002wT-2z; Tue, 03 Dec 2019 09:18:24 +0000
Date:   Tue, 3 Dec 2019 01:18:24 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Jun Nie <jun.nie@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 4/4] mmc: sdhci: Add DMA memory boundary workaround
Message-ID: <20191203091824.GA4685@infradead.org>
References: <20191202144104.5069-1-jun.nie@linaro.org>
 <20191202144104.5069-5-jun.nie@linaro.org>
 <20191203103320.273a7309@xhacker.debian>
 <CABymUCMVi_N2Mt82YDt7wrys4Z_vnXYEu15-YBa+S1CejT9iZw@mail.gmail.com>
 <20191203165123.4e6f9e28@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203165123.4e6f9e28@xhacker.debian>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 03, 2019 at 09:05:23AM +0000, Jisheng Zhang wrote:
> > >
> > > eg. drivers/mmc/host/sdhci-of-dwcmshc.c
> > >  
> > Thanks for the suggestion! Christoph's suggestion can prevent the the issue
> > from the block layer, thus the code can be shared across all
> 
> To be honest, I did consider similar solution from block layer, I.E set
> the seg_boundary_mask, when submitting the workaround last year, but per
> my understanding, SDHCI limitation is the physical DMA addr can't span one
> specific boundary,

As in exactly one boundary and not an alignment?  Where the one
boundary is not a power of two and thus can't be expressed?


> so setting seg_boundary_mask w/ blk_queue_segment_boundary
> can't work. I'm not sure I understand blk_queue_segment_boundary() properly.
> May Christoph help to clarify?
> 
> From another side, drivers/ata/libata-sff.c also workaround the 64K phy DMA
> boundary limitation itself rather than from block layer.

As far as I can tell that workaround should use the segment boundary
setting as well.
