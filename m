Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E955C33C99
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 03:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADED2064C
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 03:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wHZOgUrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgAGD7g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Jan 2020 22:59:36 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40647 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbgAGD7g (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Jan 2020 22:59:36 -0500
Received: by mail-pf1-f196.google.com with SMTP id q8so27919988pfh.7
        for <linux-block@vger.kernel.org>; Mon, 06 Jan 2020 19:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nsLzY4c5Y6gdoNQfBwxlEg/+/rRGSDP/2ZAXMLaIC88=;
        b=wHZOgUrKzhLRRjQuDOWSfKIZF/d71dALs41HMDM0J0XwTdEmiLhQ9yFju1i8KFa9G0
         xWlQIFUceImn+4lRJmwV67fq0+ntaj1lJ4OWxyYDGzNRNOCxa6YxFRfAjuslBGv3TToZ
         8PadHxlOB0m8fRSrMEhfQPqPelqzoxVDza7Qc85kg1r5ldUcg6UZH7dxN7mRPJhDMk+R
         zAv03wFp6CLGJgMd5AnQzEe2/+0NNoFc2fa1T2eD7c7NgCE0bGF578AVEqR/IZu8KjtQ
         Ncw82+/2s6qHPcDJDoyj313udN4YrlyMc46nGrxEKQWe7ls6wzk6r/JlhH115XqtUNkg
         a6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nsLzY4c5Y6gdoNQfBwxlEg/+/rRGSDP/2ZAXMLaIC88=;
        b=PZPNsERmrEtqy95h41jGy3/vDxZhaiSkJgwwrSV58cDNhv6w/E2XbY46x8IIl7xFci
         pFBSxltKv7MTzeugKPE2m4ru5Ump4TBYzd8dhlgLdWUIOLdEQaymB+vXbxK2oMstjQuq
         CtVDWe8ISd/jVSb8wgoz3ll3BjUsWTHhRHuRX5ZICAAjNhASHv8+UAuaBSIVpWmgB0UK
         GUeRiktg25B7qTCLtCJFQE/NCU39SSBy6KytH8Zxp+ICjilNnYKk2z6jgDKaS4o0ZWGj
         VVFnuUSgPC1gpjyFxe1OWUQMIYQV4cZuByXDjvnEdL2y3I5LYOA2HcK4E5J43Kdsgryj
         Kr5A==
X-Gm-Message-State: APjAAAVRj8VnvACuGsTAwWpYFvGgldZfzQNuHOHnuuZXOqIZsj3mG21G
        xZRTQt3m7nFvSI1OjsnyupA7Og==
X-Google-Smtp-Source: APXvYqy7yo97am3O3T/6re1durrfsUspsH9OQpHkAr2WAjBAvlkWgJ60ju/5LU7dUk+1FKeypjBKJQ==
X-Received: by 2002:a62:a209:: with SMTP id m9mr101853802pff.16.1578369575895;
        Mon, 06 Jan 2020 19:59:35 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id j10sm26074107pjb.14.2020.01.06.19.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 19:59:35 -0800 (PST)
Subject: Re: [PATCH] block: Allow t10-pi to be modular
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20191223081351.gsunwl6zwcltfdy6@gondor.apana.org.au>
 <yq1k1642bj5.fsf@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3128b4fd-a00d-85d8-2994-3f1734bf221f@kernel.dk>
Date:   Mon, 6 Jan 2020 20:59:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <yq1k1642bj5.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/6/20 8:25 PM, Martin K. Petersen wrote:
> 
> Herbert,
> 
>> Currently t10-pi can only be built into the block layer which via
>> crc-t10dif pulls in a whole chunk of the Crypto API.  In fact all
>> users of t10-pi work as modules and there is no reason for it to
>> always be built-in.
>>
>> This patch adds a new hidden option for t10-pi that is selected
>> automatically based on BLK_DEV_INTEGRITY and whether the users of
>> t10-pi are built-in or not.
> 
> Looks fine to me.
> 

I added it to the 5.6 mix, thanks.

-- 
Jens Axboe

