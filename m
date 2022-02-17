Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D55C433EF
	for <linux-block@archiver.kernel.org>; Thu, 17 Feb 2022 12:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240579AbiBQMyX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Feb 2022 07:54:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiBQMyV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Feb 2022 07:54:21 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC4BCA338
        for <linux-block@vger.kernel.org>; Thu, 17 Feb 2022 04:54:06 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id k3-20020a1ca103000000b0037bdea84f9cso4014794wme.1
        for <linux-block@vger.kernel.org>; Thu, 17 Feb 2022 04:54:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=OLDvzjrFTqZgzIT+FeW4Y35OjdyPdjXfrYDGwKLWfOW6zSp1y0+HouvIK5S2zJ5Zt8
         68BbKNycBEGFKBDAcC762Yv7t+3iujoH0/JFxhoSyjm7k7jkMF7SuozF+aEdV5CqXyES
         Zp6WeU9Bcso3jKvVd9LZoXu0HxPq0ldTR/jbn1v7jA1UWUDu/W09Jiw8qwepggzgmeE2
         0VkKF3GkNm0KJ6jG5kFspPtkJF5fg2ovGEqPGTqFhKMjQj1Hqu5J1LHKdFnp2Pmshnix
         C9LDcYXlh0aIqqEAVSPyC5FmAjRUWo+Pc1nWN4s27k2BjDJIFB3g7dGYOvszXk6OyVjc
         2hsw==
X-Gm-Message-State: AOAM531VEXhtn9vRdxlStE168oUdzFHpf8iJRy8LGkeqxMR+kT6K0GBB
        b8UmmWdqAWaMkyQoFCFz8hM=
X-Google-Smtp-Source: ABdhPJwqHK1mcwHOtWnhj2Zn0qY/XXaoU2Xqb4f0AF05uGu02xnYqvO/rGZcFfY8cVDRx6mMhXFBNw==
X-Received: by 2002:a05:600c:3b83:b0:37c:e735:ad87 with SMTP id n3-20020a05600c3b8300b0037ce735ad87mr2574445wms.120.1645102445164;
        Thu, 17 Feb 2022 04:54:05 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r2sm28534947wrt.65.2022.02.17.04.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 04:54:04 -0800 (PST)
Message-ID: <98b5a633-0b78-f3bb-f9c3-a2f1f3f13bc5@grimberg.me>
Date:   Thu, 17 Feb 2022 14:54:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] block: fix surprise removal for drivers calling
 blk_set_queue_dying
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     kbusch@kernel.org, markus.bloechl@ipetronik.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20220217075231.1140-1-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220217075231.1140-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
