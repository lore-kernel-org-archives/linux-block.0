Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8192C433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 10:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1DDD60E8F
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 10:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbhJYKY7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 06:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbhJYKY7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 06:24:59 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DF1C061745
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 03:22:37 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z14so10768447wrg.6
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 03:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FfX2fqDSkpQi3vUaI9dcDRa7pgCHAW91nMI3mWZRSBg=;
        b=eMBY/ImDO1jbftWoYhiHg4NIVuGwczAz/n3AP6lwZpF9ZGTCzUm+Zh6qNBP+H+gOSk
         ELBhPdSo8I+tnAFFIDJSfw0AatzS80JuuTY2dBUX6K5DVCDhoqOsR7SesH6GcbBy/qIx
         UTHNaeoQYJCcy1HghB8eAc2lQ3iw26JlV4Faqiba9q6RZmwOFe4naunF4lBa9uLgr7oz
         HLmzi8Vabz5sMjSvg/fV8gbVJyHGaUaq+3hrWBIYT4hVTTK4EkUlFYVfd24td+t+AKVZ
         TEbiMjwn95waCW835A26QMo45he3K3XqL8TSJ1rtAVNESRtWvJekyMc0KREfTlqG/L8/
         GgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FfX2fqDSkpQi3vUaI9dcDRa7pgCHAW91nMI3mWZRSBg=;
        b=ZkqNmrBHoudvXtiLY4BwpE+5GIj4PoSbrCXpvLjyYdUoVSUcPvhClR3LwPOycrsPEN
         qtpUet+Y71oZFKZcKhs59T1twh3wSCLG6jrooA6YdMNaHZlbFjvV+CHsfUBYhAUdMdwt
         ZOmd89DmgURyo9Lbjl3BR79sBH3aQvUk/wIUHZGp6uLVixGLxCJXlbwhZUS3JSSe2Ddl
         b3Xi/RoYtnQNT9PHWxHvMr/zbMUqQaC52Ok4IQnIuFGYOypqLlm8JI3HKqr/e6tI1bnI
         HGiSURP50RVEpETj0W0TA53CMqKUUIEU1p+sidLTyN+jO7s1EJ1R6mSyNoCtoZ2b5IDF
         NpLA==
X-Gm-Message-State: AOAM530dLsqBzVzMTajwqDP4v9/PRq6SnoBjL0j7k9ojYlwoX8AevyRS
        y87Ml069iA+KfAy+2GJbe+GYgqMKLy8=
X-Google-Smtp-Source: ABdhPJwkQD94UTAwGwqOzn1Yu5V2YPKfrTZ3MgVGHigUZAMnO1aVgumcNU28RuHV+d/U/Jaq8PuwVQ==
X-Received: by 2002:a5d:6441:: with SMTP id d1mr10922841wrw.367.1635157355730;
        Mon, 25 Oct 2021 03:22:35 -0700 (PDT)
Received: from [192.168.8.198] ([185.69.144.165])
        by smtp.gmail.com with ESMTPSA id o26sm18637764wmc.17.2021.10.25.03.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 03:22:35 -0700 (PDT)
Message-ID: <7644d9c6-5553-de7c-8a53-5fbb01dae172@gmail.com>
Date:   Mon, 25 Oct 2021 11:20:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 5/5] block: add async version of bio_set_polled
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <cover.1635006010.git.asml.silence@gmail.com>
 <b766a125d417b3675f0abcdf32ac038c3c235ce9.1635006010.git.asml.silence@gmail.com>
 <YXZedoab02jl5GVI@infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <YXZedoab02jl5GVI@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/25/21 08:36, Christoph Hellwig wrote:
> On Sat, Oct 23, 2021 at 05:21:36PM +0100, Pavel Begunkov wrote:
>> +static inline void bio_set_polled_async(struct bio *bio, struct kiocb *kiocb)
>> +{
>> +	bio->bi_opf |= REQ_POLLED | REQ_NOWAIT;
>> +}
> 
> As mentioned last time I'm a little skeptical of this optimization. But
> if you an Jens thing it is worth it just drop this helper and assign
> the flags directly.

Ok. I'll keep it last in the series, looks Jens doesn't mind
applying patchsets partially.

-- 
Pavel Begunkov
