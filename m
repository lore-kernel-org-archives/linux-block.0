Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3295C04EB8
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 08:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D832084E
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 08:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D832084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbeLLIxy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:53:54 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43392 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLIxy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 03:53:54 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so16781132wrs.10;
        Wed, 12 Dec 2018 00:53:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TkZUJxhIHnGlo39hfxjObLAe+B18X6l99uarqZFtmnc=;
        b=tDyvq+k1ceHvd0kBI1EaLEIfb261QL2qj/KPFzldS7zPvgetQ1dLSB6nBUkPFqvO5Y
         CnFU+qzB0Iy1rf1OtEjjbcZprP38bQ0XuRscagTpk8QhHhRmGLJKuiCs6j/Tsk0NC2ji
         NzX9w92J7U2/laWhaeSOQswWRDWxBUUG5Cs5+FheI6P6P4SHihLWqeY1WEOw87mAJmHr
         GsiBFyAW03Id8SCdeT4/pyMIpx9NRaYC6RPa+ssClg4pObzDuFJ8Fc+Ta8MFGrYQ1Hpf
         81bjm4OS50whrx4+iXXdQYbG/KAZB0IsDJUeNJBXy6H6KuwZtictFRLG7MOeVLEwd+lk
         UkMA==
X-Gm-Message-State: AA+aEWbY1UJOzxW3cy56MVW8MDu+6R5cf+mlxpPUql0RkJBHlMtFU2Dz
        ck9X4Ptp6FqyBd0He//kGxw=
X-Google-Smtp-Source: AFSGD/W/dOPmNg4wB4x8yQRbTLyr2I/+T9IFEHfGYRo7iKWygXZxk0iTEDUuPXb5OOz4Bo5Teea2rQ==
X-Received: by 2002:a5d:6450:: with SMTP id d16mr16639514wrw.64.1544604831203;
        Wed, 12 Dec 2018 00:53:51 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:7888:b13c:bff:87b0? ([2601:647:4800:973f:7888:b13c:bff:87b0])
        by smtp.gmail.com with ESMTPSA id t76sm2924149wme.33.2018.12.12.00.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 00:53:50 -0800 (PST)
Subject: Re: [PATCH RFC 0/4] restore polling to nvme-rdma
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Keith Busch <keith.busch@intel.com>
References: <20181211233652.9705-1-sagi@grimberg.me>
 <20181212070756.GC28461@lst.de>
 <937fc9db-1248-fcad-1b59-627c4b44ef16@grimberg.me>
 <20181212080945.GA29679@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5f34c9df-b0be-102a-eabe-7b4613b0c9c0@grimberg.me>
Date:   Wed, 12 Dec 2018 00:53:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181212080945.GA29679@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> I found it cumbersome so I didn't really consider it...
>> Isn't it a bit awkward? we will need to implement polled connect
>> locally in nvme-rdma (because fabrics doesn't know anything about
>> queues, hctx or polling).
> 
> Well, it should just be a little blk_poll loop, right?

Not so much about the poll loop, but the fact that we will need
to check if we need to poll for this special case every time in
.queue_rq and its somewhat annoying...

>> I'm open to looking at it if you think that this is better. Note that if
>> we had the CQ in our hands, we would do exactly what we did here
>> effectively: use interrupt for the connect and then simply not
>> re-arm it again and poll... Should we poll the connect just because
>> we are behind the CQ API?
> 
> I'm just worried that the switch between the different context looks
> like a way to easy way to shoot yourself in the foot, so if we can
> avoid exposing that it would make for a harder to abuse API.

Well, it would have been 100% safe if we could undo a cq re-arm that we
did in the past...

The code is documented that the caller must make sure that there is no
inflight I/O during the invocation of the routine..

We could be creative if we really want to make it 100% safe for inflight
I/O (although no one should ever need to use that). We can flush the
current cq context (work/irq), switch to polling context, then create a
single entry QP attached to this CQ and drain it :)
That would make it safe but its brain-dead...

Anyway, if people think its really a bad idea we'll go ahead and
poll the nvmf connect...
