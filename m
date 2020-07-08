Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B099FC433E2
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 14:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A21B20720
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 14:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="foX9E06j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbgGHOHA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 10:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbgGHOHA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jul 2020 10:07:00 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63E4C061A0B
        for <linux-block@vger.kernel.org>; Wed,  8 Jul 2020 07:06:59 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id b15so41917242edy.7
        for <linux-block@vger.kernel.org>; Wed, 08 Jul 2020 07:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=21m5JzfwGq0gXeZrVtL3JyPzgmxD8avEylD2NTGTysA=;
        b=foX9E06jNMdcDWO81XNGYFn+1KO0b2AnGeu7h3JgmA3r+Ao2tVDX8TrjsGZJfA//FK
         iPgIKB/Qnh0q7eUJROvb2++9iIPYbltIuajwulED0Qx73mZ4HoVDZh47jNqc4aVcsHjv
         NzTfMS3t2efc0n6RXdrtRAqzofggqQK5vzoNxkLUo/0CS32537pgnRv7b61Jm8kscYf8
         FMpW/pEvh9jY4AIs/KbhMQfe17G6jrA08pQ+1YgwplEAUzLCEoEUGwX8oniRp5uo10WP
         kO3ekBCnHBGvoR3nm7YkQ/soZKQLi7UIwcEssSew66HyIQ2RH3B+aj19JKhEV/R/FUK1
         PegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=21m5JzfwGq0gXeZrVtL3JyPzgmxD8avEylD2NTGTysA=;
        b=XWAndeaBx6L6gKJ3gdgU33va8AiULEZ8uFNrQwzrTUO1BKaJWSwhsTWRzmd7afskDz
         2vZomUUUHIMN+FuNZPvgJ1J+EqeQrGqqtjbkIaMMmFJ3Pp6LQdf6WOmoL1UambURizlt
         eK2hbw15cTLKRjCpwa57cHmWwPdGJ74NKBc8yPz+h4hJraB6fgqtYsOrsfyiWNj8ovaY
         8pMO9IaIR1y96rJgcUXnRx1TBmT9yk9w7EUga3SISSQjIDBWTD27zFyNXGs6tWuP06//
         lQTfwK9lI1PgHMiGzc22qs2oDqwR/5if5CAGMdF2kSb41A0Lo0aBz2ysEc6m49gj1Svz
         zn1A==
X-Gm-Message-State: AOAM530GTvnkv2xHP6u7NcRSJDVs/ZAekSReKZt8LbAqQQgegVPggRp7
        +bz2PC6epwDkIOFCca9fTWFPJw==
X-Google-Smtp-Source: ABdhPJwUZ5x7pZWbgCfiwR7VNWbDQlirAMs2veqs3gm8NbwH7cQuE/WrpF5nmo/MQlxOwxmM7RDkxg==
X-Received: by 2002:a05:6402:b10:: with SMTP id bm16mr20766451edb.92.1594217218402;
        Wed, 08 Jul 2020 07:06:58 -0700 (PDT)
Received: from [192.168.178.33] (i5C746C99.versanet.de. [92.116.108.153])
        by smtp.gmail.com with ESMTPSA id z22sm28477085edx.72.2020.07.08.07.06.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 07:06:57 -0700 (PDT)
Subject: Re: [PATCH RFC 4/5] block: add a statistic table for io latency
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Florian-Ewald Mueller <florian-ewald.mueller@cloud.ionos.com>
References: <20200708075819.4531-1-guoqing.jiang@cloud.ionos.com>
 <20200708075819.4531-5-guoqing.jiang@cloud.ionos.com>
 <20200708132958.GC3340386@T590>
 <eb2cf4d0-4260-8f10-0ba9-3cbf4ff85449@cloud.ionos.com>
Message-ID: <b37dd9cd-aebc-88ee-2b09-ac4eb36ca0f7@cloud.ionos.com>
Date:   Wed, 8 Jul 2020 16:06:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <eb2cf4d0-4260-8f10-0ba9-3cbf4ff85449@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/8/20 4:02 PM, Guoqing Jiang wrote:
>> Hi Guoqing,
>>
>> I believe it isn't hard to write a ebpf based script(bcc or bpftrace) to
>> collect this kind of performance data, so looks not necessary to do it
>> in kernel.
>
> Hi Ming,
>
> Sorry, I don't know well about bcc or bpftrace, but I assume they need to
> read the latency value from somewhere inside kernel. Could you point
> how can I get the latency value? Thanks in advance!

Hmm, I suppose biolatency is suitable for track latency, will look into it.

Thanks,
Guoqing
