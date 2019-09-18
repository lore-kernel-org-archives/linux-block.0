Return-Path: <SRS0=kmcw=XN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DECFC4CECD
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 02:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E4221881
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 02:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WK6FmzdO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfIRCBZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 22:01:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36687 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfIRCBZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 22:01:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id m29so3052084pgc.3
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2019 19:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PZ/iwWlYxXMRtVtOPXlBRri4mbuf6F3coWiuomrpcXA=;
        b=WK6FmzdOGPQRDiGiJV4re6vl0RwGgq5gWaNAOeW5Lc6MSaiu6FChClGxO2FKp1utHh
         WbKSJAv/hFVqyRVb69S402NeJ0EMP+6zAwwMNIcYcG79m0o5OlH22lw9XNIwr+h4yMm/
         AyP0ldbDytHVLQzkn39uveSWyxuV8szMNvJ03s2U41bjMtqPrhACwtwkRdb+Am0hllDl
         CEvlk0Lz2UU2wNzK/xPe2NHTKHFl8YG4KfFrMDPar4FqWuhihE4qchKUwhkrL4RN3ksM
         KKyf4EyQz7YEXcqd/X5IAXqpNe/9pJYZlGtaZwenJ4zeZWyBwneqzAP0TQr9LWrXeoVZ
         PrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PZ/iwWlYxXMRtVtOPXlBRri4mbuf6F3coWiuomrpcXA=;
        b=IK512FZscqBjWoigdtotieqaRo05witOdQo3gjtpxusAllZd2UGHSACD2YhvnVjNeh
         xmLZO6ayMcrFA1kukmTf1tu2qdmAEwdcO0qA8wLKVbroF0fwyAzAJ5P8R+sWkqg9JHo0
         kAlL3/z/LHuYJ3r42uYJjOzGX97BlcoYsVR6mmVm/YzB+ZW+k3+Y8QsmEAV+EppYeNHT
         UTSaiNvbUNWDTPKKdiQgVLz5C+cwS2CgYVWvAnd6eye6bAFgAEaLtaOA/jf32xBMjdY/
         aj+kY10TJ6ZVEiH5lCu1RqHWnFPNGRNbYVDcOMAg+3u6R1qzIc1OEn2inFbyLST5MBT+
         /jug==
X-Gm-Message-State: APjAAAW70IfI1bed9/8pEoOe6z3+DcJcbgpbsBs0tmFVIZ82mbd1ubQ5
        kK0TfdMr3EpI7DaCZ/+a7bC5dYeQd6D2bA==
X-Google-Smtp-Source: APXvYqx47p/wTcU9Rw12tmczxEEZ850D0+U7cw6giwFjzvVOONZpvxPaXcu3K24kOoPB0IhMd3hrNA==
X-Received: by 2002:a17:90a:244f:: with SMTP id h73mr1155764pje.137.1568772083458;
        Tue, 17 Sep 2019 19:01:23 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id f12sm3671390pfn.73.2019.09.17.19.01.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 19:01:22 -0700 (PDT)
Subject: Re: [GIT PULL] Block changes for 5.4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <61b11672-f41b-9708-2486-f284a99483a8@kernel.dk>
 <CAHk-=whhKxxJ8yM1StiPcb8866PzxLBB77_d+MEA3SKY4hhjjg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6f98e8a4-f3cb-a700-ac1a-5a61f3c2ecde@kernel.dk>
Date:   Tue, 17 Sep 2019 20:01:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whhKxxJ8yM1StiPcb8866PzxLBB77_d+MEA3SKY4hhjjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/17/19 6:18 PM, Linus Torvalds wrote:
> On Mon, Sep 16, 2019 at 7:52 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> - blk-cgroup writeback fixes (Tejun)
> 
> Well, that's a very short description of a pretty subtle series.
> 
> Honestly, I would much rather have seen this as three completely
> separate pull requests:
> 
>   - the writeback and cgroup stuff
> 
>   - the core queuing changes
> 
>   - the nvme driver updates
> 
>   - the other driver updates
> 
> because right now this pull request is just a mess of completely
> unrelated stuff that just shares a very weak common thread of "yeah,
> it's related to block devices".
> 
> I've pulled this, but can you please just split driver stuff out from
> core queue handling code that is largely independent of any particular
> driver, and very much out from core VM writeback?
> 
> They really have almost nothing to do with each other, and I don't see
> why you are randomly mixing these things up.
> 
> It makes it much harder to review the end result, and I think one
> example of the weakness of this is the almost useless merge message
> that didn't really talk much about these "fixes" (which is already not
> really a proper description - those patches are really more like a
> completely new way of doing certain cases of writeback, and much more
> fundamental than just "some random fix that gets a single liner in
> between other stuff").

Point taken, I have sometimes done writeback specific branches, I guess
they got mixed up this time since it Tejun also had blk-cgroup writeback
changes.

We also don't have a lot of driver vs core inter-mingled churn anymore,
which is great, so I can start doing driver branches again like.

Thanks for pulling, I'll organize things separately going forward.

-- 
Jens Axboe

