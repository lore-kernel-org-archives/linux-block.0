Return-Path: <SRS0=7rSP=3F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9FDC33CAF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 21:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6866520748
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 21:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RwlNymGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbgAPV0z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:26:55 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42781 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbgAPV0y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jan 2020 16:26:54 -0500
Received: by mail-io1-f67.google.com with SMTP id n11so23596593iom.9
        for <linux-block@vger.kernel.org>; Thu, 16 Jan 2020 13:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s+M8VHe0TuzsjIREAGxRwrcHLOdmAMPOblK/0F6fo3U=;
        b=RwlNymGR/BAbNcOf1T1Agvrv+hlgilqGpfOeibGDdaVmE4hzGktVPrIlP2zRxjBPdn
         9Y0MqGkEZu61KblDPpM1xMoqLmMPUjVmlb6hH/z+8WHnfGZPosWDE9Jc9DwCrfwGdWV1
         K/MdppDBYKMmEMYXJW+gHhp4rrdiCFY0Su0go1gDZ/cuijqZx1QGaG5VbnArFBfpljIq
         MO0vswsh+s7u7GnoivwxO8tJl+KMj0lWiwJEi/64dKwopi6Ogn/ZqNY8dAdXAgpSKghe
         fw+8Ls2zwgVF5a1ufnG5Z/gP1zU8XVvM1Kc8cyAV9YkCxsalmpHAxkJIwz+9OSgYiTzu
         eOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s+M8VHe0TuzsjIREAGxRwrcHLOdmAMPOblK/0F6fo3U=;
        b=IkNBxpRIwTvyDHVFoAt8zGqYgk1uMujLtWqdf8ECN/gLkAVC5wEhAciJg5wf/mJ3r8
         IVUrsMBIwqvNQDT6vjB6rXrV/C4iergHld9QXrP68ZvZcxbQDub+2TENPEkv5PuL0txK
         bNXbyuzXvXK7zW6BN6X9zXAg8BUz8HZVNgmMOp7YDb1CQHwpNqqlmHykMr04N/dQrHhk
         6Y1yUXaioTjEC6V4fHwEHvdOcc1K/T1oEH19cZD0dHgGxod72bpqjNZsFTjcpoG+xQtM
         GmpjQtvzMjJJZpV2YnV/iNmsMdYgy9k4vm4UoKWqbBG3p3vVZ3/oH/ok8lSP2yH8ROjj
         oAJA==
X-Gm-Message-State: APjAAAV3brV6EQKqZaEuer1UzX0luq7fiXWcx7t6/Zc7f9dHI8igsV2d
        /qzLafAcDN8h9M+ByMd/hPaMRA==
X-Google-Smtp-Source: APXvYqwtYJjjljHa7Oa0UVOe0ZgC7SnEF/Czc0uYJi0RXx2BfElFbGqDtAHAVuNEC6cRfJLfxhvLfg==
X-Received: by 2002:a02:c787:: with SMTP id n7mr30712698jao.85.1579210013770;
        Thu, 16 Jan 2020 13:26:53 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h3sm7257251ilh.6.2020.01.16.13.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 13:26:53 -0800 (PST)
Subject: Re: [RFC 2/2] io_uring: acquire ctx->uring_lock before calling
 io_issue_sqe()
To:     Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@gmail.com>
References: <1579142266-64789-1-git-send-email-bijan.mottahedeh@oracle.com>
 <1579142266-64789-3-git-send-email-bijan.mottahedeh@oracle.com>
 <9b359dde-3bb6-5886-264b-4bee90be9e25@kernel.dk>
 <8f7986c7-e5b4-8f24-1c71-666c01b16c8b@kernel.dk>
 <1397cd55-37a6-4e14-91ac-eb3c35e7d962@kernel.dk>
 <b43835cd-3bd6-705e-df51-923bbec78c67@oracle.com>
 <18346d15-d89d-9d28-1ef8-77574d44dce7@kernel.dk>
 <229bd8ea-cd65-c77a-ad58-2a79f3bd0c5b@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a316d3fe-4162-8274-a74a-2d13a4caf011@kernel.dk>
Date:   Thu, 16 Jan 2020 14:26:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <229bd8ea-cd65-c77a-ad58-2a79f3bd0c5b@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/20 2:04 PM, Bijan Mottahedeh wrote:
> On 1/16/2020 12:02 PM, Jens Axboe wrote:
>> On 1/16/20 12:08 PM, Bijan Mottahedeh wrote:
>>> On 1/16/2020 8:22 AM, Jens Axboe wrote:
>>>> On 1/15/20 9:42 PM, Jens Axboe wrote:
>>>>> On 1/15/20 9:34 PM, Jens Axboe wrote:
>>>>>> On 1/15/20 7:37 PM, Bijan Mottahedeh wrote:
>>>>>>> io_issue_sqe() calls io_iopoll_req_issued() which manipulates poll_list,
>>>>>>> so acquire ctx->uring_lock beforehand similar to other instances of
>>>>>>> calling io_issue_sqe().
>>>>>> Is the below not enough?
>>>>> This should be better, we have two that set ->in_async, and only one
>>>>> doesn't hold the mutex.
>>>>>
>>>>> If this works for you, can you resend patch 2 with that? Also add a:
>>>>>
>>>>> Fixes: 8a4955ff1cca ("io_uring: sqthread should grab ctx->uring_lock for submissions")
>>>>>
>>>>> to it as well. Thanks!
>>>> I tested and queued this up:
>>>>
>>>> https://git.kernel.dk/cgit/linux-block/commit/?h=io_uring-5.5&id=11ba820bf163e224bf5dd44e545a66a44a5b1d7a
>>>>
>>>> Please let me know if this works, it sits on top of the ->result patch you
>>>> sent in.
>>>>
>>> That works, thanks.
>>>
>>> I'm however still seeing a use-after-free error in the request
>>> completion path in nvme_unmap_data().  It happens only when testing with
>>> large block sizes in fio, typically > 128k, e.g. bs=256k will always hit it.
>>>
>>> This is the error:
>>>
>>> DMA-API: nvme 0000:00:04.0: device driver tries to free DMA memory it
>>> has not allocated [device address=0x6b6b6b6b6b6b6b6b] [size=1802201963
>>> bytes]
>>>
>>> and this warning occasionally:
>>>
>>> WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE);
>>>
>>> It seems like a request might be issued multiple times but I can't see
>>> anything in io_uring code that would account for it.
>> Both of them indicate reuse, and I agree I don't think it's io_uring. It
>> really feels like an issue with nvme when a poll queue is shared, but I
>> haven't been able to pin point what it is yet.
>>
>> The 128K is interesting, that would seem to indicate that it's related to
>> splitting of the IO (which would create > 1 IO per submitted IO).
>>
> Where does the split take place?  I had suspected that it might be 
> related to the submit_bio() loop in __blkdev_direct_IO() but I don't 
> think I saw multiple submit_bio() calls or maybe I missed something.

See the path from blk_mq_make_request() -> __blk_queue_split() ->
blk_bio_segment_split(). The bio is built and submitted, then split if
it violates any size constraints. The splits are submitted through
generic_make_request(), so that might be why you didn't see multiple
submit_bio() calls.

-- 
Jens Axboe

