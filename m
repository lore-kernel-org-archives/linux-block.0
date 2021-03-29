Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB7DC433DB
	for <linux-block@archiver.kernel.org>; Mon, 29 Mar 2021 13:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D676061932
	for <linux-block@archiver.kernel.org>; Mon, 29 Mar 2021 13:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhC2NCL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Mar 2021 09:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbhC2NB7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Mar 2021 09:01:59 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C88CC061574
        for <linux-block@vger.kernel.org>; Mon, 29 Mar 2021 06:01:59 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id f3so160899pgv.0
        for <linux-block@vger.kernel.org>; Mon, 29 Mar 2021 06:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+f9NbANnAGvNKLuXbSw8Wy8fK8ZUuswF9eo4r7SgnkU=;
        b=dbhrBBYDiRdzUHEruDNXkA/xXXADd5eppqp9zq43QXOPt3mvYuFMBBPrtOo3dcP7sD
         vUb7OkPpUG+oxHKhwwP8Irrj/D7LIDQR84cFlZMHqK1I04WN4dmThg5bHFwOZCqCA8Mp
         dBLqnO2axpVJ2rzllJwNlck51w2FFjNQc7MpzDJkXINrrgLevqW9SyIxkB8sy9hAYrFB
         Nh1J2p0WKkRtZNvN/RGcp6un4MIHjS1KAKT0SEj1788VhQG3Tk9SDUXfxsGNYeyPi7n5
         gC37Wlm9hoS+oTEVQmaHy61S497yjTJJIqyUboyyOEFVSxWxcV5hyenQynfcSkzRZQhG
         6sKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+f9NbANnAGvNKLuXbSw8Wy8fK8ZUuswF9eo4r7SgnkU=;
        b=XbGFU5uO7wcfunAGa8tIZEGim0rQfIEn2EzkOxqqiPIkCDsTyzho0oRUnZ3rxLcIBf
         Pznzibj9RxhSt/9W+TIGxHRAvovBrmUVgLKuPfx7yQLevy6UJXBfegB/NHmyxyfAob13
         IfC/HxVuZcyWc1r3noVVRzQ26VI7Ph4gbNumRxoTlmvzGn2rLNfJ4j7uxmrgcgtmqueD
         tA+X5QTOLa47YCJO+csfCKV8Wb30sawQRYuLf8MJ6iUWCSTQjhuRC2QqioXkKo2nQljo
         CpjTHqqhcp9D8DpGZ80pgZAA3TezUcXrF5sIufgcnFoorpxjwI5+v3s+E1SD8moloURf
         mvmg==
X-Gm-Message-State: AOAM533EGTr1Af9733t52kckO+z7KlrFxQLDgbgsoeX9xyrhaptyJFkR
        fLfCmGVO+4wlWOG0ktu3hHwwm+QR9OlOzw==
X-Google-Smtp-Source: ABdhPJzK1V26Ke6tGhjHi9thqYRlPFNUTEKDFh83JcApPQiAkl/Af35Y1sJE1zeo42ULpkrAx1x+9w==
X-Received: by 2002:a63:f247:: with SMTP id d7mr23039502pgk.112.1617022917890;
        Mon, 29 Mar 2021 06:01:57 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y9sm15286052pja.50.2021.03.29.06.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 06:01:56 -0700 (PDT)
Subject: Re: remove ->revalidate_disk (resend)
To:     Christoph Hellwig <hch@lst.de>, Tim Waugh <tim@cyberelk.net>
Cc:     linux-block@vger.kernel.org
References: <20210308074550.422714-1-hch@lst.de>
 <20210329055540.GA27177@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <465891ab-0633-2ee3-b51a-fe2e7be5f9ca@kernel.dk>
Date:   Mon, 29 Mar 2021 07:01:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210329055540.GA27177@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/28/21 11:55 PM, Christoph Hellwig wrote:
> On Mon, Mar 08, 2021 at 08:45:47AM +0100, Christoph Hellwig wrote:
>> Hi Jens,
>>
>> with the previously merged patches all real users of ->revalidate_disk
>> are gone.  This series removes the two remaining not actually required
>> instances and the method itself.
> 
> Jens,
> 
> can you consider this for the 5.13 tree?

Looks fine to me, we just need to drop the umem change as it was
removed. And paride really should be as well... But in any case,
I'll queue up the other two or 5.13.

-- 
Jens Axboe

