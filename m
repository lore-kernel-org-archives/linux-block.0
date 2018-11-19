Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A182C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 07:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22107206BB
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 07:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b5xA9AwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22107206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbeKSSVI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:21:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56656 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbeKSSVI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 13:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3ea/Ppx3TJkhGkum3Xa214mF8Oyaxc+ygX5JqIFp8Jc=; b=b5xA9AwM9jvHHz7xcI+L6o3Fk
        DKNKDEcrO1VCF2oXXNBimWHj2zBixwYYPGuTlpRKuoDMDG8Rh0jEgCtHBbxJQXv8ERGMSU0xvOuLP
        7vkTxe9cxxzbr61B9UzmEyvZ1omxygFrzWy/XIxzs/bH/eYxO9bI3hdujzxH+LqD4vhIDFhSU5Rnv
        FW0xGU8Wn6sQBsuHq+vnoFYGpTlELwqhbQ1WJ9ZFQYiCFsemQI7N/W55v0WlR8WNpI27UDzN0DYGg
        bXAOALD+xDtu+lxlvG/+aymZ8e4FcnkxxPf7YuHfBii90Ke7zOASCyBn2PG5VHVmH1dYsAQACfCgn
        zpZO7eSAA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOeRl-0002uL-VD; Mon, 19 Nov 2018 07:58:17 +0000
Date:   Sun, 18 Nov 2018 23:58:17 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/7] block: avoid ordered task state change for polled IO
Message-ID: <20181119075817.GA9622@infradead.org>
References: <20181117214354.822-1-axboe@kernel.dk>
 <20181117214354.822-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117214354.822-2-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Nov 17, 2018 at 02:43:48PM -0700, Jens Axboe wrote:
> For the core poll helper, the task state setting don't need
> to imply any atomics, as it's the current task itself that
> is being modified and we're not going to sleep.
> 
> For IRQ driven, the wakeup path have the necessary barriers
> to not need us using the heavy handed version of the task
> state setting.

Looks good (except for the horizontally challegened commit log):

Reviewed-by: Christoph Hellwig <hch@lst.de>
