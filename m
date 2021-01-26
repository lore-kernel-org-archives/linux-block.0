Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB59C433E9
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 22:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B684D206B5
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 22:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbhAZWAA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405422AbhAZUM2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 15:12:28 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0CFC061788
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 12:11:47 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id e19so247595pfh.6
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 12:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gsLi9w0Y4VoM2WEdXfeAxIRmg7gY3vC0ka6QScX9Qk0=;
        b=XOIk8xuZYOGk/IopvkReuEwpWyumM5GT++t/GopcYmkU0uYOfC2hSzooDefPbe8wlE
         wXJJx1/nTw9PjaSNpG7stVspEppnpf6pdG5I02IKDbig10nIDRMdMf0CRT9jsjITc+/T
         T7oUwop9r52hsuKw3QqBbW3IJlaZZD0UOoIr9PUuN3JFpXSsYUj0x4VL4DfE2N2QxxdV
         aKjX8i1Ka5Z8vAuTXBbENglp51l9bBcimoyF9XrJoM8zRnPJTiGxV4yydLebQ76nIiGQ
         DcQfvHvXdGplfDkGTgdgMFupMMGt/Bs0FArgeE2HSOw6i84n2VZlFXpBYJobvnlHJa2m
         KQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gsLi9w0Y4VoM2WEdXfeAxIRmg7gY3vC0ka6QScX9Qk0=;
        b=U+rCHVR9Vp0qxzMsvE5srmGOCMmAOT8vLrfqV4Tpb8vNi7c2AZsjtuDzSAV5EvxbLp
         23P5EI6o5433yzNYY5MJitmZ1B39O017VXARv6RaY+801aRgfGjm6ndstiM46zl2iT+Y
         1ZFzVDrYdR++mg7Pupa4d2uIsYdmtTBuJXVfVIpIx7nJhkRdTV5AvRIce/8YsiCys7Hb
         haJrK+sCLyD3c+9jhEg9T9Pu2GmhY4UPbN/92bqYRpDH5M700/bJV9gU1xtGMyCmFy2y
         EXthHPMBSwmXWBJsOU40BIU0sAmxaTQlBSD9ZfyqR81+ELKCNJReVkWoKewzo+h7DEwB
         x8JQ==
X-Gm-Message-State: AOAM533xCEwr7JRq8P3GardS25y7nfeZShGfnaizWrUQe0LcFXr+ERoC
        LTVG3Ug1Sf158aFwpDpu7uFunA==
X-Google-Smtp-Source: ABdhPJy4tLLL8Pd0yH4ZK3eN7RinUSAZBefkzR4TvYorEsZxkRFNy7ad9p/lZ9JXMvvYLqSqI5pltg==
X-Received: by 2002:a62:9295:0:b029:1b7:b74f:75b1 with SMTP id o143-20020a6292950000b02901b7b74f75b1mr6623587pfd.67.1611691907426;
        Tue, 26 Jan 2021 12:11:47 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id gv22sm2912296pjb.56.2021.01.26.12.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 12:11:46 -0800 (PST)
Subject: Re: [PATCH RESEND] drbd: remove unused argument from
 drbd_request_prepare and __drbd_make_request
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-block@vger.kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com
References: <20210121142150.12998-1-guoqing.jiang@cloud.ionos.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b3880d87-26b8-924d-f674-54c2a671f70f@kernel.dk>
Date:   Tue, 26 Jan 2021 13:11:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210121142150.12998-1-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/21/21 7:21 AM, Guoqing Jiang wrote:
> We can remove start_jif since it is not used by drbd_request_prepare,
> then remove it from __drbd_make_request further.

Applied, thanks.

-- 
Jens Axboe

