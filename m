Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE01C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 06:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4465761027
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 06:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhJMHAM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 03:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhJMHAM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 03:00:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49E1C061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 23:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6XBrGyfLCtOvf42dvPkBd38w5ZcZ/QL5CHQHSIDzL5w=; b=aXmVjKqdmVH4Guug9I2d4YepTQ
        ajHfevgjJqayh32OOaORhpGBwFN05XuL3bh4qCROeZoTOv2vVMFdZHuvZtCaQvRk5vBpSMC+FiXej
        959l+Ki1aMJKC7ywdzVh/4z3NQSrPSdkiALtzBaYaaTwxU1VKXPeW5WEKNIeYfYz4Z6DiP2ZlJF27
        zmagiupMSohLF8SXUvCUq8fQgb3JVW2myD3OKPAeeq3N4dTPit4fDWhonxI12vfUWcaxLd+RMIlSg
        nNLXZsDD3tSVjWdsAYJ8ywRKguIYl2g4ZcHu/WR6oLP/VAmbdVd+T5zs5YKV3OBj6q/nQUctW+D+d
        53lFXXKw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maYCI-007CNT-O4; Wed, 13 Oct 2021 06:57:29 +0000
Date:   Wed, 13 Oct 2021 07:57:06 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/9] nvme: move the fast path nvme error and disposition
 helpers
Message-ID: <YWaDQiwoo/vjNXxZ@infradead.org>
References: <20211012181742.672391-1-axboe@kernel.dk>
 <20211012181742.672391-6-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012181742.672391-6-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Please Cc the nvme list for nvme changes.

> -static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
> -{
> -	if (likely(nvme_req(req)->status == 0))
> -		return COMPLETE;

I think the only part here that needs to be inline is this check.
The rest is all slow path error handling.
