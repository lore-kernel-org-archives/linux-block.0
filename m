Return-Path: <SRS0=0pY0=BJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E41C433E0
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 19:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 566692074B
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 19:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rgWp8R+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbgG3Txb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jul 2020 15:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgG3Txb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jul 2020 15:53:31 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3C4C061574
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2020 12:53:31 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id s189so22249291iod.2
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2020 12:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5n75Pl4ograIr7r89j9UmXnQkww++4qtNaZ5HHcLRYE=;
        b=rgWp8R+rmFJpMjZWZnPy2tWkHTvv1W6xUmsb5Rt59WUkJ8ZSkHHgW9etAOB3wwoj+G
         9u/rIHWhrBtsZfevFE6tGPp8E6tZSOvLFSNWB36SzOUs1WO1E3C4GH+zCem7BBu/qP/t
         xRrYmSg9wYzJ5ddT6qrNrmqYoZou/X/hgTKRUfv9lE50ZNawsyhfCjJkk9Xo4qtXTMwi
         yvVk/5vejjBKYN1dYsP4cXFbLble2xBdvW54826hi1YknNJMk1sNzTGv0G3LQ4zRdFjm
         K3Ht/7wAyFkl4dfslIGfpnhyznKf1C4ZMYdEKFpmYxdFWg92L2wur5wKhnOwPmwjKE1O
         lS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5n75Pl4ograIr7r89j9UmXnQkww++4qtNaZ5HHcLRYE=;
        b=ozucMjSlKApkbuJ8tjlQw0/78Oo+KC+DZkZeCzxKQOh2ynXefBBbN9O7X9b1uH6vUK
         3tzB+ZWrwVO0mVmmqQV82WVBo3OqxIAMuVe1mB1IaB32poQBeXb2keHK+K/wwYiGhsGC
         9WnwScDnqEdzIPuQlZ9OzQloD/2yCPfWNP/2QyPQ3Q0gG1IIOb9ftv9i/O/H75x/WbVZ
         5HVshfXI100t5bg9HQ+4Vd1schIeoW+pMiSTXIL78nFVJsXjNfodoLPBX870/mGAgDDB
         ZrvVG568yu2wzOEdYjatpIYGpF7cxhXbbgcr7jx05uQ34RYobO/rh/uP+zu8M698ZrTr
         sepg==
X-Gm-Message-State: AOAM5326a87hxLeTlwcOYqwgae530YYavmTiYgn3zXE3fVwpeGWdj4S9
        9Yrn5XH52LkOc9PjDvFYBQ0BAw==
X-Google-Smtp-Source: ABdhPJyG1Ah/INKctUWHA1KH+flJKYesBK52SyrJw4nlS52rZhTvG567gC47ra4kZs76o8qqAE0+FA==
X-Received: by 2002:a6b:acc5:: with SMTP id v188mr172270ioe.85.1596138810690;
        Thu, 30 Jul 2020 12:53:30 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g13sm3374351ilq.18.2020.07.30.12.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 12:53:30 -0700 (PDT)
Subject: Re: [RFC PATCH] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Bart Van Assche <bvanassche@acm.org>
References: <20200728134938.1505467-1-ming.lei@redhat.com>
 <20200729102856.GA1563056@T590>
 <b80fa58d-34f0-cff5-c3f9-7b3d05a8a1ca@grimberg.me>
 <20200729154957.GD1698748@T590>
 <f3ead535-070d-40ec-08b8-56e2c1cd7ba4@grimberg.me>
 <20200730145325.GA1710335@T590>
 <57689a6d-9e6f-bb28-dd5f-f575988e7cb6@grimberg.me>
 <20200730181857.GA147247@dhcp-10-100-145-180.wdl.wdc.com>
 <761aa0f7-2e3f-d083-a32f-7c26ef2cd858@grimberg.me>
 <20200730192701.GC147247@dhcp-10-100-145-180.wdl.wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <05f75e89-b6f7-de49-eb9f-a08aa4e0ba4f@kernel.dk>
Date:   Thu, 30 Jul 2020 13:53:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730192701.GC147247@dhcp-10-100-145-180.wdl.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/30/20 1:27 PM, Keith Busch wrote:
> On Thu, Jul 30, 2020 at 11:23:58AM -0700, Sagi Grimberg wrote:
>>
>>>>>> I think it will be a significant improvement to have a single code path.
>>>>>> The code will be more robust and we won't need to face issues that are
>>>>>> specific for blocking.
>>>>>>
>>>>>> If the cost is negligible, I think the upside is worth it.
>>>>>>
>>>>>
>>>>> rcu_read_lock and rcu_read_unlock has been proved as efficient enough,
>>>>> and I don't think percpu_refcount is better than it, so I'd suggest to
>>>>> not switch non-blocking into this way.
>>>>
>>>> It's not a matter of which is better, its a matter of making the code
>>>> more robust because it has a single code-path. If moving to percpu_ref
>>>> is negligible, I would suggest to move both, I don't want to have two
>>>> completely different mechanism for blocking vs. non-blocking.
>>>
>>> FWIW, I proposed an hctx percpu_ref over a year ago (but for a
>>> completely different reason), and it was measured as too costly.
>>>
>>>    https://lore.kernel.org/linux-block/d4a4b6c0-3ea8-f748-85b0-6b39c5023a6f@kernel.dk/
>>
>> If this is the case, we shouldn't consider this as an alternative at all,
>> and move forward with either the original proposal or what
>> ming proposed to move a counter to the tagset.
> 
> Well, the point I was trying to make is that we shouldn't bother making
> blocking and non-blocking dispatchers use the same synchronization since
> non-blocking has a very cheap solution that blocking can't use.

I fully agree with that point.

-- 
Jens Axboe

