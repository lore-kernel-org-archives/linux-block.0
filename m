Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A72C433DB
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 13:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3A6A206F7
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 13:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732060AbhAUNat (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 08:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732024AbhAUN33 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 08:29:29 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1FCC0613C1
        for <linux-block@vger.kernel.org>; Thu, 21 Jan 2021 05:28:49 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id kg20so2107351ejc.4
        for <linux-block@vger.kernel.org>; Thu, 21 Jan 2021 05:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IfhaMJYLoML7Y22BrUgxjVOkVeb6b5jyB/SWAlkSAAA=;
        b=yg/3qXQQpHmWkucO4vOujODLkimtJry2Obbr+4KNPw0Nwy4Sf+OfP/mZ+1cCBEy+6N
         BzNeheO/U1tGD9atl0QvMY9LfBJt03NcZdZ/yqxDhbbFl3p2tHhh7ctp9WrE7MI5qjUb
         SX/pY3ujErsukqI8Q8gRnXKU91SYLeB2NTxcTebKEAS237W9VS+MoQfq3/AAaG9ynXYZ
         n+1RSp/I8ZsclB4kc+5YOBdL8g+OXQGi6GnYgJAR3A3HDhOra7lH1V5pxUzl67LKNhjF
         YfKpH+zk+kU2L7dB/UywWiovzTS+CCwIMZvjVMraIQZWbssZUs1qOalnavgXMC9HcZuv
         RdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IfhaMJYLoML7Y22BrUgxjVOkVeb6b5jyB/SWAlkSAAA=;
        b=XP6aEARZrTgoNs3WzdIpvvvngks2rBKkAqEDiZ+e645zpHeUEtZm+saUHYfsMIaLx3
         62OicBlId7sN2vVa5ZOLA1bwvOyxKEh5JNhg7hG6v0xKGjQBfZji++aBQcw3QPF58XVn
         QayK99S7ls7RDnr5+xV3F9u3PeUw8y6ivFwR301kkm+/EJnUHNkITnuBXSYh/KYqdxQd
         ihZE8UV15kvwVqOQ3OSG50EjTaI7gxlcP/vLrAraIBuw8H9tkGwQXbARKW4mCLBL+mwF
         qlfnwDPftCeD4RrfS5JVtDBJajVOGhnuUVrB15W+BkNxQpeDFnaxt/HGJCFT+jtQwouM
         1zFw==
X-Gm-Message-State: AOAM533MtnAdyen5ZNhtcky9WZ7+GBtjyhpvxSGZ0aUpb0JqVMeubppz
        R+FN08p94cAzCzDACf4qaFdo6Q==
X-Google-Smtp-Source: ABdhPJxbJ0xuGRoqkN6QYXdsmNuAuLeEgWPW6hZWUBo9DdsCwq/nMg/5pMx7SNLoEdYBaQlkY/f4Qg==
X-Received: by 2002:a17:906:14ce:: with SMTP id y14mr8995342ejc.366.1611235727873;
        Thu, 21 Jan 2021 05:28:47 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id ce7sm2238183ejb.100.2021.01.21.05.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 05:28:46 -0800 (PST)
Date:   Thu, 21 Jan 2021 14:28:46 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pan Bian <bianpan2016@163.com>, Matias Bjorling <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lightnvm: fix memory leak when submit fails
Message-ID: <20210121132846.4t4ijlogfi2pndpf@mpHalley.local>
References: <20210121072202.120810-1-bianpan2016@163.com>
 <55045608-01cb-d5af-682b-5a213944e33d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <55045608-01cb-d5af-682b-5a213944e33d@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 21.01.2021 05:47, Jens Axboe wrote:
>On 1/21/21 12:22 AM, Pan Bian wrote:
>> The allocated page is not released if error occurs in
>> nvm_submit_io_sync_raw(). __free_page() is moved ealier to avoid
>> possible memory leak issue.
>
>Applied, thanks.
>
>General question for Matias - is lightnvm maintained anymore at all, or
>should we remove it? The project seems dead from my pov, and I don't
>even remember anyone even reviewing fixes from other people.
>

At least from the pblk side, I have no objections to removing it. I test
briefly that pblk runs on new releases, but there are no new features or
known bug fixes coming in.

Current deployments - to the best of my knowledge - are forks, which are
not being retrofitted upstream.

For completeness, I get a number of questions and request primarily from
the academia. These people will probably accuse the lack of LightNVM. I
understand though that this is not an argument to keep it.

Javier
