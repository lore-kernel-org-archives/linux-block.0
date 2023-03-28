Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12651C76196
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 08:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjC1IgE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 04:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjC1Ifn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 04:35:43 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F35D5BBD
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 01:35:06 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3edc2294fb4so5628615e9.0
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 01:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679992504;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vrb82PZhwYG30G9CvM6x/5xpRlj5GG8gb4X+iqQeUvE=;
        b=IK8FV2LCtv8sMISqFDyoH8mYemhjghgz1NCvlyMC2PGCu/lw3I/X3FTv838YzFx7HH
         oMK8RGURyiS5L3HOXSvgkQ4poAmbMvLMPPd2uxkouCm8GVwnbk3G/wODYJ7u8tCc2/f7
         UEU3o0llxAZ7l4GfCaVcY7LnMg76stgZXTa0/Qs3cWwhiK0oVTeXTXRCVzF+XB3rqmRQ
         S58ReuWSP5+D0YctH9sgdmsKEdlxZajQv/TOPXvU91SKkTd4BsRWH62ERiwGhz9znk6X
         JEDyOGqBbqYaBIqTvt2GY3+0HpJsKkTwSSAs7E1+IUx8UFWdLOUXD43n7NfNBmABYeTo
         O9sg==
X-Gm-Message-State: AAQBX9cHC93Hu+5ur2t0YRizAcTtii0z1Vc4EOC8Hu6Iev3aYHajg9gn
        0GWlS8+NEjpyz/Hr+vka4zI=
X-Google-Smtp-Source: AKy350aPgWujwxXnHUMyKZo6LhoKJejbw5YY4NYR2NvmUCM7+HLiJpTNjHb/chW37R084iceeRJxBA==
X-Received: by 2002:adf:e786:0:b0:2c7:1c72:699f with SMTP id n6-20020adfe786000000b002c71c72699fmr8950485wrm.4.1679992504599;
        Tue, 28 Mar 2023 01:35:04 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p5-20020a5d4e05000000b002d75909c76esm20163490wrt.73.2023.03.28.01.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 01:35:04 -0700 (PDT)
Message-ID: <c90eff27-9d27-386a-ce07-459ebba3cde1@grimberg.me>
Date:   Tue, 28 Mar 2023 11:35:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] nvme: use blk-mq polling for uring commands
To:     Keith Busch <kbusch@kernel.org>
Cc:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de
References: <20230324212803.1837554-1-kbusch@meta.com>
 <20230324212803.1837554-2-kbusch@meta.com>
 <55f9c095-32c2-648d-7ac9-84c1d9224abb@grimberg.me>
 <ZCG2b85hN+pTm/VZ@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZCG2b85hN+pTm/VZ@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> +	if (blk_rq_is_poll(req))
>>> +		WRITE_ONCE(ioucmd->cookie, req);
>>
>> Why aren't we always setting the cookie to point at the req?
> 
> As in unconditionally set the cookie even for non-polled requests? We need to
> see that the cookie is NULL to prevent polling interrupt queues when an
> io_uring polled command is dispatched to a device without polled hctx's.

Why don't we export that to an explicit flag? It would make it cleaner
I think.
