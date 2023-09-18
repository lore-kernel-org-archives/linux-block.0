Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B07CD37B0
	for <linux-block@archiver.kernel.org>; Mon, 18 Sep 2023 15:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjIRPak (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Sep 2023 11:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjIRPai (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Sep 2023 11:30:38 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1F310FE
        for <linux-block@vger.kernel.org>; Mon, 18 Sep 2023 08:27:00 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c45c45efeeso887265ad.0
        for <linux-block@vger.kernel.org>; Mon, 18 Sep 2023 08:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695050656; x=1695655456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1SvOcpVdAsc2Q4sYYr3R8yxC4JPBSNRq7YUUT3oDYb4=;
        b=b9PBgX1k8mKX0jNifyMagDbKWDWjMGH5exKVHvDN8mbUvWZ4byfYSDQcpJZeDuKNSS
         76Wh0JOI2Yc9T5xWXWgadePuko7pat1bEb6dArm5QIUczU0ReayhlaetS8+Op6JY2K46
         IiID9kbihOXMspCOuywWF6X/m+qRunA+H5f0djReHoTB6poHhmY+BufbspkraNTXhDo9
         xK+XuKVFm8h8yPsIZkqIkhIHfPb1aW4Gc+F9aAaZ26gFgKsmtzj3KfQS31zRHARfn6ka
         6wF0jaVxcUVq5jeiX85M0iXJjJVPDG4bTUMlLtBE3XBnc1nw+rxHt5JkJ4uh52ZS4P36
         6yKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050656; x=1695655456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1SvOcpVdAsc2Q4sYYr3R8yxC4JPBSNRq7YUUT3oDYb4=;
        b=oy4WJWHOZkbU+FDfMI7ytHxWyuZKSJYvIbV2EsEhT7Ni5rkGQ3S4tAZIXQA/5qci8r
         SVWepkXkWvHeocbwYbvFuo7dRRXh7MBRYC4QGhpVT2n4LMczMZXI5Fk0LB5sYgG6ElKG
         KhAdyDGDoFfuIp7n1h5lujMhnJXH15s42HrKdO77szxQrN+HHCcfeC4jWAYDegW2UCxU
         Bj9qzdsTWyiteZkBsAzBr5ReLqE2VbNK01xVUpeTe//z5SmdySVAvnHkiPwwMmja4hNU
         jjBbwrINBGNXvPxTtT7VBwMJI5Erqdv4kA6iX7APPX++70qPAXHwkyQZ1+SQBZgvgrNK
         lk3g==
X-Gm-Message-State: AOJu0YyOE6Y8WU64WvedYND63shORHgFOI3tVNbVHnGlYtjV4UqlKvEI
        UBhX7JOQS1jAh2IA3nML6TcVspeiYy80uMOgkxMHVg==
X-Google-Smtp-Source: AGHT+IEeNsH5iLqdPZDOtg64eKzIqKRtriPRwLcj0JBMtkee1d9rhsNJN57PvcJUKCLWuGM33pvJcw==
X-Received: by 2002:a05:6602:1681:b0:792:6068:dcc8 with SMTP id s1-20020a056602168100b007926068dcc8mr12834859iow.2.1695046509302;
        Mon, 18 Sep 2023 07:15:09 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id s21-20020a02ad15000000b0042b3bb542aesm2831645jan.168.2023.09.18.07.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 07:15:08 -0700 (PDT)
Message-ID: <5706fa76-a071-4081-8bb0-b1089e86a77f@kernel.dk>
Date:   Mon, 18 Sep 2023 08:15:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] io_uring/ublk: exit notifier support
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, io-uring@vger.kernel.org
References: <20230918041106.2134250-1-ming.lei@redhat.com>
 <fae0bbc9-efdd-4b56-a5c8-53428facbe5b@kernel.dk> <ZQhPhFwgSLvR/zDM@fedora>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZQhPhFwgSLvR/zDM@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/18/23 7:24 AM, Ming Lei wrote:
> On Mon, Sep 18, 2023 at 06:54:33AM -0600, Jens Axboe wrote:
>> On 9/17/23 10:10 PM, Ming Lei wrote:
>>> Hello,
>>>
>>> In do_exit(), io_uring needs to wait pending requests.
>>>
>>> ublk is one uring_cmd driver, and its usage is a bit special by submitting
>>> command for waiting incoming block IO request in advance, so if there
>>> isn't any IO request coming, the command can't be completed. So far ublk
>>> driver has to bind its queue with one ublk daemon server, meantime
>>> starts one monitor work to check if this daemon is live periodically.
>>> This way requires ublk queue to be bound one single daemon pthread, and
>>> not flexible, meantime the monitor work is run in 3rd context, and the
>>> implementation is a bit tricky.
>>>
>>> The 1st 3 patches adds io_uring task exit notifier, and the other
>>> patches converts ublk into this exit notifier, and the implementation
>>> becomes more robust & readable, meantime it becomes easier to relax
>>> the ublk queue/daemon limit in future, such as not require to bind
>>> ublk queue with single daemon.
>>
>> The normal approach for this is to ensure that each request is
>> cancelable, which we need for other things too (like actual cancel
>> support) Why can't we just do the same for ublk?
> 
> I guess you meant IORING_OP_ASYNC_CANCEL, which needs userspace to
> submit this command, but here the userspace(ublk server) may be just panic
> or killed, and there isn't chance to send IORING_OP_ASYNC_CANCEL.

Either that, or cancel done because of task exit.

> And driver doesn't have any knowledge if the io_uring ctx or io task
> is exiting, so can't complete issued commands, then hang in
> io_uring_cancel_generic() when the io task/ctx is exiting.

If you hooked into the normal cancel paths, you very much would get
notified when the task is exiting. That's how the other cancelations
work, eg if a task has pending poll requests and exits, they get
canceled and reaped.

-- 
Jens Axboe

