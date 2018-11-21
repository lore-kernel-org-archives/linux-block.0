Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7147C43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 13:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAE8214DA
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 13:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WM5jRn7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EAE8214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbeKVABv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:01:51 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46890 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729787AbeKVABv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 19:01:51 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so5547889ply.13
        for <linux-block@vger.kernel.org>; Wed, 21 Nov 2018 05:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cjtw29MPQXxO+3fR75ETwq7fRG/F9EGyMI0CKiUPsiI=;
        b=WM5jRn7lnAUUFoFwDXum46v6o90IxYIydEY0Wkps333DOiQvnqnVA6iMmbsoyzZnWK
         N0dmlHLrI6g5NyBmnHPhGjAHFOboXh2vNVD+Qs4Q0OTdR3B6FNqaPsLCgca/0WTlYn0y
         AhXu/Sa7AMf3ZUwyYxlaxlnDX8yuoJMAJh00x08s1RgwSz4z3r+wPPp8HHWtttm8nLGk
         L60jdSXRzFxMlL5wvZTc8GdTMgEfEDO2VFgpGFF7nd/0oi6B++B8t7F96VaUYG4yvIfC
         dlJVSs6iQTyiCDyfX/nVoV0yacKWE3ovEiRD+rAy9Votc2BxARg/MVlAUA8V4vxQoksb
         moww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cjtw29MPQXxO+3fR75ETwq7fRG/F9EGyMI0CKiUPsiI=;
        b=lISGLKRMJsQYlqyU5lNvpJSsmLfeWZz1rPvbr7zLXMuH2Emo6zD3glzCg6bkxZJJBu
         /vF7eMf/gDNLRbw3kPoGRSdQE1GVj7DrYadTG1x6p3sfkY8S7Ph43DHeMGbEd2jx+HL2
         5tCmDVfzpajlfql8CQ3k5WIZeQ2nc7D3K8+3xa6pC1HS1lmSwCzQV/aB468P4rbt0fy2
         awboaM6bJqx9KexYQY9TNaUlVmp8kEYyL1gPbPJGYum4MnV+Vofro+5CAi5CkesXylfD
         +Y8pm8jvbGFEzb9A/h9S0SRB8HdcH/ATB2fJOy+qn9tkpYtOK5i0XfRFTuWsPYXwbrV4
         ZNGQ==
X-Gm-Message-State: AGRZ1gLvPwHREkeJfIBWWYlkBhLtZ4QdDDHmNdcI1x81CjAZrgDpLPYX
        ys7/g+8QqdrxoKsaOKng9+ZXvQ==
X-Google-Smtp-Source: AJdET5dTwhTQTzBotVnb8OV1yTowV3vP2QSlBH3ieQbjF/9CveXCnBJaAYJhfeAgxvSJYGUtfo5+DQ==
X-Received: by 2002:a62:2292:: with SMTP id p18mr6980230pfj.9.1542806848053;
        Wed, 21 Nov 2018 05:27:28 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id y6sm20495331pfl.187.2018.11.21.05.27.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 05:27:26 -0800 (PST)
Subject: Re: [PATCH 3/8] iomap/xfs: wire up file_operations ->iopoll()
To:     Benny Halevy <bhalevy@scylladb.com>, linux-block@vger.kernel.org,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org
References: <20181120171953.1258-1-axboe@kernel.dk>
 <20181120171953.1258-4-axboe@kernel.dk>
 <feffd542a50966c7cd552c280290f406ea5629ef.camel@scylladb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <62aca28d-fd54-ae4e-d4d4-44c7232f23da@kernel.dk>
Date:   Wed, 21 Nov 2018 06:27:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <feffd542a50966c7cd552c280290f406ea5629ef.camel@scylladb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/21/18 2:15 AM, Benny Halevy wrote:
>> +int iomap_dio_iopoll(struct kiocb *kiocb, bool spin)
>> +{
>> +	struct iomap_dio *dio = kiocb->private;
>> +	struct request_queue *q = READ_ONCE(dio->last_queue);
>> +
>> +	if (!q || dio->cookie == BLK_QC_T_NONE)
>> +		return 0;
>> +	return blk_poll(q, READ_ONCE(dio->cookie), spin);
> 
> How about:
> 	blk_qc_t cookie = READ_ONCE(dio->cookie);
> 
> 	if (!q || cookie == BLK_QC_T_NONE)
> 		return 0;
> 	return blk_poll(q, cookie, spin);
> 
> Is there a chance the dio->cookie in the if () condition
> will be stale?

I've rewritten this one, more importantly it needs to guard against
submission by ensuring that 'dio' is valid.

-- 
Jens Axboe

