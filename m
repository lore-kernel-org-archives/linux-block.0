Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2E6C64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 08:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE5320863
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 08:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="RsAPHWwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE5320863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbeK3To7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:44:59 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46935 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbeK3To6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 14:44:58 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so4217287ljh.13
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 00:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ioXF4bCL8BuwqWo5CCjgjpGdZH7diIK4hexxj1Nvf8o=;
        b=RsAPHWwKdpngwQoodtjN35xFxp6L4Ne2axZleCQscGRB1vuT9Aw65WogQB0cJZ/bn5
         KrZ4Gu5Yw0xz3E0mPzCyv4jwMo70yGzqVA3k9Xr4pSwWC0ueteybKeZ88m1wuke+oD/3
         12hgrzzCwGQV1dmTLxjEvm+oM22RJ9pWrhNoe+vKdPYCiH6qaVfXNQr+pimM4qy+HzqW
         wtzRDeg9ODyDCntGvTtPjWWP6LBJa0MtREyek8ULqdIgtlpZLnHw8Ly+1DGisEiAjEpX
         H5YdyMr1mbf9zP0BoAbUBjA/2lr5RHH54B+140YNVMK610nM7OJQdEqdXL6QQaATCxiZ
         z7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ioXF4bCL8BuwqWo5CCjgjpGdZH7diIK4hexxj1Nvf8o=;
        b=NX5P3gz7Zxr3oWRxWX+amKlDAM0scH5jbrrKQbKOwRlgbHmIBR4+rjeESMbaeMD4Cp
         j4VS1mhCasynJ8GNX6IEqwEpUUO8h52FSv1lLcDERgXSkBJlyqIZc+6ZkbG8NbEQk6Rz
         RQ6Ru+wS1ty9I33MrtdB1OjoOGSDc+rySNhXP8QEdhnAZmPPRzNkJVyjekfk7hCz/jwy
         5I+r6cEXVqEiMVqsq+Lrn233HTXfmwxhw7PCQMuZdNmfSO8rUYd7RhNTYbT/MX8UZfed
         fEnGXJW+O9QWkU9NUfU6bsT2x+ieXATiIkNBiKnDKZbd9TFIesLHTw5EJnHhoNpg8UuV
         z8OQ==
X-Gm-Message-State: AA+aEWYch4nOsIZIqecnSlzFscfe5kJJS2pm2T2Wd50zmf3qBGiK1xqg
        SGhSkbGN/XirAb+PqmR4aLRHuQ==
X-Google-Smtp-Source: AFSGD/XgpXETfsbcHjHD99lFbDWo72gPOJYrLxfDJzqpY9aEGui4EEUN+IWI3h744LW7Z4YzHwbvVg==
X-Received: by 2002:a2e:994:: with SMTP id 142-v6mr2903040ljj.120.1543566983755;
        Fri, 30 Nov 2018 00:36:23 -0800 (PST)
Received: from [192.168.0.36] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id j138sm692946lfg.64.2018.11.30.00.36.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 00:36:23 -0800 (PST)
Subject: Re: [PATCH] lightnvm: pblk: avoid ref warning on cache creation
To:     Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Javier Gonzalez <javier@cnexlabs.com>
References: <1542894410-14047-1-git-send-email-javier@cnexlabs.com>
 <1542894410-14047-2-git-send-email-javier@cnexlabs.com>
 <CANr-nt2XMzZnd309pY7QJxYXWMSuXXrcWMt8F=pa49BzARb5dg@mail.gmail.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <a0bacf2c-1405-b70b-828a-f2bbe0ecb271@lightnvm.io>
Date:   Fri, 30 Nov 2018 09:36:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CANr-nt2XMzZnd309pY7QJxYXWMSuXXrcWMt8F=pa49BzARb5dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/23/2018 11:04 AM, Hans Holmberg wrote:
> Great catch Javier! Nice refactoring work too.
> 
> Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> On Thu, Nov 22, 2018 at 2:47 PM Javier González <javier@javigon.com> wrote:
>>
>> The current kref implementation around pblk global caches triggers a
>> false positive on refcount_inc_checked() (when called) as the kref is
>> initialized to 0. Instead of usint kref_inc() on a 0 reference, which is
>> in principle correct, use kref_init() to avoid the check. This is also
>> more explicit about what actually happens on cache creation.
>>
>> In the process, do a small refactoring to use kref helpers.
>>
>> Signed-off-by: Javier González <javier@cnexlabs.com>
>> ---
>>   drivers/lightnvm/pblk-init.c | 14 +++++---------
>>   1 file changed, 5 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>> index 13822594647c..e225bd60cbb4 100644
>> --- a/drivers/lightnvm/pblk-init.c
>> +++ b/drivers/lightnvm/pblk-init.c
>> @@ -350,23 +350,19 @@ static int pblk_create_global_caches(void)
>>
>>   static int pblk_get_global_caches(void)
>>   {
>> -       int ret;
>> +       int ret = 0;
>>
>>          mutex_lock(&pblk_caches.mutex);
>>
>> -       if (kref_read(&pblk_caches.kref) > 0) {
>> -               kref_get(&pblk_caches.kref);
>> -               mutex_unlock(&pblk_caches.mutex);
>> -               return 0;
>> -       }
>> +       if (kref_get_unless_zero(&pblk_caches.kref))
>> +               goto out;
>>
>>          ret = pblk_create_global_caches();
>> -
>>          if (!ret)
>> -               kref_get(&pblk_caches.kref);
>> +               kref_init(&pblk_caches.kref);
>>
>> +out:
>>          mutex_unlock(&pblk_caches.mutex);
>> -
>>          return ret;
>>   }
>>
>> --
>> 2.7.4
>>

Picked up for 4.21.
