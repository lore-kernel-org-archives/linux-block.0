Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DB5C25B08
	for <linux-block@archiver.kernel.org>; Fri,  5 Aug 2022 17:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241014AbiHERE1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Aug 2022 13:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240801AbiHEREZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Aug 2022 13:04:25 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C7D78597
        for <linux-block@vger.kernel.org>; Fri,  5 Aug 2022 10:04:24 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id r6so1629535ilc.12
        for <linux-block@vger.kernel.org>; Fri, 05 Aug 2022 10:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ZIUZUvMby+ZyQyN2vJN1//RsIIyzMxAERYvdZ48hCdk=;
        b=YIEynqiapoixqpHcZWa8r1skf5vp4fTwhH+J/Cy704O4HU99vSjRMr3UerTJI9Kl2w
         y2zExzgk80ARkfq9Oa1mm8b/ygM3HLHBCGV/9g5/DEglijwACbQ0/waV7pDdb7TKlOL5
         9Fo25m5eqTbc+wobpJaCoypLr+O+Vd0QHsx3QiPWKOjfEySCNqeJHD/D95JcGu359bmt
         UiT2JTzoPNaSQ+T78knE1ZupHEXeEtzrGD8y8YE3kip6+grY8nscqmVqQP5sJSDTah9e
         YUHvtJfJP14Nck80d9nZjHSRAWpYUgqZXJUVDf4rqKvsNHc2IHC05EaK3KxDiCrliuPi
         sRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ZIUZUvMby+ZyQyN2vJN1//RsIIyzMxAERYvdZ48hCdk=;
        b=UQMR4KpM+u+7moc2QrgSA7xFqOVVs4fXkvNl+5vINh/K8p8tr+qobNlBR46trFQZt5
         POeKeyaKUdoDasobYJwFg9GWLKBzCAtikbkLUspRkfkL09z+C0nEdUEw2/sVwkGu7T39
         KQa8aeTcfDRDaxLSjy8+9tbNTKoVZr4mtzS0C5Xo+IKtiGv1MZvdDlkxVGcJ2sRpgyWv
         LoPlRdSkTk69M2gNLVM2yS2SZVR+TZJ9SOahRi8v0nVjK52rCrkF0NZfZVoyTT95Z1pv
         o1xwptpPT/kYkrV50vKSYXEVdplvAYakMP2wDfidX8NxsWQLYaeHId8RdK8RQbUiS9Pi
         0yqw==
X-Gm-Message-State: ACgBeo2XXXaPr3nljWI1lHDj75Jn2jHojvLynNAO1v1xAokfnkDNJRML
        CY823dUuO+p6jmxCIsn7HiY/JQ==
X-Google-Smtp-Source: AA6agR5xKX/nXXAojsu4XbbnE0kxe6LIuRhdXZFmET/3IRGkXG2CeEEtkygBzNhemE04dhCtVhJraA==
X-Received: by 2002:a92:ce50:0:b0:2dd:dc8e:1f36 with SMTP id a16-20020a92ce50000000b002dddc8e1f36mr3729145ilr.34.1659719064178;
        Fri, 05 Aug 2022 10:04:24 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i21-20020a056638381500b003428115672fsm1888782jav.30.2022.08.05.10.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 10:04:23 -0700 (PDT)
Message-ID: <78f0ac8e-cd45-d71d-4e10-e6d2f910ae45@kernel.dk>
Date:   Fri, 5 Aug 2022 11:04:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/4] iopoll support for io_uring/nvme passthrough
Content-Language: en-US
To:     Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de
Cc:     io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, ming.lei@redhat.com,
        joshiiitr@gmail.com, gost.dev@samsung.com
References: <CGME20220805155300epcas5p1b98722e20990d0095238964e2be9db34@epcas5p1.samsung.com>
 <20220805154226.155008-1-joshi.k@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220805154226.155008-1-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/5/22 9:42 AM, Kanchan Joshi wrote:
> Hi,
> 
> Series enables async polling on io_uring command, and nvme passthrough
> (for io-commands) is wired up to leverage that.
> 
> 512b randread performance (KIOP) below:
> 
> QD_batch    block    passthru    passthru-poll   block-poll
> 1_1          80        81          158            157
> 8_2         406       470          680            700
> 16_4        620       656          931            920
> 128_32      879       1056        1120            1132

Curious on why passthru is slower than block-poll? Are we missing
something here?

-- 
Jens Axboe

