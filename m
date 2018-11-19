Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFADC43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 15:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C02E20851
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 15:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ijdLmUqH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C02E20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbeKTCDY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:03:24 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40166 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbeKTCDY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 21:03:24 -0500
Received: by mail-it1-f194.google.com with SMTP id h193so7501051ita.5
        for <linux-block@vger.kernel.org>; Mon, 19 Nov 2018 07:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yusLSFFCZyegXyw1O/SHMFEMIj7LyaUGcliPePIzYSg=;
        b=ijdLmUqHJWuFLywbehckLHX8vYcBJQT2yMMtxi3sl4fWnoFy6SEbNK6buO1zb8A6a5
         Nu052VrDaOPQj9L6cnvV2inOGobr8U1oaQ8brK2fWWFwwS0Sut1XZ0IPe624/CdWmkpc
         lgAVmfSSpbC3rsSiX4D1XciEuUgxhFI+syQvxPA0k2md5C++acvdtauMDljvirSu6Ji/
         61rBDO9Be1D7uMeFHITY2NIVUZ2bp8T9kBRfUkTwBysPxtX4odNbBUoFER5QOmC3FDgq
         nuJLDTkew8TQy1ypSluInFHj/scoaQMqwgkSrJVA4bgFiXaOHwEmhHuWME1QD/I7ch4H
         0Evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yusLSFFCZyegXyw1O/SHMFEMIj7LyaUGcliPePIzYSg=;
        b=T+hr/CVVFtM0/jffM7CE0OOA/SrGvPxqYvmm7soceSNhm6/+tFiDwVeueituRRoET3
         mmhnwxhtrmUL7e0T7jSoHRhaV37ZF5RSVisujLoUMu1kYM0q1AktErpnjFXwpfoity72
         cqcpFPSKHBEvwvOZvzOpRBrb250sCk7yfXtni61IyvFUbiSmPG8Yy4PbLyK8r1wlGsif
         l4+AS9eacc5g6tRPRSYxE2YaDxoQpKGgXIaqAUrM10S4vfq169tzIiN3Bc6E1b4u0q0e
         yoWx6GqtJnntSPPszmJCfquHNoB4QhP/8P+gG4YYFupwz29cdfmGK4/s9tld8qachP/v
         PaGw==
X-Gm-Message-State: AGRZ1gJY9cvaSt6ax6W40OTUKntWgKUjvJbJzitO17LITxMeMXD6GHG/
        Cm4E6vfkf2aFFKcmchlnaB3fl9SJc/4=
X-Google-Smtp-Source: AJdET5eD+zqfrLIXsHzhbB7SU2715Y0OtRNH3yqsEPES+gohLD9sJGC8fF465BgaqjOlxGWv993KwA==
X-Received: by 2002:a02:9911:: with SMTP id r17-v6mr20767258jaj.132.1542641966446;
        Mon, 19 Nov 2018 07:39:26 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x21sm5442586iob.84.2018.11.19.07.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 07:39:25 -0800 (PST)
Subject: Re: [PATCH 2/5] aio: fix failure to put the file pointer
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20181117235317.7366-1-axboe@kernel.dk>
 <20181117235317.7366-3-axboe@kernel.dk> <20181119080710.GI9622@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cee0201c-5988-6535-0172-2801020764b1@kernel.dk>
Date:   Mon, 19 Nov 2018 08:39:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181119080710.GI9622@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/19/18 1:07 AM, Christoph Hellwig wrote:
> On Sat, Nov 17, 2018 at 04:53:14PM -0700, Jens Axboe wrote:
>> If the ioprio capability check fails, we return without putting
>> the file pointer.
>>
>> Fixes: d9a08a9e616b ("fs: Add aio iopriority support")
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Looks good.  Please also send it to Al so that it can go into 4.20
> and -stable.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Al already took it, but it's still in the series since it's not in
Linus's tree yet.

-- 
Jens Axboe

