Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53696C4332E
	for <linux-block@archiver.kernel.org>; Tue,  2 Mar 2021 23:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 334B164F46
	for <linux-block@archiver.kernel.org>; Tue,  2 Mar 2021 23:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhCBXrw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Mar 2021 18:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350794AbhCBWcm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Mar 2021 17:32:42 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4D8C06178A
        for <linux-block@vger.kernel.org>; Tue,  2 Mar 2021 14:31:36 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 201so14791392pfw.5
        for <linux-block@vger.kernel.org>; Tue, 02 Mar 2021 14:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dDOaCYCI2rpb4LQP8rVQ+Pz//+9Nqe8cELMz0UAeG/0=;
        b=OydL0mHpz8KkNLNjKg7Zcw4wTSbA9kc6aXnfOAX70XgHQvEPOG40YrS25pKI1DVtr4
         UbRHduhr4FhAqoaiMb4z9azXoFNMnr52gKTbbsfpq9jSlG917vdFyj5Q+q0f/8T+KXZb
         OCNZ7aUa/jjafQiiLYbD09B95mPvJj1tRyJj9g5PbTtv7mlMm6WUzS4hB4n4hPJEK9HB
         zMNSgvVxZ29tI8u6blcJAROHOHfV2OgtkuUoNfWOsQ11ctzgWmoPA6y8Zkfbru9IdXoP
         uqBEhrouei5ayHodTThwjOWrH9I/l+Pn2rar5uhS/egj4mI8ckHarMn+A9zzrh2WY4H6
         zQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dDOaCYCI2rpb4LQP8rVQ+Pz//+9Nqe8cELMz0UAeG/0=;
        b=fldqM+xI8Met4JfC1sGNwwdQlR15QayBh2u6fwxlRxe8zV8pWcyDDWnr7/A6AEWONK
         C8PDw3HoGnb7QF1QAhB/3mJGsshAd7hWbdd0RhWN93eq3JS3FfXCEkWtbrvjgF/HQ6if
         0nLJcrnd6zJN2Atp4k8F5WTvrqjFFAhIjZH2fxQct+MtWY2cl5NsPKawBE0PMXqajwp7
         WzvGGDsUxSCZeacHbndWaXcS/qHf5GAQ5hUml6xkrmvS5YfcTCqUHER2A/WXcAPTNA64
         ByUEDURaiqwzGP+Fs1XYGrOBi4ZsfnJCozAiVAunooDZ8HI26h7vX8DDiYYy0ZJtps73
         ofOQ==
X-Gm-Message-State: AOAM531LAJSVb+Z9NTWuS9HgvhNI0diMUzQ6QqdTg+Y6cpOkYnOJvRRP
        eWMCC9MOIr6EMznfLYPDuaUELw==
X-Google-Smtp-Source: ABdhPJynei85DD/12aeywxJt2eZTx14tQ/eEgKpARUyMiW6zvkxoyIapV6e2KTjaHjLzyHbHckRm5Q==
X-Received: by 2002:aa7:9281:0:b029:1ec:48b2:811c with SMTP id j1-20020aa792810000b02901ec48b2811cmr5109495pfa.18.1614724296196;
        Tue, 02 Mar 2021 14:31:36 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 68sm8831655pfd.75.2021.03.02.14.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 14:31:35 -0800 (PST)
Subject: Re: 5.12-rc1 regression: freezing iou-mgr/wrk failed
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1614646241.av51lk2de4.none.ref@localhost>
 <1614646241.av51lk2de4.none@localhost>
 <ad672889-2757-142b-9259-3e0aee6d8078@kernel.dk>
 <fd148797-d8cb-7597-8612-83ddfafac425@kernel.dk>
 <8cd026a0-ada6-9ae5-9ea1-a685b482173c@kernel.dk>
 <1614722744.btwkumq4s4.none@localhost>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bb6fc05c-f2b0-d7ad-489b-2db23e2abe52@kernel.dk>
Date:   Tue, 2 Mar 2021 15:31:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1614722744.btwkumq4s4.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/2/21 3:13 PM, Alex Xu (Hello71) wrote:
> I tried 29be7fc03d ("io_uring: ensure that threads freeze on suspend") 
> and it seems to work OK. The system suspends fine and no errors are 
> printed to the kernel log.
> 
> I am using Gentoo on the machine in question.
> 
> I didn't test the other patches you supplied. Let me know if there's 
> anything you would like me to test.

OK great, thanks. I'll add your reported/tested-by to the patch.

-- 
Jens Axboe

