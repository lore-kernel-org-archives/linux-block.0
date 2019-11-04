Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEECCA9EC9
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 22:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF728214B2
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 22:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XA8chn2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbfKDWzq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:55:46 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37817 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729122AbfKDWzq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Nov 2019 17:55:46 -0500
Received: by mail-pf1-f194.google.com with SMTP id p24so7099507pfn.4
        for <linux-block@vger.kernel.org>; Mon, 04 Nov 2019 14:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bKroX2Oqfu9YpajlfJGWEgz50qMCuQXoKuLPSDMXuOw=;
        b=XA8chn2sgkYc6h3ctprz9LAnU8TC1bZOdocaqrIfaw0qn6Lxd5zsTQmsZC/35I5uQ2
         P5G7tgNslez7OhfXSHn6lHz0Qu6bWd+wf+pT2j5Q6pvEiRzkvUEIXl36OM5r+ubkUoda
         93EwiZeczgXB2ZDWGztzaLPic0Ae3aaZN2CRaodUyDmogFWLa5hmReal9UpIn7KnhW3c
         lWLFcEqK3jhXAUx+jQ0yE2xSHSnf6zMgUWMODdcnxAsxCzSeUW3SdEFd99CbUxcBdWzj
         ewJtdwZKdBJ1AUFjB2Ns3NnS/Fk53Y3QHXs4TuTHz8aL5g3lA2Y4q3zOczCWKfsF16lC
         wABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bKroX2Oqfu9YpajlfJGWEgz50qMCuQXoKuLPSDMXuOw=;
        b=m3BaI/KRPcPIFcoYkgri1LBSLggCPiVlRay32G31BgIr6Cf6MpCXfMsHoMe3ETzkmO
         TfardiaYRTTDDV/Ecb3SdvJAt7VGboyDjowoqFyGDLjGi8RvNnPqT+o9rqV9esWbj+0l
         6Gwd9F+HF4yoNzgXohyac41mQlGZXt5gMQs1bSOEWIv1n5MAAmPlrWSJn5Kc8jHIQc3t
         jNOftULLKp7NuSiXvQfLqJA/DXOCOTS5hZuCKuFT+BfBgCB22YOq0i1mePnaVAz85c05
         yiTBqcEaTsgw1vMm+bhhGw57qp+V1nk3qHnQkky2CG/2X3U5fi6wE+Igh0a/0vl17uWr
         CBIQ==
X-Gm-Message-State: APjAAAXZHdrqe2yAcgGqQlD18PqKEalBRlHWONmzVyul265fXPk0d0oy
        hXDfg8ewKfshHoYZvtudgwS/PgAqKHB2xg==
X-Google-Smtp-Source: APXvYqx6/ZFNlV5IUnp8Cr6rjEHmh5PXFQFM0tNZmQDpGxwKtg2kN674BWGgBKCE2xqjovXTHbTSfQ==
X-Received: by 2002:a62:e214:: with SMTP id a20mr18555276pfi.193.1572908144666;
        Mon, 04 Nov 2019 14:55:44 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id s202sm19090183pfs.24.2019.11.04.14.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 14:55:43 -0800 (PST)
Subject: Re: [PATCH] block: avoid blk_bio_segment_split for small I/O
 operations
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, ming.lei@redhat.com,
        linux-block@vger.kernel.org
References: <20191104180543.23123-1-hch@lst.de>
 <20191104193002.GA21075@redsun51.ssa.fujisawa.hgst.com>
 <f1050949-31b1-a9cf-02d6-00c94f505290@kernel.dk>
 <20191104225036.GA21282@redsun51.ssa.fujisawa.hgst.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2822bfe1-5d9d-ec87-9607-36617e528985@kernel.dk>
Date:   Mon, 4 Nov 2019 15:55:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104225036.GA21282@redsun51.ssa.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/19 3:50 PM, Keith Busch wrote:
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

Gotcha

>> And if they do, do they align on non-4k?
> 
> All existing ones I'm aware of are 128k, so 4k aligned, but if the LBA
> format is 512B, you could start a 4k IO at a 126k offset to straddle the
> boundary. Hm, maybe we don't care about the split penalty in that case
> since unaligned access is already going to be slower for other reasons ...

Yeah, not sure that's a huge concern for that particular case. If you
think it's a real world issue, it should be possible to set aside a
queue bit for this and always have them hit the slower split path.

-- 
Jens Axboe

