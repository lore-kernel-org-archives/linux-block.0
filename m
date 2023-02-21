Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC53C636D7
	for <linux-block@archiver.kernel.org>; Tue, 21 Feb 2023 23:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBUXv2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Feb 2023 18:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBUXv1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Feb 2023 18:51:27 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010FA2E0CD
        for <linux-block@vger.kernel.org>; Tue, 21 Feb 2023 15:51:25 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id ky4so8066025plb.3
        for <linux-block@vger.kernel.org>; Tue, 21 Feb 2023 15:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1677023485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TeKLKkYe7T5N+C7Ygt0F/TxvVhMbnFp2tjfm+IUYSX0=;
        b=mJdbtyIQsVHASS7I7Se3Y25RaM/iHeLZg/qiRLnAA9WQmL3CYqO8IkmwNcxHxU8aE+
         W2AYPqAMXlC05Fu0evorL0OvTQM6ELoja86egTMxr282GCCtZGpvrPojPX95rvISj9Y5
         rYQmnWIkvqd8wOdwzScPvZpLmAae79D7RDO08p5TVA/Pg8FT/ipwJAHnvA0KF0JAwhQf
         C1vBd5Ovs4NQZmdUQpSrIKAxKXLndpVzEWdpPNOBR2NzYXzeK/OlxdBGqqF/wJUQ4cuj
         SocF5pfRZzA/U3E88FkPlpm1PUXNgi8la/8WacDTTWW77K31czSRbbw+PlA9AfiaGN4I
         /4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677023485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TeKLKkYe7T5N+C7Ygt0F/TxvVhMbnFp2tjfm+IUYSX0=;
        b=fuYMVV6IlD6EZDHgwMobNIi+Wnfn7R6uO+/y9OTeienwd/W90BfoRm7lCpJ4Enm/2R
         DZDeV9kOsnbglLvo8R2F8nYLHxGnH4R7psUw4gVtY2BSMp0XaQQQdKNX9uXjN95ZnIgH
         IQp35VjPnjNC01S/6o4vr1Csflik6UD9S3peZULqJAxfOJFZWPoeeKHP4n436yhVfp0k
         W5r8AIfgCpoEO5oGIroTl62A4Q4qDfTMTF6dB4vjp0cxmXNFmXJIdiLavPTZrKtWVFOJ
         fn9IiLqEOs/2sSIjGzsvCw1c9WAReWOxSEZ0FOe4j/JJChAhbuYg2Adra9oC9wuwmb5o
         nK8A==
X-Gm-Message-State: AO0yUKW2H5gwrEpD65NwgkPSA1A/3AQ/VfzNwm80FHrdabaWMpu0zxaB
        DQemhXSIQj5LsJr2cPcbOC3AsA==
X-Google-Smtp-Source: AK7set9Pxte5hFty2cfQJ0DZ0iksgHrG7y/k3rNWGlRW04pIGZKYIjwZu5GvKLY+H+N5l3qtxXNBjA==
X-Received: by 2002:a17:90a:a516:b0:234:9d30:84ff with SMTP id a22-20020a17090aa51600b002349d3084ffmr6497433pjq.3.1677023485279;
        Tue, 21 Feb 2023 15:51:25 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id bb19-20020a17090b009300b0022c0a05229fsm3691964pjb.41.2023.02.21.15.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 15:51:23 -0800 (PST)
Message-ID: <339e527b-2f2f-8b6f-6de4-84d7b5e3f96d@kernel.dk>
Date:   Tue, 21 Feb 2023 16:51:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 0/1] improve brd performance with blk-mq
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Cc:     hch@lst.de, gost.dev@samsung.com, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <CGME20230203103122eucas1p161c0f0b674d26e23cf38466d5415420e@eucas1p1.samsung.com>
 <20230203103005.31290-1-p.raghav@samsung.com> <Y+Gsu0PiXBIf8fFU@T590>
 <6035da22-5667-93d5-fe00-62b988425cb5@samsung.com> <Y+nwh7V5xehxMWDR@T590>
 <95506a88-c89c-0f41-3ab4-eb5741410c02@samsung.com>
 <7c28caf6-931e-0a7a-a3c0-e4a430f860ff@kernel.dk>
 <8cc2659b-b7f9-eb8a-e73b-3056b82f159b@samsung.com>
 <db1d7cd7-6c89-7d6b-3fe5-3778bb3cb5e9@kernel.dk>
 <a10f11a5-2646-6db9-ab25-f2bb41190cc8@samsung.com>
 <Y/U+sxv6s09s/AyX@bombadil.infradead.org>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y/U+sxv6s09s/AyX@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/21/23 2:59?PM, Luis Chamberlain wrote:
> On Fri, Feb 17, 2023 at 08:22:15PM +0530, Pankaj Raghav wrote:
>> I will park this effort as blk-mq doesn't improve the performance for brd,
>> and we can retain the submit_bio interface.
> 
> I am not sure if the feedback was intended to suggest we shouldn't do
> the blk-mq conversion, but rather explain why in some workloads it
> may not be as good as the old submit_bio() interface. Probably low
> hanging fruit, if we *really* wanted to provide parity for the odd
> workloads.
> 
> If we *mostly*  we see better performance with blk-mq it would seem
> likely reasonable to merge. Dozens of drivers were converted to blk-mq
> and *most* without *any* performance justification on them. I think
> ming's was the commit log that had the most elaborate performacne
> metrics and I think it also showed some *minor* slowdown on some
> workloads, but the dramatic gains made it worthwhile.
> 
> Most of the conversions to blk-mq didn't even have *any* metrics posted.

You're comparing apples and oranges. I don't want to get into (fairly)
ancient history at this point, but the original implementation was honed
with the nvme conversion - which is the most performant driver/hardware
we have available.

Converting something that doesn't need a scheduler, doesn't need
timeouts, doesn't benefit from merging, doesn't need tagging etc doesn't
make a lot of sense. If you need none of that, *of course* you're going
to see a slowdown from doing all of these extra things by default.
That's pretty obvious.

This isn't about workloads at all.

-- 
Jens Axboe

