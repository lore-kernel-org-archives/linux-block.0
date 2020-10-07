Return-Path: <SRS0=w7gf=DO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE54C4363D
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 14:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD7921531
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 14:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KwogTcW4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgJGOCT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Oct 2020 10:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgJGOCR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Oct 2020 10:02:17 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35CCC061755
        for <linux-block@vger.kernel.org>; Wed,  7 Oct 2020 07:02:15 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id l16so2316454ilt.13
        for <linux-block@vger.kernel.org>; Wed, 07 Oct 2020 07:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7PmeV7A2s7ZHQXqDKwao7sD4aBVqIsNQs6VXNj1YEYc=;
        b=KwogTcW4hy9FHKhhK4CoGtwQRNETfccZAi+8JgcEzHJneLzVt0lZRipR6yJHNsnuBl
         9GrSt19QBHfA6YBzAC3B+Z9VD6C11O8+yR6f/vExQfAKz2cZfICjYJUFeZcmvS+TakoZ
         NmQvLUH/GxGJO2E0u3z/RgvJ2KiLBqW5fxhs/cRmnx8ej42ld8kVRK9RAMT6ZpvPaILQ
         SX+ABz1d4p9uOcS0Br6OlkiHDIEgRWd3HziR1kNJv+a+VzPwC5ZAu2/8rUUjGqbw5KrZ
         pYEwmEJHvT+CFcKZWIRZbrYt2+ypPtqanwRPNAC65dmKbnXgc3XrJjQFrRQZVpIskr0d
         MI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7PmeV7A2s7ZHQXqDKwao7sD4aBVqIsNQs6VXNj1YEYc=;
        b=cYkxygqxAs/C1FpNbQCyEJwp2Qxx5BSAE9iNZs+Td6RiEB9QTAv/PHaScbxnavsJ05
         AFSKfucKT8d2ZhoVFt9Kwx0/NPiflA0GSRWNXw0ilbUnjWV2/CjUU0wfxSIQzQ4GKXwe
         eoDktdgEDnXvBx26EYHKfpZxFEZ2Dy3uMbdw+bt5CiiJUQ35E+k39EKxYXEXauTmEb7w
         2VGNJhQWaUBogHmjTr4lMHLfpAHI3LqtfeOqE30EF5VieGCFBgXnqGIoGgdw/LL0wSl6
         FbiN8d53D88lKlabYufmMA0luhH5syBYnYTplVZUcH2qJFEcKxQ+5IF8xJmeHmsc6ciY
         om1A==
X-Gm-Message-State: AOAM533fa8j+JtORva9Ce5aZIGXEsjE+g5Zkx/gBa3qIyebhKEeMxD1e
        cju1FCjG8DKg9dgCj9J5L1LDvQ==
X-Google-Smtp-Source: ABdhPJxT6/PJs6QyWsWwtgVYf7Gzdtu19Vwnqm+ahLG7MbcWcakBIwfdrj7HEip5LfA9Ojd2s4+hXg==
X-Received: by 2002:a92:db45:: with SMTP id w5mr2687206ilq.158.1602079334890;
        Wed, 07 Oct 2020 07:02:14 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s23sm915544iol.23.2020.10.07.07.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 07:02:14 -0700 (PDT)
Subject: Re: [PATCH] partitions/ibm: fix non-DASD devices
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, sth@linux.ibm.com,
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20201007124009.1438269-1-hch@lst.de>
 <a8b1c076-c280-d201-8403-2392a42d2163@kernel.dk>
 <20201007135411.GA1000@lst.de>
 <874c518d-7c15-d08a-61a2-116f605c4b5a@kernel.dk>
 <20201007140109.GA1042@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <55d92fb3-acd7-d62c-093b-4f716d98ac52@kernel.dk>
Date:   Wed, 7 Oct 2020 08:02:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007140109.GA1042@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/7/20 8:01 AM, Christoph Hellwig wrote:
> On Wed, Oct 07, 2020 at 07:54:45AM -0600, Jens Axboe wrote:
>> On 10/7/20 7:54 AM, Christoph Hellwig wrote:
>>> On Wed, Oct 07, 2020 at 07:53:27AM -0600, Jens Axboe wrote:
>>>> On 10/7/20 6:40 AM, Christoph Hellwig wrote:
>>>>> Don't error out if the dasd_biodasdinfo symbol is not available.
>>>>
>>>> Should this be marked for 5.8-stable?
>>>
>>> The Fixes tag should automatically take care of that.
>>
>> Not if it's not marked for stable. Maybe auto-selection will pick it
>> up, but it's not a given.
> 
> Yes, trivial patches with a fixes tag get reliably picked out.  But
> if you don't trust the system feel free to add a stable tag.

I prefer being explicit instead of assuming it'll get picked up.
I applied it for 5.9, added the tag.

-- 
Jens Axboe

