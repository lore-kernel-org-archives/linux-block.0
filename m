Return-Path: <SRS0=YHP0=RW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D081C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 03:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249F020989
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 03:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HyduMx4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfCSDhi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 23:37:38 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33516 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCSDhi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 23:37:38 -0400
Received: by mail-ot1-f66.google.com with SMTP id q24so16447571otk.0
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 20:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Hqp0jHS2sCkG7UFO+bJYm762lcPTSyNN5UvsAKRxIRc=;
        b=HyduMx4Nd+g0ECNFs6PwjpgwVXZH4fNygCsrIJ6l3j96IKvyPe//ectkM+PVsohffl
         FAZDbAk2TJXj/AXQCbBQZc6oRxPCYl70RaDA+ypvWIVYvr9xbp3uM1dAOcJhq3M+npAB
         JYnGpRs03xK5yASQynygptPIPAuGDUmO+Qswg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Hqp0jHS2sCkG7UFO+bJYm762lcPTSyNN5UvsAKRxIRc=;
        b=VoiNVFqzspf2ptYnYxHOSi8jnACvRYNSZy2yjSuLGS1rT4DSSvjx1xO+lwIS1R4wb2
         d0CdlfkPNdE3Z6gSrlHiAES48AfNi8p9aPLEMwX20OrU+eayyGWBPIa3b3CV7CKN67SJ
         6Fd9ieN/EfRZR2I/DUWIR9KhbBf6EgCkmr8HqD1FD0JWg5mDa3Tzr2GeF8A/CtdzVzEx
         7rm+iC0f9pzdIgowyLFpjCZzu3ivHkBoN/0M9m8Itli9R98+0kD6Qbd5fZ+jgb5n8+a9
         2+3ZRYjPp7q0+OoqMZRPWGWtPg07ExLRjCl/eesPMJ4kOvV/r3a5BHl0bvUBeonUnuMO
         +Png==
X-Gm-Message-State: APjAAAVN+F3gd3CFuI8gcGM/X5Vh9yO0Kich7sKDH0UgeXJ2gu90dkcf
        N/AOAvEb/HWk0lV6POTpj1X3rg==
X-Google-Smtp-Source: APXvYqwd4nBKALFUHpa5esaxhq4DGHCfCGvp9keLcexl1VZj96JIvdGCJOAEyuFiBu1FYCjugt7k7w==
X-Received: by 2002:a05:6830:1018:: with SMTP id a24mr176643otp.111.1552966657145;
        Mon, 18 Mar 2019 20:37:37 -0700 (PDT)
Received: from [192.168.1.237] (ip68-5-145-143.oc.oc.cox.net. [68.5.145.143])
        by smtp.gmail.com with ESMTPSA id h138sm5594128oic.8.2019.03.18.20.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 20:37:36 -0700 (PDT)
Subject: Re: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
 <4563485a-02c6-0bfe-d9ec-49adbd44671c@broadcom.com>
 <20190319010601.GA22459@ming.t460p>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <606d3477-e7ed-d876-f132-11627a77a760@broadcom.com>
Date:   Mon, 18 Mar 2019 20:37:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190319010601.GA22459@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/18/2019 6:06 PM, Ming Lei wrote:
> On Mon, Mar 18, 2019 at 10:37:08AM -0700, James Smart wrote:
>>
>> On 3/17/2019 8:29 PM, Ming Lei wrote:
>>> In NVMe's error handler, follows the typical steps for tearing down
>>> hardware:
>>>
>>> 1) stop blk_mq hw queues
>>> 2) stop the real hw queues
>>> 3) cancel in-flight requests via
>>> 	blk_mq_tagset_busy_iter(tags, cancel_request, ...)
>>> cancel_request():
>>> 	mark the request as abort
>>> 	blk_mq_complete_request(req);
>>> 4) destroy real hw queues
>>>
>>> However, there may be race between #3 and #4, because blk_mq_complete_request()
>>> actually completes the request asynchronously.
>>>
>>> This patch introduces blk_mq_complete_request_sync() for fixing the
>>> above race.
>>>
>> This won't help FC at all. Inherently, the "completion" has to be
>> asynchronous as line traffic may be required.
>>
>> e.g. FC doesn't use nvme_complete_request() in the iterator routine.
> Yeah, I saw the FC code, it is supposed to address the asynchronous
> completion of blk_mq_complete_request() in error handler.
>
> Also I think it is always the correct thing to abort requests
> synchronously in error handler, isn't it?
>

not sure I fully follow you, but if you're asking shouldn't it always be 
synchronous - why would that be the case ?  I really don't want a 
blocking thread that could block for several seconds on a single io to 
complete.  The controller has changed state and the queues frozen which 
should have been sufficient - but bottom-end io can still complete at 
any time.

-- james

