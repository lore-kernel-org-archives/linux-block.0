Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C82C65BAE
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 08:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF562146D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 08:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="TOITIWu2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF562146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbeK3Tor (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:44:47 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46819 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeK3Tor (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 14:44:47 -0500
Received: by mail-lf1-f66.google.com with SMTP id f23so3467049lfc.13
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 00:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mrwc12kGFUvTe4G8O2yVusGKb78ANicaV+8Tfof25bQ=;
        b=TOITIWu20w+TZzp9jiY2fK2vjMZvd83jQatrBCtKkujphNDnnVWVNTAGQ0VU/zKcAV
         G+6wA3zFS9Pu1NKX6suxFFvxrNxBkWUzY3SZOzmoBqClkdTrdNASnO3QWodWM+IUHAi/
         jVh4MxqNsJOVsLhh/bF7r/Ml6VIoV1JlwfWr/LqajnllsBMt4+wKH4Lx+VccUg9AhLEe
         36dP/9ECY2fxwKBUNdz5ExGr8G1Zy7Tp8bFpvqEedT+qbgMdyM7Ipd3L46XcGsqbNKU0
         p/w7uRwVEXVOZdz4+BIThD0a/M5uWCzDsxr00+CLHZWYjxplpC0I+9Z1pmyuweBXh6t8
         8V3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mrwc12kGFUvTe4G8O2yVusGKb78ANicaV+8Tfof25bQ=;
        b=t3oUf4OwdtWHZFpqV66UYCjG5JO9V6KUuEQ82sOW0Ok0PFTvTEvVrGT1h6krNJcbyO
         tvGGpeQcDvliM22IBI6tj2apgzsPiKM+ZGac1BegtJqJBKALrNWvu36kTGzN0At1AxVW
         6aCH3Om9DBOlQra/BaeH6Ydghe7R8LRa7+KaXoeFDoyRUQHNUW9c9tGmEE0WQaH0XiR5
         JceCWU8sRqR+ZapIjrJLYo+QOC3V/425do+MGIhHueYV0krZuOcibWsSUHGRW64n1R7Z
         CUZomA40Xe8OUl5VWvZLu7wUhcNE/h4sk+qeolr1eRv17ksxP/9hHvdgaVudItBLjOBn
         98lQ==
X-Gm-Message-State: AA+aEWZKyPV8VygwUoXYK3MDxT6a6cDjMDaQMBj4DlvnPFjQ9JDzPn10
        vh3iTwF+Ggt6PPlwM1BbGgZUDvYSfGU=
X-Google-Smtp-Source: AFSGD/WogDBerdNDJVhwo/56h03oEPgBsq3YVBIT0qvkfFxexAGMgJktNrhYK1X1RDMqPbR8JX6HtQ==
X-Received: by 2002:a19:2106:: with SMTP id h6mr2943704lfh.29.1543566972748;
        Fri, 30 Nov 2018 00:36:12 -0800 (PST)
Received: from [192.168.0.36] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id b81-v6sm680627ljb.7.2018.11.30.00.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 00:36:12 -0800 (PST)
Subject: Re: [PATCH] lightnvm: pblk: add lock protection to list operations
To:     Javier Gonzalez <javier@cnexlabs.com>,
        Hua Su <suhua.tanke@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181128091352.5088-1-suhua.tanke@gmail.com>
 <930717BD-D32A-4BE2-AEE6-579594E70842@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <ad41a638-4c59-e079-e272-9ebd98ab929b@lightnvm.io>
Date:   Fri, 30 Nov 2018 09:36:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <930717BD-D32A-4BE2-AEE6-579594E70842@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/28/2018 10:16 AM, Javier Gonzalez wrote:
>> On 28 Nov 2018, at 10.13, Hua Su <suhua.tanke@gmail.com> wrote:
>>
>> Protect the list_add on the pblk_line_init_bb() error
>> path in case this code is used for some other purpose
>> in the future.
>>
>> Signed-off-by: Hua Su <suhua.tanke@gmail.com>
>> ---
>> drivers/lightnvm/pblk-core.c | 13 ++++++++++---
>> 1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>> index 6944aac43b01..247112e1db94 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -1295,15 +1295,22 @@ int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line)
>>
>> 	ret = pblk_line_alloc_bitmaps(pblk, line);
>> 	if (ret)
>> -		return ret;
>> +		goto fail;
>>
>> 	if (!pblk_line_init_bb(pblk, line, 0)) {
>> -		list_add(&line->list, &l_mg->free_list);
>> -		return -EINTR;
>> +		ret = -EINTR;
>> +		goto fail;
>> 	}
>>
>> 	pblk_rl_free_lines_dec(&pblk->rl, line, true);
>> 	return 0;
>> +
>> +fail:
>> +	spin_lock(&l_mg->free_lock);
>> +	list_add(&line->list, &l_mg->free_list);
>> +	spin_unlock(&l_mg->free_lock);
>> +
>> +	return ret;
>> }
>>
>> void pblk_line_recov_close(struct pblk *pblk, struct pblk_line *line)
>> --
>> 2.19.1
> 
> Looks good to me.
> 
> Reviewed-by: Javier González <javier@cnexlabs.com>
> 

Picked up for 4.21.
