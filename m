Return-Path: <SRS0=MGRw=ID=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FFFC433E0
	for <linux-block@archiver.kernel.org>; Fri,  5 Mar 2021 18:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7659D6509F
	for <linux-block@archiver.kernel.org>; Fri,  5 Mar 2021 18:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCESbL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Mar 2021 13:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhCESap (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Mar 2021 13:30:45 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870FDC061756
        for <linux-block@vger.kernel.org>; Fri,  5 Mar 2021 10:30:34 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id h18so2895228ils.2
        for <linux-block@vger.kernel.org>; Fri, 05 Mar 2021 10:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3IlmUCsWY/eRND+udc8axXocUIZQxevXufT1IASQhBA=;
        b=hMEob3ya3S4cxR/QfDGwT9WccEGdP9BTRCh6WnwMK7QRRDfkdPXEr+ondeOSRmgtI7
         RLOLOt+sGmgtvmeNIepQCuGI8+/gaRkrh4aZbG41WZhv/z3za8Hw1B/v+G5nUF6Vx/Ks
         I5J6udodKEabqAK6QaCmhWJLxe9/rQPBXdF+2QYfIV+EptT2T/5uNxkTsUb27GIzetbj
         BQbO7deysM5RuIvBPYA1e8ozzIs6AQqqOf0UNQRFJHxr+5CzmXDk1Q7SEub+pVZ1qaXL
         tROJIvwiSBl+yj39UfIKwdJ90jkBQE2sT3hMRyOmLaISP+C1HLYch8caIwwSqa8cUvbw
         eXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3IlmUCsWY/eRND+udc8axXocUIZQxevXufT1IASQhBA=;
        b=YGGrfaGvEG/galmag+EgxqACa1hmaDwkV14CjXYTB06WeML7IRhtYK8/aP9MU446UR
         qQiG7xSS+8aLWjTo6g743su3apjo0jtnR5QztavOt1RA/fOGqUKR4D9qXk8XhLRvZ5u4
         bsLooddfeij6VHpJyd7MO6+BKQj1eY7aS5BkkEWCakABVD5nagvERjsHRT1iqoiKG0E3
         bgStBaFV7el3V+KtpWyisl36tCBlSZzZm0cNoaOxEZlKq+DFg3y7v/jFko0GfJ88h7MU
         +gkpN6afjW4/dVSSPLNMo4GWdEQoi3sHiSO4eD3W04Wws8i0j+rCPblyYX9rrPzqTxCM
         MtLQ==
X-Gm-Message-State: AOAM533KVcHGV/RVFd/uxq3zaNLTTpSUJ00aEC2EzxgKI50saTTDj/4s
        w4DCI24JU/SQmj7JEUOljH5/7H6zUL2q8Q==
X-Google-Smtp-Source: ABdhPJxYfdOPRFbnxmUPblKztE5zYP3aqY3QXkX7EmdwzocqTcVRKt2OMMpF9LDEhsxtTzg+AgwgLA==
X-Received: by 2002:a92:c883:: with SMTP id w3mr10852946ilo.212.1614969033933;
        Fri, 05 Mar 2021 10:30:33 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h193sm1669618iof.9.2021.03.05.10.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 10:30:33 -0800 (PST)
Subject: Re: [PATCH 0/2] s390/dasd: driver unbind fixes
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20210305125439.568125-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e435321c-26b5-ff6c-5329-4a2a4918eb08@kernel.dk>
Date:   Fri, 5 Mar 2021 11:30:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210305125439.568125-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/5/21 5:54 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> please apply the following patches that fix two issues that may happen
> during driver unbind.
> 
> Stefan Haberland (2):
>   s390/dasd: fix hanging DASD driver unbind
>   s390/dasd: fix hanging IO request during DASD driver unbind
> 
>  drivers/s390/block/dasd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Jens Axboe

