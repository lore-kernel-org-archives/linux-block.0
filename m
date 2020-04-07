Return-Path: <SRS0=69Bb=5X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0C5C2D0EC
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 19:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD4D2075E
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 19:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="umqPoRxN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgDGTYd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:24:33 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42992 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgDGTYd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Apr 2020 15:24:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id v2so228251plp.9
        for <linux-block@vger.kernel.org>; Tue, 07 Apr 2020 12:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6GN8OH2/jW9JwHGhBC4VMasJH95BH8giiJV5mLcCQBQ=;
        b=umqPoRxNCHNRpmbH80vy5O201YJUULc6hqGly7WERsycQLmJAhO/fVVs0NUxbo0l+E
         Ei4s58f5tNqvMgLIcwKgvVEnW0BeTKp+LR2xj28quO7X9xzHL1qheZq8K+9zq3fpFXT1
         7Bz/U4ffV/4gQmnphXeuqNVVISlhLjUOwzYBbP8l2iA8/Vk4T8zzQ40zx8ygNihSUJ3K
         iIA1RizX4q3JVeW6dTXuVhqd2CbOnVNHjczZklP/lu6OnSsNR+gGdqswsbT5kB8IcXz8
         uAWz543RkO8Mz2nU8LVlHh6qdTEUVNFTbPhnDQzkXW6hAGebrFdQRcxEKFYqM9Mrasf3
         aTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6GN8OH2/jW9JwHGhBC4VMasJH95BH8giiJV5mLcCQBQ=;
        b=MekVzul1qanBnGA+3un4jyuACBbcFQhUXakj3bAGgoA6LzkwQLFAa2LRSW+O3wy88m
         h60LwVX8e94axbUO5Du5klZ6APmgcPFxc64r+a3426PmXNvTDLy/B+RMHLf/V2NRdCpc
         DRNd0L7aHDKK0aV1gLeEHD22iXM+T48225pvIvJLIhsCNLYMzh6R4gdXlNkz77EOcZz+
         aF44EPm1sPhRzyC2mJUwdj2bTheKoiJGsEyqwzBf7V7WaI+AeULjf0oRrEDg8sZKCkhZ
         6JimylRowrzDPYbJ/2UOIY+V6Em9A2FXNp0Ei4eg8fzg2lqZxHw98M6boz68Fyf6pzY1
         fEhw==
X-Gm-Message-State: AGi0PuZ5vietNv9aMIqD7OqKX6HFCjOIP/cDNbcglrlNk7GjRgEc10ED
        Tu9DlqiNHbQEsR2z9cXwLrts9njyycotXg==
X-Google-Smtp-Source: APiQypJkFPl162p4/chu82kIXc2V1RKn4YeyTYS10aBaifyojwyQWsTT5b8OWXXLdeIHmi9Pnd1a7w==
X-Received: by 2002:a17:902:b210:: with SMTP id t16mr1553926plr.71.1586287472981;
        Tue, 07 Apr 2020 12:24:32 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:ec7d:96d3:6e2d:dcab? ([2605:e000:100e:8c61:ec7d:96d3:6e2d:dcab])
        by smtp.gmail.com with ESMTPSA id x186sm14543759pfb.151.2020.04.07.12.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 12:24:32 -0700 (PDT)
Subject: Re: [PATCH 1/1] s390: Cleanup removed IOSCHED_DEADLINE
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
References: <20200406074118.86849-1-sth@linux.ibm.com>
 <20200406074118.86849-2-sth@linux.ibm.com>
 <0efad2a5-90f5-8ccf-169e-9715a64a4bb0@kernel.dk>
 <c7ac9c3c-3a1f-3ce3-acbd-422bc4206288@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4a51ce19-7827-5ee6-8b06-5b814bdf503a@kernel.dk>
Date:   Tue, 7 Apr 2020 12:24:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c7ac9c3c-3a1f-3ce3-acbd-422bc4206288@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/7/20 3:01 AM, Stefan Haberland wrote:
> Am 06.04.20 um 17:32 schrieb Jens Axboe:
>> On 4/6/20 1:41 AM, Stefan Haberland wrote:
>>> From: Krzysztof Kozlowski <krzk@kernel.org>
>>>
>>> CONFIG_IOSCHED_DEADLINE is gone since commit f382fb0bcef4 ("block:
>>> remove legacy IO schedulers").
>> Isn't this a leftover thing from when dasd selected deadline
>> internally? I don't think we need this anymore, just kill the
>> select completely.
>>
> 
> Basically yes.
> We still have the recommendation to use deadline and there are some udev
> rules in place which select it.
> So I thought it might be a good idea to keep the line. But I am also
> fine to drop it completely if you prefer this.

I don't feel super strongly about it, but at the same time I don't
think there's a reason for it. Besides, I think everyone has deadline
enabled. So I guess we should just kill it.

-- 
Jens Axboe

