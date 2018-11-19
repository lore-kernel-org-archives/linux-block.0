Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76836C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 08:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AE320823
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 08:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U+PnXQTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37AE320823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbeKSSgW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:36:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39448 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbeKSSgV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 13:36:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K1k5ben9BxQfnsrl8Ctvmn8MfFpJBdh8d7p11OghvB0=; b=U+PnXQTuWGq1nyulWYLllr8F/
        vuXeCmnBCJ9vZSLkFQuJQE14y+Y0fyk3MSY7nxi9d2lIfIFWaWHANQMAw7szDlvnqqI1XGvKxigOR
        6VL4Tnee8SsZLWD7RgLv1RReu9HmzQnN+xGBpwVN9/nbRXpIPvVvhzTgyM2T8CR7JxTxY/D5Y2wYT
        hH7NmnFlBhlcbVBWuzdwAnceNxHdoJ4fL+OW3SoDdcoxvDaTWUHJ3nQ3lNBDkmvzDxoNAPxK2OW1E
        u29GjA9i7CBwlCsBXoqzWpZOPTYCWEHio2skXs8oOuLCDORhNBiZF29BVzoeFaU0SG6qZzaSgB39e
        03e9e1dyw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOegT-0000SS-1b; Mon, 19 Nov 2018 08:13:29 +0000
Date:   Mon, 19 Nov 2018 00:13:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/7] block: Remove bio->bi_ioc
Message-ID: <20181119081328.GM9622@infradead.org>
References: <20181119035131.11255-1-damien.lemoal@wdc.com>
 <20181119035131.11255-3-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119035131.11255-3-damien.lemoal@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 19, 2018 at 12:51:26PM +0900, Damien Le Moal wrote:
> bio->bi_ioc is never set so always NULL. Remove references to it in
> bio_disassociate_task() and in rq_ioc() and delete this field from
> struct bio. With this change, rq_ioc() always returns
> current->io_context without the need for a bio argument. Further
> simplify the code and make it more readable by also removing this
> helper, which also allows to simplify blk_mq_sched_assign_ioc() by
> removing its bio argument.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
