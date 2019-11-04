Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48DDCA9EC9
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 22:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928122080F
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 22:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbfKDW6p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:58:45 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42040 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729122AbfKDW6p (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Nov 2019 17:58:45 -0500
Received: by mail-pf1-f196.google.com with SMTP id s5so5359935pfh.9
        for <linux-block@vger.kernel.org>; Mon, 04 Nov 2019 14:58:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TKeyTMzqF036iq+k7U/9Q4otLzQJRmo5Olzo7ipoNoE=;
        b=MFpazQfh502Ex4raDrZ34tyM555CJfeqDwGMIHrRfEeAIqDJUPKbHX3zTMKVRhkAUV
         PNe0nlT5kO4tKhlAe/d+jfN2O35hlT/kpUlP+FCf6mtXxuArgT2PvV6I+QIyFCQY2NbA
         NhQolQWNyxWouns+lUmP74ajeobEhH2qi7xOCk2dfwGKqh1DmMWTV4Sd0XUNtr0Bjo2k
         znU8ZhwFXh2ZBxcq8ZN2eTtyzVNkv+zPR0Jt4dTTGbkz1ae/y0SwWiXu+hfoRspSpMZn
         779iZG6NL4qeWfb6p0mKXkU7aB10+dT9nSKtKoaHC5vevmHKexRswYJ7r+Cyr9WLkaoI
         xFoA==
X-Gm-Message-State: APjAAAXv/O4nafkTtNWLvrJG4WtJXR5HXWf/V77unWlWaScLnX6h6i9r
        gh7Kq46qBvNnz8fjXuCA/6i0iVql
X-Google-Smtp-Source: APXvYqx0Aqvb2kzNR9wOwM7T4eFEfhV90ANvNz8q+3dianF7kIjjo2JwMk23MWQQxKFFX4J9J4/nNg==
X-Received: by 2002:a63:5f44:: with SMTP id t65mr25129646pgb.124.1572908324009;
        Mon, 04 Nov 2019 14:58:44 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y22sm10093839pfn.6.2019.11.04.14.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2019 14:58:43 -0800 (PST)
Subject: Re: [PATCH] block: avoid blk_bio_segment_split for small I/O
 operations
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, ming.lei@redhat.com,
        linux-block@vger.kernel.org
References: <20191104180543.23123-1-hch@lst.de>
 <20191104193002.GA21075@redsun51.ssa.fujisawa.hgst.com>
 <f1050949-31b1-a9cf-02d6-00c94f505290@kernel.dk>
 <20191104225036.GA21282@redsun51.ssa.fujisawa.hgst.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e5cd73ac-9184-97f5-132f-ba4a7069608d@acm.org>
Date:   Mon, 4 Nov 2019 14:58:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104225036.GA21282@redsun51.ssa.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/19 2:50 PM, Keith Busch wrote:
> On Mon, Nov 04, 2019 at 01:13:53PM -0700, Jens Axboe wrote:
>>> If the device advertises a chunk boundary and this small IO happens to
>>> cross it, skipping the split is going to harm performance.
>>
>> Does anyone do that, that isn't the first gen intel weirdness? Honest question,
>> but always seemed to me that this spec addition was driven entirely by that
>> one device.
> 
> There are at least 3 generations of Intel DC P-series that use this,
> maybe more. I'm not sure if any other available vendor devices report
> this feature, though.
>   
>> And if they do, do they align on non-4k?
> 
> All existing ones I'm aware of are 128k, so 4k aligned, but if the LBA
> format is 512B, you could start a 4k IO at a 126k offset to straddle the
> boundary. Hm, maybe we don't care about the split penalty in that case
> since unaligned access is already going to be slower for other reasons ...

Aren't NVMe devices expected to set the NOIOB parameter to avoid that 
NVMe commands straddle boundaries that incur a performance penalty? From 
the NVMe spec: "Namespace Optimal IO Boundary (NOIOB): This field 
indicates the optimal IO boundary for this namespace. This field is 
specified in logical blocks. The host should construct read and write 
commands that do not cross the IO boundary to achieve optimal 
performance. A value of 0h indicates that no optimal IO boundary is 
reported."

Thanks,

Bart.


