Return-Path: <SRS0=S5B1=ZN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176A9C432C0
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 16:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDF420637
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 16:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MRC5GtQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfKUQH3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:07:29 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:38751 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfKUQH3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Nov 2019 11:07:29 -0500
Received: by mail-il1-f193.google.com with SMTP id u17so3801613ilq.5
        for <linux-block@vger.kernel.org>; Thu, 21 Nov 2019 08:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P4W4hyYZ6T+wL1O213mYLd96KdBzBHpg9/YQCjoVILM=;
        b=MRC5GtQYRbjWjFGZ/vJsaClUMDJ7hy8XeLThYplbe7u/VBoJyVDfOQRYNCc9WHf1+R
         YM8i3LUmqrCtDbaOPuE+/759ibNWitWsdr/1LB32m8NQp+rYS/R5MRMYP0SxrAH7pDW/
         yzbDF1xvKxuXI/4YwDImOAMRtkxOBtfLCZb7Rn0Rg5lGNiLHY69oLwDT8tQHHONCPyOL
         VRRMjJIF0O4osgapAp43czNPYKTjL442yIx7Ljhmy1ctls9w6UWWmnJ6QyM6DqVy3hqf
         4k0Yi51vruRfdY62Nc1rpQ3KoiUObEVajgdICck/bxmpkaj8MaFGqq96EHvYxa8LmC1u
         C7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P4W4hyYZ6T+wL1O213mYLd96KdBzBHpg9/YQCjoVILM=;
        b=Wq6cNBdMw3soqLcV3VSmlYK3fphhR+ovR3xNNsNjPU9iD+wrxkft5U/G6WzRM+P45m
         3FsbgxLMpskRQFk2sOSTTDFGTuh8jWAaaJ7EMOqGUZPS2+1/injlSeURVcV3lIGPrK+8
         sFREMt5j7j6UlLe7fHJ07V7PiQ+6qEEcG48FhKpTjTkVQ+DZ/Jb7sFvhXmQIH2n1JMbO
         LYyNAoqoaIRBAET2+2jpcFeHlyqy/iLH/0t7PddF6wjsdU3mNh9bbbiu9BZrInGEarEk
         PD5DLV59YhjJDoRhGtfE+JTazWbuys5NV0hTJ2BmO1lNO9QZ/4SCD8AfBNdWxJnOcu9I
         jFkQ==
X-Gm-Message-State: APjAAAVFy6zPD/+IoeCKHvIg88YxyCBhzqp6cDgt6Rh+e7H59Z63t9xz
        IL1udBss4otuvkPTeqQl7BEYzQ==
X-Google-Smtp-Source: APXvYqwBuxR5GnmNrTTF+fDPqQ/m+MVGAFtj5D46hjZm7URBjIHtPwDjypsu1kC4QDIwCYtLqK4NhA==
X-Received: by 2002:a92:9ace:: with SMTP id c75mr11197162ill.296.1574352448192;
        Thu, 21 Nov 2019 08:07:28 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v15sm1379208ilk.8.2019.11.21.08.07.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 08:07:27 -0800 (PST)
Subject: Re: [PATCH] block: add iostat counters for flush requests
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
References: <157433282607.7928.5202409984272248322.stgit@buzz>
 <ff971ff6-9a10-c3f1-107d-4f7d378e8755@kernel.dk>
 <20191121160430.GJ6211@magnolia>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f542739c-7d43-1ea3-5235-c7809bb59f62@kernel.dk>
Date:   Thu, 21 Nov 2019 09:07:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191121160430.GJ6211@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/21/19 9:04 AM, Darrick J. Wong wrote:
> On Thu, Nov 21, 2019 at 08:56:14AM -0700, Jens Axboe wrote:
>> On 11/21/19 3:40 AM, Konstantin Khlebnikov wrote:
>>> Requests that triggers flushing volatile writeback cache to disk (barriers)
>>> have significant effect to overall performance.
>>>
>>> Block layer has sophisticated engine for combining several flush requests
>>> into one. But there is no statistics for actual flushes executed by disk.
>>> Requests which trigger flushes usually are barriers - zero-size writes.
>>>
>>> This patch adds two iostat counters into /sys/class/block/$dev/stat and
>>> /proc/diskstats - count of completed flush requests and their total time.
>>
>> This makes sense to me, and the "recent" discard addition already proved
>> that we're fine extending with more fields. Unless folks object, I'd be
>> happy to queue this up for 5.5.
> 
> Looks like a good addition to /me... :)

That's all the encouragement I needed, added :-)

-- 
Jens Axboe

