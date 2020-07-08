Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41DCC433DF
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 13:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E8FB2065F
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 13:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="PTpAiqd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbgGHNgn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729622AbgGHNgn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jul 2020 09:36:43 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AB7C08C5CE
        for <linux-block@vger.kernel.org>; Wed,  8 Jul 2020 06:36:42 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l12so50527016ejn.10
        for <linux-block@vger.kernel.org>; Wed, 08 Jul 2020 06:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=03JonGFN41nMFJlGEFKXl9Bpzl1Ujvr23TaWRry9onc=;
        b=PTpAiqd5RBCVgLGXWMXrunrli3T+E2DRzw707sA1qaIazkk1zVS3jiycB3+KP5jLb6
         m5YAmUwQ53ftCOo62gFY/HYloYVnKUhS7Iq5KBCW7w/UDdy9bMPKAXqQwU2jz85e2vGC
         ALkviGT9PZvm4uM+oxth8Xd38yi3gsX+t8fkglimpP1cl2PmLCsHae2moo7n0uXKfUkC
         x9jXy10+LnxamCFwmlbp5Z4LbzKA6B2rPgPjXdo+raNSneJhTjdyYqESlCLAcPmbcOL3
         pF6A9AIhJ+bvbpu/AiGswEK3ZxopazEVxQuVGD9j3jsGzaXppove6apHUkvn5LQRItim
         kxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=03JonGFN41nMFJlGEFKXl9Bpzl1Ujvr23TaWRry9onc=;
        b=jsUvlR2fZngSr80i2TSjeKhnCV3/L+rLK2YcI3mgXQxGcINGkxzOKtLwSmSwODiyZR
         Vrpql1HQlLHAONKBAKfsWhJxdGJf3zhDlZrwVkjKk9MbdS49QvwZ3rmX2ArGnsqWfITA
         kj+PsPiiO5HkPMnwc5BipmhOykmTWDH8th5o762D58NWv/fEuQ9P2JuWNaMIBzIT/BeX
         wgvdpPW//SuwfnXafaLZyTb6NUV1vXtCJejC/8i21I3DJdTLmW5xfR+UgCPi0dI9ASZH
         laOR0uvWDgUzFVpLoHibMHMcbURxr85OA+7E9/J1BQyzFC/iJu1nlTac0l/CKHmnSawh
         zslA==
X-Gm-Message-State: AOAM532/CeOHwmCVZW9dzkTdVqg0EwKWBlXkaSPIRCPKUi0vN7AqhJPz
        +MkaFYjIBYWrFTr7ODFYY2XPhQ==
X-Google-Smtp-Source: ABdhPJwVfFoW6iQQ+fqbd7xp/1R/wW/saRz131MOzHu2XUHAvs/Onqzqo2VydVyKgnOzuUcxyR0yLw==
X-Received: by 2002:a17:906:7b54:: with SMTP id n20mr50913962ejo.144.1594215401541;
        Wed, 08 Jul 2020 06:36:41 -0700 (PDT)
Received: from [192.168.178.33] (i5C746C99.versanet.de. [92.116.108.153])
        by smtp.gmail.com with ESMTPSA id d26sm26632583edz.93.2020.07.08.06.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 06:36:41 -0700 (PDT)
Subject: Re: [PATCH 1/6] md: switch to ->check_events for media change
 notifications
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <song@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200708122546.214579-1-hch@lst.de>
 <20200708122546.214579-2-hch@lst.de>
 <09cd4827-52ae-0e7c-c3d3-e9a6cd27ff2b@cloud.ionos.com>
 <20200708132338.GO25523@casper.infradead.org>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <69412063-07eb-ddd1-2fee-2d3e1258cecf@cloud.ionos.com>
Date:   Wed, 8 Jul 2020 15:36:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708132338.GO25523@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/8/20 3:23 PM, Matthew Wilcox wrote:
> On Wed, Jul 08, 2020 at 03:17:31PM +0200, Guoqing Jiang wrote:
>> On 7/8/20 2:25 PM, Christoph Hellwig wrote:
>>> -static int md_media_changed(struct gendisk *disk)
>>> -{
>>> -	struct mddev *mddev = disk->private_data;
>>> -
>>> -	return mddev->changed;
>>> -}
>> Maybe we can remove "changed" from struct mddev since no one reads it
>> after the change.
> You missed this hunk:
>
> +static unsigned int md_check_events(struct gendisk *disk, unsigned int clearing)
>   {
>          struct mddev *mddev = disk->private_data;
> +	unsigned int ret = 0;
>
> +	if (mddev->changed)
> +               ret = DISK_EVENT_MEDIA_CHANGE;
>          mddev->changed = 0;
> -	return 0;
> +	return ret;
>   }
>

Yes, sorry for the noise.

Thanks,
Guoqing

