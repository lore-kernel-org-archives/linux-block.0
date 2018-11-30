Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754D3C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 17:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5BC20834
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 17:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YkY73Qbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5BC20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbeLAES1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:18:27 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:34836 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeLAES1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:18:27 -0500
Received: by mail-it1-f195.google.com with SMTP id p197so10315546itp.0
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 09:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kUdwve3dUdMPV5/43T6NYnH/S0iz3bA9+GatIT7DvJI=;
        b=YkY73Qbs1X+eGGkJ5lsyY4HvB+zBmlWJtqvNjGuJK2TxZ5skvNko6ftfr+7lCOlz1w
         PotUDSANf5AVNIDxoAT/LxDXGIWLz7fx8hYqtJC3oDYTBBKjWfMVsmxFKWOMAMhC9Iu3
         YkZRtr2vWL8zciOFpCa8ldkvI3xQgCbPw6Cvmx4Nvp9eUBPbnThEybPTydKQnm/PzyDS
         rj+gbZqk+PwM6bsXyqBvcvknmLsEX6jSlUmWUya8UzcJ5StxPOJYzB5AkGKr2L/uPf/E
         1IkxPtOi9Uc+2OKFXwuQUCQzImAvpyYQ4pNCr7Ttzfc1XJQ3AuWkkkPqniWyMnRiwVVC
         LstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kUdwve3dUdMPV5/43T6NYnH/S0iz3bA9+GatIT7DvJI=;
        b=MXXl+gM0jzIeG0G0WL5Bp6krF6Dsq5fvvwCISXuCPDqyBO551txkCORKhs/QCkxDbQ
         A8eKUOSTFdp0lDDzVHK+XMyO/9nF3HbW3hUrHYrBfWc0672r8Djc5SMSFdLnuKZKsAep
         j+736GGVGlIbLwi4cToU1StTAblBGJe6nTYymNc2Vxo3+JQF4/6QuNDuryus7KDQ0VH3
         DW0KVz8fTFWZBjUvG9G+JAQniVjtWgKXmfIOfU9f2P661vfA74PV+fcaGgfAGrSpEn/7
         RGqw1cXDTAWHZ5RWeBeKrwJm+mESwWvNvv/ELHAjsa4nUGSci0EnTpBtTHaIm4Hbw6Bz
         RZMA==
X-Gm-Message-State: AA+aEWa6QpRRaNFNb6fompvgVyYeLrOR8/63p72LyoGJQvh1qasT1FhK
        PWt5gaYnPOsdnmg/cTRkwMUP4g==
X-Google-Smtp-Source: AFSGD/VFS75e9jkp2dUHog5jbUoEoFO+1QorGWT/wWfEEWLgZlSTuvK0Pq6E+Kv12cm2/wbHXIRVKA==
X-Received: by 2002:a24:85d4:: with SMTP id r203-v6mr5771538itd.124.1543597709169;
        Fri, 30 Nov 2018 09:08:29 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r139sm2375668ior.53.2018.11.30.09.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 09:08:28 -0800 (PST)
Subject: Re: [PATCH 01/27] aio: fix failure to put the file pointer
To:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Cc:     hch@lst.de
References: <20181130165646.27341-1-axboe@kernel.dk>
 <20181130165646.27341-2-axboe@kernel.dk> <1543597666.4347.1.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <52910028-205c-adc5-acc0-3f03e35ece66@kernel.dk>
Date:   Fri, 30 Nov 2018 10:08:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543597666.4347.1.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/18 10:07 AM, Bart Van Assche wrote:
> On Fri, 2018-11-30 at 09:56 -0700, Jens Axboe wrote:
>> If the ioprio capability check fails, we return without putting
>> the file pointer.
>>
>> Fixes: d9a08a9e616b ("fs: Add aio iopriority support")
>> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  fs/aio.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/aio.c b/fs/aio.c
>> index b984918be4b7..205390c0c1bb 100644
>> --- a/fs/aio.c
>> +++ b/fs/aio.c
>> @@ -1436,6 +1436,7 @@ static int aio_prep_rw(struct kiocb *req, struct iocb *iocb)
>>  		ret = ioprio_check_cap(iocb->aio_reqprio);
>>  		if (ret) {
>>  			pr_debug("aio ioprio check cap error: %d\n", ret);
>> +			fput(req->ki_filp);
>>  			return ret;
>>  		}
> 
> Since this patch fixes a bug that was introduced in kernel v4.18, does this
> patch need a "Cc: stable" tag?

The fixes should take care of that by itself, I hope.


-- 
Jens Axboe

