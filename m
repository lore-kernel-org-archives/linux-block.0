Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33947C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 16:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28F820825
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 16:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZTpOq3CY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28F820825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbeKQCa4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:30:56 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:33639 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbeKQCaz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 21:30:55 -0500
Received: by mail-io1-f53.google.com with SMTP id f12-v6so17488541iog.0
        for <linux-block@vger.kernel.org>; Fri, 16 Nov 2018 08:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jj35fgeniWyp+tA3d7evBYZDzySFFYlZF5QLhQOAAmA=;
        b=ZTpOq3CYqYARBvP6bXfaCJxEFnJIawpV75NtBjVBhV81q/fQP4RjBmUgrsgmmSuV+l
         ukGtadQ4ZEZv9lnWp5E8wT/gBeUiH+dmUNckMRgLy18xdfjDkwBNATTnlH1eAw0CQrmx
         m0Ir4gyswhVOLnQyaeh6lPrcyUoAqNzTGKAfPIGRKwx9UIeD1nlCQdx8jRqRr1cfENW5
         9iBlyikikqNt4h16qQzvyl3fQWs9qzjIZAmb8ME69CPT6jfyDAw8xdusnHSNzz0D+59R
         gQnWnY2PyskF3pxtO9iMUQ6kJxYShflLxrpwmF1FwXA1687Xd3+B8liDdUaPsDgAOx31
         I1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jj35fgeniWyp+tA3d7evBYZDzySFFYlZF5QLhQOAAmA=;
        b=sjZ7mn+ermMoNCVT3LpB0mKcB3tFxpeFMHV3yLaQkUab1MNGs9vfZ8P53VO47fjR3B
         vODHrlc9vYF52Tk97nuH63o4tEQ+UfqI/VJ3Q780ocPDEe06//YBZCm0m3jo1M7IUuCQ
         L+j9tMRBbSM0jYUsYcBH1kOTwiEI3zZDknX2M7jwvtcMvL3NveYXy/nREv0LN4//ylG/
         E8s8yMkqe8J58tu/YgmP63A+8qPOHmIUP1i1TKnAM5y5oKj62y00F8z+00VpuB0OxxiA
         gRs4Wm1TRswlTYZSUQn5Zt1wstuOCTSk1ue0js51FgCsGUAsaeFd9VkU/YIdzMGS5X0b
         EgTg==
X-Gm-Message-State: AGRZ1gJ89NItCIlaI7mCbMcHpH/SVFb6pqJbdlGwQBiPMkykuQyQUR7m
        Qj5ybfsjorM8KJ1ubyTNf3s6jg==
X-Google-Smtp-Source: AJdET5fcV1YUooC74+fDGjEuvxmyTV3J8S9MrcbvafPYiEWN/3ir66uXD5izvKZjwFFkIZBDhdKr4Q==
X-Received: by 2002:a6b:b5d5:: with SMTP id e204-v6mr8593439iof.233.1542385074718;
        Fri, 16 Nov 2018 08:17:54 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j18sm9977801itl.20.2018.11.16.08.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 08:17:53 -0800 (PST)
Subject: Re: queue_lock fixups
To:     Christoph Hellwig <hch@lst.de>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <20181116081006.5083-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bf3feb54-29a6-64e7-d005-59b307694f70@kernel.dk>
Date:   Fri, 16 Nov 2018 09:17:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181116081006.5083-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/16/18 1:10 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> a few fixups for the queue_lock conversion, drop a few more bogus
> queue_lock uses in drivers, and clean up the mmc use of the queue_lock
> as suggested by Ulf.

Applied 1-5 for now, giving Ulf a chance to checkout #6.

-- 
Jens Axboe

