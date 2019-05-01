Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764FEC43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 21:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1B72085A
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 21:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zuyE1eDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfEAV5Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 17:57:16 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38805 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfEAV5Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 17:57:16 -0400
Received: by mail-it1-f194.google.com with SMTP id q19so1359itk.3
        for <linux-block@vger.kernel.org>; Wed, 01 May 2019 14:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=TuzrgtFnewRP7Az/ul/8XSuGGtyu58jE0oPsW6+MEAI=;
        b=zuyE1eDhKGoj82/2Fhg7aMy0ci0Lu6OK6LcYuEMrFei7aUhMOqFe47RYDBR/Aacen8
         TrJPQpuBATcYNwAAE6U/kA2vkesbB0WjaF91oy3F6MPM5mipLNUNFL0wdeWGh+zqRte/
         dum7CIT49PHZcYDSApfFGppqqZi+FoXzckJExcxI2DY+LTQS4IxLNWpWR2c1eMJN5SsZ
         XSMoNyHq5lAA4adtPZgQSXeqUaQC/NJtax9oywb93ubkG8W1A1eM991B/nYCVwjmKKr4
         lqPbiEbj4s6lFBZSie8BQf9oQ7ZM5ACsOEEfUZxju7jyxAdQdSCrkPlROKKHUeQ/sI4C
         rE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TuzrgtFnewRP7Az/ul/8XSuGGtyu58jE0oPsW6+MEAI=;
        b=KNAMK2BasZGrPjsjwa4axpBP3sxficFoo1IV/Hk1ViS3biDXIPf7aAWQj0J6vslkvv
         6V97EqfiK8dPyIHr0CbA9PzfoUKT2wQRuSgS6+rOfIsjrk1IjK4JfMWgKmODrMXc4UpB
         7EzjkaLB7Blt0+kCejzdGZsbewCUlqXN5cg67pSI8qtPeSqsnfFc/uV/9Kwsk7nK+NCi
         SIY3xgLxvgeJ0LzUE6vY/xRaadlgV2+Co7vr7R2sSK5FB5ElSRqi+iReQ+NFQ3v8xc7u
         JfB7KA91YNuv/jAUoipqVr0wN2OxOjMqZF/ZYaWILREDo5x86CwLGPKHc6D8FJwEpUY5
         hK8g==
X-Gm-Message-State: APjAAAV4gT/Xa3R330cfc7NejqyC7HI52JeHfzkAtJ3cAD1CdjK2Xy6T
        vcrTBDYmIP17rQtmmbQ3zT/I3lZwuEwf0A==
X-Google-Smtp-Source: APXvYqz9/cdAtBgYCfg98tPbhFuc2v8QLYYXTs9aHihYSWRS5MJM6E2fMfiggX556KpgYaSpi1Dw6A==
X-Received: by 2002:a24:2e4f:: with SMTP id i76mr9619870ita.171.1556747835400;
        Wed, 01 May 2019 14:57:15 -0700 (PDT)
Received: from [192.168.1.113] (174-23-158-160.slkc.qwest.net. [174.23.158.160])
        by smtp.gmail.com with ESMTPSA id d133sm4004433ita.5.2019.05.01.14.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 14:57:14 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] [io_uring] req->error only used for iopoll
To:     =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20190501115336.13438-1-source@stbuehler.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f9499cb0-8e00-8e82-0acb-edf1c5556f21@kernel.dk>
Date:   Wed, 1 May 2019 15:57:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501115336.13438-1-source@stbuehler.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/1/19 5:53 AM, Stefan Bühler wrote:
> No need to set it in io_poll_add; io_poll_complete doesn't use it to set
> the result in the CQE.

Looks good, I added this for the 5.2 series. Thanks.

-- 
Jens Axboe

