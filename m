Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B08C00140
	for <linux-block@archiver.kernel.org>; Mon,  1 Aug 2022 02:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239336AbiHACnU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Jul 2022 22:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239459AbiHACnJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Jul 2022 22:43:09 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE41813E14
        for <linux-block@vger.kernel.org>; Sun, 31 Jul 2022 19:43:06 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 130so1560767pfv.13
        for <linux-block@vger.kernel.org>; Sun, 31 Jul 2022 19:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bOPt45iNQ2snV3Ghh1gRMXdM+xNU5yMfjsSduHJEp7k=;
        b=Gwo9n/eauzrC5Zq/5uvgUuDmNHxKWxjvIzYVWN6zjLa0w5+GPTIndt/H0n9lJeI3NS
         9suxOtHPA3wmWpC2pfgC/agOYP1R7BsYMTXwvJjzoe5QVUel00qVhCnNbfeyX3snzWE1
         SEtOgldKtOjHmALTcezb1kxHz3xPC7hcpmYV/vb74yTwk7QLMFrVK+gLV2zKV7GjxrkK
         O0A8XcG3iErhkfe5VIBqv+cvmdxZmJn2phYpYYJx+q6D1Q6LUDnKukAqkKbJU2vq1q1F
         nmFDbzIsOyEufPyLIjm4u3RPXHiVQMJ5RICIbp/6ZewBltwd/UqlPw3gnd9liDwh/fX2
         wR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bOPt45iNQ2snV3Ghh1gRMXdM+xNU5yMfjsSduHJEp7k=;
        b=YTbMEX4sDyEmwg6Yu/2OVw+U6DRcYNLbn8K03zq4IHjLU0ZUFpap2VntFlkmTTXh/2
         Y4AjQUuplIDy5P+pmrQ5PlKdypC5SRi+8Bg8eso4kDGP1jmHnZ2Je57jwfIa0mkxsApF
         dt6F1meB+7ZS5ZPs2lmNVSm2clJXvj72mgzXOK19z8fPn6F8thc6EnzpjE12Hd53449V
         bmG3aNzqGQPI/0cTJ0zuSKZzT4UmKerEXT2GG5mp4Eiwyuq+7GzSzfAuOKc9xcKflP9P
         cNvRac5CniWBi6C9qsSa1RWvT1iUEmu5EfO46zmdBfScKFKkgboo7FDrnUd1fcIUJBZl
         7dHg==
X-Gm-Message-State: ACgBeo1Ftz8IeLUSEe0sJS66u5mRXzsw9j5RwaTE0V7PwMCuvS2u/qZF
        tHuJD6P3IieY0KSTr7RlqLT+sQ==
X-Google-Smtp-Source: AA6agR4asJb3vGcpnXUfl9JlHogYWsjDQvGFVGNs6nDDYrncV9oEkgWisGdso1M41uu7wcGGEt3a+Q==
X-Received: by 2002:a62:cd8c:0:b0:52d:a632:a8e0 with SMTP id o134-20020a62cd8c000000b0052da632a8e0mr41365pfg.52.1659321786145;
        Sun, 31 Jul 2022 19:43:06 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id m11-20020a170902db0b00b0016dbb5bbeebsm8171102plx.228.2022.07.31.19.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 19:43:05 -0700 (PDT)
Message-ID: <70d3dc55-a877-c4c9-cafc-feebf150fbb7@kernel.dk>
Date:   Sun, 31 Jul 2022 20:43:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V4 0/2] ublk: add support for UBLK_IO_NEED_GET_DATA
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, xiaoguang.wang@linux.alibaba.com
References: <cover.1659011443.git.ZiyangZhang@linux.alibaba.com>
 <4c6f7d83-183a-da98-a41a-5363db6f3297@linux.alibaba.com>
 <Yuc3dq50YoU3CVzP@T590>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yuc3dq50YoU3CVzP@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/31/22 8:16 PM, Ming Lei wrote:
> On Sun, Jul 31, 2022 at 04:03:30PM +0800, Ziyang Zhang wrote:
>> Hi Jens,
>>
>> Please queue this patchset up for the 5.20 merge window.
>>
>> UBLK_IO_NEED_GET_DATA is an important feature designed for Ming Lei's
>> ublk_drv. All the patches have been reviewed by Ming and all test cases
>> in his ublksrv[1] have been passed.
> 
> Hi Jens,
> 
> This feature is helpful for existed projects to switch to ublk from similar
> tech, so IMO the change makes sense.

Can we get this resent against for-5.20/block? It doesn't apply anymore.
Then we can still make the next release.

-- 
Jens Axboe

