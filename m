Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF72C43215
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 13:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC9720640
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 13:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ENkvTP7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfLCNGN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:06:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52208 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfLCNGN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Dec 2019 08:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nB+RFuMx6p+ckuFU7XT4n9LRqqE+cpEgvTBUwrwJ8BQ=; b=ENkvTP7/SADn+Vrs/m/95i8on
        Q0D1kUNIgud/Ip202gJZ1OHdzB+AA034RXVtOjN+em2vaxQEBAvHVcdycQgD8kvUccbDV1Kqgdo6f
        NaxTzcU/Siv1d7Sz62ZScvTBWMtDw+7ev8vVcSMXAtNN5s7g9F/2MKSuJ1Jhpw6lW+Ishw3iq2/Nj
        XX1ou+pTsQbCWcVAVEX3AnREDHqHPFW2cK5EnfRwVfO6AlPDXq3h62LMTbAltYgERyM1CLJmjp65o
        qWtnzXwPqwvCzQ9/NuED3R3xuUbieb9bUX7yffTTJN2GIJ+2eEKle7x4ODrtkazFc2lEQPUS8no6Z
        5ienkSB/A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ic7sX-0000aC-BW; Tue, 03 Dec 2019 13:06:09 +0000
Date:   Tue, 3 Dec 2019 05:06:09 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jun Nie <jun.nie@linaro.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH 4/4] mmc: sdhci: Add DMA memory boundary workaround
Message-ID: <20191203130609.GA2144@infradead.org>
References: <20191202144104.5069-1-jun.nie@linaro.org>
 <20191202144104.5069-5-jun.nie@linaro.org>
 <20191203103320.273a7309@xhacker.debian>
 <CABymUCMVi_N2Mt82YDt7wrys4Z_vnXYEu15-YBa+S1CejT9iZw@mail.gmail.com>
 <20191203165123.4e6f9e28@xhacker.debian>
 <20191203091824.GA4685@infradead.org>
 <20191203172434.39b2c2c2@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203172434.39b2c2c2@xhacker.debian>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 03, 2019 at 09:49:49AM +0000, Jisheng Zhang wrote:
> > As in exactly one boundary and not an alignment?  Where the one
> > boundary is not a power of two and thus can't be expressed?
> 
> Take drivers/mmc/host/sdhci-of-dwcmshc.c for example, target physical DMA addr
> can't span 128MB, 256MB, 128*3MB, ...128*nMB
> 
> I'm not sure whether blk_queue_segment_boundary could solve this limitation.

That is exaxtly the kind of limitation blk_queue_segment_boundary is
intended for.
