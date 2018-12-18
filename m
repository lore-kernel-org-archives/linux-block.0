Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E84C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 17:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338E621850
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 17:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Dc5Xb30e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbeLRRus (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:50:48 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:37854 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeLRRus (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 12:50:48 -0500
Received: by mail-it1-f194.google.com with SMTP id b5so5463456iti.2
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 09:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FrOme91Zb7gYcX57QV7yFjdyJAGfyUX6mBTEzVF6nGg=;
        b=Dc5Xb30eAB4oU+KPdAp1gpwPs6Jwtc9vIfViHenAEssghwrylL9D8S/9hz17AELDST
         wN0AfoL/OgjGqZDzDiVgPbLfhCI4Hj3jA/yMHCuHXdXWZtVeUI5ZfP5npnRJU/8jyzqy
         SPZ0ZbltTHeitmYOkeP62YX7BQeq1ZuM2p3F0LpIsTQibHG3IdZdU7jNaSl6QXVvgP0x
         ScCt1IyPDbS/lQAe68TIsijZSnDHdnOF2cX7XNnsH1IRcq0tAGa1vZUVJBaGJWUOx8YK
         fLrhHh2MqtFXlDAfU3H5aylOX2JaykfYOn6IYjaJP5Z47JUDo9xnmJsN4qb8ykcNF/Nj
         TJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FrOme91Zb7gYcX57QV7yFjdyJAGfyUX6mBTEzVF6nGg=;
        b=D6uJdKlP7FgAhdZsEqMWZbyyA0+fM6z/dPsZ+xEvUi0oAzU3oOjSIj6GeOC3oM1+wm
         UtElXmDfqz4hn9xKmMOcoxxG8pvByyn2N07w+YghwhXdY4Tim25Sogo5cieJnZCxn4L3
         iUTbg0nm82+WMcdEolY0r8wv08sR/9ZuPTaVXCL35ysMSDPDOkVDwSIZK2kWSIer8QnA
         GCtYdtGvWy7oYq7lZ+IhqXU7OfEP6s588abET4RFFvmrfWKUN5xblFpd5cVnMbQVoiUp
         mkvvt6NObc9uzU4gQ+jwRvuBJRUtU88jCRQgIyPQTWFY314NhGjUxsGZ6FjX79IXuz4c
         JaWg==
X-Gm-Message-State: AA+aEWZmpEZEhspx1j2PqNqztxBivVgruxmMu7RWmU7OQieJzHY9CKSq
        AOUkcoQzDA/JFiwLaju7bKFlyLahdmCxCA==
X-Google-Smtp-Source: ALg8bN4l0k5qH11S28p+37tx8ZRLDZb9OfPv7OCLP6+TMP0mkoW5EdHbJUbbVi5c31TftAsqn5Yo+w==
X-Received: by 2002:a24:7284:: with SMTP id x126mr1856586itc.15.1545155447198;
        Tue, 18 Dec 2018 09:50:47 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w16sm1977805ita.38.2018.12.18.09.50.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 09:50:46 -0800 (PST)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <04e2f9e8-79fa-f1cb-ab23-4a15bf3f64cc@kernel.dk>
Date:   Tue, 18 Dec 2018 10:50:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <e5049f63c7aadd11f64b8027f352a014@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/18/18 10:48 AM, Kashyap Desai wrote:
>>
>> On 12/18/18 10:08 AM, Kashyap Desai wrote:
>>>>>
>>>>> Other block drivers (e.g. ib_srp, skd) do not need this to work
>>>>> reliably.
>>>>> It has been explained to you that the bug that you reported can be
>>>>> fixed by modifying the mpt3sas driver. So why to fix this by
>>>>> modifying the block layer? Additionally, what prevents that a race
>>>>> condition occurs between the block layer clearing
>>>>> hctx->tags->rqs[rq->tag] and
>>>>> scsi_host_find_tag() reading that same array element? I'm afraid
>>>>> that this is an attempt to paper over a real problem instead of
>>>>> fixing the root
>>>> cause.
>>>>
>>>> I have to agree with Bart here, I just don't see how the mpt3sas use
>>>> case is special. The change will paper over the issue in any case.
>>>
>>> Hi Jens, Bart
>>>
>>> One of the key requirement for iterating whole tagset  using
>>> scsi_host_find_tag is to block scsi host. Once we are done that, we
>>> should be good. No race condition is possible if that part is taken
>>> care.
>>> Without this patch, if driver still receive scsi command from the
>>> hctx->tags->rqs which is really not outstanding.  I am finding this is
>>> common issue for many scsi low level drivers.
>>>
>>> Just for example <fnic> - fnic_is_abts_pending() function has below
>>> code -
>>>
>>>         for (tag = 0; tag < fnic->fnic_max_tag_id; tag++) {
>>>                 sc = scsi_host_find_tag(fnic->lport->host, tag);
>>>                 /*
>>>                  * ignore this lun reset cmd or cmds that do not belong
>>> to
>>>                  * this lun
>>>                  */
>>>                 if (!sc || (lr_sc && (sc->device != lun_dev || sc ==
>>> lr_sc)))
>>>                         continue;
>>>
>>> Above code also has similar exposure of kernel panic like <mpt3sas>
>>> driver while accessing sc->device.
>>>
>>> Panic is more obvious if we have add/removal of scsi device before
>>> looping through scsi_host_find_tag().
>>>
>>> Avoiding block layer changes is also attempted in <mpt3sas> but our
>>> problem is to convert that code common for non-mq and mq.
>>> Temporary to unblock this issue, We have fixed <mpt3sas> using driver
>>> internals scsiio_tracker() instead of piggy back in scsi_command.
>>
>> For mq, the requests never go out of scope, they are always valid. So the
>> key
>> question here is WHY they have been freed. If the queue gets killed, then
>> one
>> potential solution would be to clear pointers in the tag map belonging to
>> that
>> queue. That also takes it out of the hot path.
> 
> At driver load whenever driver does scsi_add_host_with_dma(), it follows
> below code path in block layer.
> 
> scsi_mq_setup_tags
>   ->blk_mq_alloc_tag_set
>           -> blk_mq_alloc_rq_maps
>                      -> __blk_mq_alloc_rq_maps
> 
> SML create two set of request pool. One is per HBA and other is per SDEV. I
> was confused why SML creates request pool per HBA.
> 
> Example - IF HBA queue depth is 1K and there are 8 device behind that HBA,
> total request pool is created is 1K + 8 * scsi_device queue depth. 1K will
> be always static, but other request pool is managed whenever scsi device is
> added/removed.
> 
> I never observe requests allocated per HBA is used in IO path. It is always
> request allocated per scsi device is what active.
> Also, what I observed is whenever scsi_device is deleted, associated request
> is also deleted. What is missing is - "Deleted request still available in
> hctx->tags->rqs[rq->tag]."

So that sounds like the issue. If the device is deleted and its requests
go away, those pointers should be cleared. That's what your patch should
do, not do it for each IO.


-- 
Jens Axboe

