Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AC9C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 17:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB5720868
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 17:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BSeb9ISk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB5720868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbeK3EKd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:10:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35438 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbeK3EKd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 23:10:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0hqw8xUDohtXn6VoJwgjaQ+IP8tZnIcYjRDbsDneboo=; b=BSeb9ISkJmiUVYNqpxma8St1k
        /0EbAqc98Fk6z79nR6VnXjUMntRcTirYFN4H6kojx/KD8nhvO6RzvKuY/wkan2S6279KVZwAjuL9X
        yjOaLOlPdP3x8rHtDyGfmcusVMELSGnmdYEzQR+xBpgsoDqxBzoJ9TDK/WYuXaFhNJnUBnMeN3PdP
        iv7hYaoxAvw/+4coC1oH1LrklZXfy8rBQojnfkgnGhGM6RyVyrEdogKfdoTIpsIJ5F9r/k15EDWnY
        6Imi9nQGlQnud8wmB7GtM1FZjaBKydqgAAJ4JTyogB+weo1ic+snf/HJfH1bdnE5ky6tdw3kPUkv6
        Q2Ir9cO0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSPjq-00078K-Sa; Thu, 29 Nov 2018 17:04:30 +0000
Date:   Thu, 29 Nov 2018 09:04:30 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/7] nvme: implement mq_ops->commit_rqs() hook
Message-ID: <20181129170430.GA27364@infradead.org>
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-4-axboe@kernel.dk>
 <20181129154713.GC7234@infradead.org>
 <2188627d-6d45-fe8a-8d31-fa46fdb82618@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2188627d-6d45-fe8a-8d31-fa46fdb82618@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 29, 2018 at 10:02:25AM -0700, Jens Axboe wrote:
> On 11/29/18 8:47 AM, Christoph Hellwig wrote:
> >> +static inline int nvme_next_ring_index(struct nvme_queue *nvmeq, u16 index)
> >> +{
> >> +	if (++index == nvmeq->q_depth)
> >> +		return 0;
> >> +
> >> +	return index;
> >> +}
> > 
> > This is unused now.
> 
> Huh, wonder how I missed that. GCC must not have complained.

gcc never warns about unused static inline functions.  Which makes a lot
of sense at least for headers..

> 
> > Also what about this little cleanup on top?
> 
> That looks good, I like it. With that, can I add your reviewed-by? I'll
> run a sanity check on it first.

Reviewed-by: Christoph Hellwig <hch@lst.de>
