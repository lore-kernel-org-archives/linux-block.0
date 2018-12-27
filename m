Return-Path: <SRS0=Cd4S=PE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E620CC43387
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 20:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAAE921741
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 20:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YRrO3t5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbeL0Ueu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Dec 2018 15:34:50 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34829 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729867AbeL0Uet (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Dec 2018 15:34:49 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so9189477pgs.2
        for <linux-block@vger.kernel.org>; Thu, 27 Dec 2018 12:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DbmXm2+UYTLE/sM4gbM3yhpOgDyP8hE9QQ0YcBCEj2Q=;
        b=YRrO3t5BNpQLjSiGh0cy+d6OROpMGdDISskqJ0cIyLoIMOJ0wRWkONrdsTfoAbHlsI
         vDPLefniPt5VsdZxOv+eMxfZtOtiFl+qs1WxoAyTMCPcifFV1KjFhiJU+E3pnmB3aaFw
         OSGmfPWaI8AOTVj9GA+MPdrw3KNJessdWQG4se/F65fhj7DKP6dzo+FM2sqx2rQ9XJBx
         wPRBZf1m0Qwgfuimfs31NBT3d5mnRBfpT2gAY5NTzQQoweVpwGQF70JKQ354EC6qFTka
         WGFXs5VUJ3sejvxg6yUC0MhnGCd96Y7EunjPkiwsx4XByU6zkNIvW6xR3A8LR3N5wO4M
         nyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DbmXm2+UYTLE/sM4gbM3yhpOgDyP8hE9QQ0YcBCEj2Q=;
        b=rJhllpp9fn7M+5+N61NJoNfkG+Sp5foLCX5s3U2BWTYdCzyImfv6YoH7svLiXqxvt9
         6pUNAXPsu2rCu4hs/wqZgPpYLLn9H3fl/PcO+qJQtetxzy+5KpCNbkxpx41yl/tAwOMR
         X51GvL2yfdGFm70SITyajsk0dkry+GoAyjZpKEhN2vr/HG6Uh/rrLjZLSGbmFFIBI4Q0
         GoJkUgQJf5rFh4ns9yzOfNV78BJHkBS/kzFIihlkCvf0GO+SIKgG1tlUiKcbLciwDukd
         e0+TYHGRkByqNMdGN7NHpVTQWTCXWeUI5BDVrTeEotiSRCQrz8/gpVQJE0zx7UY0gM8C
         WE6w==
X-Gm-Message-State: AA+aEWZ/eG/aZe6YKqFYaLAZIRJLSNMK07NeiOmnNqiFIOVQRJi9QXDF
        UTxmf0hrDwEWLuhQ6ScrihqRVw==
X-Google-Smtp-Source: AFSGD/WD+NQt1xG0DLf0+ukmxPyLCxUo7stN1rRgSiKUShLH95To4daZdYgRpiWsMakCQQG0Yr4zWw==
X-Received: by 2002:a62:c42:: with SMTP id u63mr25010103pfi.73.1545942888853;
        Thu, 27 Dec 2018 12:34:48 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 84sm77179881pfk.134.2018.12.27.12.34.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 12:34:47 -0800 (PST)
Subject: Re: [PATCH 19/22] aio: support kernel side submission for aio with
 SCQRING
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, hch@lst.de, viro@zeniv.linux.org.uk
References: <20181221192236.12866-1-axboe@kernel.dk>
 <20181221192236.12866-20-axboe@kernel.dk>
 <20181227135753.GE25525@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <48838356-101d-d1f6-9b84-9d5a502dd5b7@kernel.dk>
Date:   Thu, 27 Dec 2018 13:34:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181227135753.GE25525@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/27/18 6:57 AM, Christoph Hellwig wrote:
> On Fri, Dec 21, 2018 at 12:22:33PM -0700, Jens Axboe wrote:
>> If an application sets IOCTX_FLAG_SCQTHREAD, the io_context gets a
>> single thread backing. If used with buffered IO, this will limit
>> the device queue depth to 1, but it will be async, IOs will simply
>> be serialized.
>>
>> Or an application can set IOCTX_FLAG_SQWQ, in which case the io_context
>> gets a work queue backing. The concurrency level is the mininum of
>> twice the available CPUs, or the queue depth specific for the context.
>> For this mode, we attempt to do buffered reads inline, in case they are
>> cached. So we should only punt to a workqueue, if we would have to block
>> to get our data.
> 
> I'm really worried about having this code present twice.  Do we have
> strong use cases for both?  Can't we emulate IOCTX_FLAG_SCQTHREAD good
> enough with a workqueue without concurrency management?

A work item is not a good fit for this. If we want the polled
submission, which I think is pretty nifty, then you need a higher
context than a wq item that comes and goes.

-- 
Jens Axboe

