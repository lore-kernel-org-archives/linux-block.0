Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911D1C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 23:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FD9208E4
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 23:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0+mk7Hns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56FD9208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeK1Kul (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:50:41 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42555 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbeK1Kul (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 05:50:41 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so8584696pga.9
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 15:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=chPLM2ut1zrQrb/WKWZL6HQr4aL9PwArFL8xtEPQ/4A=;
        b=0+mk7Hns/pGV3tzhPuBbZQmGz6YwCpW2XHfM+FdZ6UFdB0ueHK9fOnzns0Xl9YeCI+
         cvuVi0SJSiT3kqkyHf5ICrbntBlVHyqU1CXxWMtn+2dn4UErJTTzKubYadff6IQf2xYg
         lfQrtyD1B5rQyONOUzyC6ZqylsqLlfxAq6bIyWBEgv/oRkFnp6iYfNfHFJDxmK9mmVXF
         EU/XF1uJ2T+ITZvPIJ7CU/v14m3c64Pmcx7pSJdfTEb9PP/jwZJUwX8AitB1z0VatQIa
         Rg6v6mz86TA3qgdQpXBhQmcFaue7QAtYkyHMxY8CUqWs52d9aBF4eKsjiVVr5ClhnWcN
         kZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=chPLM2ut1zrQrb/WKWZL6HQr4aL9PwArFL8xtEPQ/4A=;
        b=E/Fzao4KVl+1JdLNjkW7CFtpiV4ALXdU0OIlLPDyk74WBla25qWwWQRaKbrxzA9mO/
         qXCsriyiX5ajphyEqxUzkHKIJiI/9UVvO3mD989uvrJINZ/UELTty7qG5Wuk5hdS2Mwz
         D2yEc1XtluATiOZKXINdE/wgHFwVzAlWtPV+TuaXi9gL9mPIZbFvGDbxdicX+l/zEdu/
         sKTjOYmuaGSNFoOVZrIphNToxrH3GuFMuOw38UErsVWN1Pem9i+HEffh6ubFt30BmFJ0
         TKF/toWFp/tYurEBimfuuLB5boBHnCuLSWrth6SNFeDFs8R1N9BfN4ct3qkaVF+l28Si
         dEtQ==
X-Gm-Message-State: AA+aEWZmpYcZI53ZXXDycO6Q8YQ2I4bDT8JaQfpvjhWhr3PmHSuMFN9D
        r9EcfDokf3hgd6xmvg96lxM3TS3MrAs=
X-Google-Smtp-Source: AFSGD/VXHhgYI7y1YNQLoYi/reQkQjKqm9PDMkF3rhPGo5FJ/Ux3wggP61kxm1Mfi6lf+bZu77BUCA==
X-Received: by 2002:a63:585c:: with SMTP id i28mr31314595pgm.178.1543362667970;
        Tue, 27 Nov 2018 15:51:07 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id x12sm5200592pgr.55.2018.11.27.15.51.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 15:51:07 -0800 (PST)
Subject: Re: [PATCH 7/8] blk-mq: use bd->last == true for list inserts
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-8-axboe@kernel.dk> <20181127234954.GF846@vader>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cf96f72c-bf3d-f44f-166d-1b3e8c959de1@kernel.dk>
Date:   Tue, 27 Nov 2018 16:51:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181127234954.GF846@vader>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/27/18 4:49 PM, Omar Sandoval wrote:
> On Mon, Nov 26, 2018 at 09:35:55AM -0700, Jens Axboe wrote:
>> If we are issuing a list of requests, we know if we're at the last one.
>> If we fail issuing, ensure that we call ->commits_rqs() to flush any
>> potential previous requests.
> 
> One comment below, otherwise
> 
> Reviewed-by: Omar Sandoval <osandov@fb.com>

>> @@ -1260,6 +1260,14 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
>>  	if (!list_empty(list)) {
>>  		bool needs_restart;
>>  
>> +		/*
>> +		 * If we didn't flush the entire list, we could have told
>> +		 * the driver there was more coming, but that turned out to
>> +		 * be a lie.
>> +		 */
>> +		if (q->mq_ops->commit_rqs)
>> +			q->mq_ops->commit_rqs(hctx);
>> +
> 
> This hunk seems like it should go with the patch adding commit_rqs.

Agree, that would be better, since that also makes that patch fix an
actual issue instead of just being a prep patch. I'll shuffle that hunk
to that patch.

-- 
Jens Axboe

