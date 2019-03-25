Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28495C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 11:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E891320854
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 11:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="UHt4LI0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbfCYLFP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:05:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44315 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbfCYLFP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 07:05:15 -0400
Received: by mail-ed1-f65.google.com with SMTP id x10so7075965edh.11
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2019 04:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dYbJo+DOeUOtkMKYeR2jP15CUezJ9Glck5C8M5Qzl3o=;
        b=UHt4LI0Xlfe2wHWfSD405LAL38+MWwTZ2miRAlDRyYZ+fD58nLLGiHYt1/zvH4h+t8
         0ocG2Mq+g08ii+0S7SHVG6sxZdJDTURVkEboxKkySkgDYT/GXhNNzNLRI3x4zCBtDQyX
         iIOddho8TxnuwIb5YTw+zamAkwbAhnPQ7rnutqc2WS4SXs+2GqiRaaRUpk393nXDPzTF
         RaIPu9MrRQVXW0ev7VD2cDc8uDT7hkvKRpULerxa0AiFx1M+EuPe2ZbOK9UkP8gTNRSN
         xh9Nqhg3k0FSuwbOAYtDxRQn1emcusn80N9fvbFDbgB1vJQrA98PrED9CuymbFB1a1lb
         BimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dYbJo+DOeUOtkMKYeR2jP15CUezJ9Glck5C8M5Qzl3o=;
        b=WX+ABrs+GRiHfKgQhKg6IT6ksdE5AjUswJB80P/6T4jY/KNb+Bxha235MSkMbUELd9
         dMx4kP3ZEuCESXMxsTvvpavoNsX7mhihZxKnOYaUhwfFk+fUmramwM31xQQbctY56ozw
         mHd5FEQ134mFnK2SpBxHWqUZ48WFL8ref8wWceiVRzxvI/H5NOi9VebCJqwzH3g+3Ah7
         78mMU6rVCoj0kMJEYSfVvpnLcbA1ri8NRrIeIUbHmUUY0dgm2IiupKLROHw0PjAaIDc1
         YkN2Qfm/chTjCv4+LmifhcqbWuckyZLLBElr2r50Gq2cHBWEGroyPS+8s2fQaOqaKWwy
         Uudw==
X-Gm-Message-State: APjAAAXjEcl8EhpAoWCouhNA7e3fc42AGcRv/V3Uok6mZY+TUDXkTFkc
        ppmggEz1ZIVVaaGF10Oz+meA4g==
X-Google-Smtp-Source: APXvYqy0EvZQy368BWKJEIoRMSaQHwtw5ia9kRn8xOzEDy/AG0H0mrT/ybNH4f+Wfm0GHXFpY65uUg==
X-Received: by 2002:a17:906:7748:: with SMTP id o8mr13413620ejn.196.1553511913515;
        Mon, 25 Mar 2019 04:05:13 -0700 (PDT)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id v12sm5321087eda.55.2019.03.25.04.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 04:05:12 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: add a lock to prevent before the race condition
 on pblk remove
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Cc:     Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <1553005484-10584-1-git-send-email-marcin.dziegielewski@intel.com>
 <0673B702-0816-4FB6-B8BB-A08F8369E422@javigon.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <ff8b6994-d18f-4029-5b36-a5f5996e75d8@lightnvm.io>
Date:   Mon, 25 Mar 2019 12:05:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <0673B702-0816-4FB6-B8BB-A08F8369E422@javigon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/21/19 10:17 AM, Javier González wrote:
>> On 19 Mar 2019, at 15.24, Marcin Dziegielewski <marcin.dziegielewski@intel.com> wrote:
>>
>> When we trigger nvm target remove during device hot unplug, we
>> have a chance to hit general protection fault caused by use of
>> nvm_dev which was freed from another (hot unplug) thread (in
>> nvm_unregister function).
>>
>> This patch introduce lock in nvme_ioctl_dev_remove function to
>> prevent us before a situation like described above.
>>
>> Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
>> ---
>> drivers/lightnvm/core.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>> index 5f82036..84f0b9a 100644
>> --- a/drivers/lightnvm/core.c
>> +++ b/drivers/lightnvm/core.c
>> @@ -1335,11 +1335,13 @@ static long nvm_ioctl_dev_remove(struct file *file, void __user *arg)
>> 		return -EINVAL;
>> 	}
>>
>> +	down_read(&nvm_lock);
>> 	list_for_each_entry(dev, &nvm_devices, devices) {
>> 		ret = nvm_remove_tgt(dev, &remove);
>> 		if (!ret)
>> 			break;
>> 	}
>> +	up_read(&nvm_lock);
>>
>> 	return ret;
>> }
>> --
>> 1.8.3.1
> 
> Looks good to me.
> 
> 
> Reviewed-by: Javier González <javier@javigon.com>
> 

Thanks Marcin. I've reworded the description a bit before pulling it in.
