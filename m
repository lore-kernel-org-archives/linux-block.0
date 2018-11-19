Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D271C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 08:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5677C20823
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 08:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eoGX7rLA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5677C20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbeKSSkH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:40:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39562 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbeKSSkH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 13:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=t3GhbO8ws1nYON4ZLQJHcQbSS6DyRLRgvwmAvW9I7rY=; b=eoGX7rLAtlM8FnfTWpkExppmP
        qpNjrLPBzyY9B282IIlhooTP8td+5hAbp+2em+NkaTN9HZToGA6YoX0qQOZlgCycE9MT7h3LSg2gv
        TfLmcz0OrAx4KbF1SB5d3RGRxv5+FCEARuCw89iMXCUkwBu9lcVQJ9vgBrfnxha0j7ZiGOjt1G3uE
        1x9hONRHHePQdVaUiefAHzCHba0NOWNImAUtSjnhTwnw0+mHkQOVY+TSOoFu/q9qNFGK3j2XmC5I6
        Wp6tujazxarFdDR5TFdHQIlbwYq8hUYyITEis3q/hUT0bL1PrLevdgUst5xN3XJjyeiBKIUJQH66z
        KvehjzR8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOek5-00023H-TX; Mon, 19 Nov 2018 08:17:13 +0000
Date:   Mon, 19 Nov 2018 00:17:13 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/7] block: Introduce get_current_ioprio()
Message-ID: <20181119081713.GO9622@infradead.org>
References: <20181119035131.11255-1-damien.lemoal@wdc.com>
 <20181119035131.11255-5-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119035131.11255-5-damien.lemoal@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 19, 2018 at 12:51:28PM +0900, Damien Le Moal wrote:
> Define get_current_ioprio() as an inline helper to obtain the caller
> I/O priority from its task I/O context. Use this helper in
> blk_init_request_from_bio() to set a request ioprio.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
