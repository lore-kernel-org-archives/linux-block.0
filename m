Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A385C04EBF
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 14:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05080206B7
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 14:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ozuoeayd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05080206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbeLEOlS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:41:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37396 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeLEOlS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 09:41:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UROyFab+JAcNob14SXW9LqqhZqIaIbOZfRtzfgy7SqU=; b=ozuoeaydKHJwLWtl9M7MdPVrW
        MD8Eh4qIsmaCUT0oyN9y6cBJdel3ex0hm9vnKwAtZ1CexnxgOtYOEhwtI6dP7TNoM5WIfVQTxwn/X
        xxcgmw7hi4Rs+vJ05YD0+vYZcbNWvMCLjBKbzm1WO9P9lCJLUAKLricG+KU3oBHfzOrvzysoEAy6d
        lFZwSnqHY/ZQuzyBLw1hTerGRLa/OVYF6exdDbVUrv0HL/Z/KAH59QB7hMYISWVk+oWe49XpyhueI
        Ac01b3Iyghw9q2W8vXj86xdrLdh8vRg63loDg7j2xUOxFPhJpWLJBf7S7RGCrStv9XcBrEDF67M1k
        zXcS4LGng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUYMX-0006gq-VQ; Wed, 05 Dec 2018 14:41:17 +0000
Date:   Wed, 5 Dec 2018 06:41:17 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] blk-mq: fix corruption with direct issue
Message-ID: <20181205144117.GB18123@infradead.org>
References: <1d359819-5410-7af2-d02b-f0ecca39d2c9@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d359819-5410-7af2-d02b-f0ecca39d2c9@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 04, 2018 at 03:47:46PM -0700, Jens Axboe wrote:
> If we attempt a direct issue to a SCSI device, and it returns BUSY, then
> we queue the request up normally. However, the SCSI layer may have
> already setup SG tables etc for this particular command. If we later
> merge with this request, then the old tables are no longer valid. Once
> we issue the IO, we only read/write the original part of the request,
> not the new state of it.
> 
> This causes data corruption, and is most often noticed with the file
> system complaining about the just read data being invalid:

Looks good as the first quick fix:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But as we discussed I think we need to be even more careful. including
the only read and write check below in the thread or some higher level
approach.
