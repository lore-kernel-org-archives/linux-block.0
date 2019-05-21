Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7254C04AAF
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 12:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF2A2173E
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 12:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tI1uNaXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfEUMrM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 May 2019 08:47:12 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:38990 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfEUMrL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 May 2019 08:47:11 -0400
Received: by mail-pl1-f171.google.com with SMTP id g9so8401549plm.6
        for <linux-block@vger.kernel.org>; Tue, 21 May 2019 05:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x/UTKa8OiyTLBhxpCx3H3MMuiDiKJhzdQrFaGYD0x2U=;
        b=tI1uNaXG1yDpqSxK9MAqhsjOtkJfhnG75NRfUloDodhIy87MDm0sfJXz+DP3pHjZ3o
         CglF2YHTykctk+TiWI9oYLV4Qw441Vwoe1DgSRDnuAq83OXM3nAtLjVdxUmjOQ/P+wRt
         SCDtUWQMguFtQWGp9eZIjEiH/AdAv+MPoye7q5xra8myGnTGTAHJaFEyEZ133wcE2Ox5
         ipmGr7h5Dq8ie2r3XITlsFmQDSFEkEjRIaAeaNVZgIDdw0qOGDpgwk/HkRBaNswK+4p5
         hn8CQqFEl+iYqMzuwf4emTTiCvmitR32kGFZn+oBJ6V36J14lE0lr6klQuWUk/FFV8YN
         ctbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x/UTKa8OiyTLBhxpCx3H3MMuiDiKJhzdQrFaGYD0x2U=;
        b=IctEhVkkdWflrDEfMmGfUhPvO4w9RWQV9mMUir6RgDi3CkkbX99tlhJi10/2SiNW1e
         ciVwqXaNEdqRU9T8lN030/cZfyyDpQOofH7uJ7mSaQqYNWWfeGf0ygnR+4oNFxZx6Ylz
         AP67cHeFK0TzkSWUrCAm8cBlC94Z4E4CWZZ5e/egavnEsuL4vY8ijEjS05zBFwlDDuq8
         jIt//0wjwmXZkY+ScHEhi2vnVXJ4hCvtVSogF84D8LdAqi3e8ChTJxtpeMkMQSvUUr0E
         dBuSaBcfp45wiaKd9ioHc5jbDzK1yaPgPbmDSZQJy9N5CfkAI73qucZ+xCsnWADMUulq
         BR5w==
X-Gm-Message-State: APjAAAV6Fh39mc3iJGcgx9TjAef27OD5U1wwzCOIFO6Po88OtxM7XndW
        CCJnCAyZJtaSaW0vFp08gUtRdHtwFbgFGw==
X-Google-Smtp-Source: APXvYqyZFvqpOmMW1kpfZdixJD+Z00oTPWelAkqDkDOHnwl4e1lRGUzsf924dgTUNXKmZGJzeVGw7A==
X-Received: by 2002:a17:902:4503:: with SMTP id m3mr81035792pld.97.1558442830607;
        Tue, 21 May 2019 05:47:10 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id t7sm25592049pfh.156.2019.05.21.05.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 05:47:09 -0700 (PDT)
Subject: Re: fix nr_phys_segments vs iterators accounting v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org
References: <20190521070143.22631-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b3a63583-fdcd-6b7b-f80a-e3a0b9b54397@kernel.dk>
Date:   Tue, 21 May 2019 06:47:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521070143.22631-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/21/19 1:01 AM, Christoph Hellwig wrote:
> Hi all,
> 
> we have had a problem for a while where the number of segments that
> the bvec iterators will iterate over don't match the value in
> req->nr_phys_segments, causing problems for anyone looking at
> nr_phys_segments and iterating over bvec directly instead of using
> blk_rq_map_sg.  The first patch in this series fixes this by
> making sure nr_phys_segments matches the actual number of segments.
> Drivers using blk_rq_map_sg will still get the lower number returned
> from function eventually, but the fact that we don't reduce the
> value earlier will not allow some merges that we might otherwise
> allow.
> 
> With that in place I also noticed that we do not properly account
> segements sizes on devices with a virt_boundary, but it turns out that
> segment sizes fundamentally don't make sense for such devices, as their
> "segment" is a fixed size "device page", and not a variable sized
> scatter/gather elements as in the block layer, so we make that fact
> formal.
> 
> Once all that is sorted out it is pretty clear that there is no
> good reason to have the front/back segement accounting to start
> with.

Applied, thanks.

-- 
Jens Axboe

