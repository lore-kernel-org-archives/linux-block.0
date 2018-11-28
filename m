Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B211C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 07:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE02E20832
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 07:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V2WRjZIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE02E20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbeK1SVQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 13:21:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38654 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeK1SVQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 13:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X73Kc5aekeNVl+WbqdkRenTGOOwFJV7qAvNs0BDKMmc=; b=V2WRjZIypJYvYPu95pFkB4e64
        VfWd+jukcbm/2K79TUd087vwjuVvlaztJvcnV+KOKQIFosq8FMys+Eo9PwoW75SBEP5ggebYWtSYV
        MWEig4xnyF1J1HZLZUggwq4VAD0GdHlW8bZTAblOrlf8h8cbOHkgvQ732evgeMS+DUEY0k3/NB9uE
        icirP2o3z2wbqh/N8fZMG19SMVhnUMYTKQtwfe47yJfLuW81YtxW4CbaEFGt3hRrBcMNSKI/kxu+4
        xMCTfnSE9fcSENtWeSjxU9YL4ZVVY/vGa5LEbgk96iBwP5ndRohBEBYaonjX3Sm9QRsmU6Yq9W7JV
        xYwoLZB3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRu9F-0006LG-Eo; Wed, 28 Nov 2018 07:20:37 +0000
Date:   Tue, 27 Nov 2018 23:20:37 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/8] nvme: implement mq_ops->commit_rqs() hook
Message-ID: <20181128072037.GB11774@infradead.org>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-5-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126163556.5181-5-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +static inline int nvme_next_ring_index(struct nvme_queue *nvmeq, u16 index)
> +{
> +	if (++index == nvmeq->q_depth)
> +		return 0;
> +
> +	return index;

Can you please just drop this helper?  It makes the code not only
less readable but also longer.

Otherwise the change looks fine to me.
