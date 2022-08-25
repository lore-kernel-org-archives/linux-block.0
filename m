Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1860EECAAD4
	for <linux-block@archiver.kernel.org>; Thu, 25 Aug 2022 21:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244183AbiHYVvR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Aug 2022 17:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243975AbiHYVuv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Aug 2022 17:50:51 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB9F474D7;
        Thu, 25 Aug 2022 14:50:49 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id z187so21056872pfb.12;
        Thu, 25 Aug 2022 14:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=A1GDSS4ZswYZdPLm/xFYMxcSzWgFZQdBzdkCHj25ONs=;
        b=UzP0SV502OQyMH0z5e5q2Pfzjbt3o026Cb9KKFiRT3cC7mFHxxA09x5qJBlhrZtyyD
         SbaeOOHm9vJktEaN93j/n6aiJ7rUhQ48cBCXBfSbwhV8hUvRXs0mFjPuUpatPdZW30mz
         omw4rJs3xm/VdrjB21SkX3QMi7UwQxAUWw6FkZ+orBEfsJHnC8epVRMj4vLC9fu2qxlw
         iqIAoI6WkYc7Vn0EbW33TS03lAwAcwK31+6Nya04JeILNIKwnj7qMj71BhDc7ZHBFch4
         gQ8LBrqQ3NVhrCSxrTygFBPw5l2H8HvYfR2KSgw3zd7ebv4JXBlcicbkmM09MLMDY1tq
         1w+w==
X-Gm-Message-State: ACgBeo1l9gKykkRX+AXo0JDoS0T19xyTlKFozQvFlBRZM4GUyfS5JGNY
        QMa7GjZKunbj+F+hg9j5eJU=
X-Google-Smtp-Source: AA6agR4mlNQNlswjcYi/OOqa2VKdvYxaaS8E9JPwi6wD85RRMAlmfsBiW/v3/FllaJ/9tjyjR3F0Cw==
X-Received: by 2002:a63:e20c:0:b0:42b:4467:e0f4 with SMTP id q12-20020a63e20c000000b0042b4467e0f4mr874532pgh.576.1661464248859;
        Thu, 25 Aug 2022 14:50:48 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:349c:3078:d005:5a7e? ([2620:15c:211:201:349c:3078:d005:5a7e])
        by smtp.gmail.com with ESMTPSA id i12-20020a17090332cc00b001713af9e85dsm36928plr.180.2022.08.25.14.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 14:50:48 -0700 (PDT)
Message-ID: <1dcffde8-ded6-b665-58a4-0f9f091b2a8e@acm.org>
Date:   Thu, 25 Aug 2022 14:50:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [dm-devel] [PATCH v12 08/13] dm-zoned: ensure only power of 2
 zone sizes are allowed
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, agk@redhat.com,
        snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de
Cc:     pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        gost.dev@samsung.com, jaegeuk@kernel.org, matias.bjorling@wdc.com,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121909eucas1p113c0c29f7e28d0ee3e1161f7da243baf@eucas1p1.samsung.com>
 <20220823121859.163903-9-p.raghav@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220823121859.163903-9-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/23/22 05:18, Pankaj Raghav wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> dm-zoned relies on the assumption that the zone size is a
> power-of-2(po2) and the zone capacity is same as the zone size.
> 
> Ensure only po2 devices can be used as dm-zoned target until a native
> support for zoned devices with non-po2 zone size is added.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

