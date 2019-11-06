Return-Path: <SRS0=NI9l=Y6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D94BFC6178
	for <linux-block@archiver.kernel.org>; Wed,  6 Nov 2019 22:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F21E2166E
	for <linux-block@archiver.kernel.org>; Wed,  6 Nov 2019 22:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1nfiw/Gq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfKFWSX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:18:23 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40145 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfKFWSX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Nov 2019 17:18:23 -0500
Received: by mail-io1-f65.google.com with SMTP id p6so30814iod.7
        for <linux-block@vger.kernel.org>; Wed, 06 Nov 2019 14:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=iNLFgFIUTa921BtZj20hnjhyClAzxM7pWPjz0tad1Rg=;
        b=1nfiw/GqPFKBQaiXbdFx5GuT5NMoT0pEVPPQE12g4h+X07wF+x3Y1idBovLuz+vV5B
         4NC8T0zWRCvFQN0GPMxp7oLahDJ9QJhxRCsmn00J7DpNK4MjkqO5+NQqh7OoDPsuFnrc
         TvNU0JRe+v9osjvbu9VyhtYBwyaO9zT5Yhr18nRuWF/sCiZRPqLMHlfpaxFmcEvS80HC
         6QLc1UzKvWYO2YK5dMOEKdFFn/XF5xnWev3Lgmrc3ItNaUWINJjRKuX36t3po0g4k2Tq
         k2NWkF8Rc5D+/q+tCymCQYCjCK3MVruDwy46Rm4C42+BlKWLdd8jUV9jByj7Fbo4KNgt
         M0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iNLFgFIUTa921BtZj20hnjhyClAzxM7pWPjz0tad1Rg=;
        b=rk0ufbRqY1CeoL3pPZewbbVXNGB2A3JI3KUcktqtKrHM5qYOxsOGSxJ0V1rQ8oJntA
         J/b+E46kGe4W3UcpxByCLoSeuBZQSOeCEhVn0lo/dmUKgRM6Ym009S6/DzLyB1KNTIuU
         6/PzBIHfEvqHekv2t7FAeUtD+Dx4A4qUuFRnImOgWA/vUvWLv9rosDtGp6kCAoZZISo7
         RS9qaIBbBw5lURtPvRmjIXXZYPODl30YNx9NyWIzHE+6Tt4J3L5s1+xLb6rndUlSLOa/
         qpGOz49vqlo/9jxHBbTjKhhnR1o5zb4MJrUMgRPANNZRpSBQ519jeNVtIRf1W6KJcafr
         qy9Q==
X-Gm-Message-State: APjAAAW+Lmq1eoajWFNRZ8eJkQ0j1Ny865kngpcfjzvls0klAbif53L1
        H6Plk9zQ8ymGdkmPg6AgKIB2vJ1usxo=
X-Google-Smtp-Source: APXvYqxWg2HS0sxDkZXaceQR4/Hy3ltw6V+dlMGFsdssqxNhkUIe959kCCAqthYdhwOL1Vfl97fLAw==
X-Received: by 2002:a6b:f701:: with SMTP id k1mr4245893iog.260.1573078700670;
        Wed, 06 Nov 2019 14:18:20 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u21sm3691ila.41.2019.11.06.14.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 14:18:19 -0800 (PST)
Subject: Re: [PATCH v2 1/3] io_uring: allocate io_kiocb upfront
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
References: <cover.1573077364.git.asml.silence@gmail.com>
 <ed30899d479bf40c6d386cac5d9401892836c3b5.1573077364.git.asml.silence@gmail.com>
 <3ba4d378-db8c-27ac-e7a1-ac13f361bd91@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <49a76924-c788-1305-6aad-36018315e30e@kernel.dk>
Date:   Wed, 6 Nov 2019 15:18:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3ba4d378-db8c-27ac-e7a1-ac13f361bd91@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/6/19 3:05 PM, Pavel Begunkov wrote:
> This one changes behaviour a bit. If we haven't been able to allocate
> req before, it would post an completion event with -EAGAIN. Now it will
> break imidiately without consuming sqe. So the user will see, that 0
> sqes was submitted/consumed.
> 
> Is that ok or we need to do something about it?

At the very least we need to return -EAGAIN to the application. So
something ala:

return submitted ? submitted : ret;

where ret is 0 or -EAGAIN if we failed to get a request.

-- 
Jens Axboe

