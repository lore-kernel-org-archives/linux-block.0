Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C0FC46CA1
	for <linux-block@archiver.kernel.org>; Mon, 18 Sep 2023 16:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjIRQFD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Sep 2023 12:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjIRQFB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Sep 2023 12:05:01 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22E6FE
        for <linux-block@vger.kernel.org>; Mon, 18 Sep 2023 09:04:49 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-760dff4b701so58670839f.0
        for <linux-block@vger.kernel.org>; Mon, 18 Sep 2023 09:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695053038; x=1695657838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7iWbebg10gnFWR7iM1oWW4Z9fG3e9i+/WJObqob0t58=;
        b=tKQNOQGHKn+Gxt7uMRiqOo4YQufWcFWl2UD1f0J21DxVj1BsUCylU/oghslKPqZFUx
         +hqUbVIR8e7/bpUSi2/sb3ky5iCLqiISWwUYSLIZXsBWhqrH0XKx1kSN6AEkydcjwiJq
         9Dpzdf2XLpv693bgnJSlh4ZFqfQK93BcsclQrU4UXwtPmyWwkkxiUJZfDVPk3wK5u5TM
         82dYIbCtmywgTHowRpRBPIjkcI7LvfPEsXsgBSG4CCGH2MdUPVAgLdt7TjxeSg0/VBUE
         zv6/7NP+p/0QGTPmKZNGNxwyMDZsuVKtakFgiiMhcQ0YyANFDlIx3Vi729J6Q6l+KkpT
         aGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695053038; x=1695657838;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7iWbebg10gnFWR7iM1oWW4Z9fG3e9i+/WJObqob0t58=;
        b=VGOQvTieJlGE5MxZzbL4/Wlgenr4tl7+U/cyTz3w22I8L2ZQTit48iNWkPecfyXya4
         ySYMUMvw1+kfq+yMD0uNWzPDoiffqHMCTXk6l+0EHnuOv06GBGNxadPi3cwYd3/0Z2Ge
         1mDcrNPVFdgBKq7CZBHgbgIShAJbZV8dFx7IKJk+vuq3X9Kbmw/Vxxyidmz0+Jm+jXTz
         yY9KOhqq9uBwNW1rglml2P3e/jP3J7DeRR8uYS2lBOlM3r2s/Vt95A9Ad0ot9uzm9fmm
         HYcnMOdjab4dBcU7rIVggrvRa9DBZ/BAZVX7ulQoG9/k7ybSlFy4vAjP/OBE499eV5Pl
         9CQg==
X-Gm-Message-State: AOJu0YzT/PW+zYsAbFImKySnktQaAzQr0r46/pn/Y68tvXZyEDZ4xwR7
        ltLiZXMz6nrT5gpmJiD5lnGQaw==
X-Google-Smtp-Source: AGHT+IHGWRTSLzgZTvIMZdns13ovPmqiV8pBpaTltJZjgdLGTo/zbP9EC3nybcTa+ExfOJG9jb8BdQ==
X-Received: by 2002:a92:dcd0:0:b0:34e:2a69:883c with SMTP id b16-20020a92dcd0000000b0034e2a69883cmr9338192ilr.1.1695053038244;
        Mon, 18 Sep 2023 09:03:58 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c5-20020a92cf05000000b003459023deaasm1550824ilo.30.2023.09.18.09.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 09:03:57 -0700 (PDT)
Message-ID: <6067f24d-a641-441e-afc2-dd190f8a6931@kernel.dk>
Date:   Mon, 18 Sep 2023 10:03:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] io_uring/ublk: exit notifier support
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, io-uring@vger.kernel.org
References: <20230918041106.2134250-1-ming.lei@redhat.com>
 <fae0bbc9-efdd-4b56-a5c8-53428facbe5b@kernel.dk> <ZQhPhFwgSLvR/zDM@fedora>
 <5706fa76-a071-4081-8bb0-b1089e86a77f@kernel.dk> <ZQh0p+ovm1sd3Vau@fedora>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZQh0p+ovm1sd3Vau@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/18/23 10:02 AM, Ming Lei wrote:
> On Mon, Sep 18, 2023 at 08:15:07AM -0600, Jens Axboe wrote:
>> On 9/18/23 7:24 AM, Ming Lei wrote:
>>> On Mon, Sep 18, 2023 at 06:54:33AM -0600, Jens Axboe wrote:
>>>> On 9/17/23 10:10 PM, Ming Lei wrote:
>>>>> Hello,
>>>>>
>>>>> In do_exit(), io_uring needs to wait pending requests.
>>>>>
>>>>> ublk is one uring_cmd driver, and its usage is a bit special by submitting
>>>>> command for waiting incoming block IO request in advance, so if there
>>>>> isn't any IO request coming, the command can't be completed. So far ublk
>>>>> driver has to bind its queue with one ublk daemon server, meantime
>>>>> starts one monitor work to check if this daemon is live periodically.
>>>>> This way requires ublk queue to be bound one single daemon pthread, and
>>>>> not flexible, meantime the monitor work is run in 3rd context, and the
>>>>> implementation is a bit tricky.
>>>>>
>>>>> The 1st 3 patches adds io_uring task exit notifier, and the other
>>>>> patches converts ublk into this exit notifier, and the implementation
>>>>> becomes more robust & readable, meantime it becomes easier to relax
>>>>> the ublk queue/daemon limit in future, such as not require to bind
>>>>> ublk queue with single daemon.
>>>>
>>>> The normal approach for this is to ensure that each request is
>>>> cancelable, which we need for other things too (like actual cancel
>>>> support) Why can't we just do the same for ublk?
>>>
>>> I guess you meant IORING_OP_ASYNC_CANCEL, which needs userspace to
>>> submit this command, but here the userspace(ublk server) may be just panic
>>> or killed, and there isn't chance to send IORING_OP_ASYNC_CANCEL.
>>
>> Either that, or cancel done because of task exit.
>>
>>> And driver doesn't have any knowledge if the io_uring ctx or io task
>>> is exiting, so can't complete issued commands, then hang in
>>> io_uring_cancel_generic() when the io task/ctx is exiting.
>>
>> If you hooked into the normal cancel paths, you very much would get
>> notified when the task is exiting. That's how the other cancelations
>> work, eg if a task has pending poll requests and exits, they get
>> canceled and reaped.
> 
> Ok, got the idea, thanks for the point!
> 
> Turns out it is cancelable uring_cmd, and I will try to work towards
> this direction, and has got something in mind about the implementation.

Perfect, thanks Ming!

-- 
Jens Axboe

