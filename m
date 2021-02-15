Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671F5C433E0
	for <linux-block@archiver.kernel.org>; Mon, 15 Feb 2021 04:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AB4D64E8A
	for <linux-block@archiver.kernel.org>; Mon, 15 Feb 2021 04:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhBOE2p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Feb 2021 23:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhBOE2o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Feb 2021 23:28:44 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52638C061574
        for <linux-block@vger.kernel.org>; Sun, 14 Feb 2021 20:28:04 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d13so3032246plg.0
        for <linux-block@vger.kernel.org>; Sun, 14 Feb 2021 20:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y9rLIk8vmQ+GjmBKJydKgV4WguITvhXZ6Q3wPw9o0LA=;
        b=R2kncrmzKq8XuNkCy1GZC57SXYxU4rO7zKRTPz+ek+ZzNTo0D7eogDxTBb/fuj/Jfd
         KmNo/Cbe05jhLNN4kA7JV7v4fGKZP2Rnquy+iMrtdBVmu0VMXs+4oYGQiffQX0OMm/6y
         IQ+2+G2xW3CWBotFVgN0N1XNB8UqwvU54SYDw2bNFOXU95wE6eytxOS/mQo7G1FcE+hk
         Un/5k7KeY7gNgp0MLMISVVEQGXsKFXWu4go56jLGFrE1A0/bXDdOkC5+YYQUe6+DM6ue
         yYzxeMGLi73pWsFupjHsq/KuGhiFs/lAdYSsmM0IyvsoCreFuutMfM8/0LBwb43b8gJ9
         xwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y9rLIk8vmQ+GjmBKJydKgV4WguITvhXZ6Q3wPw9o0LA=;
        b=TilSzuxJt/IxQf61xB5qDF1R40vYLtvnC1Gbeqs/2sVjs2J/TzFSsNuAJsWuLNt/yA
         FKMmgir9bENL95tDw0z7HfN8cEvBN64LQ4EUqnVqdzs4iSIHG8oE5evcThwUuAXo7Cd2
         lenhneZtB2Su1KzygbJsLnb59IS4mbrjC/lswK8+IBVPn69YjwNt5izznyrn9e8BsL3h
         LFso2PSzoVMPdKwSF7F0cnippMC/C37bhweP7+lK+8giiIXnUjpuwEKNl1gjPscMO0sR
         gkb/73zfE7Z/1QVw9u+5clg6PHIfobE0bESsG1jfofp52sS2QJZtkimEknDl4olp2LlJ
         XsEA==
X-Gm-Message-State: AOAM532+uajRB4z8PTnCpCfEZwt8TA0ERNTxnKGV5su/eROiGDkI4C2M
        E17sA50OHkMiEUGm3mhopNrLkUhcF2KccQ==
X-Google-Smtp-Source: ABdhPJyAQNYx50hcB0TgmbF1UJkTSqtMNjXSPjZYVlE6v/Y+NHzKEaeIkCbIuX7SKw29g4RwE/WV7g==
X-Received: by 2002:a17:902:ab90:b029:e0:17b:ae98 with SMTP id f16-20020a170902ab90b02900e0017bae98mr13879390plr.6.1613363283877;
        Sun, 14 Feb 2021 20:28:03 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id z2sm16399232pfj.100.2021.02.14.20.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Feb 2021 20:28:03 -0800 (PST)
Subject: Re: [PATCH 0/2] lightnvm pull request
To:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>, m@bjorling.me
Cc:     linux-block@vger.kernel.org,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>
References: <20210214103103.122312-1-matias.bjorling@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dbb09acc-f4eb-14d6-4131-126c5d0ef674@kernel.dk>
Date:   Sun, 14 Feb 2021 21:28:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210214103103.122312-1-matias.bjorling@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/14/21 3:31 AM, Matias Bjørling wrote:
> Hi Jens,
> 
> A small PR for 5.12. Can you please pick them up when convenient.

Applied, thanks.

-- 
Jens Axboe

