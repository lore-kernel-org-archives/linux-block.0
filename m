Return-Path: <SRS0=A/1A=5J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F2BC43331
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 16:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F7420788
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 16:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fQEuKNFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgCXQGa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:06:30 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36335 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbgCXQGa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Mar 2020 12:06:30 -0400
Received: by mail-io1-f67.google.com with SMTP id d15so18648288iog.3
        for <linux-block@vger.kernel.org>; Tue, 24 Mar 2020 09:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ojwoexmi/yNDp0QrqjuP+tb9z9BxusbHoCk6iHU7shU=;
        b=fQEuKNFQnAsD07TtSc6hXHFzVHp8dLZVMVM5iWSjjjdGw4f2R/gciWR/viQuDDtOfX
         7es7jXjtssrvriqGFL5nVHrdtsxIQvYC/VBWTu7PB5BmEH27FnpoqZIsDCbsw97eSlDY
         Ypij/2VgnN453qPo4pw07Ld9eSes/EugM5d7Zk1sVvuNNZpJjGUisbNxO7GgHret37KC
         1CfI/hbxhhzJAM+DO6H/4zytEk592jhdyJRt60sxjsWFwAAXXXdz90/LvucNkwXawTqM
         mF98FzSQfTQqxNOi/Mh0yyw26lXdwssdBTUc9eu4RLefyEvSv7XrpcCxtBeW+okQsfPq
         UC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ojwoexmi/yNDp0QrqjuP+tb9z9BxusbHoCk6iHU7shU=;
        b=PCxAPmMREhRY08Ep+zMsSzo0Pegg1o28xtzbWx8C2V6wAy5nVpsx0lRFf/IYArt2nr
         qKVSkrtetKn+HSGOSGsc6iUJtzST0m4WvM/u4WVL35WyfJ4nHkNyuHlIbP0oLIYWF7wj
         fy3Zx1LrswYYNIi7NPoUKitRWOqfk8MoR2Oc2X3N1TqtnoBJaNC5B173mwjL373on9GF
         r1GFK+CH4CbNlkcpQ2KkFwk+UpLzVzO1xJ/OtRb5KmH0P1dfCxRJg9OLrj4H2k+5LYYS
         psk4Bl7qANWfyfqPXdKPFMxvKEM7nU6eZyLk1up6kVqT+RA3p7ewaxigwjU5wntoxUBF
         YC5A==
X-Gm-Message-State: ANhLgQ2caPwj9TE2TQT9e2EyZ6rZteHxaqTING+/3j6Z176ra/IU3hx/
        j7vTR43qsQBUwrdYJOxwFG3ujw==
X-Google-Smtp-Source: ADFU+vtSEIy6OU2P3p0F5VYmIIPCNs10wRnCB6nYzCevCk/nSG4XkYeAO/0NiEIbndZmWaAyWKV5KQ==
X-Received: by 2002:a6b:156:: with SMTP id 83mr24819257iob.187.1585065989365;
        Tue, 24 Mar 2020 09:06:29 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n18sm6464554ilq.38.2020.03.24.09.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 09:06:28 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] block/diskstats: more accurate io_ticks and
 optimization
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
References: <158503038812.1955.7827988255138056389.stgit@buzz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8aa3e8f7-cd53-b038-d5a7-dca7bf3fa929@kernel.dk>
Date:   Tue, 24 Mar 2020 10:06:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <158503038812.1955.7827988255138056389.stgit@buzz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/24/20 12:39 AM, Konstantin Khlebnikov wrote:
> Simplified estimation for io_ticks introduced in patch
> https://lore.kernel.org/linux-block/20181206164122.2166-5-snitzer@redhat.com/
> could be very inaccurate for request longer than jiffy (i.e. any HDD)
> 
> There is at least one another report about this:
> https://lore.kernel.org/linux-block/20200324031942.GA3060@ming.t460p/
> See detail in comment for first patch.
> 
> v1: https://lore.kernel.org/lkml/155413438394.3201.15211440151043943989.stgit@buzz/
> v2: https://lore.kernel.org/lkml/158314549775.1788.6529015932237292177.stgit@buzz/
> v3:
>  * update documentation
>  * rebase to current linux-next
>  * fix compilation for CONFIG_SMP=n

Can you respin this against my for-5.7/block branch?

-- 
Jens Axboe

