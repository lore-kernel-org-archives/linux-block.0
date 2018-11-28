Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21383C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 00:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF24920665
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 00:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="G9Xauzbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF24920665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbeK1LP5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 06:15:57 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34465 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbeK1LP5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 06:15:57 -0500
Received: by mail-pl1-f195.google.com with SMTP id f12-v6so16443883plo.1
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 16:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6ksc5Cke5URKkYew+rVQcwIS+ky7RV5Tl9V0SU5JlsY=;
        b=G9XauzbtBd0TT+i5tduo4S30di6mA0lxRbtL+fYH3tOB7/8UMUYUxcA8iWki4kXlpT
         qu4ZUcnTGkXMi12odgWVhmWITNQEKhp+WhrHcbKCHdeNi7nBhA2x+/G3rXAw7BZBJH+z
         SdSJeaZhycjhF8vfdyQlIdTA9Z61q7b4a311UtAjC8jtIuAOmh24FlFnIgWTohATtoum
         cjv35jQDYj6jfy89CAwudX1LhMi1z4K+eAkN6v3q99hV2ZHeWQUqcDrD/tLgutRqZFlT
         z+4UD6fI3v9aJMN14NIu376UtMDI5qDHSPyL/gJ7TOaGoZFrzbeI5ufXIr3hpdjM/Wml
         s50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6ksc5Cke5URKkYew+rVQcwIS+ky7RV5Tl9V0SU5JlsY=;
        b=NX9vA1slDDCwTRN1Tl0TzBGGGJDb6FyAa85h0R6sY+Pq74WCojHbFrpMX8K9v6LQhk
         9NHmhOrGbMnxVf2iUUo78LvOPWXj7YUkGIE918ZfLm7uaLDaMDt/ESX2c7enzyfqX1u3
         +7VCN7zG2qsKmxbYb9uuddDMmh/1/yJqk43l0X+JGf9+Vv2OyifoTIjSjYBTH1AQ2jNB
         PSzCHw4yhVv6nFFh0tuFzTwLAyUkCHhRoNIoBQype5q6TyzHcC3rhvBiaurIkNm9RJkq
         sT3Eq9WkB3C3/T99VKu3xqJiPwWqO+Xtf1GUbZcQQ4NFl5pNF9vNEIo0NlppgV5KSzuJ
         m7NA==
X-Gm-Message-State: AA+aEWatCj3MYDsHRfkpPXaaYree8a2HyNxWFGTLWTM2NkPBCLI/MZw0
        8LVmDcEZ8mTe82qb5uwYGaAwew==
X-Google-Smtp-Source: AFSGD/V0pPbs6Ad2O5sttei1EPbyalVzbQYYsONERb9h4RroWFWH4mc1dadq2tbiJKcsvhiMcJrAyw==
X-Received: by 2002:a17:902:59c8:: with SMTP id d8mr34654898plj.116.1543364180516;
        Tue, 27 Nov 2018 16:16:20 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e123sm5407742pgc.58.2018.11.27.16.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 16:16:19 -0800 (PST)
Subject: Re: [PATCH 2/8] block: improve logic around when to sort a plug list
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-3-axboe@kernel.dk> <20181127233142.GB846@vader>
 <b6cfc7c8-39f4-252b-8c27-3a75f561061a@kernel.dk>
 <62f96268-f596-78b8-d227-6be1f5ae1cea@kernel.dk> <20181128000501.GH846@vader>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <142fca05-eb21-48ff-8dc3-ddc8797e7e1a@kernel.dk>
Date:   Tue, 27 Nov 2018 17:16:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128000501.GH846@vader>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/27/18 5:05 PM, Omar Sandoval wrote:
>> +static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
>> +{
>> +	list_add_tail(&rq->queuelist, &plug->mq_list);
>> +	plug->rq_count++;
>> +	if (!plug->multiple_queues && !list_is_singular(&plug->mq_list)) {
>> +		struct request *tmp;
>> +
>> +		tmp = list_first_entry(&plug->mq_list, struct request,
>> +						queuelist);
>> +		if (tmp->q != rq->q)
>> +			plug->multiple_queues = true;
> 
> Actually, I thought we want to sort whenever there are different
> software/hardware queues on the plug list, even if they're on the same
> queue?

That was the original intent, but with the tons of testing I've done
lately, the cost of sorting batches is higher than the cost we pay for
having to do multiple inserts. So I think the only sane case is >= 3
requests, and multiple queues.

-- 
Jens Axboe

