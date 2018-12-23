Return-Path: <SRS0=sUj2=PA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F2BC43387
	for <linux-block@archiver.kernel.org>; Sun, 23 Dec 2018 12:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7674121849
	for <linux-block@archiver.kernel.org>; Sun, 23 Dec 2018 12:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbeLWM5N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Dec 2018 07:57:13 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:51803 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbeLWM5N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Dec 2018 07:57:13 -0500
Received: by mail-wm1-f46.google.com with SMTP id b11so9272732wmj.1;
        Sun, 23 Dec 2018 04:57:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=0mZjSL5rVJFEYazbO6PanpYGXm9y36Qt//elXnmS2/Y=;
        b=L8S6KX3lSIi2zssIvjvNtFRxOxzl0g/Zg63p7qaELDe7I1nv5vqaxzhoXJmKnkAjt2
         i5/r4SI1tTR+QR6mTC1G7UXfUWwEzvqA2gpWIjGPtY5OfWAowwJoXsMC19FC8mTd//8X
         K7TRA2M138wGpjEEGqae7E0IgCO3JtLUcU42yDKhFlyJhV/RX+uPBU9nWsD/GRsz7PYA
         ZVBGR8+5NSYqWStuCLaIRAhy/jep6rFE6h8aVrSQKg4Lxq/Xv28P7LRmoMn7+sU/NXJu
         Ce1D2/+XNU6IiDiHzE2VGuUZiqeCjVaYBXgYwzdslAcey4K28bsQcsso6KvqnwqgSY84
         ICgg==
X-Gm-Message-State: AJcUukfATOEHX4EokntvkW6+Wal6ZY6zQ5fEoFF6J74Ll2oFMIE0KaQq
        Cp6HDPka74DVUHMhIL1OzXsKy/GW
X-Google-Smtp-Source: ALg8bN6epES0eI7MhIyRivM2ASYgSpHbUyUH8v6jO2t5+4Bx8bdRAMyE1HLdX8sh7hI0+9ejM1cUsg==
X-Received: by 2002:a1c:2408:: with SMTP id k8mr9000749wmk.110.1545569829837;
        Sun, 23 Dec 2018 04:57:09 -0800 (PST)
Received: from [10.0.0.5] ([207.232.55.62])
        by smtp.gmail.com with ESMTPSA id c9sm25214731wmh.27.2018.12.23.04.57.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 04:57:09 -0800 (PST)
Subject: Re: remove exofs, the T10 OSD code and block/scsi bidi support V3
To:     Christoph Hellwig <hch@lst.de>,
        Douglas Gilbert <dgilbert@interlog.com>
References: <20181111133211.13926-1-hch@lst.de>
 <4f4b6aff-6726-c500-e3e4-f8b73d641851@electrozaur.com>
 <20181219144347.GB23410@lst.de>
 <0e8b8d45-cfeb-ba9d-c92f-953cabede1ee@interlog.com>
 <20181220072656.GA10011@lst.de>
Cc:     axboe@kernel.dk, martin.petersen@oracle.com,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Boaz Harrosh <ooo@electrozaur.com>
Message-ID: <406d1a96-2a97-2e35-e52e-22525555fc09@electrozaur.com>
Date:   Sun, 23 Dec 2018 14:57:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20181220072656.GA10011@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 20/12/18 09:26, Christoph Hellwig wrote:
> On Wed, Dec 19, 2018 at 09:01:53PM -0500, Douglas Gilbert wrote:
>>>   1) reduce the size of every kernel with block layer support, and
>>>      even more for every kernel with scsi support
>>
>> By proposing the removal of bidi support from the block layer, it isn't
>> just the SCSI subsystem that will be impacted. Those NVMe documents
>> that you referred me to earlier in the year, in the command tables
>> in 1.3c and earlier you have noticed the 2 bit direction field and
>> what 11b means? Even if there aren't any bidi NVMe commands *** yet,
>> the fact that NVMe's 64 byte command format has provision for 4
>> (not 2) independent data transfers (data + meta, for each direction).
>> Surely NVMe will sooner or later take advantage of those ... a
>> command like READ GATHERED comes to mind.
> 
> NVMe on the other hand does have support for separate read and write
> buffers as in the current SCSI bidi support, as it encodes the data
> transfers in that SQE.  So IFF NVMe does bidi commands it would have
> to use a single buffer for data in/out, 

There is no such thing as "buffer" there is at first a bio, and after
virtual-to-iommu mapping a scatter-gather-list. All these are currently
governed by a struct request.
request, bio, and sgl, have a single direction, All API's expect a single
direction.

All BIDI did was to say. Lets not change any API or structure but just
use two of them at the same time.

All the wiser is the very high level user, and the very low HW driver like
iscsi. All the middlewere was never touched.

In the view of a bidi target like say an osd. It all stream looks like a single
"Buffer" on the wire, were some of it is read and some of it is written
to.

> which can be easily done

?? Did you try. It will take much more than an additional pointer sir

> in the block layer without the current bidi support that chains
> two struct request instances for data in and data out.
> 

That was the all trick of not changing a single API or structure
Just have two of the same thing, we already know how to handle

>>>   2) reduce the size of the critical struct request structure by
>>>      128 bits, thus reducing the memory used by every blk-mq driver
>>>      significantly, never mind the cache effects
>>
>> Hmm, one pointer (that is null in the non-bidi case) should be enough,
>> that's 64 or 32 bits.
> 
> Due to the way we use request chaining we need two fields at the
> moment.  ->special and ->next_rq.  

No! ->special is nothing to do with bidi. ->special is a field to be
used by LLD's only and are not to be touched by block layer or transports
or high level users.
 
Request has the single ->next_rq for bidi. And could be eliminated by
sharing space with the elevator info. Do you want a patch?

(So in effect it can be taking 0 bytes, and yes a little bit of code)

> If we'd refactor the whole thing
> for the basically non-existent user we could indeed probably get it
> down to a single pointer. 
> 
>> While on the subject of bidi, the order of transfers: is the data-out
>> (to the target) always before the data-in or is it the target device
>> that decides (depending on the semantics of the command) who is first?
> 
> The way I read SAM data needs to be transferred to the device for
> processing first, then the processing occurs and then it is transferred
> out, so the order seems fixed.
> 

Not sure what is the "SAM" above. But most of the BIDI commands I know,
osd and otherwise, the order is command specific, and many times it is
done in parallel.
Read some bits than write some bits, rinse and repeat ...

(You see in scsi the all OUT buffer is part of the actual CDB, so in effect
 any READ is a BIDI. The novelty here is the variable sizes and the SW stack
 memory targets for the different operations)

>>
>> Doug Gilbert
>>
>>  *** there could already be vendor specific bidi NVMe commands out
>>     there (ditto for SCSI)
> 
> For NVMe they'd need to transfer data in and out in the same buffer
> to sort work, and even then only if we don't happen to be bounce
> buffering using swiotlb, or using a network transport.  Similarly for
> SCSI only iSCSI at the moment supports bidi CDBs, so we could have
> applications using vendor specific bidi commands on iSCSI, which
> is exactly what we're trying to find out, but it is a bit of a very
> niche use case.
> 

Again bidi works NOW. Did not yet see the big gain, of throwing it
out.

Jai Maa
Boaz

