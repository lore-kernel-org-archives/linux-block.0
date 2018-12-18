Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A2FC43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 18:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73A1218AC
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 18:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mXvNyYBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeLRSLy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:11:54 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52978 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbeLRSLx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 13:11:53 -0500
Received: by mail-it1-f193.google.com with SMTP id g76so5578396itg.2
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 10:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OsybF4Gw1XtINVbPNU13wg4WEs0mYxk56McH5vYD6o0=;
        b=mXvNyYBroE49t6R5ouIbRE30MJAzUgIhqmx0d+spI37ant6epT/6RUyXcb41UbuM4T
         wqeKy7jU5KTu6/M7ej9mX4GqLYU282kFzYwKgpqEt84cW6LCDcbeqRsLrRZTqnnfI7l7
         dGOcyLKMvxl532U57Eo+e/hBvhFkt8BCU0iwGzh0Y2ZphZ3NI3Yu1Vf4W0acILsrW5ZU
         JTW/ypNKfmGX8gtgjL/n2UpShHbopysaOowEscGQb9zuJs26PSgB6Fg0kE6IwMAn5ghd
         Khyf+LMSs89NWg9/T03xHdXd2riIbHgV2RVujAWE6NBd0jGu7D7F8OjLgrq/Uo2BV6R7
         i2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OsybF4Gw1XtINVbPNU13wg4WEs0mYxk56McH5vYD6o0=;
        b=f1prrodDoEQGzX+0/GgqFE2JfyZMR129wKyPZgaCfPhq5W4FHPOWRqtkqa2vAVu6JX
         N5jP3T3YKrTzIS20HKcfOdYC74FQq2hzvR4BVZp9iBnfS22W5O4WuM+sZQfdD6ZaajUb
         JV9Te0aG/OR3O4eQmOyhMGu0+Mo/ZgjXQb3IXz9ehe401JlfggVjuPLTbi65pTcU4/4A
         7sqDXRQvAczWGEAoA/f3uJMdVHgOcarVzdbfdA6RsQR4ratQ8R2J+fbCW0neN9Onql3d
         Ud6sD0QwsLYLfsu1DENf8LqaXtLl7+OEFBeXEccKvzQ5voiLvOEdnpgnG+p+zsNrmp5N
         JA7Q==
X-Gm-Message-State: AA+aEWaGYTns6Au/JxjJblqQDHObK+tyu3sdGulGH3x178TcdIgJv5N4
        so0z8sUUcpKRB1FiYk/QtxD53Q==
X-Google-Smtp-Source: AFSGD/WlwwxpsTklsggY248Gg/wyOaWbe9ptUy4NjERfvJ0s89/cGhacZvPoS4Xk+o/IxCE5ZKXAiA==
X-Received: by 2002:a24:9307:: with SMTP id y7mr3904472itd.38.1545156712458;
        Tue, 18 Dec 2018 10:11:52 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q14sm1692667itb.36.2018.12.18.10.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 10:11:51 -0800 (PST)
Subject: Re: [PATCH V2] blk-mq: Set request mapping to NULL in
 blk_mq_put_driver_tag
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
References: <CAHsXFKHSjBHZy9tyhdEjYJcLJeE6SqdeBPcoeq=bCaRfzvMqgw@mail.gmail.com>
 <1545149754.185366.449.camel@acm.org>
 <ae741e1b-ec2d-075e-82b0-a1e09d0553fd@kernel.dk>
 <41bb993fdc71d02a884cc2b793403ca7@mail.gmail.com>
 <9d1601bd-5b28-23f8-2a36-8fc100323422@kernel.dk>
 <e5049f63c7aadd11f64b8027f352a014@mail.gmail.com>
 <04e2f9e8-79fa-f1cb-ab23-4a15bf3f64cc@kernel.dk>
 <a9186c0c84f31623a544d73ce9a779d6@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7a2b3fa5-652a-2d43-c93c-be5277b34060@kernel.dk>
