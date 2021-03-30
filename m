Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EF3C433C1
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 18:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 013C7619CF
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 18:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbhC3SFI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 14:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbhC3SEn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 14:04:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDA6C061574;
        Tue, 30 Mar 2021 11:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DCGEHAzJrV8TqbrVal8s6ACJF5FQzaLRc2ecvWIp5uQ=; b=nTYQiqxt4PueC98KnAfNM3/O38
        dbsuOomyHP2AAlRvuWq0ux8fPHd8F9AS3elAPMNs18HIxYepjNZEn5zSbr98Hqgpc1geeVaP204zl
        21VSZivSVIBjFQjuP9Q5dfdbiE02OgX3PfxknYyjJ5nTU1XeXX6KFan2NEs9KUTaHkJbSCDKrUv8o
        w7671ZbAJv3c9EdRAAhmW4H2S9m3c9VBPff0nUpyiYam9s558hgQKwh1z0gYhjmVeGie02WObM9wm
        /MpbSlDcjoomg4zbRudswmcl9sBaeRONWyNKtFGiY6VPHaWHAzfcuuYA9REhs8wkOgeoyyf9kGOaF
        k/pOWRSw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRIj2-003PGz-0F; Tue, 30 Mar 2021 18:04:28 +0000
Date:   Tue, 30 Mar 2021 19:04:23 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2 1/8] block: introduce blk_ksm_is_empty()
Message-ID: <20210330180423.GA811594@infradead.org>
References: <20210325212609.492188-1-satyat@google.com>
 <20210325212609.492188-2-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325212609.492188-2-satyat@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 25, 2021 at 09:26:02PM +0000, Satya Tangirala wrote:
> This function checks if a given keyslot manager supports any encryption
> mode/data unit size combination (and returns true if there is no such
> supported combination). Helps clean up code a little.

The name sounds a little strange to me, but the functionality looks
ok.  A kerneldoc comment might be useful to describe what it does so
that we don't have to rely on the name alone.
