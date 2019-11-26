Return-Path: <SRS0=BQu2=ZS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FF5C432C0
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 17:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A5220722
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 17:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="S15yxd+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfKZRME (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Nov 2019 12:12:04 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37591 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfKZRME (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Nov 2019 12:12:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id p24so9496452pfn.4
        for <linux-block@vger.kernel.org>; Tue, 26 Nov 2019 09:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YmxnTHoMTmHtFii5x0WQKkMvHP6HPmoIXv6VIOe1k1s=;
        b=S15yxd+VpRIx5tUNoWWP+6/NQFUSWPmUk+NXFRzN738tzHxbjOmLuMNeNEo0myw6Mm
         Zidocm4ZMn9kxG1p21hQilnvTj/4Fq0xRXv8tNi/kD6PpAsJQ82zhBI2RxBsoEXWYw49
         xfiq7O4rFRtnMb2h/4ZWwQEYI2tP9VGbsh2EiyAGmN4zsA/JyZXft6jcMjPe57zE17ni
         fGrZ5G2Hd/ABm+BWEsmjnlnePkoWtAcBhroM7GFRrqTlZcdzGSuV1tqrG+ITfmEPW3Be
         EHhiRlFGIA2A5Ym+LOkMo/7thBAPBh9pXZPdWAIQTo1rU9gSn6yqSG1gY5Kf/QFsGNbi
         5F0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YmxnTHoMTmHtFii5x0WQKkMvHP6HPmoIXv6VIOe1k1s=;
        b=hnoDTcp8ocTHzxtdQkHc4oXhlMMcde6/ZEDN3PfQ6CU4hWhA3wMFk5VP1Xvgkt/Yr+
         Fo4/vHtKSsmQSA7jL+bpR/yjaEWa+I6RpGfV7gmEYFyFx4Rxu4Z4FAbGwIZhgSc/Bq0p
         w3El/d2l1huFPm6e27JPNtDT1hGYAYLT8E4vp5QmrI7BeVYsZu51ywwOMu2QCTr6mnXP
         jUUyW5eVmLPa3dzCIuP73EhIuwSRgW0TXo7bVq+RUA4osj5wyxXI/72+RorrAfGw+NpI
         63wIbsfGhF2hxy0cmpb46IHcNsiIqB8/Zy5NBag5+8AoNxPcySs+7yXam0/ZnvSfgy1a
         ElPA==
X-Gm-Message-State: APjAAAWgaiI7sS83VNEIl/4K7gDfMZP/5KzI8SF+3CO0QIL3oTMa9AwB
        WPKeNFB62arSMBFTGG7zw9db5xP0ihUdng==
X-Google-Smtp-Source: APXvYqzL/Wc42hi3HgXhlLxNytdk5Ax0xRxHColZlI6s7Re1ba7hnLEmeWzKD/53cumi+UzQGNHCgw==
X-Received: by 2002:a63:391:: with SMTP id 139mr40920909pgd.40.1574788322420;
        Tue, 26 Nov 2019 09:12:02 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id e6sm3015201pff.41.2019.11.26.09.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 09:12:01 -0800 (PST)
Subject: Re: [PATCH 3/8] blk-mq: Use a pointer for sbitmap
To:     John Garry <john.garry@huawei.com>, Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20191126091416.20052-1-hare@suse.de>
 <20191126091416.20052-4-hare@suse.de>
 <8f0522ee-2a81-c2ae-d111-3ff89ee6f93e@kernel.dk>
 <62838bca-cd3c-fccf-767c-76d8bea12324@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <00a6d920-1855-c861-caa3-e845dcbe1fd8@kernel.dk>
Date:   Tue, 26 Nov 2019 10:11:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <62838bca-cd3c-fccf-767c-76d8bea12324@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/19 9:54 AM, John Garry wrote:
> On 26/11/2019 15:14, Jens Axboe wrote:
>> On 11/26/19 2:14 AM, Hannes Reinecke wrote:
>>> Instead of allocating the tag bitmap in place we should be using a
>>> pointer. This is in preparation for shared host-wide bitmaps.
>>
>> Not a huge fan of this, it's an extra indirection in the hot path
>> of both submission and completion.
> 
> Hi Jens,
> 
> Thanks for having a look.
> 
> I checked the disassembly for blk_mq_get_tag() as a sample - which I
> assume is one hot path function which you care about - and the cost of
> the indirection is a load instruction instead of an add, denoted by ***,
> below:

I'm not that worried about an extra instruction, my worry is the extra
load is from different memory. When it's embedded in the struct, we're
on the same cache line or adjacent.

-- 
Jens Axboe

