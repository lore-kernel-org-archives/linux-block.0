Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22EDC433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 18:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 662A564F6A
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 18:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbhBBSjl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 13:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238631AbhBBSir (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 13:38:47 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ED5C061788
        for <linux-block@vger.kernel.org>; Tue,  2 Feb 2021 10:38:05 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id s5so11186038edw.8
        for <linux-block@vger.kernel.org>; Tue, 02 Feb 2021 10:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=odCEBJJ2/dNv63zc58f7nNICas6kDLHkL2UZrPTeD8k=;
        b=EfElAlHxeatUdCJU0xKGiA/6MITNkwtYUxu9clULENb/PWxIQ/npVjmfhN3svM1dfo
         0U30y2/A87ggzC3udn/BEYmSOpopI7QVL7SuL++11LUcA9eTX6LrO0lGx0wg4EWHWfo/
         Dn1DoLV6XYIbkiHg2OZm3CuyOU1QAK5OhWqD3WrILau3WDp8dfTCkVa5IbYTsigzboPa
         pgDnlDBJa/zbNZKjTjgaEKHz8cNFng5L44X0L+ZKVnNIjJxN7pfy8DQ2ynS3mvqDUKZ4
         3tKWl/GeDerpGoFbqWKz31KeFkXkYfpjyASV2qPgOA2b2MGmUPGmXXWtIOh5cOgJlOBt
         fmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=odCEBJJ2/dNv63zc58f7nNICas6kDLHkL2UZrPTeD8k=;
        b=aNEOE0z0zHQO+PaOb4F6rgnK08YLGjAU/f8aV7LqpOkbeq9e+CpL0tYdyN09HOz/Xc
         QBR9RdzxMSUBE7PpEK7dyXWfQDKUmIlPL+vYsnQ7HD3KLl1ERcnCbPiOjDetugAeMCKL
         DaFxQfQV/BX6z+kd7+3CYLXd5eb4NBaGzmNUoG7VEOHEk4v7hQsp2yRvk/r3agghRyDC
         MOWN5WeQfrZADYCYoePgU2NIEgpktESMxU9v0sdnkcx8+NJEgEGmPd8d6JfBiHz12ii0
         AdUw1IGX3u3Zmb/7koRxqTFMJ9iiWyGv7uD2tjU43nPLEI4n9H2Nq6Js4KVAk1V2YRb2
         TqNA==
X-Gm-Message-State: AOAM5300EP70UjClMUX/LN0FB5XUyQ3bnTXEnBth9pxgf8DC9UdSdoHT
        Xri8BYpSGqMq3AF+PKFn/rVaAzQ95/1/Cw==
X-Google-Smtp-Source: ABdhPJyKmppucuvTF+FKViLb9/9o9xraj0H1FQOH/20UwdUFh34R4nLs6PF1YBd2NC5DAPkX9swt/Q==
X-Received: by 2002:a05:6402:4310:: with SMTP id m16mr269863edc.207.1612291084093;
        Tue, 02 Feb 2021 10:38:04 -0800 (PST)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id lz27sm9730581ejb.50.2021.02.02.10.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 10:38:03 -0800 (PST)
Subject: Re: [PATCH] lightnvm: fix unnecessary NULL check warnings
To:     Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1612230105-31365-1-git-send-email-tiantao6@hisilicon.com>
 <BYAPR04MB4965F95707D5C87608B4ADEA86B59@BYAPR04MB4965.namprd04.prod.outlook.com>
 <f76e7f84-5f4a-c69a-e203-117102164335@lightnvm.io>
 <20210202172406.GA3699007@infradead.org>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <faf36685-4f31-86f9-f5a7-d47638abd4e5@lightnvm.io>
Date:   Tue, 2 Feb 2021 19:38:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210202172406.GA3699007@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02/02/2021 18.24, Christoph Hellwig wrote:
> On Tue, Feb 02, 2021 at 05:00:34PM +0100, Matias Bj??rling wrote:
>> Thanks, Tian and Chaitanya. I'll queue it up.
> Didn't we plan to kill off lightnvm?

I haven't got a clear signal from Jens for me to go ahead and submit a 
patch to remove it, or if we wanted to first deprecate it, and then 
remove after it has been deprecated for a while.

