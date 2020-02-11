Return-Path: <SRS0=uOpu=37=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE22C352A3
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 17:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB8520578
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 17:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsnKazxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgBKRQW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:16:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45193 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbgBKRQV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Feb 2020 12:16:21 -0500
Received: by mail-wr1-f67.google.com with SMTP id g3so12292250wrs.12
        for <linux-block@vger.kernel.org>; Tue, 11 Feb 2020 09:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZfNwHwXfw/8GSZ4MKcK5t1g/zszh0xJvL2d+WT45nRM=;
        b=GsnKazxYJEWfa+2xu7z2B9lz+NfLGCHbj08hYDehOYyBAFLDRyryPJvG9+y+8TmadJ
         Q5bHCWmrVCYEMsr0Del81n9JNQTG+79bxxnbQGe5LglwWH3aGh9Tdjl1BL94kwv8tWmy
         lfgNIkAOnDaXMy8A4UNhS2hvoewpyykVWgVHhCedDI2ZEkhFn9KechLpWkBK/9oqCV1P
         S2C3jg15VREOiKM9ChMWaCGLWA0AUmluPXQ12iq+fGaMmxGYvZ5yAaPLbw+PXri2EG77
         YJAuXg94ROkIlOf34L3LwMTeWRn/mDZN075FYA84waDMSu9W9h65luiVD0FeIvb/Q6Jv
         NN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZfNwHwXfw/8GSZ4MKcK5t1g/zszh0xJvL2d+WT45nRM=;
        b=MLvNgT8QLwssOwH/P96xLiZulIASPVHj3ev+YsCuyIXYlulB4CerxxOlbhYrLEpvQa
         buQplLNJJAFUFw03C/6ZZ6dLe97lmo1zKM85cG9lk02cPM2cCOpOXQHgOdxqKFM46qLH
         mhR9Aa49rDb0cBGgCuHJ1Y+cFk3hrVCV6+yvM7CgoOqEqAYR17YoJUtE0tOEKhdsDIam
         HvG4lHB0WyMhhh1DVSVg24rLk63ADxnWlvSJdGqXJbYZY/WnC2SjQmm7ah3v+qxD120s
         4Jda6ROwMCBfiid8cRDeyLPl2I6L1cvLl6gVoot4Jy4odB1oAtjLp/sEGeRRhqI9dKS1
         NSow==
X-Gm-Message-State: APjAAAVJEREEWfpwNfsgFws3Qfx1OC0M+ZeisLNBPLAr63OQC+5HnkRV
        SLIvTW5HGVIwX9lEYs6hnQ==
X-Google-Smtp-Source: APXvYqweTv2ibV99v1h3KroC6nOkHCZ7bZeqTjBV47GJOjvjaWFQ+OXw0d3izJOIiJJdkGju3HXoMg==
X-Received: by 2002:a5d:66cc:: with SMTP id k12mr9322580wrw.72.1581441379571;
        Tue, 11 Feb 2020 09:16:19 -0800 (PST)
Received: from avx2 ([46.53.254.169])
        by smtp.gmail.com with ESMTPSA id a198sm4439954wme.12.2020.02.11.09.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 09:16:19 -0800 (PST)
Date:   Tue, 11 Feb 2020 20:16:16 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, damien.lemoal@wdc.com
Subject: Re: [PATCH v2] block: support arbitrary zone size
Message-ID: <20200211171616.GA2187@avx2>
References: <20200210220816.GA7769@avx2>
 <20200210222045.GA1495@avx2>
 <afaa196d-ca85-3b6d-fa67-d25b24ff812e@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afaa196d-ca85-3b6d-fa67-d25b24ff812e@lightnvm.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 11, 2020 at 12:28:17AM +0100, Matias Bjørling wrote:
> The ZNS specification is specifically written to accommodate this. It 
> has two type of zone sizes, the Zone Size (which is what should be a 
> power of two) and the Zone Capacity (that is the writable capacity of 
> the zone).

Ouch, what an embarassing patch I've sent.
For some reason holes in LBA space completely escaped my mind.

	Alexey
