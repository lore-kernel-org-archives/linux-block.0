Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28943C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 17:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB14121873
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 17:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZaBsLC7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeLRRNa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:13:30 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:34722 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbeLRRNa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 12:13:30 -0500
Received: by mail-it1-f195.google.com with SMTP id x124so8743772itd.1
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 09:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5hvYqj8r4CmmGgs7VnKI7yYqKANorzjnNmFu4w52cbo=;
        b=ZaBsLC7EbPvnZ7ftXVRs/ePFBgB1y5bamZxrzis7/AOnpIsrxu5Bal8yGtQ9JSf7JK
         KXrx0Og645pIyDMCykeHG0pP9J1YfMAPEWP436YFdPPlVrmH4vly6yRcgY7yP2RFaxw2
         jmwFR4GSWNbRBF0ahHre9mqSPPUvoaqrlzAzyRHUKIYTDbBvhL1nS3IyMW9VD4y5lO8p
         1nkL7hJCcegKezPcycLm7t2oV+V4CeDlRh5rum6JD2I9tLCmujoPWjVJI23YEBeVTZzs
         Fjv/S//MwbOUuuTl54xPjaCsHXTkVmo2Xd8PX+NbN1RdgP481Ks6GgHh6nkp211KtSad
         y6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5hvYqj8r4CmmGgs7VnKI7yYqKANorzjnNmFu4w52cbo=;
        b=dc1VMNVVibSgrmWBERrJaki96nOrVdVcOCFfP9xv9e/81dFR2hcbjm0BoL1EoWwKkJ
         93w992kBxnyA+CbIrlp33yDbuQKoktJKFFD1bUcVzh24cTu+Uols7jAe7olcuAw+kb7g
         iMZytJdV2cPhR5YbPg4NcEx3upba9X52evxTJjdNkLOynAs9fYN6QoJhCuBt4+Q7SM4+
         PiB6/daTJ+ayjxc7NOFwz3e/mZHIm3JVJ4LsyMc1iq6Lr7HRxbhScMWKILbH0rimov2b
         1FhDAgMpas+2x/pSPRoZfOYSUV4hh0z6nB9WWcmxNAW+NzI9Y14Rqf+lofR1bLBn4+0Y
         EL6w==
X-Gm-Message-State: AA+aEWbL4Uy8bZCal1QdzUqiUA/1CBc2h3SJXPLwQGl+RVbhgCTXnKJ6
        ueCGpG2LvFRExWfyBnH4Zy8gyw==
X-Google-Smtp-Source: ALg8bN7dSgDwTRLpVwoOAnYy040NzNjmavAOOdHOJDEIIxFC9sm5TYY3/Xwh7hrLSZ36DFDrmJ7jkQ==
X-Received: by 2002:a24:7284:: with SMTP id x126mr1741793itc.15.1545153209434;
        Tue, 18 Dec 2018 09:13:29 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id l186sm1709118itl.22.2018.12.18.09.13.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 09:13:28 -0800 (PST)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9d1601bd-5b28-23f8-2a36-8fc100323422@kernel.dk>
Date:   Tue, 18 Dec 2018 10:13:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <41bb993fdc71d02a884cc2b793403ca7@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/18/18 10:08 AM, Kashyap Desai wrote:
>>>
>>> Other block drivers (e.g. ib_srp, skd) do not need this to work
>>> reliably.
>>> It has been explained to you that the bug that you reported can be
>>> fixed by modifying the mpt3sas driver. So why to fix this by modifying
>>> the block layer? Additionally, what prevents that a race condition
>>> occurs between the block layer clearing hctx->tags->rqs[rq->tag] and
>>> scsi_host_find_tag() reading that same array element? I'm afraid that
>>> this is an attempt to paper over a real problem instead of fixing the
>>> root
>> cause.
>>
>> I have to agree with Bart here, I just don't see how the mpt3sas use case
>> is
>> special. The change will paper over the issue in any case.
> 
> Hi Jens, Bart
> 
> One of the key requirement for iterating whole tagset  using
> scsi_host_find_tag is to block scsi host. Once we are done that, we should
> be good. No race condition is possible if that part is taken care.
> Without this patch, if driver still receive scsi command from the
> hctx->tags->rqs which is really not outstanding.  I am finding this is
> common issue for many scsi low level drivers.
> 
> Just for example <fnic> - fnic_is_abts_pending() function has below code -
> 
>         for (tag = 0; tag < fnic->fnic_max_tag_id; tag++) {
>                 sc = scsi_host_find_tag(fnic->lport->host, tag);
>                 /*
>                  * ignore this lun reset cmd or cmds that do not belong to
>                  * this lun
>                  */
>                 if (!sc || (lr_sc && (sc->device != lun_dev || sc ==
> lr_sc)))
>                         continue;
> 
> Above code also has similar exposure of kernel panic like <mpt3sas> driver
> while accessing sc->device.
> 
> Panic is more obvious if we have add/removal of scsi device before looping
> through scsi_host_find_tag().
> 
> Avoiding block layer changes is also attempted in <mpt3sas> but our problem
> is to convert that code common for non-mq and mq.
> Temporary to unblock this issue, We have fixed <mpt3sas> using driver
> internals scsiio_tracker() instead of piggy back in scsi_command.

For mq, the requests never go out of scope, they are always valid. So
the key question here is WHY they have been freed. If the queue gets killed,
then one potential solution would be to clear pointers in the tag map
belonging to that queue. That also takes it out of the hot path.

-- 
Jens Axboe

