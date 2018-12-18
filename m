Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1C7C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 18:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076CF218A2
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 18:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vkvw2IrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeLRS2t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:28:49 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43360 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeLRS2t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 13:28:49 -0500
Received: by mail-io1-f66.google.com with SMTP id g17so1709579ioc.10
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 10:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uy8jtcp2IPE/iqRBP41q69w/MXA8vn0/HYDZdPvmsLs=;
        b=vkvw2IrQ0wviH6Q0O0O+PnQq7Y3p26VyOD+X3mrbqI8ZFtFqe4SOmosirFGwr89jP5
         gD821ZEgi5ZNtvO7d4Yw+HXU0F6t46idaUzHCQcKhI84DE4vhbfnbWgDHjodyNN3Lgo+
         AZP8j1GPldr0C2Jq81nBysu0zVVDjt4fpRj0trh77Fhb1zLBzIfdS5KIMyLw7qWBY0nb
         1co0h0NkfBt2FIFJj4u2zNfRLxAuZVatnmzpZTF6D+zueKlGBDKwKDRAMFVBEs2P1RzJ
         +Xjem5FUwYHZfDo45pMaXe3vSoGq+96bbCDYk+kUlndu76AFgeWCK/tl0Grwg3Nsf3I4
         Qxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uy8jtcp2IPE/iqRBP41q69w/MXA8vn0/HYDZdPvmsLs=;
        b=k1jN3VeOwB7qmZO0n4qHMj7sOjYdypYynatiOBDUsY+afsC+wEtXRbG0D1fF1HGVSn
         DorGgrfWuKeosjE81mcMEbB9r4FsWXY1Ejhj7sIrQC6PEheZTihg82T7ZHJYuavplWqX
         yRM2cwD9cAitK0kUEaJWWyzjqLIGq/droqdGqhTy3yv/Ym2lXqCEHuYUHZr3ZecBVa4k
         lUvZgl5+fgb4pgdy61B6w1/ywkucBCnIqHkyY5w3CTFLjI9jNy2sb/nzuI/Yp3SXsx7T
         B+5gVDa0nZIohpZ99dZjYXrI3mJrVNTwYOwPOlhDcIiU0bqBoaIltjWag1gS8dA3i1aL
         Ll3w==
X-Gm-Message-State: AA+aEWYNTANK+U5rFIwRLNhDFg6ST21WWPr6VNmy6LKit6rqDs5DAu/r
        Gy98yOFodPv1SKbqyPu3orQIMQ==
X-Google-Smtp-Source: AFSGD/X7ezgQhhVdNVXGIUiLOVp5Ahzx2gfIyD2r7bQF+3olBRG6EMvbOLx3Lj5Mkw9pz7kVOciC5Q==
X-Received: by 2002:a6b:156:: with SMTP id 83mr15205282iob.63.1545157728264;
        Tue, 18 Dec 2018 10:28:48 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id v5sm6537986iob.78.2018.12.18.10.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 10:28:47 -0800 (PST)
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
 <7a2b3fa5-652a-2d43-c93c-be5277b34060@kernel.dk>
 <26fb62ae415185db2df6af3bed159a68@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cf524178-c497-373c-37f6-abee13eacf19@kernel.dk>
Date:   Tue, 18 Dec 2018 11:28:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <26fb62ae415185db2df6af3bed159a68@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/18/18 11:22 AM, Kashyap Desai wrote:
>>>
>>> At the time of device removal,  it requires reverse traversing.  Find
>>> out if each requests associated with sdev is part of hctx->tags->rqs()
>>> and clear that entry.
>>> Not sure about atomic traverse if more than one device removal is
>>> happening in parallel.  May be more error prone. ?
>>>
>>> Just wondering both the way we will be removing invalid request from
>>> array.
>>> Are you suspecting any performance issue if we do it per IO ?
>>
>> It's an extra store, and it's a store to an area that's then now shared
>> between
>> issue and completion. Those are never a good idea. Besides, it's the kind
>> of
>> issue you solve in the SLOW path, not in the fast path. Since that's
>> doable, it
>> would be silly to do it for every IO.
>>
>> This might not matter on mpt3sas, but on more efficient hw it definitely
>> will.
> 
> Understood your primary concern is to avoid per IO and do it if no better
> way.
> 
>> I'm still trying to convince myself that this issue even exists. I can see
>> having
>> stale entries, but those should never be busy. Why are you finding them
>> with
>> the tag iteration? It must be because the tag is reused, and you are
>> finding it
>> before it's re-assigned?
> 
> 
> Stale entries will be forever if we remove scsi devices. It is not timing
> issue. If memory associated with request (freed due to device removal)
> reused, kernel panic occurs.
> We have 24 Drives behind Expander and follow expander reset which will
> remove all 24 drives and add it back. Add and removal of all the drives
> happens quickly.
> As part of Expander reset, <mpt3sas> driver process broadcast primitive
> event and that requires finding all outstanding scsi command.
> 
> In some cases, we need firmware restart and that path also requires tag
> iteration.

I actually took a look at scsi_host_find_tag() - what I think needs
fixing here is that it should not return a tag that isn't allocated.
You're just looking up random stuff, that is a recipe for disaster.
But even with that, there's no guarantee that the tag isn't going away.

The mpt3sas use case is crap. It's iterating every tag, just in case it
needs to do something to it.

My suggestion would be to scrap that bad implementation and have
something available for iterating busy tags instead. That'd be more
appropriate and a lot more efficient that a random loop from 0..depth.
If you are flushing running commands, looking up tags that aren't even
active is silly and counterproductive.

-- 
Jens Axboe

