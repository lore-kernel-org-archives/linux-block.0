Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38CAC4332F
	for <linux-block@archiver.kernel.org>; Wed, 14 Dec 2022 16:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239005AbiLNQ4w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Dec 2022 11:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238864AbiLNQ4v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Dec 2022 11:56:51 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09A81A3B3
        for <linux-block@vger.kernel.org>; Wed, 14 Dec 2022 08:56:50 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id p6so3689667iod.13
        for <linux-block@vger.kernel.org>; Wed, 14 Dec 2022 08:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQKY6n7m8NgblNOiTPoGQcWD1P9sRiAJmGKmfHIQaJI=;
        b=qDiKuv3fl7iPMbNQg9zsteNnbztHAVsD0qiatsZnMDeWRzSCENzuNxv7fKTpR+Aw+r
         ECz5GcXEvCuKQDcHXOMTehJ1L5S4PpdMcTf3ybKc3xVfHxgUG12zlkpPgbt2fzGVRC6f
         kUPYozQIOLOtXEUGvyVZSPyQFiS9fFd2SO6uuS5xj/GSFMWnpKviC2uBk0oaJKCm6zE+
         DsWWHeR3MKc7e8NNBk6Uyqp0DVkcJypwUYLBfpKRPRrjJ5WjnsyTpod1l/oQeYM1VKur
         Rm4ThNy1htZjuZnUjH2X/8HKwcDCdQRCIWa8WwnxmqFFMAWZlr0dsHlqBsENZZAQbuBw
         E3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQKY6n7m8NgblNOiTPoGQcWD1P9sRiAJmGKmfHIQaJI=;
        b=aTA2dqokGfqZ9OVmQLI9OypZo2wUj68VWh7g6yZy2mpqki/hm7J1sUuxVNgjvufUuu
         piESb4eICT/f17SChBQRMfl13ktP5OnsWnCA6Hwl5EG/GKaBSu3QwWVrvkfEnl+Xfb3K
         DBArWaDVtXt818GQrHVKx2zBf1eB+y+4afArkaFJ2UGHSSHIhwl96aagFb0KP0gncYM6
         FasdrnVO541yNRp4KIBf0Df0QcLHzrfk0aSKoX9XffJJ25uJwhkVe/DkTWe728omVHrl
         2Jf2R7oU80bUvSUPwOfPRdIg/RKRIQA4e07fEOnvmz9jfe4oHMqAItmAh45pgiWJ+qme
         rkBA==
X-Gm-Message-State: ANoB5plvcaR27eBFBSl1TZ5qrrpBuK3P3XDz/6wZPd4LnhoSTMFIuoVk
        kbeCITUyOuudbsJ6ALCt6jOnKw==
X-Google-Smtp-Source: AA0mqf6EevuivNXXAQi/VoNVtUci6/oMtUNuVbFhp6RbiFmC3pFn9nxylIiq7PZMzgNMOJPACpmzzg==
X-Received: by 2002:a5d:9141:0:b0:6c2:13a1:ffc0 with SMTP id y1-20020a5d9141000000b006c213a1ffc0mr2767580ioq.1.1671037010203;
        Wed, 14 Dec 2022 08:56:50 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f26-20020a056638113a00b0038a6ee3c07bsm1929874jar.62.2022.12.14.08.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 08:56:49 -0800 (PST)
Message-ID: <974973f8-c703-59aa-5afe-40b33429fdbb@kernel.dk>
Date:   Wed, 14 Dec 2022 09:56:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3] block/blk-iocost (gcc13): keep large values in a new
 enum
Content-Language: en-US
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Martin Liska <mliska@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20221213120826.17446-1-jirislaby@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221213120826.17446-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/13/22 5:08 AM, Jiri Slaby (SUSE) wrote:
> Since gcc13, each member of an enum has the same type as the enum [1]. And
> that is inherited from its members. Provided:
>   VTIME_PER_SEC_SHIFT     = 37,
>   VTIME_PER_SEC           = 1LLU << VTIME_PER_SEC_SHIFT,
>   ...
>   AUTOP_CYCLE_NSEC        = 10LLU * NSEC_PER_SEC,
> the named type is unsigned long.
> 
> This generates warnings with gcc-13:
>   block/blk-iocost.c: In function 'ioc_weight_prfill':
>   block/blk-iocost.c:3037:37: error: format '%u' expects argument of type 'unsigned int', but argument 4 has type 'long unsigned int'
> 
>   block/blk-iocost.c: In function 'ioc_weight_show':
>   block/blk-iocost.c:3047:34: error: format '%u' expects argument of type 'unsigned int', but argument 3 has type 'long unsigned int'
> 
> So split the anonumois enum with large values to a separate enum, so

anonymous?

-- 
Jens Axboe


