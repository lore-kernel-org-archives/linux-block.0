Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63684C3A59E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 15:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D84D22DA7
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 15:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfHUPlf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:41:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34920 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfHUPlf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 11:41:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id gn20so1536695plb.2
        for <linux-block@vger.kernel.org>; Wed, 21 Aug 2019 08:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=crisZJ7D+vC3F3uLPwL+1nRE93mFXssO3OIJRXjUNTg=;
        b=OEzIbrfgXUEXy+cLl1Xs75P3qXuE3U9SeJQCvMO6a7cgOP1i8QJCZw0+dMC6U7JAtC
         5/ZWBZgoRbLu0fLrUSTLCXDzHBAH0fGUymf5Rz4Df7ejIBccFiK0QMMDrQtkzXC32IZ7
         VzPEG+2PAnClPkGTXELh2mELYQDOwU/Ip+EkEIiPmgCPykEGm0QjytGjsTNGDx4rxxqD
         Cw7JfZ1z8AFIbUNv804Ea+y3nS6656cOxAEjWUZDep05PC0HEhlrpw8gpXwME/th1lw0
         Ldd7NoNVwnkW/t49OXm45TZApOH79EWtJsQVtSATJc9jyUPEGlsAYVF1sS5AwK6ofrdr
         QrCg==
X-Gm-Message-State: APjAAAVFR5N4RU9hxOHQTJAC9LUylDpEEdUfxR7z+uvDj7HKb8K06zRh
        IxPIAgW8yQA83ULqah2Ol1I=
X-Google-Smtp-Source: APXvYqzDA0GtTXF7S+CLebYfnQ9gp8K9UCz2HD8DHvCg7X7E0HHqKOpTNiwf8rBHUHoGpz15c8Akbw==
X-Received: by 2002:a17:902:d690:: with SMTP id v16mr19309438ply.318.1566402094589;
        Wed, 21 Aug 2019 08:41:34 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y16sm25598684pfn.173.2019.08.21.08.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2019 08:41:33 -0700 (PDT)
Subject: Re: [PATCH] block: don't acquire .sysfs_lock before removing mq &
 iosched kobjects
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <20190816135506.29253-1-ming.lei@redhat.com>
 <09092247-1623-57ff-6297-1abd9a8cc8a2@acm.org>
 <20190821030052.GD24167@ming.t460p>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <d27b430e-ed9b-7de7-5947-c93f1753c529@acm.org>
Date:   Wed, 21 Aug 2019 08:41:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821030052.GD24167@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/20/19 8:00 PM, Ming Lei wrote:
> On Tue, Aug 20, 2019 at 02:21:10PM -0700, Bart Van Assche wrote:
>> -	/*
>> -	 * Remove the sysfs attributes before unregistering the queue data
>> -	 * structures that can be modified through sysfs.
>> -	 */
>>   	if (queue_is_mq(q))
>> -		blk_mq_unregister_dev(disk_to_dev(disk), q);
>> -	mutex_unlock(&q->sysfs_lock);
>> -
>> +		kobject_uevent(q->mq_kobj, KOBJ_REMOVE);
> 
> Could you explain why you move the above line here?

I'm not sure whether kobject_del() deletes any objects attached to the 
deleted kobj. This change ensures that kobject_uevent() is called before 
the parent object of q->mq_kobj is deleted.

Bart.
