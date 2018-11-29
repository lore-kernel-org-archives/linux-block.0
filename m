Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C6EC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 15:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC57C213A2
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 15:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fp2nnvsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC57C213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbeK3C4E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:56:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37444 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbeK3C4E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 21:56:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KcQTkbLwsOiSWiCe0Tl2UBBhjbGxumKtuOVujqoykn4=; b=fp2nnvsTIlHWuM6wIk0bHG8c9
        ADoSgwWKcMT0jjIE7tKETqLCIoHWMNqr7ag05SOZy0DaHy3iHMu8+3yFze11zinNVUhe+Le4VyAjE
        +4hDGxVmGUWcLScZ0kXvTjjQ6rLn8BPMIozMQ1l1p7br8Kk5oa75+LzY6QeAELWY/RzxFXkq095PB
        iTpfpdmzoJlzvGqL15sdOAOFWGdHhrk3xKWKRMohXxND1p9ZrGQTt3dXhudC73bWbDta2tpCEBEOf
        JrDvFRd48uTvYTA9MmuOu4bZqgYqYCSXhf6KIv6jKA2PwC0dYdknMfgB2+Jvtu+Z6DS1I5aevMh38
        7Rll8xQ5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSOa0-0006Vo-P6; Thu, 29 Nov 2018 15:50:16 +0000
Date:   Thu, 29 Nov 2018 07:50:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 7/7] blk-mq: use plug for devices that implement
 ->commits_rqs()
Message-ID: <20181129155016.GG7234@infradead.org>
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-8-axboe@kernel.dk>
 <20181129154959.GF7234@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129154959.GF7234@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 29, 2018 at 07:49:59AM -0800, Christoph Hellwig wrote:
> > +		/*
> > +		 * Use plugging if we have a ->commit_rqs() hook as well,
> > +		 * as we know the driver uses bd->last in a smart
> > +		 * fashion.
> > +		 */
> 
> Nipick: this could flow on just two lines:
> 
> 		/*
> 		 * Use plugging if we have a ->commit_rqs() hook as well, as we
> 		 * know the driver uses bd->last in a smart fashion.
> 		 */

But of course otherwise this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
