Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD905C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 22:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F48A2145D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 22:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ni+3glFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F48A2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725749AbeLAJQt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:16:49 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36524 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLAJQt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Dec 2018 04:16:49 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so730021itj.1
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 14:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0oD5VX8izmnxCXdCr+bseRZWcJTv4RGRoQ0NR4979As=;
        b=Ni+3glFuLRXe9yDP+0UZwyfbAaKa62l0oZSHn7o4WYJk0iIfh9hdJ1KzJ6PPFNzmPz
         UDIS6RaVOEf2swkzXSo9tEFat+Ziuc6xVL+yBw6erJO6MortwwO22W2zjPsRlX+FlZtX
         2gdzFJllE03d/Ua9il2gTSWhWs2WuxAyY8NAMS5pr+DcWI/Oq5PAqFt4CE2jqzswYMmA
         dS3bdxXoeIZGDubV0vAMb50x5DfPMsnZbSJvHeN+SK3fdTnT6sPqUPwDGwWEQjsZMAjG
         6VfQ5Z9EyQHHQYyj1+qjCxiEp4EOlED2LxA9jgetOiUu6x5+zrNuqKxBdWPP/SKY4lu1
         6hIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0oD5VX8izmnxCXdCr+bseRZWcJTv4RGRoQ0NR4979As=;
        b=lgSF3CRiKTVAyM/gr/SOoCxYueU+dgZAfcdmoX6iO14cHNdE6puLSpCKflRaHh9BBa
         ANdkNIvqUfxck9qXr+f3QcUo7NKfCDmIpk9jG4CuZAYftmoTE1szrfdEfDsDU0iy/puZ
         E4cUp2NVRLkB67wjdnd1k3o97oydfxeFlBxPlCJ81j/kGEvUcZ8K62B+pZBKDRHci0Y+
         MtqYyRb2BpGyAY3t3VHW6G0R3tJ6x28xr3KlvT4ZGN2GS0p0pzPp7LOP8nHMOW16DAnD
         SlN7YSLyXwQKSHLdtEJqbV/IxnDE9GLyk5met1OmlpezeJzBDYT04prXZFycBBmA92s/
         nU2w==
X-Gm-Message-State: AA+aEWYkPlJu2/y4Qk4hT7E8R218GV4OHCeTXdyGk3624aZivOadDhFS
        hFF9CL+gGpAPhv2UGHuyty80nw==
X-Google-Smtp-Source: AFSGD/V1ci6KAOkH6ZjPSk7YN7wOEMJY3HOOBEs1LsAuHLzwjNxZ7f/xpe0341Ig7AGlzzsDsCs8YA==
X-Received: by 2002:a24:d583:: with SMTP id a125mr490782itg.172.1543615564103;
        Fri, 30 Nov 2018 14:06:04 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f5sm2663872ion.10.2018.11.30.14.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 14:06:03 -0800 (PST)
Subject: Re: [PATCH 24/27] block: implement bio helper to add iter kvec pages
 to bio
From:   Jens Axboe <axboe@kernel.dk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de
References: <20181130165646.27341-1-axboe@kernel.dk>
 <20181130165646.27341-25-axboe@kernel.dk>
 <20181130192102.GP2217@ZenIV.linux.org.uk>
 <6e42d763-9c94-6b84-7099-f5ef5964404c@kernel.dk>
 <1545b364-df01-51e7-1786-56dde7c49b5d@kernel.dk>
 <20181130211117.GQ2217@ZenIV.linux.org.uk>
 <07803d69-84cc-bb39-686f-2f50874ea184@kernel.dk>
 <20181130212503.GS2217@ZenIV.linux.org.uk>
 <1de11537-56c0-a9d1-60da-68c5b3e431ce@kernel.dk>
Message-ID: <fa952128-f96a-4188-d7e5-2f4783974b1a@kernel.dk>
Date:   Fri, 30 Nov 2018 15:06:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1de11537-56c0-a9d1-60da-68c5b3e431ce@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/18 2:34 PM, Jens Axboe wrote:
> On 11/30/18 2:25 PM, Al Viro wrote:
>> On Fri, Nov 30, 2018 at 02:16:38PM -0700, Jens Axboe wrote:
>>>>> Would this make you happy:
>>>>>
>>>>> if (!is_vmalloc_addr(kv->iov_base))
>>>>>         page = virt_to_page(kv->iov_base);
>>>>> else
>>>>>         page = vmalloc_to_page(kv->iov_base);
>>>>
>>>> Free advice: don't ever let Linus see anything along those lines.  Results
>>>> tend to be colourful...
>>>
>>> We already have those lines in the kernel, XFS for instance. Al, could you
>>> please try to be helpful instead of being deliberately obtuse?
>>
>> Again, the last time something like that had been suggested, Linus had replied
>> with a very impressive rant.  I *did* propose pretty much that, and reaction
>> was basically "hell no, not in general-purpose primitives".  Precisely about
>> iov_iter stuff.  A part of that was due to touching page refcounts, but quite
>> a bit wasn't.
> 
> Nobody is touching the page count here, and for the aio user mapped IO,
> nobody is touching them at the end either.
> 
> As far as I can tell, the above is fine. It's either a vmalloc'ed
> address and should be treated specially, or we can do virt_to_page() on
> it.
> 
> Do you have a link to said rant?

I found the rant. I think the solution here is to switch it to using
ITER_BVEC instead. With ITER_KVEC, we don't necessarily know if we can
map it, for bvec we already have the pages. And from the aio point of
view, we know the pages are sane.

-- 
Jens Axboe

