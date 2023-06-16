Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D60EB64D7
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 22:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjFPW2H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jun 2023 18:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFPW2G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 18:28:06 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEA62D6B
        for <linux-block@vger.kernel.org>; Fri, 16 Jun 2023 15:28:05 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-25bf7568f73so934110a91.2
        for <linux-block@vger.kernel.org>; Fri, 16 Jun 2023 15:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686954485; x=1689546485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3iZIa3b3KREAEUdhNA6p/V0gi2VpJPLq6VYDn4e2IBY=;
        b=f5PU65lbSTS4r382anD9W50Or3/syi64iM0Dz6E8aQbsBPn8h7+YAL82/RRGwOWRYG
         eSg4l1geuDr6GGuv76kb0Jdx0HchJ/v7RiR5cddoQYdIhO+nF4dKXE/pGRwGupyomiCa
         MVpDvYprQgDLD20mOud/NemEFgOmUhF9nvo/A4vdT637FpucJ+ISxGcXMFZLHneOA+h6
         GDuHgL/cGPjaZoarrj5fkGWTzLQLdnI+b0/bXi9ocywrYUbxtWroAjh8S6pT/+sCID7P
         lOVNLxTKyjc+UqhRThB8JrWm3nM/sfl58WGNcuacsFEdaRJWGB/l70Ff2GRJ6mY+o1IX
         2ACA==
X-Gm-Message-State: AC+VfDykwIWfRjLb58kseE1rjFfFrJZ+W12DwygZzkzF7wRLlBxK5GAV
        fDBjbhhcBGodcZ0N3m5gJgM=
X-Google-Smtp-Source: ACHHUZ7ax7Kmak9hlUvt2Q5NXZn4BxBQ8G9YpgWIEk9DRlS9BnVpRm5ONBmQt1oQdN2Vh8wyIJNd5g==
X-Received: by 2002:a17:90a:195e:b0:25e:9549:6bef with SMTP id 30-20020a17090a195e00b0025e95496befmr2846681pjh.29.1686954484850;
        Fri, 16 Jun 2023 15:28:04 -0700 (PDT)
Received: from [192.168.50.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id 39-20020a17090a0faa00b0024e33c69ee5sm1963293pjz.5.2023.06.16.15.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 15:28:03 -0700 (PDT)
Message-ID: <9bb864d3-1932-f391-7399-248abdf9f0b1@acm.org>
Date:   Fri, 16 Jun 2023 15:28:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 0/8] Support limits below the page size
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Sandeep Dhavale <dhavale@google.com>,
        Juan Yescas <jyescas@google.com>
References: <20230612203314.17820-1-bvanassche@acm.org>
 <5041fc15-2c6c-b91e-6fb6-5eac740f75eb@kernel.dk>
 <20230615041537.GB4281@lst.de> <1d55e942-5150-de4c-3a02-c3d066f87028@acm.org>
 <20230616070237.GC29500@lst.de>
 <d0dce017-390e-301f-1c85-0970c91ed80d@acm.org>
 <e5782494-1a57-819d-d790-13f2051c4714@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e5782494-1a57-819d-d790-13f2051c4714@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/16/23 14:48, Jens Axboe wrote:
> Nudge the vendors to ensure what they deliver comply with that,
> I believe Google has quite some pull in terms of that...

It would be great if vendors of Android devices would ask the Google 
Android team for its opinion before selecting hardware components. 
However, that's not how it works. I think that it's more likely that 
Android vendors will put Google under pressure to support the hardware 
they have selected instead of Android vendors asking Google for its 
opinion about which hardware components to select.

Additionally, bring-up of 16K page size support for Android happens with 
existing Android hardware. This patch series helps 16K page size support 
bring-up effort because 16K page size support is being tested on Android 
devices with an Exynos UFS host controller.

Thanks,

Bart.


