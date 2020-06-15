Return-Path: <SRS0=pdd5=74=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C25BC433E0
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 22:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCA1A20739
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 22:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HwsPMF4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgFOWwL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgFOWwK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jun 2020 18:52:10 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F811C061A0E
        for <linux-block@vger.kernel.org>; Mon, 15 Jun 2020 15:52:09 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x207so8520623pfc.5
        for <linux-block@vger.kernel.org>; Mon, 15 Jun 2020 15:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RwrdlsWehKZKBVZQSVbm4FZ+bZkOFL8rSZ1Dubk+3s8=;
        b=HwsPMF4pWt1ws4mKNcP2Ya9FrKgdDvltSNqUltzclLf1OG3MvSSLnw4ZQCBfOKNYnN
         KmMIITLprB3TvVG/kcoSQ33WWH8p7wNK3O2389ax6ZVOqgzok6nRzUgvKaX8Gnwz18Rb
         u6CKCGXkOYThg/3ZKrk61Qhq/Ofj0xgqHiO/s612k2akDYlerc+gRB3Mim0IopO8an+x
         x8935Rn1HctWYYtZlmir8+LKvUh+JwJrAiFz+PIJxidVWgbzGduwzoXzHXYHQcr+Y09S
         FTYQopH43e+3weONi0vnGiMtrc0rIjVOvNAJq2OWsGLLQRGOuiruuszBR0n70eBKnoPU
         f0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RwrdlsWehKZKBVZQSVbm4FZ+bZkOFL8rSZ1Dubk+3s8=;
        b=GbtYJ8phlJ7JacTnf5XBXhBMc3gl00v13ONAfw2OnZYBrlACyiIOpeoafJufC3u/1z
         bT2VSzf0desygn4p0AZzY/rpUu5YwPESu0cXQOdyt5bmUfyPCfLqi4VEGDX+TjAM3Y3I
         QcJg3HabNHxUGDXujG1GdI9EwM9UNnlDokJFsBk627xArHlcHwyr604l4AeE+QfH+Orw
         tMnhEfyOG/Q5srDOtoPrcU5auRxM+VOIu2HaI4GT9i2KZoukoXmyQ9ctL/67Z/Md/5jc
         DMEY2gVO9nKFC3sJxbFw4dxuXVNKlNxJ1bljCXiyj4DcyzfA7IgNAO50e4/jlXz5kCi2
         gIrw==
X-Gm-Message-State: AOAM532p002G2YEL5wHB/S+XP12auL+SgICANcG/pOEBs6cnLB8b3bU+
        pNISyNb8FFaVwXyr1zd5rqSIDw==
X-Google-Smtp-Source: ABdhPJx0yc3wWLKwncX5fZpU4ROUljh6Czx52DiKh1T5kEl0Ddnty5eyDjZFWlRxaTDPUCkvX6/EpQ==
X-Received: by 2002:a63:d951:: with SMTP id e17mr17827703pgj.318.1592261528999;
        Mon, 15 Jun 2020 15:52:08 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id j13sm464942pje.25.2020.06.15.15.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 15:52:08 -0700 (PDT)
Subject: Re: [PATCH] trace/events/block.h: drop kernel-doc for dropped
 function parameter
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>
References: <d572a150-192a-bbce-4449-8de45bce1a9b@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <baaf65e6-dd38-473e-e00b-98a19cd9bfbe@kernel.dk>
Date:   Mon, 15 Jun 2020 16:52:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <d572a150-192a-bbce-4449-8de45bce1a9b@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/15/20 1:22 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kernel-doc warning: the parameter was removed, so also remove
> the kernel-doc notation for it.
> 
> ../include/trace/events/block.h:278: warning: Excess function parameter 'error' description in 'trace_block_bio_complete'

Applied, thanks.

-- 
Jens Axboe

