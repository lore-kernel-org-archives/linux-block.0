Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36444C5479D
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 01:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjAJBuQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 20:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237223AbjAJBuN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 20:50:13 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAD3F02C
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 17:50:13 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id l1-20020a17090a384100b00226f05b9595so9740812pjf.0
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 17:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tyv8+Pn1vu+82OVxcvG0igzn00GRq+MSjEWLLPkF+Rc=;
        b=oePbeJxm1AQPwaQkd0+KXPEzdtKfJltivnIPrVBVLrBVySJRjSRl69dW2crsZpCWpX
         OnnYTRjkQNZmkrnUs0L0bkNEQECHalfcMhFtUJK8SZmLhVolZva0ltT5hE3RTD5OT1VD
         oIQaEsHySRTGzw+5sF8dxLxTkv7YEMKJ+rHiZ9icSUD9JeGxNQYpD0YmnbsmBqmld23K
         qtB32ZAfmQboEffk3fpzD3fP1wQR7d1HavQ0yvPb3M0DpaHT05L+Pn/Tv9F1xkaFP7AS
         2t63JYfB09V/1KVxLoiqIAbXXlMzW6D1ffKm/yCsaNOT37tuQCN3NoYeUMvsDNVB6PIj
         b80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tyv8+Pn1vu+82OVxcvG0igzn00GRq+MSjEWLLPkF+Rc=;
        b=w5emFKOjsfLKAZfzUVAqSQuRXJIfnQpP7A38WunEtwKuzrir6jWOHYbL1byKBjgaFc
         sTAHFIWw1BcTXEgZtEy6p9HgJOgR0tm9AtBNCcmzLUIqMtrLtudzQUbvjJnvjmSa8dFp
         cu1E/zWc23ytwALzJ4SCYG9Icx3wDZ1WbqJR2SPg6t6KNqb7EmlxNABnUQ2bmHMFk1XO
         7+AopVCz+pSbt19moGlMzt7NonYDUCU8reyQv55LHBwFyROcqUw5VATfF7fxLZSIpMJ0
         5gSQ7R+2oQWk3ujj3zZvN/hGrbkkkgYETTDTj+Mz5tON/MQUxGPLB5r3D5/hHotOzDj4
         P7vA==
X-Gm-Message-State: AFqh2kppwic6/5o4Ii3cgDCZqBBw7WkNipyIShjLsFogWjq+/XAVYR+a
        FSBVzVbkZIu7YBwJR6Y7QyqgxA==
X-Google-Smtp-Source: AMrXdXskv6xre3HkiaS5sbvlcrD7p5Htk+8l2cuuNZuAHeNuTH+c9ZncC1iuBsvBdASsA6nVMssE3Q==
X-Received: by 2002:a05:6a21:e30e:b0:b5:f6de:e28c with SMTP id cb14-20020a056a21e30e00b000b5f6dee28cmr822877pzc.6.1673315412696;
        Mon, 09 Jan 2023 17:50:12 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j17-20020a635511000000b00478b930f970sm5645276pgb.66.2023.01.09.17.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 17:50:11 -0800 (PST)
Message-ID: <007cb2a5-f9c0-a75e-9e4c-198e0ae11d05@kernel.dk>
Date:   Mon, 9 Jan 2023 18:50:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [External] [LSF/MM/BPF BoF] Session for Zoned Storage 2023
Content-Language: en-US
To:     "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        lsf-pc@lists.linux-foundation.org
References: <F6BF25E2-FF26-48F2-8378-3CB36E362313@dubeyko.com>
 <Y7h0F0w06cNM89hO@bombadil.infradead.org>
 <4CC4F55E-17B3-47E2-A8C5-9098CCEB65D6@dubeyko.com>
 <CGME20230107015641eucas1p13c2b37b5ca7a5b64eb520b79316d5186@eucas1p1.samsung.com>
 <5DF10459-88F3-48DA-AEB2-5B436549A194@bytedance.com>
 <20230109153315.waqfokse4srv6xlz@mpHalley-2.localdomain>
 <AF3750AD-1B66-4F8A-936F-A14EC17DAC16@bytedance.com>
 <04cc803e-0246-bf8a-c083-f556a373ae4f@opensource.wdc.com>
 <ca30360e-ab51-6282-bd3c-208399e5a552@kernel.dk>
 <E2BA234A-D3D3-440B-BBDB-230B772B2D01@bytedance.com>
 <e4a972f4-50fd-4c0e-1b44-dc702fd9c445@kernel.dk>
 <B512D508-4460-44B8-9067-84F78BA43E0E@bytedance.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <B512D508-4460-44B8-9067-84F78BA43E0E@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/23 6:39?PM, Viacheslav A.Dubeyko wrote:
> 
> 
>> On Jan 9, 2023, at 5:09 PM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 1/9/23 4:20?PM, Viacheslav A.Dubeyko wrote:
>>>
>>>
>>>> On Jan 9, 2023, at 3:00 PM, Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>>>> My point here that we could summarize:
>>>>>> (1) what features already implemented and supported,
>>>>>> (2) what features are under implementation and what is progress,
>>>>>> (3) what features need to be implemented yet.
>>>>>>
>>>>>> Have we implemented everything already? :)
>>>>>
>>>>> Standards are full of features that are not useful in a general purpose
>>>>> system. So we likely never will implement everything. We never did for
>>>>> SCSI and ATA and never will either.
>>>> Indeed, and that's a very important point. Some people read specs and
>>>> find things that aren't in the Linux driver (any spec, not a specific
>>>> one), and think they need to be added. No. We only add them if they make
>>>> sense, both in terms of use cases, but also as long as they can get
>>>> implemented cleanly. Parts of basically any spec is garbage and don't
>>>> necessarily fit within the given subsystem either.
>>>>
>>>> The above would make me worried about patches coming from anyone with
>>>> that mindset.
>>>>
>>>
>>> OK. We already have discussion about garbage in spec. :)
>>> So, what would we like finally implement and what never makes sense to do?
>>> Should we identify really important stuff for implementation?
>>
>> Well if you did have that discussion, then it seemed you got nothing
>> from it. Because asking that kind of question is EXACTLY what I'm saying
>> is the opposite of what should be done. If there's a demand for a
>> feature, then it can be looked at and ultimately implemented if it makes
>> sense. You're still talking about proactively finding features and
>> implementing them "just in case they are needed", which is very much the
>> opposite and wrong approach, and how any kind of software ends up being
>> bloated, slow, and buggy/useless.
>>
> 
> I simply tried to suggest some space for this discussion and nothing
> more. If all important features have been implemented already and
> nobody would like to discuss new feature(s), then we can simply
> exclude this topic from the list.

If something is missing and there's a bof/session, then someone will
bring it up. Fishing for things to implement is not a good idea.

-- 
Jens Axboe

