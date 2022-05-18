Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDB1C433F5
	for <linux-block@archiver.kernel.org>; Wed, 18 May 2022 22:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiERWjM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 May 2022 18:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiERWjL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 May 2022 18:39:11 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B283E1756A6
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 15:39:10 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id a9so1383460pgv.12
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 15:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TwGOpsZXmKjMebcqrmfjeutofyqjwqigUU8vU4Hxsjg=;
        b=ltO2bQWW4c9ju/2uK55hWAnRfjLi5f6mWGgzjz+VPPbGZ9A+Y4IqXH3hn1+sOU0dgX
         3kzudr1+8/ovu8n19SlVF4F8g6lWWCnvNZPtj3FENTwMhz8oV2+JX2J/wfE0MHsroYv1
         65ezdDzYMJ03lYT5W919MXR/+aWgKuaOxk7wQjYfWH1DNzxQMqo5WPFH5lF4J0Q1VkAB
         LWjqwoh+x5b10U22YJQQAzXg0sMYMTmi8g3MWKaaOa3ejSvZfPrziZmGewd6tMdd4XXG
         YTJRg1XzLyscAApvAZ5nzeisLEfndH+iMkGbPUIDOV+dJq8SJKLwZRllbeuf/Y5cS3vN
         ZYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TwGOpsZXmKjMebcqrmfjeutofyqjwqigUU8vU4Hxsjg=;
        b=G8Gc/1t82DvS2YBp0h41+OkOD3eqmfijcJnWhcEMEazgBQMIEYASyh1MQPTRW8OqqB
         FJrA+DkjmwqlGip2fNgGYjn2bGiKB1tJ2gPxP2Yp4Hz/BXFWGZFPjFwZn96PaiSdwBnp
         2LeKxK1/Kvl6SgbBjxVVe5fvJAslPeXQWNaUN+BPFH936ejbs0hrx0n07Owo5P077MHU
         l34VmZ2KZROSlcRp82nUDEAg7VM71eHxaL/Enf5QQdmbtI5CQxGjCLjrro9hOA09UWb/
         qBVzoy2SKegJ3wSy86RclBduYmr7l4YE4woPkVy7uxlszBKUVYSbK1uznYi0KoYhX2nf
         WLIg==
X-Gm-Message-State: AOAM531x6DHKLbOH0zfi13XEXeaL7uOteCvIbwb9rD/chWcXfStMe5IC
        OEQ71b9JY3gqjikacyMzZNLe6y5psgVuIg==
X-Google-Smtp-Source: ABdhPJy7E1edQgt3ih3y4+NE5mAm66sIVfltCyXZCC1mkjHKtj6Ok+XbL/9nyPA5caK7Eaik3CwV4g==
X-Received: by 2002:a05:6a02:208:b0:3c6:9898:e656 with SMTP id bh8-20020a056a02020800b003c69898e656mr1406244pgb.560.1652913550177;
        Wed, 18 May 2022 15:39:10 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u1-20020a170903108100b0015f2b3bc97asm2147095pld.13.2022.05.18.15.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 15:39:09 -0700 (PDT)
Message-ID: <c412b561-defe-dd86-1d4a-14dc10fc20fb@kernel.dk>
Date:   Wed, 18 May 2022 16:39:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/3] blk-mq: remove __blk_execute_rq_nowait
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
References: <20220517064901.3059255-1-hch@lst.de>
 <20220517064901.3059255-2-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220517064901.3059255-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/22 12:48 AM, Christoph Hellwig wrote:
> +	} else {
> +		/*
> +		 * Prevent hang_check timer from firing at us during very long
> +		 * I/O
> +		 */
> +		unsigned long hang_check = 
> +			sysctl_hung_task_timeout_secs;

Trailing whitespace and odd formatting here, I fixed it up.

-- 
Jens Axboe

