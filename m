Return-Path: <SRS0=exTe=U7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F35C5B578
	for <linux-block@archiver.kernel.org>; Tue,  2 Jul 2019 01:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1F521841
	for <linux-block@archiver.kernel.org>; Tue,  2 Jul 2019 01:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SkDMBCd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfGBBym (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 21:54:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:47029 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfGBBym (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 21:54:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id i8so3659728pgm.13
        for <linux-block@vger.kernel.org>; Mon, 01 Jul 2019 18:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D2g0s0JUGomRLeX7dDerJhRH+KgNtz7R3e0skhYcLEg=;
        b=SkDMBCd3SUFo6ihA0QikeMboxta1FQi/bn9Yu3kDfMuHhS3cnAZAt+tCkm3jYfivPL
         YXGDR+OtVOTOqarwDNDY8T8ZMGdoIY5Q9XkwOr5GaF89ns8H4ffEsc2Ghx302cwhhr6K
         b+YYQqi94Ij238cGuapznFvcu0nLxJ/eJjDTPvO4Nsrn5QjtWDEfNpSJczK6Cy7Mqblm
         AP50M9Gv4pLyuLpS7tQbCNXYYA9qKrKsLr93a0tBzBc+2JhLu2C/umBOs9D293vO2N7g
         VxrBZ6e9b2vgx38v8zt9snQ6HhuqkFR9GFEg32UlRLBF3h9hFcxleNMleqrR961eMg8i
         MF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D2g0s0JUGomRLeX7dDerJhRH+KgNtz7R3e0skhYcLEg=;
        b=kddApWzSHdKw9g1sRJFBbGo6sS4ajbmQ6QxfNyOklznZP8WA3+ghxJhH+mTEEWS0a5
         57c7uLG/joC4IqSgfHmNHPLRXM3fgl5vSPzidLZVZcS39ga/PITwC1BYtrmBXhVqzHyJ
         QqsHjO3M26ZwtTvaTSdfgYwEh0txw4vOPY21Ks9aA6CyIheMgrUq6VfmBNraz50JrBA5
         ekos6R1KmPEWpjmoRcCSuiKRWOlPypInQW/Xqvuqd0wyPbN1DLKdAdCU8GziHDQWjvS6
         X1cHB8ofAdL2dCOilrJIDpanmBIXPW9aqhZFWwnQapbden1khcKS/einTG76sfKOwu8P
         Aykw==
X-Gm-Message-State: APjAAAXT4iL+FnNl1T32+NTlvvrw8X9nFiEiSg/y6m0j4IPMnC2SaC9e
        1EdBPVjWy45D0thtrGq7kPQ=
X-Google-Smtp-Source: APXvYqxeN84yuR5dgrIUqvA6+LTJjiA2KJVz6fa2lNJVfKI04RgFYHvXaZZkoY1xThpS337V/9zIrQ==
X-Received: by 2002:a17:90a:3310:: with SMTP id m16mr2553249pjb.7.1562032481771;
        Mon, 01 Jul 2019 18:54:41 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id q10sm9889974pgg.35.2019.07.01.18.54.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 18:54:40 -0700 (PDT)
Subject: Re: [PATCH V2] block: fix .bi_size overflow
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Liu Yiding <liuyd.fnst@cn.fujitsu.com>,
        kernel test robot <rong.a.chen@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org
References: <20190701071446.22028-1-ming.lei@redhat.com>
 <8db73c5d-a0e2-00c9-59ab-64314097db26@kernel.dk>
 <bd45842a-e0fd-28a7-ac79-96f7cb9b66e4@kernel.dk>
 <8b8dc953-e663-e3d8-b991-9d8dba9270be@kernel.dk>
 <20190702013829.GB8356@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7c3987b1-ac39-276b-da6d-511bfc4485bf@kernel.dk>
Date:   Mon, 1 Jul 2019 19:54:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190702013829.GB8356@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/1/19 7:38 PM, Ming Lei wrote:
> On Mon, Jul 01, 2019 at 08:20:13AM -0600, Jens Axboe wrote:
>> On 7/1/19 8:14 AM, Jens Axboe wrote:
>>> On 7/1/19 8:05 AM, Jens Axboe wrote:
>>>> On 7/1/19 1:14 AM, Ming Lei wrote:
>>>>> 'bio->bi_iter.bi_size' is 'unsigned int', which at most hold 4G - 1
>>>>> bytes.
>>>>>
>>>>> Before 07173c3ec276 ("block: enable multipage bvecs"), one bio can
>>>>> include very limited pages, and usually at most 256, so the fs bio
>>>>> size won't be bigger than 1M bytes most of times.
>>>>>
>>>>> Since we support multi-page bvec, in theory one fs bio really can
>>>>> be added > 1M pages, especially in case of hugepage, or big writeback
>>>>> with too many dirty pages. Then there is chance in which .bi_size
>>>>> is overflowed.
>>>>>
>>>>> Fixes this issue by using bio_full() to check if the added segment may
>>>>> overflow .bi_size.
>>>>
>>>> Any objections to queuing this up for 5.3? It's not a new regression
>>>> this series.
>>>
>>> I took a closer look, and applied for 5.3 and removed the stable tag.
>>> We'll need to apply your patch for stable, and I added an adapted
>>> one for 5.3. I don't want a huge merge hassle because of this.
>>
>> OK, so we still get conflicts with that, due to both the same page
>> merge fix, and Christophs 5.3 changes.
>>
>> I ended up pulling in 5.2-rc6 in for-5.3/block, which resolves at
>> least most of it, and kept the stable tag since now it's possible
>> to backport without too much trouble.
> 
> Thanks for merging it.
> 
> BTW, we need the -stable tag, since Yiding has test case to reproduce
> the issue reliably, which just needs one big machine with enough memory,
> and fast storage, I guess.

Just to be clear, I wasn't saying it shouldn't go to stable. But it's
pointless to mark something for stable if you know it'll reject, and
won't be easily fixable by the person applying it. For that case, it's
better to NOT CC stable, and just send in an appropriate patch instead.

But that's all moot now, as per last section in the email you are
replying to.

-- 
Jens Axboe

