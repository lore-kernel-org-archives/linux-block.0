Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FC4C433FE
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 06:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A0B960FBF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 06:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhJYGrr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 02:47:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52704 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhJYGrq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 02:47:46 -0400
Date:   Mon, 25 Oct 2021 08:45:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635144323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ddXW1IAEewv3IDmdYyUoJd2X13n5ysAHyyFO1j6t/0o=;
        b=Im+Ftc4FvRhlJHm9A0ueRGkbHUxNi5W8PUeFsip9tCBZHgxDMrN5fLCzB1Mj5RfmSxsgTv
        nUz1xg8C3FKg9pLOXwrEyn/OqghQCbV1BcD6Ygr4aiCgBKLt7Kpw/geopYGXbf1jhzW4Km
        75mGSfl9vt/RkWaTHvbJX0zpdc/AyvnXtmOz/OSApOD9Ma3SqSzP6qRrQ6MPRS8kwGmhiT
        /fHEqCRPXsjP3HB/Zwjs+8k0OA4ajkxEDyg6yfaBcfwOU09x5/BHqfAB8C3nKPV5UBW2W3
        x/QA6eWkQt3Qn4W5o9yogBktQKtWAoPY3wF39JhSpVRmFUdlUtDYZsoPJpEPxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635144323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ddXW1IAEewv3IDmdYyUoJd2X13n5ysAHyyFO1j6t/0o=;
        b=nNFDOrz6yv8xHs0xavwonaW23nJ5RD8tYubLAMGMS9I6ophJjCFQvRPKRpKZoPTxXX23wD
        2zWwB6/KQvDvtIDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        tglx@linutronix.de, Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 1/2] blk-mq: Add blk_mq_complete_request_direct()
Message-ID: <20211025064522.5rkkj72rcfka3wqj@linutronix.de>
References: <20211018135559.244400-1-bigeasy@linutronix.de>
 <20211018135559.244400-2-bigeasy@linutronix.de>
 <YW2Q0ikJR13NWgGD@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YW2Q0ikJR13NWgGD@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021-10-18 08:20:50 [-0700], Christoph Hellwig wrote:
> On Mon, Oct 18, 2021 at 03:55:58PM +0200, Sebastian Andrzej Siewior wrote:
> > +static inline void blk_mq_complete_request_direct(struct request *rq,
> > +						  void (*complete)(struct request *rq))
> 
> Pleae avoid the overly long line.
> 
> ote that by doing the normal two tab indent for the continuation that
> would be super trivial and way more readable.

Oki.

Sebastian