Date:   Tue, 18 Dec 2018 11:11:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <a9186c0c84f31623a544d73ce9a779d6@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/18/18 11:08 AM, Kashyap Desai wrote:
>> On 12/18/18 10:48 AM, Kashyap Desai wrote:
>>>>
>>>> On 12/18/18 10:08 AM, Kashyap Desai wrote:
>>>>>>>
>>>>>>> Other block drivers (e.g. ib_srp, skd) do not need this to work
>>>>>>> reliably.
>>>>>>> It has been explained to you that the bug that you reported can be
>>>>>>> fixed by modifying the mpt3sas driver. So why to fix this by
>>>>>>> modifying the block layer? Additionally, what prevents that a race
>>>>>>> condition occurs between the block layer clearing
>>>>>>> hctx->tags->rqs[rq->tag] and
>>>>>>> scsi_host_find_tag() reading that same array element? I'm afraid
>>>>>>> that this is an attempt to paper over a real problem instead of
>>>>>>> fixing the root
>>>>>> cause.
>>>>>>
>>>>>> I have to agree with Bart here, I just don't see how the mpt3sas
>>>>>> use case is special. The change will paper over the issue in any
>>>>>> case.
>>>>>
>>>>> Hi Jens, Bart
>>>>>
>>>>> One of the key requirement for iterating whole tagset  using
>>>>> scsi_host_find_tag is to block scsi host. Once we are done that, we
>>>>> should be good. No race condition is possible if that part is taken
>>>>> care.
>>>>> Without this patch, if driver still receive scsi command from the
>>>>> hctx->tags->rqs which is really not outstanding.  I am finding this
>>>>> hctx->tags->is
>>>>> common issue for many scsi low level drivers.
>>>>>
>>>>> Just for example <fnic> - fnic_is_abts_pending() function has below
>>>>> code -
>>>>>
>>>>>         for (tag = 0; tag < fnic->fnic_max_tag_id; tag++) {
>>>>>                 sc = scsi_host_find_tag(fnic->lport->host, tag);
>>>>>                 /*
>>>>>                  * ignore this lun reset cmd or cmds that do not
>>>>> belong to
>>>>>                  * this lun
>>>>>                  */
>>>>>                 if (!sc || (lr_sc && (sc->device != lun_dev || sc ==
>>>>> lr_sc)))
>>>>>                         continue;
>>>>>
>>>>> Above code also has similar exposure of kernel panic like <mpt3sas>
>>>>> driver while accessing sc->device.
>>>>>
>>>>> Panic is more obvious if we have add/removal of scsi device before
>>>>> looping through scsi_host_find_tag().
>>>>>
>>>>> Avoiding block layer changes is also attempted in <mpt3sas> but our
>>>>> problem is to convert that code common for non-mq and mq.
>>>>> Temporary to unblock this issue, We have fixed <mpt3sas> using
>>>>> driver internals scsiio_tracker() instead of piggy back in
>>>>> scsi_command.
>>>>
>>>> For mq, the requests never go out of scope, they are always valid. So
>>>> the key question here is WHY they have been freed. If the queue gets
>>>> killed, then one potential solution would be to clear pointers in the
>>>> tag map belonging to that queue. That also takes it out of the hot
>>>> path.
>>>
>>> At driver load whenever driver does scsi_add_host_with_dma(), it
>>> follows below code path in block layer.
>>>
>>> scsi_mq_setup_tags
>>>   ->blk_mq_alloc_tag_set
>>>           -> blk_mq_alloc_rq_maps
>>>                      -> __blk_mq_alloc_rq_maps
>>>
>>> SML create two set of request pool. One is per HBA and other is per
>>> SDEV. I was confused why SML creates request pool per HBA.
>>>
>>> Example - IF HBA queue depth is 1K and there are 8 device behind that
>>> HBA, total request pool is created is 1K + 8 * scsi_device queue
>>> depth. 1K will be always static, but other request pool is managed
>>> whenever scsi device is added/removed.
>>>
>>> I never observe requests allocated per HBA is used in IO path. It is
>>> always request allocated per scsi device is what active.
>>> Also, what I observed is whenever scsi_device is deleted, associated
>>> request is also deleted. What is missing is - "Deleted request still
>>> available in
>>> hctx->tags->rqs[rq->tag]."
>>
>> So that sounds like the issue. If the device is deleted and its requests
>> go away,
>> those pointers should be cleared. That's what your patch should do, not do
>> it
>> for each IO.
> 
> At the time of device removal,  it requires reverse traversing.  Find out if
> each requests associated with sdev is part of hctx->tags->rqs() and clear
> that entry.
> Not sure about atomic traverse if more than one device removal is happening
> in parallel.  May be more error prone. ?
> 
> Just wondering both the way we will be removing invalid request from array.
> Are you suspecting any performance issue if we do it per IO ?

It's an extra store, and it's a store to an area that's then now shared
between issue and completion. Those are never a good idea. Besides, it's
the kind of issue you solve in the SLOW path, not in the fast path. Since
that's doable, it would be silly to do it for every IO.

This might not matter on mpt3sas, but on more efficient hw it definitely
will.

I'm still trying to convince myself that this issue even exists. I can see
having stale entries, but those should never be busy. Why are you finding
them with the tag iteration? It must be because the tag is reused, and
you are finding it before it's re-assigned?

-- 
Jens Axboe

