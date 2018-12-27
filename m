Return-Path: <SRS0=Cd4S=PE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A89C43387
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 20:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781A5214C6
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 20:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gPfLQMqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbeL0U30 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Dec 2018 15:29:26 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44909 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729796AbeL0U30 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Dec 2018 15:29:26 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so9532936pfh.11
        for <linux-block@vger.kernel.org>; Thu, 27 Dec 2018 12:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hSUw7gL1uFDodwEgGYdttlWHU8QDAzZ1TyXePKNqo0c=;
        b=gPfLQMqIoNk7CEfJa4XPcW4tP/Ne8O1zbgoUmCUmvwyc6Kx4hSWqHkuyfIQuYonrs7
         Px/+ziz6/yJnRRFgcGouEWBplkLXCfngq4Ng9Qhp/mmN/0/nt1ObAUECgECgbpawgUyg
         YN9vUmRNtIrpEbibooEzJpdBy0ysI9yJRS1RvBY5bMx0U3q1wu4dsYJppcOtdlorl7Xr
         fG/0cFyRXxFqxe3YCuowFzQbgAzLtV95zwYBv/i0MKcx0eCo73/X09cJGI1434NjZthz
         aTbfJTHtQGLdY70sU2SCjyg7Quu9zi3oOhzzEaqGvDQvkEEhncpZZWyP0pJlD0NIOTuV
         dZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hSUw7gL1uFDodwEgGYdttlWHU8QDAzZ1TyXePKNqo0c=;
        b=aRrQKka5cRZ/ERcPEbpNg75UlmmmI81Adzs4dqdMa583MpTDusnxzkWvM9MOo302T5
         CyZkzS9tsk3ZD2gHuk3PhmuddhjTxRLw+XUi6+T5l4AvgjeB4HFNZ6UOz7CrAy3+Fzba
         odIi8FW1nDp/ZBW2zXVp+TvP26vFozZ/TOTSKyDEEjWdu0JNUF6+03LWfybwMpbzivfA
         BeFIsFBOE7YYpoCDeRVbOj9ghxq2OKWC3iCBC4wS4Yutgjh3flOMJBICZo6B85j2Zdck
         vZW/TCMmZ/0cxU649uU9QI+D+waduyO1bTQ3pLxhIfhG+ANN4P5w5xpTypEsJRugeb07
         uRwg==
X-Gm-Message-State: AJcUukcxvFVMqOWnW98PGRI/oQOwz3OXflOJr/VKtCa0Rw97xsJsY8lf
        89ujdRpXqUB5YTyGUd6NrSa5Rw==
X-Google-Smtp-Source: ALg8bN5diLTaQJlAARj/enUFTmOTKLRNse1XrWdZsqvq6KAMMW2Mywr4iMK+Lh5ZuT7JWZCDgBpdwA==
X-Received: by 2002:a63:7a09:: with SMTP id v9mr23968792pgc.112.1545942565612;
        Thu, 27 Dec 2018 12:29:25 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id f6sm56268993pfg.188.2018.12.27.12.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 12:29:24 -0800 (PST)
Subject: Re: [PATCH 08/22] aio: support for IO polling
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, hch@lst.de, viro@zeniv.linux.org.uk
References: <20181221192236.12866-1-axboe@kernel.dk>
 <20181221192236.12866-9-axboe@kernel.dk>
 <20181227135552.GB25525@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fb722cb0-c223-8878-7fe6-0e1c1993e750@kernel.dk>
Date:   Thu, 27 Dec 2018 13:29:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181227135552.GB25525@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/27/18 6:55 AM, Christoph Hellwig wrote:
>> diff --git a/include/uapi/linux/aio_abi.h b/include/uapi/linux/aio_abi.h
>> index 8387e0af0f76..a6829bae9ada 100644
>> --- a/include/uapi/linux/aio_abi.h
>> +++ b/include/uapi/linux/aio_abi.h
>> @@ -52,9 +52,11 @@ enum {
>>   *                   is valid.
>>   * IOCB_FLAG_IOPRIO - Set if the "aio_reqprio" member of the "struct iocb"
>>   *                    is valid.
>> + * IOCB_FLAG_HIPRI - Use IO completion polling
>>   */
>>  #define IOCB_FLAG_RESFD		(1 << 0)
>>  #define IOCB_FLAG_IOPRIO	(1 << 1)
>> +#define IOCB_FLAG_HIPRI		(1 << 2)
> 
> NAK for this hunk.  We already have a hipri-flag on the command,
> which we have to force on, and we have another one on the context.

So what do you prefer? The polling tied to the ioctx, and not have
userspace set it? As I said previously, I don't really care, but I
obviously lean towards having this be explicit in the app. If you
feel strongly about it, I'm fine with dropping IOCB_FLAG_HIPRI and
the polling being implied by the io context it's submitted against.

-- 
Jens Axboe

