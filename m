Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADF5C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 16:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC12C2175B
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 16:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dGbLYcV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfA2QGr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:06:47 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:43310 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfA2QGq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 11:06:46 -0500
Received: by mail-io1-f45.google.com with SMTP id b23so16708256ios.10
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 08:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=40/2Hi4lILs7UkVpSK5hSMHeCtKCg/qz7rmCrZpZxv4=;
        b=dGbLYcV9FojYcuYMC8sN9Xe25ZTpYy0zoz5I6+8m/GWb7v9wmCtaT2r4ttEjl7EvvB
         JTnkBtq12WYoGXc6hUGfDgPWZ4P9muNDw0kq5xmS0JhC7kFCzsmXlvXAix3kLxVdkYGK
         OIpSg+bgxyvmNUP9yzFqnqz6pBaaK27x+WQiFtMuO4aJwEB3iMvv1iHuZYi/uUxPY+BZ
         EMHDQxS7YMQASlkA/mjaDHdaLw5aFR7OfF8iCcBhib5OnTbQXA32maglw8qqL3rbuG6U
         lanPPneP7csg1hrKIShniijQWLyw2mCyAWStRVfHavJXmB8kbzoAIHKRe4vhKFJJsllG
         /YFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=40/2Hi4lILs7UkVpSK5hSMHeCtKCg/qz7rmCrZpZxv4=;
        b=EJfwuC1vo+jcgsvHBNHOn/7FgBZRypjun9JCNBSm2Pz8E0LD8bofLjYcCcaZeU+/4P
         7cjaQfIYVnBGggurlBgT2q5+Hst1gPZ4lmIm2RgmNbihKL85OT0QaVJ8RLMZ2gUJXts/
         BUYELDD2BnZZtSQZkGxKMPquDV8ep6kNcGAV9WoEX/IA2DUUwWhHl1fjk4t3S3L/LeJP
         OPyLZjL6s0NGiYCAW8HMo/v4P3FXpOVYOv+HVJfMyuibv7JaMxHmfymfkSQ0xaGmkizQ
         CihyCfwTp9q0O2QN2EtyUzIEA1XApdT/O2bytyGD1nn4vvdnM1uzELxjR81e9yo1K3dU
         HQwQ==
X-Gm-Message-State: AHQUAubuavOp+iTgRRTpB/m/JxvWL+fRTwukP0Nvp632vhwMJhIIZbQG
        BLeUXOg/uSEJ/FPJEzl22eiSlw==
X-Google-Smtp-Source: ALg8bN5hgcFN9ZYpMYdsQ+gjVSUgUXQjG5d6vbGizfLeTj5FbYGY2K1TNm2VeK+nagqYiUha0ZHllA==
X-Received: by 2002:a6b:c402:: with SMTP id y2mr16772021ioa.77.1548778005270;
        Tue, 29 Jan 2019 08:06:45 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m186sm1777914ita.2.2019.01.29.08.06.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 08:06:43 -0800 (PST)
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Jann Horn <jannh@google.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
References: <20190128213538.13486-1-axboe@kernel.dk>
 <20190128213538.13486-6-axboe@kernel.dk>
 <CAG48ez1qxZLfJzK95kjh0RiQ6kvZLbQhr6Dr0EjBNQB6Fr7NXQ@mail.gmail.com>
 <CAG48ez1Ms+NPTXPj_UiQyv=2aMaMR3akCdp5SdDL3x7x7gd_ig@mail.gmail.com>
 <b5902860-30a9-3dc9-b513-3d892afdc51b@kernel.dk>
 <CAG48ez0sNBjgW7ynpNC+sir-_AuccY1sKguiD+VAXvL9-j4iag@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <076acc85-b71d-c65f-e729-53e347626a1d@kernel.dk>
Date:   Tue, 29 Jan 2019 09:06:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez0sNBjgW7ynpNC+sir-_AuccY1sKguiD+VAXvL9-j4iag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/29/19 8:56 AM, Jann Horn wrote:
> On Tue, Jan 29, 2019 at 4:46 AM Jens Axboe <axboe@kernel.dk> wrote:
>> On 1/28/19 7:21 PM, Jann Horn wrote:
>>> Please create a local copy of the request before parsing it to keep
>>> the data from changing under you. Additionally, it might make sense to
>>> annotate every pointer to shared memory with a comment, or something
>>> like that, to ensure that anyone looking at the code can immediately
>>> see for which pointers special caution is required on access.
>>
>> I took a look at the viability of NOT having to local copy the data, and
>> I don't think it's too bad. Local copy has a noticeable impact on the
>> performance, hence I'd really (REALLY) like to avoid it.
>>
>> Here's something on top of the current git branch. I think I even went a
>> bit too far in some areas, but it should hopefully catch the cases where
>> we might end up double evaluating the parts of the sqe that we depend
>> on. For most of the sqe reading we don't really care too much. For
>> instance, the sqe->user_data. If the app changes this field, then it
>> just gets whatever passed back in cqe->user_data. That's not a kernel
>> issue.
>>
>> For cases like addr/len etc validation, it should be sound. I'll double
>> check this in the morning as well, and obviously would need to be folded
>> in along the way.
>>
>> I'd appreciate your opinion on this part, if you see any major issues
>> with it, or if I missed something.
> 
> The io_sqe_needs_user() checks still look racy. If that helper sees a
> IORING_OP_READ_FIXED, but then __io_submit_sqe() sees a
> IORING_OP_READV - especially if this happens in io_sq_wq_submit_work()
> -, I think you could potentially end up in places like
> io_import_iovec() without having done the set_fs(USER_DS) and
> use_mm(), causing the access to potentially occur with KERNEL_DS and a
> lazy mm.

Indeed, for that case I think we should just copy the sqe. It's in the
async offload context anyway, so a copy won't really change anything
in terms of performance. And since the gap is so large between the two
problematic spots, it'd be trickier to fix.

-- 
Jens Axboe

