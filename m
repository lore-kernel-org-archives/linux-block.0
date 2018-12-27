Return-Path: <SRS0=Cd4S=PE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5B3C43387
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 20:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F6421741
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 20:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RwHiJJkb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbeL0Ubs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Dec 2018 15:31:48 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34194 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729817AbeL0Ubs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Dec 2018 15:31:48 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so9558930pfg.1
        for <linux-block@vger.kernel.org>; Thu, 27 Dec 2018 12:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ddrF0glPGFUqP3hdn3AnpwdQGteTd5PF49cqNEIi1rA=;
        b=RwHiJJkbZUM/acEjgsI1eWXgcJWluV1SL0Tm6COA0kIdHFTbujfEkp5QiAO/dh2Ghr
         5lDC/9vE1/pSXfXWFHd2CCSJec1DNCU/n6Sgz35+gLck+4t6J2iIsEmfqVII3EZoy4c1
         YxMFPXH/SsHfW07DOpWJF/BBC5OHfMO10OjmGfnx7nVz/M1YNfYIIgjgtimB+t97YhWM
         qKZ0RLY3jWach/SdufJijcrtHngCl5d3ygzGrpTgtjFMjBcJ6fFt5MvAyy6X30YMe7MT
         NS4wzyFrC/jsYTDDMl1br9n0sZtXgXoOeZLiuXQtnJzLthiy7ZvPdCQDskrz5qK37Hbm
         9kjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ddrF0glPGFUqP3hdn3AnpwdQGteTd5PF49cqNEIi1rA=;
        b=ZxLE2+WDf1hsDhfsny1gTujascDflMlcVhFkg8xEQVaDIQ2Z7HSpAUFZyNjBQyyxSb
         TLnzQFj4WjlwP1vGRs8OeB/dhXeJqgVAvUbumZgq15MsmuuBWMucTeRxo/BA/FRCN2SN
         PqCE3SFXXfBdZ8ov5hsgczOTofN2pabX9g5b7qtZytCHA/ZEHky1808EcUS1G8iSg++6
         DjGqv5pd0qqroJnv6Kb0z/XB/c6mjbLc0FZxMxORfo6J3WugQr6pPGhyKjceH8Th8jBQ
         0pZ38KyX1ifRo6Pf8seNXl+ekieyaprKiF5b7oShVGhJX7F7p2g7G0Dupvvo+qZJ/WaP
         hUlA==
X-Gm-Message-State: AJcUukcD6rGnsT0E0KWYqMavtxc+xMj3Je45KayNBrNRBtb6DBRYie5p
        gUXbvG89UtodbdDlEXhHKXcDmQ==
X-Google-Smtp-Source: ALg8bN6LV+KfCOcr/LYkcRgvSgpV6MKgXt0TJKwEJ3BeavnLDcZaV4ZjCaovXk2z63knggpaEMiS4g==
X-Received: by 2002:a65:60c2:: with SMTP id r2mr24164579pgv.393.1545942707193;
        Thu, 27 Dec 2018 12:31:47 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id g70sm65024806pfg.98.2018.12.27.12.31.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 12:31:46 -0800 (PST)
Subject: Re: [PATCH 09/22] aio: add submission side request cache
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, hch@lst.de, viro@zeniv.linux.org.uk
References: <20181221192236.12866-1-axboe@kernel.dk>
 <20181221192236.12866-10-axboe@kernel.dk>
 <20181227135656.GC25525@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b930953e-0df3-5c85-bf5b-dd642339e50c@kernel.dk>
Date:   Thu, 27 Dec 2018 13:31:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181227135656.GC25525@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/27/18 6:56 AM, Christoph Hellwig wrote:
>> +/*
>> + * After the iocb has been issued, it's safe to be found on the poll list.
>> + * Adding the kiocb to the list AFTER submission ensures that we don't
>> + * find it from a io_getevents() thread before the issuer is done accessing
>> + * the kiocb cookie.
>> + */
>> +static void aio_iopoll_iocb_issued(struct aio_submit_state *state,
>> +				   struct aio_kiocb *kiocb)
>> +{
>> +	if (!state || !IS_ENABLED(CONFIG_BLOCK))
>> +		aio_iopoll_iocb_add_list(kiocb);
> 
> This still looks odd to me.  Why would be make a batch or not batch
> decision based on CONFIG_BLOCK availability?  Either batching is safe
> for all ops, in which case we should always enabled it, or it only makes
> sense for block devices / block backed filesystem in which case we need
> a per-operation check.

It is safe for any device, but ideally we want the schedule flush to
be enabled to not sit on requests if we block.

The alternative is to make the plug cb handling available with
!CONFIG_BLOCK and not need these checks.

-- 
Jens Axboe

