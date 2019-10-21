Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEA5CA9EB5
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 09:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B908206C2
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 09:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="UNTgufW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfJUJil (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:38:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35789 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfJUJil (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 05:38:41 -0400
Received: by mail-ed1-f68.google.com with SMTP id v8so9502037eds.2
        for <linux-block@vger.kernel.org>; Mon, 21 Oct 2019 02:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=NXcRFQoNuRosGXQTqtzmhzpLAvpzTxPjdnuoGUgHUuI=;
        b=UNTgufW+ZhfOcrjInY2HRyamnw6TAoFKALfGHnfj2kgo86L+Kt2B5eyDdf5MbUVvts
         avdspXH0RXLmJZbiA7tHsRHXPeB5zl6RGxheT1h6syKK9k8LrdSA9EAc+OpkLG7M1cCC
         xxT61Rmn0DhIbW8PjoBx+I2acUuqvRt7IOoPWRpAL7a/HoQ4GwwuAWN9WOuDlqLIjbd1
         fpdkhfApoT4oZqEa9qS1NSBm0uSlyjG9UKC/kXBxyOv+AeAh5nDIlydXYqhcuKn2xiY2
         vnRqVNSsHkBJUnh0upvVX/nX8rPRutJJ6LOU8rlIuy6f3PdLUw+eylbMMM1NPEyabgWq
         dsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NXcRFQoNuRosGXQTqtzmhzpLAvpzTxPjdnuoGUgHUuI=;
        b=a2lE4U0U8SudELYw+3npT+g8SJLwdMrbboXSrbKXjsuhiJJdgHzQ1anqsmGBSj9MM2
         4ZBLFy2VQc254nBSC3DleNDHDsXPFMx/EOoYr7fK1TvcG2muFEGsl8qSQeXzGfij6OaW
         0kyoK5KD7gXpXV3WZdRevcnIIX1V8BDCGy87CAfpFuVuAA/8JGj7FO5f+N4L2EWUNAmF
         KEyRZ4ZC/YHBtPxIf9Fh/yddl3XUDNNIKi0EHZ7Kp2NVLdSG/eXerNeE4aDguUqAaw1P
         sdJ8jGsuDsuSoj2Ru7l/GLNNxg9FGZw0YZzkIqG2EUgaEu1D9N8XBDCJmWUv0QpRhaOg
         fT8A==
X-Gm-Message-State: APjAAAUpSAY/pmNan4rMbOMaYm48KqBCSKt0t8NxXn5uYBmdUSZuag8a
        yI3LUN51Nns9QSGTuGLVuUpGB77iMzXfeQ==
X-Google-Smtp-Source: APXvYqzyNB+2NyYl+4lFxuFn1NgE2cMuSfqmx8POTIRBzHWcOnIo0xoWjXv0xyjA1gssaONocKh/0Q==
X-Received: by 2002:a50:8f65:: with SMTP id 92mr24740132edy.9.1571650719453;
        Mon, 21 Oct 2019 02:38:39 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:2920:f165:80aa:e780? ([2001:1438:4010:2540:2920:f165:80aa:e780])
        by smtp.gmail.com with ESMTPSA id d15sm22492edx.78.2019.10.21.02.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 02:38:38 -0700 (PDT)
Subject: Re: [PATCH 2/2] bdev: Refresh bdev size for disks without
 partitioning
To:     Johannes Thumshirn <jthumshirn@suse.de>, Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20191021083132.5351-1-jack@suse.cz>
 <20191021083808.19335-2-jack@suse.cz>
 <4d58a159-e935-1200-1a71-8eb252fc5bdc@cloud.ionos.com>
 <20191021091256.GB17810@quack2.suse.cz>
 <f77bed8f-16a7-dc96-d006-41c34e86eff0@cloud.ionos.com>
 <3eca5fff-1b55-13ba-3176-2d8b24e46ed0@suse.de>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <a857606a-f6db-eda8-01cc-13b34aee0ee8@cloud.ionos.com>
Date:   Mon, 21 Oct 2019 11:38:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3eca5fff-1b55-13ba-3176-2d8b24e46ed0@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 10/21/19 11:36 AM, Johannes Thumshirn wrote:
> On 21/10/2019 11:27, Guoqing Jiang wrote:
>>>>>     static void bdev_disk_changed(struct block_device *bdev, bool
>>>>> invalidate)
>>>>>     {
>>>>> -    if (invalidate)
>>>>> -        invalidate_partitions(bdev->bd_disk, bdev);
>>>>> -    else
>>>>> -        rescan_partitions(bdev->bd_disk, bdev);
>>>>> +    if (disk_part_scan_enabled(bdev->bd_disk)) {
>>>>> +        if (invalidate)
>>>>> +            invalidate_partitions(bdev->bd_disk, bdev);
>>>>> +        else
>>>>> +            rescan_partitions(bdev->bd_disk, bdev);
>>>> Maybe use the new common helper to replace above.
>>> What do you mean exactly? Because there's only this place that has the
>>> code
>>> pattern here...
>> The above looks same as the new function.
> The above is changed in the new bdev_disk_changed() function. Patch 1/2
> factors out the pattern and this patch changes the behaviour
>

Oops, yes, sorry for the noise.

Thanks,
Guoqing
