Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA6EC43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 08:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938C120823
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 08:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iblNDjrL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938C120823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbeKSSmM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:42:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39606 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbeKSSmL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 13:42:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tBAAeYfqmh5bvL/8d0zy96DMnMxqV3XFDdJGPyTvklk=; b=iblNDjrLtybEn5qD2LUX4VjZm
        ZLvrd9a6lQMLQmez1xD0yyTOQDQolMgFrEzel8vfQf9v7vO4TmqK/3YGYZrOvBx6B2YxEChGIBRaM
        Cn3dQ9P1BN6ko48VYB9LsMo0iGpRzGyOK4iwr4UEukrFHGgcWNETkvPnXbcSDp2a2JZZsLorCwrZW
        zR8FzLk/EDXBcrR4buehfBBISY/zfBnZ0QID3cjEdvsFj2GZ/JnTs1OSAOEDw135uMsiJxILMXEN7
        xJGfTdDU00Vs00fNcVrVCGxTAW+Xq41OviKaW6888BISLD++gWLLPn/yQPKPB+5PG3Cw4URGJIPCG
        gPgD+T/vQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOem6-00026c-Gf; Mon, 19 Nov 2018 08:19:18 +0000
Date:   Mon, 19 Nov 2018 00:19:18 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6/7] block: prevent merging of requests with different
 priorities
Message-ID: <20181119081918.GQ9622@infradead.org>
References: <20181119035131.11255-1-damien.lemoal@wdc.com>
 <20181119035131.11255-7-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119035131.11255-7-damien.lemoal@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	/*
> +	 * Don't allow merge of different I/O priorities.
> +	 */
> +	if (req->ioprio != next->ioprio)
> +		return NULL;

> +	/*
> +	 * Don't allow merge of different I/O priorities.
> +	 */
> +	if (rq->ioprio != bio_prio(bio))
> +		return false;
> +

These comments just restate what is obvious in the code.  I would
recommend to drop them.
