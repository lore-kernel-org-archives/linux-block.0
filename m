Return-Path: <SRS0=zyEp=R5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA78C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 14:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D04B2075D
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 14:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tSJUbweK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbfCZONe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:13:34 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53578 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731697AbfCZONe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Mar 2019 10:13:34 -0400
Received: by mail-it1-f193.google.com with SMTP id y204so5472086itf.3
        for <linux-block@vger.kernel.org>; Tue, 26 Mar 2019 07:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L3m64orwlPvqN0L9P3flUz75pA7vREJUnHemqbnA/zw=;
        b=tSJUbweK8v3iG7soWdlmbVq8OhCiDUrf2b/qwCbIFmGuwl8tdAOe1hDzeKzKuRCtKf
         W42EP9yKgEYilXRU7mqZ4Nlv0TwOAJIMAE3a5fKgSmGCoJvSBcF1VO35ayHFrOwGcfTW
         hjxjia38x28VDV/7oGM3ID8qnwUbflboMi+w68R3P12zThSvDnuEUf3Bx9MXfLEHn+0h
         Wo15VfM5/o6wAJmd0+7plfB9FnDDIJkq02I4Mri0bqTsJJmrU9JfSfDLkm3+gTGnr+0Y
         24YlBOlIRDeI3S64t2Eg2Pl4AxYtj6OHcQxBG7ndDPnINDOfE7wBKGzcGDG5RK4Y2cjO
         G0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L3m64orwlPvqN0L9P3flUz75pA7vREJUnHemqbnA/zw=;
        b=g4I7juM1yyJO127x7tK1hcQZ3mZvLYZ5u2PXripMmhOPhuLBlxcOZMO6EAkMsKW9BS
         YiMsYMXdRLwahSUZTVzk7ROr98KeIWS5C7vfCN+zYTd1bo0wb/1Bl2Z2v/8l4MDsTpI1
         uKow/MY3USBu2FYB+Frg3QfcGIqrTQdt5KkiDleDAWZVzgur0RJJLqqwEflKnUULioP1
         CFbB/MNPdL/VmmfwmAvOIEyEuXyYqk48SHkoNn8bUQyeI2aaAzZe1/4EoNZfwJ4anO8p
         xqQ/TspYf50/u5opD+iqDGv7UNteuEqmydXtfTrftRBWLFCzZ79W55kT9Fo/x0aCFFgm
         Payw==
X-Gm-Message-State: APjAAAV2Nlq1c/jepFxSssCMTAQizxBFRB+gy2gNoRP6Jb/a7j7nNkI8
        WfVs/f3NlOFOV/u11/wMBbCzHQ==
X-Google-Smtp-Source: APXvYqxCPEiBgJb/96puHSSERD5MG4/scpragodikUpNCTBaFT0JCdU+K4sZSSRBvlaQZdKzbDHjxw==
X-Received: by 2002:a24:ac6b:: with SMTP id m43mr16530180iti.28.1553609613251;
        Tue, 26 Mar 2019 07:13:33 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k18sm8931430iob.60.2019.03.26.07.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 07:13:32 -0700 (PDT)
Subject: Re: [PATCH BUGFIX IMPROVEMENT V3 0/9] lock, bfq: fix bugs, reduce
 exec time and boost performance
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, broonie@kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        fra.fra.800@gmail.com, alessio.masola@gmail.com,
        holger@applied-asynchrony.com
References: <20190312085935.11340-1-paolo.valente@linaro.org>
 <E7E093AD-07CC-4B76-9675-14F0A7C4D8E1@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d8d37c06-c05c-8521-f79a-2fe1296149dd@kernel.dk>
Date:   Tue, 26 Mar 2019 08:13:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <E7E093AD-07CC-4B76-9675-14F0A7C4D8E1@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/26/19 5:53 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 12 mar 2019, alle ore 09:59, Paolo Valente <paolo.valente@linaro.org> ha scritto:
>>
>> Hi,
>> this is the v3 of the series
>> https://lkml.org/lkml/2019/3/10/138
>> that fixes some bug affecting performance, reduces execution time a
>> little bit, and boosts throughput and responsiveness.
>>
>> The difference w.r.t. v2 are new fixes to the patch "block, bfq: print
>> SHARED instead of pid for shared queues in logs", after patient checks
>> and suggestions by Holger and Oleksandr.
>>
> 
> Hi Jens,
> have you had time to look into this?

Looks ok to me, I'll queue it up for 5.2.

-- 
Jens Axboe

