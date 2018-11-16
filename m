Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0507BC43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F6F2089D
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LKbCiFy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F6F2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbeKPSxR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:53:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60998 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbeKPSxQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 13:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rkyG39oqVlMEv8WnpEX9bSMSaF8eVOLZSUAUhMAxUJ0=; b=LKbCiFy5JeokljgaXqvfPaFD4
        87fc2fxe6HAU8lEmATyzI6WuxT++Cs8wx2RGidU6MfDfzbja3QiNXp9VXsw3iIfU3Krs1UbmqwGPY
        tEbTTEx4FeO6augWlojzYz9oy4P4eYRWejqLzNOPfsTbiKtx+MoSMpsiAksu56bMlGK3+Lv4mfhYe
        bbNkVswMZHlJljdBjozOEj2ITbbI5F6EfjtSY/ZiSq+DJI872x5keNNKtRKwIPRcHNm/RaxTuyMcw
        9DWF5OBkvggFiltmkRwUf8c0yhQeHTPHYkLFuSjQTxveqF6EmWC7nTATdylxBFU4s0B0nN8QFsy6P
        Ty9zkX3gw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNZhL-000607-Si; Fri, 16 Nov 2018 08:41:55 +0000
Date:   Fri, 16 Nov 2018 00:41:55 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 05/11] block: add polled wakeup task helper
Message-ID: <20181116084155.GG9023@infradead.org>
References: <20181115195135.22812-1-axboe@kernel.dk>
 <20181115195135.22812-6-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115195135.22812-6-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 15, 2018 at 12:51:29PM -0700, Jens Axboe wrote:
> If we're polling for IO on a device that doesn't use interrupts, then
> IO completion loop (and wake of task) is done by submitting task itself.
> If that is the case, then we don't need to enter the wake_up_process()
> function, we can simply mark ourselves as TASK_RUNNING.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
