Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46801C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 15:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDB72086C
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 15:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GCjhH/G9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDB72086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeKQBie (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 20:38:34 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37690 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbeKQBie (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 20:38:34 -0500
Received: by mail-io1-f67.google.com with SMTP id a3so10644250ioc.4
        for <linux-block@vger.kernel.org>; Fri, 16 Nov 2018 07:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T8awT9g6denNB6E2LmSfJOM/mUXw5zBF0ucdUeC71Mo=;
        b=GCjhH/G9m1HykBoH/nUtCkoba7tJMgAncN7JzRKT4kDejCkY3Abz6WujXi7x0jwNjy
         KdgZoevYqLDtvLN1mJ1I/4hSS+ZsLmfp8CtiA+IgtE5FMY5f1bMlHv67ACzRl4nlv0f4
         KhHQBQxQJ3igHsHluVjqEJsjghgzrVmaQdvBk80QE0IkXjGynGYRGuBitbCqaIzE5Zb2
         tYsygnAsH3OfYqoPdNcNbyPCy0y6dkW2Zouv6K+I4l3uTtySRr/R0oJ2OvBZ63fjLZkd
         fL0k3VQpYgIVnVghPO7t4OGurbMyWzzNyoe2fk4lIdu87GVPYVqg/8FPRo5GNI2pZcDG
         g5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T8awT9g6denNB6E2LmSfJOM/mUXw5zBF0ucdUeC71Mo=;
        b=BoF5yzu6mNpW63eUoeYype+DOE9jjDWvswbHzRPQH1Lw1XgwX1qY6Fnt1Q4buzGCLp
         UE6EDrVaNlb0T8tAJfpCtfd5JDCyqxKxuDH0fBs6x4ln74nLfcTWjgPaJUO+HgRJuayP
         ZQecf1c86v+OpDfiAm8vzjV+joYk9wrvqKLHcCVErkyjlwVFM61xDxdEc/DskIGzAuSy
         xVXTnzV9i4HWGC8QhILSYjRX9iMm5v1AhLwbiDQ1cpLZ0s8NWUZz17KZTIzaZMrhvwfM
         n111QI0Cn5R6hg7T8AC+xJ47/epWdh1biL5tRBsFhBvrkwXErn87TVUcJOnC6ZyqWulp
         EkGw==
X-Gm-Message-State: AA+aEWZTqq4/DtrGprKFsdZCFUdiqA+thW9CZuFDwQkvxYn7CNq9QveK
        wSdicM2u2CqiKwCERbwCPsOQlHY0HlY=
X-Google-Smtp-Source: AFSGD/VF2Mw1u2OWX7oNdmQg9K4UndHmRJ338LV3nN0pbjtvrc402XH8UJ46HU82PYLyQCGmTU94DQ==
X-Received: by 2002:a5e:8a4a:: with SMTP id o10mr3660935iom.32.1542381944806;
        Fri, 16 Nov 2018 07:25:44 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u68-v6sm555909itd.1.2018.11.16.07.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 07:25:43 -0800 (PST)
Subject: Re: [PATCH 3/3] block: use a driver-specific handler for the
 "inflight" value
To:     Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, "Alasdair G. Kergon" <agk@redhat.com>
References: <20181116000508.980108938@debian.vm>
 <20181116091102.GA22961@infradead.org> <20181116135555.GA28870@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c84a1ed6-cc90-472f-446f-d83a27d3ac20@kernel.dk>
Date:   Fri, 16 Nov 2018 08:25:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181116135555.GA28870@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/16/18 6:55 AM, Mike Snitzer wrote:
> On Fri, Nov 16 2018 at  4:11am -0500,
> Christoph Hellwig <hch@infradead.org> wrote:
> 
>> On Fri, Nov 16, 2018 at 01:04:19AM +0100, Mikulas Patocka wrote:
>>> Device mapper was converted to percpu inflight counters. In order to
>>> display the correct values in the "inflight" sysfs file and in
>>> /proc/diskstats, we need a custom callback that sums the percpu counters.
>>>
>>> The function part_round_stats calculates the number of in-flight I/Os
>>> every jiffy and uses this to calculate the counters time_in_queue and
>>> io_ticks. In order to avoid excessive memory traffic on systems with high
>>> number of CPUs, this functionality is disabled when percpu inflight values
>>> are used and the values time_in_queue and io_ticks are calculated
>>> differently - the result is less precise.
>>
>> And none of that is device mapper specific.  Please submit this code
>> to the block layer for use by all make_request based drivers.  Depending
>> on what Jens as the maintainers thinkgs of the tradeoffs we can discuss
>> if the summing should be on or off by default, or if we maybe even
>> need the current code as a fallback.
> 
> I agree.
> 
> Mikulas, we discussed that the changes would be made to block core.  I
> know that makes you less comfortable (I assume because you need to
> consider more than DM) but it is the right way forward.
> 
> Now that the legacy IO path is gone we have less to consider; these
> counters are only impacting bio-based.

Agree, either the new code is good enough to be used in general, and
then it should be generally used, or it should not exist in the first
place. We've always worked very hard to provide the most efficient
helpers and infrastructure we can in the block layer itself, so that
drivers don't have to reinvent the wheel.

-- 
Jens Axboe

