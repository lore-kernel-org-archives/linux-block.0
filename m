Return-Path: <SRS0=KeVv=B4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BE8C433DF
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 16:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DEBE207D3
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 16:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="um9u8CPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgHRQpG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgHRQpC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 12:45:02 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F39FC061389
        for <linux-block@vger.kernel.org>; Tue, 18 Aug 2020 09:45:02 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u10so9475056plr.7
        for <linux-block@vger.kernel.org>; Tue, 18 Aug 2020 09:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EYH9QFulwc1L9HM0/F/ZkVeSU+OyN7m9DTioie6aqBw=;
        b=um9u8CPWT2vG3JzJ0O6YmmAwCf5SU9BaVzjyUdm9d5aXPxhYeyIThBfbfm7MOIKFst
         2JaGKUkAewEX9C7agQwDPPHXupRyvdJElX4MejOjaJ1JCpNAy7doG5YRQhP1Nf9cSAIZ
         Ar84YjQGI4IpBs3XRKLqC1q/i1jzpU/zmN646j73aT22pMNiIjeuAur03HPhWQg3sikO
         dXOdQGxEw6+w4xRlkNtUqnckJvTa/d0OVhZHKoEw3Fk7G6P39ucDRSucGImAqdDcBXq0
         8uyNG7iwvGLPPZT8rAaP7nJ1uiImiw68pLjlsRwRf3Q6TBP4CU+dxD7PY0j7B5GSwrrc
         F7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EYH9QFulwc1L9HM0/F/ZkVeSU+OyN7m9DTioie6aqBw=;
        b=pw85NwY9w8atpP57xzCmDNpBEGo6Yq9Y7y/LVTNOsZ8wIZ5bYUz1RzE/1nWEBpPLvP
         lNAWhM+AYk1R/nC9ZDBzZcitT+Lpz3vzVktIWDNhTn1Dc0Mw0R5bYAs69psx0rSUZRY5
         JEp6pfM6Lmpt3pls/Z+W/1+GjSJ7+2PdJtdOHfnn3ha2SFuutbbDPqbhD0hpNtC2VZxV
         rjVfrMjeiTFjbNO+FRFwJqC+m0I4MJDbvxr9XEovo6fKb2IjEALzuDQ+MbRRQF3ZnH68
         zRj8Zw1tbN1/ULlW20MXZlmLcL7eQrb0O/+qmfB7M2OHXePZtHLn8AQiEvGOiX3fzGf5
         CFbg==
X-Gm-Message-State: AOAM531SqPhcwI9+J6p85g5dysvFHr/tYi6/RULeM+EjD0RmhBWQsG/P
        7jJeoGKPNWQFYSGkLASFiftqYA==
X-Google-Smtp-Source: ABdhPJyhHR9ulFLMzLG8a0aTSfejqMZzC2bFrA6G+Y0gxun8N+vMYLa9iHOvXPtVrn/j/pu4QAhieQ==
X-Received: by 2002:a17:902:ed4a:: with SMTP id y10mr16088246plb.106.1597769102161;
        Tue, 18 Aug 2020 09:45:02 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:9214:36a5:5cec:a06d? ([2605:e000:100e:8c61:9214:36a5:5cec:a06d])
        by smtp.gmail.com with ESMTPSA id v78sm26545853pfc.121.2020.08.18.09.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 09:45:01 -0700 (PDT)
Subject: Re: [PATCH] block: fix get_max_io_size()
To:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org
Cc:     Eric Deal <eric.deal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, stable@vger.kernel.org
References: <20200806215837.3968445-1-kbusch@kernel.org>
 <20200818163932.GA2674385@dhcp-10-100-145-180.wdl.wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <edcaf8e7-c76f-6ed5-e0e8-080f8fbb7473@kernel.dk>
Date:   Tue, 18 Aug 2020 09:44:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818163932.GA2674385@dhcp-10-100-145-180.wdl.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/18/20 9:39 AM, Keith Busch wrote:
> Hi Jens,
> 
> The proposed alternatives continue to break with allowable (however
> unlikely) queue limits, where this should be safe for any possible
> settings. I think this should be okay to go as-is.

OK, let's try this again then. Queued up for 5.9.

-- 
Jens Axboe

