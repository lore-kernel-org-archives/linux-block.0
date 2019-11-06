Return-Path: <SRS0=NI9l=Y6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B421C5DF65
	for <linux-block@archiver.kernel.org>; Wed,  6 Nov 2019 14:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2992173E
	for <linux-block@archiver.kernel.org>; Wed,  6 Nov 2019 14:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Jv4m8wul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfKFOOc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Nov 2019 09:14:32 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:41828 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbfKFOOc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Nov 2019 09:14:32 -0500
Received: by mail-il1-f195.google.com with SMTP id z10so21897930ilo.8
        for <linux-block@vger.kernel.org>; Wed, 06 Nov 2019 06:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z4ukJ1lm6CvbI3gUgAVjNcJXVQibz1/R6/WEKe6djV0=;
        b=Jv4m8wul4taZUzK+/dHDjAS8jtlL5/4rKjeqvgpfuiEPKnSJOtL30a6wb5zl6YrWu1
         a4sXu6gnveKPdMw5vuu65ukMAcx+5+L83sQ5Lm0E5nj8IJtew9XHWAUbZZ/vjycQfxhR
         Rcgr8Eydg3RzJhjOl9ssquxmoE/8i8yE6spzg4aquNKTZJa+E0oLwSA/oSErefEwBSv+
         s/KR1fPdNOW7kQi1W4sI1Ib82ADUf3GGxDFt+5zZiIxPKBtPNt4q5e1VgnRA7DvYF0Yw
         4UhLgIMCQajakWd3YrnyJg8Eft21bGRELYjNi/IVc2s48ERX+1UtOYLsHC/0rENANixP
         CAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z4ukJ1lm6CvbI3gUgAVjNcJXVQibz1/R6/WEKe6djV0=;
        b=NhUFQA7cWJdbKjCNcPzRJ7RmZHaELv6s3XIEYqvb2WgAKOeu8tpct5TQhzBoJjUQ37
         AUiAi30ftQy8g7yDxkjT6xf2f8a6JgOCaaT5J19wC7IeL+UOAd19sNGe0KuUC9A3ceGc
         HfxTmMDaED7mfMvslthKJDrIV/fAMxkyIMm1vf8niXUjyO7LDbZwvpTvL36EJCGoTXOP
         NjXJREfnqNcv/BUhXvqn/Hc8dqSyn+2epuTwAPVN8pl9pH8wwQTv+aIiZ85zPB9kv73Z
         hcaPOmLSV5aFz017o02TacqsUscExcMwSAu8EcmdxPIWUQ0pVsUJRL1/AYpwaR/9zL/d
         dLBg==
X-Gm-Message-State: APjAAAX+tfFVe3+YuEwsex7BDya3wCQIrJVgS5T3maWa6rs1dfnKuNSQ
        HPKbtBIXk7GdYxL7oIymw/Mxig==
X-Google-Smtp-Source: APXvYqzJmdwfl2l1kmVf3e3zHBHgGu5wLfu2MAos7TtjSOpFEZYjerpnEfhsI4lL60TWgys2KK/UoQ==
X-Received: by 2002:a92:9a54:: with SMTP id t81mr2776642ili.147.1573049670456;
        Wed, 06 Nov 2019 06:14:30 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d14sm3614391ilr.76.2019.11.06.06.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 06:14:29 -0800 (PST)
Subject: Re: [RFC] io_uring: stop only support read/write for ctx with
 IORING_SETUP_IOPOLL
To:     yangerkun <yangerkun@huawei.com>, Bob Liu <bob.liu@oracle.com>,
        linux-block@vger.kernel.org
Cc:     houtao1@huawei.com, yi.zhang@huawei.com
References: <20191104085608.44816-1-yangerkun@huawei.com>
 <a01cc299-69e7-daa2-6894-1c60aaa64e67@oracle.com>
 <3fd0dee1-52d6-4ea8-53d8-2c88b7fedce6@huawei.com>
 <50de6a43-fc11-aada-40e6-f3fee6523d49@kernel.dk>
 <aedaf337-ab16-b16e-fe49-d2511fb5f5ea@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8194c20d-4523-8885-2b80-b9849d37e890@kernel.dk>
Date:   Wed, 6 Nov 2019 07:14:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <aedaf337-ab16-b16e-fe49-d2511fb5f5ea@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/6/19 5:00 AM, yangerkun wrote:
> 
> 
> On 2019/11/4 22:01, Jens Axboe wrote:
>> On 11/4/19 4:46 AM, yangerkun wrote:
>>>
>>>
>>> On 2019/11/4 18:09, Bob Liu wrote:
>>>> On 11/4/19 4:56 PM, yangerkun wrote:
>>>>> There is no problem to support other type request for the ctx with
>>>>> IORING_SETUP_IOPOLL.
>>>>
>>>> Could you describe the benefit of doing this?
>>>
>>> Hi,
>>>
>>> I am trying to replace libaio with io_uring in InnoDB/MariaDB(which
>>> build on xfs/nvme). And in order to simulate the timeout mechanism
>>> like io_getevents, firstly, to use the poll function of io_uring's fd
>>> has been selected and it really did work. But while trying to enable
>>> IORING_SETUP_IOPOLL since xfs has iopoll function interface, the
>>> mechanism will fail since io_uring_poll does check the cq.head between
>>> cached_cq_tail, which will not update until we call io_uring_enter and
>>> do the poll. So, instead, I decide to use timeout requests in
>>> io_uring but will return -EINVAL since we enable IORING_SETUP_IOPOLL
>>> at the same time. I think this combination is a normal scene so as
>>> the other combination descibed in this patch. I am not sure does it a
>>> good solution for this problem, and maybe there exists some better way.
>>
>> I think we can support timeouts pretty easily with SETUP_IOPOLL, but we
>> can't mix and match everything. Pretty sure I've written at length about
>> that before, but the tldr is that for purely polled commands, we won't
>> have an IRQ event. That's the case for nvme if it's misconfigured, but
>> for an optimal setup where nvme is loaded with poll queues, there will
>> never be an interrupt for the command. This means that we can never wait
>> in io_cqring_wait(), we must always call the iopoll poller, because if
>> we wait we might very well be waiting for events that will never happen
>> unless we actively poll for them.
>>
>> This could be supported if we accounted requests, but I don't want to
>> add that kind of overhead. Same with the lock+irqdisable you had to add
>> for this, it's not acceptable overhead.
>>
>> Sounds like you just need timeout support for polling? If so, then that
> 
> Hi,
> 
> Yeah, the thing I need add is the timeout support for polling.
> 
>> is supportable as we know that these events will trigger an async event
>> when they happen. Either that, or it triggers when we poll for
>> completions. So it's safe to support, and we can definitely do that.
> 
> I am a little confuse. What you describe is once enable SETUP_IOPOLL
> and there is a async call of io_timeout_fn, we should not call
> io_cqring_fill_event directly, but leave io_iopoll_check to do this?
> Or, the parallel running for io_iopoll_check may trigger some problem
> since they can going to io_cqring_fill_event.

Maybe that wasn't quite clear, what I'm trying to say is that there are
two outcomes with IORING_OP_TIMEOUT:

1) The number of events specified in the timeout is met. This happens
   through the normal poll command checks when we complete commands.
2) The timer fires. When this happens, we just increment ->cq_timeouts.
   You'd have to make a note of that in the poll loop just like we do in
   cqring_wait() to know to abort if that value is different from when
   we started the loop.

All that's needed to support timeouts with IORING_SETUP_IOPOLL is to
have that ->cq_timeouts check in place. With that, the restriction could
be lifted.

-- 
Jens Axboe

