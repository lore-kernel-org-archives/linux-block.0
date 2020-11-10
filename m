Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BCFC4741F
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 10:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8EB8207BB
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 10:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="zk/3RsKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgKJKPd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Nov 2020 05:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJKPc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Nov 2020 05:15:32 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86F1C0613CF
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2020 02:15:30 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id k9so12068049edo.5
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2020 02:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OJOkjF/XcHi2FZlRaU793W8VWHWoTtmd6m46I1hFRlc=;
        b=zk/3RsKuZjCVv0t1nteStYNB/HcBCqzymtN+1ok7gMlowAmPS26fuStaSNdQEgUmv3
         q8T63tFzJ/Ps6TboGv1AiLo27qQOkS1ZvFlurM6xvf34eyGLDFtJ3/vmF3/EvTlE9N4j
         8WVXhSDN04rqjuTHgnF50l2V+IW4xDnBV0HD/DubZsUQX5jWDAfQQeD4J0EXDQqAQuxn
         gY9dOvRkSgaSkce30FGzJRZ55/iCTT4xOWw40EFFSF0ALR1auedfox0GIfukyAh7SgbU
         wqEpfAlpYhvrtPcJo0Rg6jYs6SmzuixrJJA4sGIikoYszEyH73bmeSQTuD41tWdLtI0A
         9zRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OJOkjF/XcHi2FZlRaU793W8VWHWoTtmd6m46I1hFRlc=;
        b=F65MqjTk1CMlB9rWNxp8FfYfttu3w7yxHQR7PrVXrPGFa2wettxfp+XVNWIjnuri+d
         wKrP3XKB7tgp5rBDdrNQIJlhYCPj1no44Puj56vQsZJpjC6pQEu0a5R4oMlnHJlOwO60
         Bz6ssJdCprroqJbXIw/UFTBiqg05nQXMEDfsggHF0smolTSmtzetmL7V7heH40uEuzb3
         O6SoFgqC9gtqzzzio8I7O3ac4SIIoamt5DPVzuD9wgLDdInTvgKSuWIHk2EmlOAVK/Te
         KGaHZDsstlNZ8QeIPoaBW23Ra1rYRKgYoZBb9iqwS5p3h/GE4K8JkTRmDtR06d7Uxvx3
         ksjw==
X-Gm-Message-State: AOAM532BN+Z/vb9sDkteQitGFdMVnYOXXmNBLafNm8WXRENojqF3FK4y
        qG6z3T7c9O9KkoPnt1i6Dh4K0Q==
X-Google-Smtp-Source: ABdhPJxHLEHhFYa0zWNPnJ6aQ/Hiio+ArZqt+ltC1Wco3+Uc76zuq02PmeMSUSDs+WwuHG7QpdRDMg==
X-Received: by 2002:a05:6402:559:: with SMTP id i25mr20784439edx.128.1605003329529;
        Tue, 10 Nov 2020 02:15:29 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id c5sm10054069edw.67.2020.11.10.02.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 02:15:28 -0800 (PST)
Date:   Tue, 10 Nov 2020 11:15:27 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
        joshi.k@samsung.com, k.jensen@samsung.com, Niklas.Cassel@wdc.com
Subject: Re: nvme: enable ro namespace for ZNS without append
Message-ID: <20201110101527.6bvanzvux4qtnjk4@MacBook-Pro.localdomain>
References: <20201110093938.25386-1-javier.gonz@samsung.com>
 <20201110094354.GB25672@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20201110094354.GB25672@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10.11.2020 10:43, Christoph Hellwig wrote:
>> -	if (id->nsattr & NVME_NS_ATTR_RO)
>> +	if (id->nsattr & NVME_NS_ATTR_RO ||
>> +			test_bit(NVME_NS_FORCE_RO, &ns->flags))
>>  		set_disk_ro(disk, true);
>>  	else
>>  		set_disk_ro(disk, false);
>
>This has a very minor conflict with the patch from Sagi to remove the
>else side of the clause.  I'll merge your patch and will fix unless
>someone else objects to the approach.

Sounds good.
>
>Note that as discussed we really need a hard read-only settings
>instead of set_disk_ro for both NVME_NS_ATTR_RO and the zns with missing
>features case, but I'll look into that once I've got a few other things
>off my plate.

Thanks! Please, let me know if there is anything we can help with. I'm
looking into the char device now.
