Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2799C3F2CD
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 19:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DA820774
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 19:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPrQqIuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgCWToT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:44:19 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39215 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgCWToT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 15:44:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id i20so3963157ljn.6;
        Mon, 23 Mar 2020 12:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PxeFoR7puwfL5UMnOaJme3OEi0Xyw7aUebfMwwSK1j8=;
        b=bPrQqIujsyit09I1b6HS0plHeSy/7GNoVldQQIa0S/dJSXAF7YI38liDRIGik2JBYI
         UrBomCmNaw2IK6/aWfpoQ1N86pk1j5X0N3scONHbpag4RBj/8dmXdKH1ouEeLm8GxOKr
         HfkJKnJt+1BWSVN6Hrx9Zfsu2ykkyY459B9L5AVsetHE8YHQ6Dkx4BuYmhoQZjsvsYj0
         MN1RCDXd1G7pHvwRO2/2TFZsAJTOCGI4X05MUQuxww8dMFZ4L2PUHPROlkx+mfoJ14JT
         DUC0WXy2aTpS9gfNMTtcRrULvToyhgdKSxoHw1pZOgjlzHAiKwK10BkIlzeqdXUlIHqq
         +xRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PxeFoR7puwfL5UMnOaJme3OEi0Xyw7aUebfMwwSK1j8=;
        b=r7rXLJ6rt+QIVnb1R/BZUfaPzPyYfoXQVJ6PQpvz6iCD64ELcwgPudZZgJRbc/lvyo
         3yp25FmqZP8mJ6rY5yF/agN70TS69qV8zG2ILx9kmw9tOja++onHP40nANsd+0aFf6LX
         vx2nLlhWbjjgmeuo1Ts0AWAsx9op2GNGHdNNFJLmBuABfvWvuP/GQHO/IxKeqT/zvJaL
         ayHbjQJiDIy6KqTC6Mlm00oAl7JsWotbq52BE+5Y92F9CY+ocwgun5FnTYDYMMW/cCUW
         YAh356wMDkVfNQ1a7fcefqZQj8B2B/7k/AUjzBDDLU1WPzt3XdJZ/4E1grPOgnHJEsAn
         J9DQ==
X-Gm-Message-State: ANhLgQ2w0lYexPYm0BTKGAKM7/AQ3AAvJEgZzl5xqUUvP5yK9Iv/pdeP
        kuJr7BXI4WZyMs6ygzyROS3tI7st
X-Google-Smtp-Source: ADFU+vvJyZu6IUSbYZsv/K3Gya6Nma49+gt39zgYnXVmB2IOUGZMTKQf3gSICLzZxL5pEbC4UC4wdA==
X-Received: by 2002:a2e:924a:: with SMTP id v10mr14123746ljg.21.1584992655648;
        Mon, 23 Mar 2020 12:44:15 -0700 (PDT)
Received: from [192.168.2.145] (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.googlemail.com with ESMTPSA id s4sm10309834lfs.54.2020.03.23.12.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 12:44:15 -0700 (PDT)
Subject: Re: [PATCH v3 00/10] Introduce NVIDIA Tegra Partition Table
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>, linux-tegra@vger.kernel.org,
        linux-block@vger.kernel.org, Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200323163431.7678-1-digetx@gmail.com>
 <20200323180750.GA30585@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9f63f113-fc67-5e1c-a539-81e3b0cd4e31@gmail.com>
Date:   Mon, 23 Mar 2020 22:44:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200323180750.GA30585@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

23.03.2020 21:07, Michał Mirosław пишет:
> On Mon, Mar 23, 2020 at 07:34:21PM +0300, Dmitry Osipenko wrote:
>> Some NVIDIA Tegra devices have GPT entry at a wrong location and others may
>> even not have it at all. So either a custom workaround for GPT parsing or
>> TegraPT support is needed for those devices if we want to support them in
>> upstream kernel. The former solution was already rejected [1], let's try
>> the latter.
> [...]
> 
> Hi Dmitry,
> 
> This amusing use of whole-device offsets in the TegraPT makes it take
> a lot of hacks to support it. Have you considered to first join the MMC
> hardware partitions using DM and its linear target and only then processing
> the partition table dividing just the merged device?

Hello Michał,

Thank you very much for the suggestion! I had a thought about that and
it's not apparent to me how to determine when the joining needs to be
done and when not.

The joining shouldn't be done for devices that aren't booting from eMMC
because then the alt GPT entry will be found on a joined block device
and this shouldn't happen.

Actually, maybe we could create a new MMC device-tree property, telling
that the joining needs to be performed. Perhaps this indeed could result
in a less hackery, I'll give it a try and see how it goes.
