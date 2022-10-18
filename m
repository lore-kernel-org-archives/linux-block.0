Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E6EC4332F
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 09:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiJRJGs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 05:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiJRJGr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 05:06:47 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92654E402
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 02:06:44 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id bh7-20020a05600c3d0700b003c6fb3b2052so2587597wmb.2
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 02:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v93eNXmzPwiXrwCHFiAuODfKt84UHq2qJ0/xhTRG8ZQ=;
        b=YV87nq6r74brSaOQTRXnGwvj7s0vXGTPzh0WWxvXBCs53wSDd1PSl6jFzNuIdl+YfR
         4VrrobN2XD/i7QF7yR4ep2REbRd+Vk63+9cDjVf6cpXLVZNu81qRMhErcMLvIbrxiCOY
         ZvbWtbF7I6B4djiirbO3y8rriMKFkwOFWTSpp+x6S/XyaF1LERpIUHdHnoETAdixi6OH
         1vDibHMev7W+gG/sCbjhjeIRZmhwzRoFkAaVX/08ZGnGdJ8rJ/pWYIbYPiA4nNXG8IOj
         TK/Wn4WGwvi79ez11r7zwnhVzj0ptS50AjKw3Iwkf8iAlmBPgAiksfQqDNlRKjaPnDMz
         ZmNg==
X-Gm-Message-State: ACrzQf343mLQ/edPyaGXCnAECxQ2KRSKDWkLOgzHjEQ+YbiHRHRuZw9K
        jFIAMGOpa0fL28yUnlRBEww=
X-Google-Smtp-Source: AMsMyM49bWEGu0upxRjYoWsaRWbAgFxNRR9tL5Lg/JOCFd+pRckafbSt2Z/qcRrEAGF3Zb5Y+6xryg==
X-Received: by 2002:a05:600c:695:b0:3c6:b7f1:6f39 with SMTP id a21-20020a05600c069500b003c6b7f16f39mr1248821wmn.5.1666084003051;
        Tue, 18 Oct 2022 02:06:43 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v16-20020a5d43d0000000b00228d67db06esm10646674wrr.21.2022.10.18.02.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 02:06:42 -0700 (PDT)
Message-ID: <3a466711-860a-667f-b78d-daa1eedb4edf@grimberg.me>
Date:   Tue, 18 Oct 2022 12:06:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, kbusch@kernel.org,
        ming.lei@redhat.com, axboe@kernel.dk
References: <20221013094450.5947-1-lengchao@huawei.com>
 <20221013094450.5947-2-lengchao@huawei.com> <20221017133906.GA24492@lst.de>
 <20221017134244.GA24775@lst.de>
 <b0631151-4081-2fdb-fbb0-eab1db633200@grimberg.me>
 <20221018085557.GA28266@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221018085557.GA28266@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> The only question in my mind is regarding patch 2/2 with the subtle
>> ordering of nvme_set_queue_dying...
> 
> I think we need to sort that out as a pre-patch.  There is quite some
> history there was a fair amount of dead lock potential earlier, but
> I think I sorted quite a lot out there, including a new lock for setting
> the gendisk size, which is what the comment refers to.
> 
> Something like this:
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 059737c1a2c19..cb7623b5d2c8b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5105,21 +5105,21 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
>   
>   /*
>    * Prepare a queue for teardown.
> - *
> - * This must forcibly unquiesce queues to avoid blocking dispatch, and only set
> - * the capacity to 0 after that to avoid blocking dispatchers that may be
> - * holding bd_butex.  This will end buffered writers dirtying pages that can't
> - * be synced.
>    */
>   static void nvme_set_queue_dying(struct nvme_ns *ns)
>   {
>   	if (test_and_set_bit(NVME_NS_DEAD, &ns->flags))
>   		return;
>   
> +	/*
> +	 * Mark the disk dead to prevent new opens, and set the capacity to 0
> +	 * to end buffered writers dirtying pages that can't be synced.
> +	 */
>   	blk_mark_disk_dead(ns->disk);
> -	nvme_start_ns_queue(ns);
> -
>   	set_capacity_and_notify(ns->disk, 0);
> +
> +	/* forcibly unquiesce queues to avoid blocking dispatch */
> +	nvme_start_ns_queue(ns);
>   }

If we no longer have this ordering requirement, then I don't see why
the unquiesce cannot move before or after nvme_set_queue_dying and apply
a tagset-wide quiesce/unquiesce...
