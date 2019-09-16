Return-Path: <SRS0=sa6N=XL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC54C49ED7
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 16:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD91F21852
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 16:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PdGG8+M6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732016AbfIPQwj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Sep 2019 12:52:39 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:45189 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729084AbfIPQwj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Sep 2019 12:52:39 -0400
Received: by mail-pl1-f172.google.com with SMTP id x3so131642plr.12
        for <linux-block@vger.kernel.org>; Mon, 16 Sep 2019 09:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mafOmfUjFV3O7Ul/Un1dHRGe62gU1AXzGq1aE/zr7+g=;
        b=PdGG8+M6evNNuGiNOLut3OfoX6EaOSQTLzB0zq6KWfmfOiNvtOqFv0Dhzo9JnIpz3h
         60lDa3N3AQC+aLma8k568u0aenrA8m+cYQRHZrpvS1wBSA3n1B5U1zcjRK7jTvVb0VdJ
         gRB/j+8qSKas4mOwQrfZPJUV7Drf5/RdSAVy1DABfTM3zVElVmAD7jtCG01HY2HT/7+L
         wGCv1eP1rIVD5rd3otYPoIG0TetNGk895r1EKDUIRHM3L2yxdSVIzxoFDYJfEvOEE6v4
         i1uqUQe2ODiIKus+VkW3nTDGOO3geyAKMNSMQqaxulgsjPi+0DGOxNVomn2vAcCL139u
         81dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mafOmfUjFV3O7Ul/Un1dHRGe62gU1AXzGq1aE/zr7+g=;
        b=ZXGf48xFu8eJd1cC3CwQaJ9cbQyvrO9UGkRyCAkvMu/0Br4eqCtEhjBMTbuZoM7fNt
         5N2VL/IbVwlFrEF1jFMIqw4jeJYgL39nQjfLwG+T9PUk9tRgqxFFNhHBqvUzum2yG22l
         Wi+t7/j/UgyNxPS5Lj04BgS+uMmchXteHNBmmy+aXPDszmPIN1NV1OAAMq2UkiblOxIF
         n7vK73HrzA+LgqcvNdeFM+vka8rF8jI/18g+4fckNpAnCBnKLwHHCg5mJXoFiFFDxaiX
         OhaB5ql0/NUeZRfk+9kS+hi5QEpKID59FIwgP7jxdpb+T5aqMe2Gll4g/q/GtBCFZGld
         aLDQ==
X-Gm-Message-State: APjAAAXgTvwa9BPPjrzZ53vh186ZPZlL5yFIoTlGKDteU30cHjyfb6DB
        WIRX9sl1Z6TRFDVCphaA9U7enAdeN6pY9A==
X-Google-Smtp-Source: APXvYqyYg3fFRtVZZAz0CA8BCv6BzdNux11yToJP0h2s+jKEaxXM9bnSw57pGcfHJrdyUZWIAMj7ZA==
X-Received: by 2002:a17:902:a98a:: with SMTP id bh10mr715335plb.343.1568652755744;
        Mon, 16 Sep 2019 09:52:35 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:c484:c1a1:f495:ecae? ([2605:e000:100e:83a1:c484:c1a1:f495:ecae])
        by smtp.gmail.com with ESMTPSA id l72sm100442pjb.7.2019.09.16.09.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 09:52:34 -0700 (PDT)
Subject: Re: [PATCHv2 0/2] blk-mq: Avoid memory reclaim when allocating
 request map
To:     Christoph Hellwig <hch@infradead.org>, xiubli@redhat.com
Cc:     josef@toxicpanda.com, mchristi@redhat.com,
        linux-block@vger.kernel.org
References: <20190916021631.4327-1-xiubli@redhat.com>
 <20190916090606.GA13266@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8c08e9f8-cf71-8fcc-cff3-0d92dd859a59@kernel.dk>
Date:   Mon, 16 Sep 2019 10:52:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916090606.GA13266@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/16/19 3:06 AM, Christoph Hellwig wrote:
> On Mon, Sep 16, 2019 at 07:46:29AM +0530, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> To make the patch more readable and cleaner I just split them into 2
>> small ones to address the issue from @Ming Lei, thanks very much.
> 
> I'd be much happier to just see memalloc_noio_save +
> memalloc_noio_restore calls in the right places over sprinkling even
> more magic GFP_NOIO arguments.

Ugh, I always thought those were kind of lame and band aiding around
places where people are too lazy to fix the path to the gfp args.
Or maybe areas where it's just feasible.

This is not one of those.

-- 
Jens Axboe

