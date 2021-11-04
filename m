Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68927C433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A53360F9B
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhKDSkG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 14:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhKDSkF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 14:40:05 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82912C061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 11:37:27 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id bg25so10024243oib.1
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 11:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aLUN3i8CTLf1jGD8D+iw9q7fPn6Rne6oiaQuTXFVOtQ=;
        b=pOFDfUxzcctMc86LsnnuqOXnlh1syLszGwAOWdxuuUi28MPBcUCS+iS3CtFdm2ubSX
         56ee9FQ82lcT2RUopZymmJGq+2W8D2Ffgg127N3aGzwLKVOTHbEKqN7L9px4iSBi3Ijw
         yGsuWtGNwDqhY3VUGQv0X1FtEiaNQEgqUnQVLEyq3v9UoHeKGBuNXH+O38NdqEEZk00e
         ddVtGFwFJpRcvyX630CnmyLfRylhiDZxmvUqTl9V2nNmdSP7AHWFT66Xzy8dwTTo2vFE
         VQsRYT8Ql2qBOxDwHn55trgnVo2xkGuHUfWKWHJ4cyrMDBnJxq5uZl9x2C0RHbY4wdba
         +c3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aLUN3i8CTLf1jGD8D+iw9q7fPn6Rne6oiaQuTXFVOtQ=;
        b=y9aVJSSsXHyLRVSkHl1thTimtA8axqU/EdAEbmfpj9w8uP9ENHKOry3QGoJ5uNM2M8
         CVW5Td2x6H5b4wqC5V28DTjakj/0zQP6RfYjZMjmPMtBrjOpze0RYN0xftIavBmuy7eM
         RYDgD2xMFaazZMX+l3S4f3bfLVdJfAgcOkeAJ8RHXvJ06rIyRHlORBRXIWvNYhF7eW1V
         Fgwj3dBWX+Ewg795MTWV5IgzzdumZrskLTgGqwlgdP/ERl/P5X6ZQYWMzF7C5QCCun5z
         tZkdmMIwXkQcCKzRTopDE/8B6pFsQAtvkREaYmOxpovVZQVCwcL5jAcOl29bh+g1oh0w
         e0bg==
X-Gm-Message-State: AOAM530feP4dsNHJlAWvubVh1iDT8wnG825zgFk51WhriTWDTt/C9Aha
        J0pCrvV+IMaqbc2VZpyE+hqIqDS/2+YRgQ==
X-Google-Smtp-Source: ABdhPJzOyeNY7jOwEx+OsmKNXRuR6ywpwDixVnx0CAGhw7NvRvGKG6Ee/MFU9ZZqvEY3N8iKbaz9bQ==
X-Received: by 2002:a05:6808:228b:: with SMTP id bo11mr14768076oib.153.1636051046696;
        Thu, 04 Nov 2021 11:37:26 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id bc32sm1670883oob.12.2021.11.04.11.37.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 11:37:26 -0700 (PDT)
Subject: Re: [PATCH 4/5] block: move queue enter logic into
 blk_mq_submit_bio()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211104182201.83906-1-axboe@kernel.dk>
 <20211104182201.83906-5-axboe@kernel.dk> <YYQoLzMn7+s9hxpX@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2865c289-7014-2250-0f5b-a9ed8770d0ec@kernel.dk>
Date:   Thu, 4 Nov 2021 12:37:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YYQoLzMn7+s9hxpX@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/21 12:36 PM, Christoph Hellwig wrote:
>> +static inline bool blk_mq_queue_enter(struct request_queue *q, struct bio *bio)
>> +{
>> +	if (!blk_try_enter_queue(q, false) && bio_queue_enter(bio))
>> +		return false;
>> +	return true;
>> +}
> 
> Didn't we just agree on splitting bio_queue_enter into an inline helper
> and an out of line slowpath instead?

See cover letter, and I also added to the commit message of this one. I do
think this approach is better, as bio_queue_enter() itself is just slow
path and there's no point polluting the code with 90% of what's in there.

Hence I kept it as-is.

-- 
Jens Axboe

