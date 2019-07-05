Return-Path: <SRS0=Wa/x=VC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46F7C46499
	for <linux-block@archiver.kernel.org>; Fri,  5 Jul 2019 21:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8893E20449
	for <linux-block@archiver.kernel.org>; Fri,  5 Jul 2019 21:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AVLZNY7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfGEVOt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Jul 2019 17:14:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38667 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfGEVOt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Jul 2019 17:14:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id y15so4789235pfn.5
        for <linux-block@vger.kernel.org>; Fri, 05 Jul 2019 14:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/7sZUFxUANgrKwZaqSwAspZ8SITW9fKQroiR42hBGA4=;
        b=AVLZNY7HvgtTqG8qSJ8rrlHa6oPWCJbGkOo2mbSBAGR2f037N3nHVrdjVzuX1S3EjU
         ZQ0sZZzZiuI0eTwfKkwAu/jq5b9Dkt8JOEY7zZO4mw56goXGRJuw326D4ul2HF9s5lV8
         dMGcw+enhA0P7CfZo4PmKHtSDbz2gwMH3eiuKQMh55jEFwBAHg58IfM2LqDIx/w4F17T
         wrXqlFBgLUc41rP45OXQDJ/RvQe2NsZD4qI32c2Z8j9bdJxpp3noP2NhIdCPARd9XZiA
         4sRaNU9lQ3TOZxB6YYQLXxGY73v25TbRHPk20KaJKGnn/4sVKjKUGctf1l1G94rdkjBv
         kBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/7sZUFxUANgrKwZaqSwAspZ8SITW9fKQroiR42hBGA4=;
        b=niHuUkI/n/mXv4OpZ3CiGSlUeKtZgH5JTwIsqgT2WD6U4muLlL/7Ah0IihqdleOlDC
         sVdPE1n3e/ZSkQQyBLAfeNJULjVrEmuT0Y753+eBdBB9SppjCnRzyjkYdLFlJh8qNX8D
         CCq/Zki39hc+NYFU4bv5cA+R0FrKL/hdCIB1w46OgzN4ic1ANiSFA9lNnkeJVgILdn5P
         1BmMBe/9U6gyFLk8MYHGE7+a4y4qkOaDnRDeF+EJ+tVYJ6I7dh0oFnpgZvIe+BKyXItE
         Z67X+lcX31Sw26nyF7LQbXqyB0STagzBwD/TmLinZb3S54keQGw+C8vi7+sqvvHcqWxD
         eYVg==
X-Gm-Message-State: APjAAAUG+OQnxfahcg+SXe5zM3Auv2rMwQCO34MpInluP5c0ndjnfUlP
        3WvAXOcRO87hn1MLlARFo65zrTFIK8eeXw==
X-Google-Smtp-Source: APXvYqz6BDQH4rK2bc0RJgE080Jy2A3c3I0cjWgbYCmxihXtOHdmNBVtvaFKJmtLBWrjVwyQzuR8gw==
X-Received: by 2002:a17:90a:c481:: with SMTP id j1mr7869857pjt.96.1562361288894;
        Fri, 05 Jul 2019 14:14:48 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id 27sm8845789pgt.6.2019.07.05.14.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 14:14:48 -0700 (PDT)
Subject: Re: [PATCH v2] blk-iolatency: fix STS_AGAIN handling
To:     Dennis Zhou <dennis@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190705210909.82263-1-dennis@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <084ad6be-7bef-4cf4-eefc-41359a880f01@kernel.dk>
Date:   Fri, 5 Jul 2019 15:14:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190705210909.82263-1-dennis@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/5/19 3:09 PM, Dennis Zhou wrote:
> The iolatency controller is based on rq_qos. It increments on
> rq_qos_throttle() and decrements on either rq_qos_cleanup() or
> rq_qos_done_bio(). a3fb01ba5af0 fixes the double accounting issue where
> blk_mq_make_request() may call both rq_qos_cleanup() and
> rq_qos_done_bio() on REQ_NO_WAIT. So checking STS_AGAIN prevents the
> double decrement.
> 
> The above works upstream as the only way we can get STS_AGAIN is from
> blk_mq_get_request() failing. The STS_AGAIN handling isn't a real
> problem as bio_endio() skipping only happens on reserved tag allocation
> failures which can only be caused by driver bugs and already triggers
> WARN.
> 
> However, the fix creates a not so great dependency on how STS_AGAIN can
> be propagated. Internally, we (Facebook) carry a patch that kills read
> ahead if a cgroup is io congested or a fatal signal is pending. This
> combined with chained bios progagate their bi_status to the parent is
> not already set can can cause the parent bio to not clean up properly
> even though it was successful. This consequently leaks the inflight
> counter and can hang all IOs under that blkg.
> 
> To nip the adverse interaction early, this removes the rq_qos_cleanup()
> callback in iolatency in favor of cleaning up always on the
> rq_qos_done_bio() path.

Looks good, applied for 5.3. Thanks Dennis.

-- 
Jens Axboe

