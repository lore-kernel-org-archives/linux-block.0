Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB61C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 15:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1254C2081B
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 15:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="y1TR7aZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1254C2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeK2CWS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:22:18 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45140 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeK2CWS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 21:22:18 -0500
Received: by mail-io1-f67.google.com with SMTP id w7so20233616iom.12
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 07:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9IzR2ZPEDUqsYaGzu0x0pAPCd33jktjjRbWgRXhob6E=;
        b=y1TR7aZ4ys2rX34XYpNIj3fLEdnNSU8hHklJxqTZmWUSjRmKch50VgjcRZ8Gk6OPrU
         PzufldLI4Ibf9/QXmqfYMIu/lyXWs5xL6kFhqShbprY2sqkRSGtYv4OSeSdZuo+fhWRZ
         Iegljg+jBD4cT4k1GX/pb0e3feC3skSuM0SB5PS7bWDY3Vt4zNX+ies0+R5Rp5KToqfQ
         tHUkYIOOZxLWman91U/QkRxqAqRg+CSV+e/pnBxGfwn0rfVLlXqjZ6Q0jN3Ot3Wcb3j8
         SuM3Zxgpi2wSvoPv9ZhVSI71opMN/bfvQ/8U/l9sALspKqMupkEcdIIWQQ2LJIE1pQ9I
         AuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9IzR2ZPEDUqsYaGzu0x0pAPCd33jktjjRbWgRXhob6E=;
        b=kTROoO9qHVUSSPuXdfBXLM8EyA5RukswRW+zcc9AYMz6//Kecvi7Wt0+6dINkT7ndu
         X8x0HKI7nxGAMFY/77D7NZn2PQhBlqcFWwpq/kCVSq7EsW9+PaSUfZsSPChhzpfIY3Ih
         f0sBEDzP1N1xnWFYWUNELH8soXgziEvGinvZspjWGUvd4zWXaVoG0yiLGm8m0S+DwL2p
         Yo+Uk9xiZHevfr0B+kpkDJxnUcul68GYIDFL6QYQz311+kiV0RBg0kdVgWtP/6HPuNoE
         PyAXkLH+N5ue6P5QoMw5j2Qvriy62no82WlALr+AbHoQ4R/odhw9EgcVBnpu5ii5lxGI
         fZKg==
X-Gm-Message-State: AA+aEWbOev5DpzJ/7sRtBwxEyIfKOdLEbxTR5Hi632ksOzVENaHVhfmG
        PXx1UsedyQhWto7BFkc+YxUJugb1on8=
X-Google-Smtp-Source: AFSGD/VQYLOj/Ru8ah2/lDN5fqD6PcMkLWTtgjQuGetao9a3tqTRbmLFUQ2Do8qD0VfyKpC5VFMA/g==
X-Received: by 2002:a6b:6e07:: with SMTP id d7mr27148745ioh.8.1543418416977;
        Wed, 28 Nov 2018 07:20:16 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u127-v6sm1321546ita.10.2018.11.28.07.20.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 07:20:15 -0800 (PST)
Subject: Re: [RFC PATCH v2] block: add io timeout to sysfs
To:     Weiping Zhang <zwp10758@gmail.com>, linux-block@vger.kernel.org
References: <20181119141145.GA25638@192.168.3.9>
 <CAA70yB6DedBE=yrbQD5qUdPL2HBtRHg9TejcywGMqeuAcqGM6Q@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ae7c1cc8-cd0b-1aff-6388-4ada80418350@kernel.dk>
Date:   Wed, 28 Nov 2018 08:20:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAA70yB6DedBE=yrbQD5qUdPL2HBtRHg9TejcywGMqeuAcqGM6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/28/18 7:52 AM, Weiping Zhang wrote:
> Hi Jens,
> 
> It's useful if user want a short timeout when a disk doesn't work normally.
> Would you give some comments for this patch,

I'm fine with the patch, in fact I've posted a similar/identical one in
the past but just never got around to merging it. I think we should
expose the value in seconds or msecs, however, not in jiffies. That
makes it hard to use for people.

So modify it to do a msecs_to_jiffies() on the value passed in.

-- 
Jens Axboe

