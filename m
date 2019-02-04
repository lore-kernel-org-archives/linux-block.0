Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23C5C282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 15:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85012087C
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 15:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nwxSiiqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfBDPne (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:43:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729487AbfBDPne (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 10:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dJgRYNY3TsUQCM4LfqRqffgHmBi3c1IwOrsBksI+04w=; b=nwxSiiqm8IdYGrcQ5wXBfyBcC
        ZJVpVZ6AuM0Pvl2nVFaRXaif3/5cq3DR7MBVLf/Ctetzo9QqGTwOPmxRTL6ofBp6Ci/5zXBRF9t2Q
        KZCPnPIpPMCaQwDasU1PamFTVNKWJAmllj1h1CITLSwgW0JXCoaTfZv7pRCtwYO5txjEDdPcQF1B/
        m1dmySF8+3evNUM1hh2pTXbtFp5irOcr2lzUuHI2zOUtgm4hv5ItXk8cHrR4wHzpdePdhp6oW4/I8
        VsGsb/zU14mgEM2tjn3ZS3i/shNMJTQoNYXWCpJBf7zSReGroNIOoHYyZhsm+P7/FvgG3hOFPYoZy
        QSIu+oe+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqgPE-00073d-Tb; Mon, 04 Feb 2019 15:43:32 +0000
Date:   Mon, 4 Feb 2019 07:43:32 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] bsg: allocate response buffer if requested
Message-ID: <20190204154332.GA24612@infradead.org>
References: <20190130094424.94255-1-hare@suse.de>
 <20190204144040.GA23983@infradead.org>
 <81ff4b98-32aa-11a5-f929-18cdacdba9a3@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81ff4b98-32aa-11a5-f929-18cdacdba9a3@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 04, 2019 at 04:37:46PM +0100, Hannes Reinecke wrote:
> static int bsg_scsi_complete_rq(struct request *rq, struct sg_io_v4 *hdr)

So this is bsg_scsi_ops that you quote.

> This expects the 'response' to be allocated.
> Yet nowhere in the block/bsg.c we actually _do_ allocate the 'response'
> field.
> And as the header is pretty much copied from userspace we don't really have
> any control about the contents of the 'response' nor the 'response_len'
> parameter.
> 
> These fields used to be filled by mpt3sas (to hold the sense code), but with
> commit 651a01364994 ("scsi: scsi_transport_sas: switch to bsg-lib for SMP
> passthrough") the sense code handling got removed.

But all the transport bsg users actually use bsg_transport_ops and thus
should never end up in the above code.

Something in this bug report does not add up.
