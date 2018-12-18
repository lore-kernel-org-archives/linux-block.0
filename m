Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B025C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 00:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA4A21849
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 00:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HQ34jSZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbeLRA0m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 19:26:42 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35506 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbeLRA0m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 19:26:42 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so7206621pfi.2
        for <linux-block@vger.kernel.org>; Mon, 17 Dec 2018 16:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zAWXW1/oVAgz0QN2KT0qUJDrNOuFTdtoJF9kAahALj0=;
        b=HQ34jSZHlp+ihsd+flScrvK3anhIwWkqyfJD/xTVJqkOmk/yoi1+xBcraOW2raE0m6
         hzyl/HpERRloytNWSXpqZwkLYy7z6jPcHJjS9iqk1ZPci0fdxMGELFHo3ta8d9vuKWjX
         mWlmmFXsWZOoOrck05SqavIYs28/0VCSfqDgYEIdGxahSd4TQu9krCkanIgLA1pANaQ/
         TpiioCAn+eh+3Rt05VlfAqm9u/RzJ7zRA/Veq04A8FtvZIO8n99W+lceiS1V60sKaui6
         WtGB1h6tTuiGutcSGButi01bPG2HftwjE+DlcYHM+aYSeosHgkyEhIimoUKFiqboW8kz
         kKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zAWXW1/oVAgz0QN2KT0qUJDrNOuFTdtoJF9kAahALj0=;
        b=k280ORoDUoAcv1hREYhW6VrRAfzVI3JI5pBCgimWL7HTH4I4PsbABs54hGyEuObXTb
         GD32yfLfDqLxgWBl2+xHr5L9VWdziyaF3SBOSGS1YxCya0LsrVeYTCelHBDEPO/Z+zJ6
         Ihd77uVu+MyhQcmXO9i0DUMjFG5CxyAXBHugZAAPa6/Hj5PeHHhuOVvhlyxLh57LSQ1j
         uZRVc4qeJtGyNO9jM/JeovQwK4poKN+2/GJ5NmgtNixNbpcIXTvVwDBiCGKl8cKDsnh1
         9B0M5/+cxbzqIfoIIj6AffKqJluuqaz8Qwe/YOkEMndVPCLWHH2zs8u73mZjPhn1lWaT
         SnUA==
X-Gm-Message-State: AA+aEWa5swmajl9LglfW7TDvxOw6I9JTAhhPgc6Os/fdSRhpjiEkzO/I
        rT3p43c49j9CaEjWfqphxIqkvg==
X-Google-Smtp-Source: AFSGD/VLsfmazrhdnXfUpmFPehLMsz2yq8yOgKk+96M7QQrEcPf0N45hyCeycWiDJfV9Ugxu093SeA==
X-Received: by 2002:a63:e74b:: with SMTP id j11mr2920893pgk.397.1545092801443;
        Mon, 17 Dec 2018 16:26:41 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id p2sm18871833pfp.125.2018.12.17.16.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 16:26:40 -0800 (PST)
Subject: Re: Upcoming merge window
From:   Jens Axboe <axboe@kernel.dk>
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Mike Snitzer <snitzer@redhat.com>
References: <6fe5169f-8032-ac2a-ecb7-f845c56b1d73@kernel.dk>
 <1545088576.185366.443.camel@acm.org>
 <8ae21d8c-81a1-891a-66c4-c94ff8bee20b@kernel.dk>
 <69609425-5f1d-3c4f-3b1c-34f3b156006a@kernel.dk>
 <83df36a6-f36b-43b0-8817-59feff02038e@kernel.dk>
Message-ID: <0ad2ac54-c1e4-10bb-2129-6ef3e962c43e@kernel.dk>
Date:   Mon, 17 Dec 2018 17:26:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <83df36a6-f36b-43b0-8817-59feff02038e@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/18 5:16 PM, Jens Axboe wrote:
> On 12/17/18 4:49 PM, Jens Axboe wrote:
>> On 12/17/18 4:27 PM, Jens Axboe wrote:
>>> On 12/17/18 4:16 PM, Bart Van Assche wrote:
>>>> On Mon, 2018-12-17 at 11:28 -0700, Jens Axboe wrote:
>>>>> As I'm sure you're all aware, the merge window is coming up. This time
>>>>> it happens to coincide with that is a holiday for most. My plan is to
>>>>> send in an EARLY pull request to Linus, Thursday at the latest. If you're
>>>>> sitting on anything that should go in with the initial merge, then I need
>>>>> to have it ASAP.
>>>>>
>>>>> I'll do a later pull about a week in with things that were missed, but
>>>>> I'm really hoping to make that fixes only. Any driver updates etc should
>>>>> go in now.
>>>>
>>>> Hi Jens,
>>>>
>>>> If I run blktests/srp/002 against Linus' master branch then that test passes,
>>>> no matter how many times I run that test. If I run that test against your
>>>> for-next branch however (commit 6a252f2772c0) then that test hangs. The output
>>>> of my list-pending-block-requests script is as follows when the hang occurs:
>>>
>>> Ugh, I'll try and run that here again, that test is unfortunately such a pain
>>> to run and requires me to manually install multipath libs (and remember to
>>> uninstall before rebooting, or udev fails?).
>>>
>>> I'll take a look!
>>
>> Looks like what Ming was talking about. CC'ing Ming and Mike. Lots of
>> kworkers are stuck like this:
>>
>> [  252.310187] kworker/2:19    D14072  8147      2 0x80000000
>> [  252.316803] Workqueue: dio/dm-2 dio_aio_complete_work
>> [  252.322925] Call Trace:
>> [  252.326137]  ? __schedule+0x231/0x5f0
>> [  252.330703]  schedule+0x2a/0x80
>> [  252.334689]  rwsem_down_write_failed+0x204/0x320
>> [  252.340330]  ? generic_make_request_checks+0x55/0x370
>> [  252.346542]  ? call_rwsem_down_write_failed+0x13/0x20
>> [  252.352669]  call_rwsem_down_write_failed+0x13/0x20
>> [  252.358601]  down_write+0x1b/0x30
>> [  252.362781]  __generic_file_fsync+0x3e/0xb0
>> [  252.367933]  ext4_sync_file+0xcc/0x2e0
>> [  252.372599]  dio_complete+0x1c4/0x210
>> [  252.377168]  process_one_work+0x1cb/0x350
>> [  252.382915]  worker_thread+0x28/0x3c0
>> [  252.387482]  ? process_one_work+0x350/0x350
>> [  252.392632]  kthread+0x107/0x120
>> [  252.396717]  ? kthread_park+0x80/0x80
>> [  252.401285]  ret_from_fork+0x1f/0x30
>>
>> Where did this regression come from? This was passing just fine
>> recently.
> 
> Looks like this is the offending commit:
> 
> commit c4576aed8d85d808cd6443bda58393d525207d01
> Author: Mike Snitzer <snitzer@redhat.com>
> Date:   Tue Dec 11 09:10:26 2018 -0500
> 
>     dm: fix request-based dm's use of dm_wait_for_completion

Yep confirmed, reverted that on top and it passes. dm-2 has plenty of
requests that are allocated and pending dispatch, so the md_in_flight()
will return true. Mike, should it be checking for allocated requests or
in-flight?

-- 
Jens Axboe

