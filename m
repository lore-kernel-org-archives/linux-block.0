Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B41C00140
	for <linux-block@archiver.kernel.org>; Wed, 10 Aug 2022 22:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiHJWWA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Aug 2022 18:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiHJWV7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Aug 2022 18:21:59 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710EB8C449;
        Wed, 10 Aug 2022 15:21:58 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id t22so16105297pjy.1;
        Wed, 10 Aug 2022 15:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=YZbS2XsmWJ/nsjhvibRctXvETOOxOBZgEYWKbgY8GtQ=;
        b=m3t8wRXM4+VtWI+JJ9Xn/pG8QOT1dxAMeE7utcz9C0OnAmW3E4PoulIv8BNcGrMOn2
         Ob4XfB2Lukagjq4hxNkaNQBulSQsfjyWtoDYzlhNhfk/5myHLUR2M9zYeLVo4tbQN4Lc
         U7+UYvgr+Xc2r1QLUpxYfE/zrt0kNBHjB322qLkxdbv754HaJh4CbCOBmZRQEhmMVDrX
         AchdY+TUbh/4pDSthMqKsmEG2jTQ6303zXP3f5bPyRkPZdIxR5OrU4qNOBG6lHWv7l6x
         5QvAp94t+sb3l42MrZIWdovrZuXS+1E0jMV9hVagc7Yr4gPLHu+ZWa91i2kMgcBOXuBM
         1Rhg==
X-Gm-Message-State: ACgBeo1j47FeL2PORkEukIWivnZbL+tnZNHrbSIKXHEWXPfxegKVvJcc
        UZlMVBapzKCUzjIv5SKbKio=
X-Google-Smtp-Source: AA6agR6jOnCaIK1g4UVpsCDqCwACNR5OVkNOYFcsanuEvLQRJkWhesCYWJ10S4BB4YfYrOIE44S7FQ==
X-Received: by 2002:a17:902:ea02:b0:16f:11bf:f018 with SMTP id s2-20020a170902ea0200b0016f11bff018mr29159076plg.150.1660170117746;
        Wed, 10 Aug 2022 15:21:57 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:85c9:163f:8564:e41f? ([2620:15c:211:201:85c9:163f:8564:e41f])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902f68600b0016c454598b5sm7263159plg.167.2022.08.10.15.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 15:21:57 -0700 (PDT)
Message-ID: <91cdca66-3fd5-667c-de78-113e8a28bb59@acm.org>
Date:   Wed, 10 Aug 2022 15:21:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: fs/zonefs/./trace.h:22:1: sparse: sparse: cast to restricted
 blk_opf_t
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jth@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <202208061533.YBqXyzHm-lkp@intel.com>
 <affa6eee-3b7c-105a-8f4a-35f1ed81f0cd@opensource.wdc.com>
 <b3a6b038-ba0c-2242-3a29-5bcadcaa9d71@acm.org>
 <24b7e027-e098-269b-ccf7-b14deb499c33@opensource.wdc.com>
 <8aa0e7a4-265c-21f4-bdb4-57641d15b7b9@acm.org>
 <27eed02c-fd92-6f99-b213-1be70193b37d@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <27eed02c-fd92-6f99-b213-1be70193b37d@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/10/22 12:14, Damien Le Moal wrote:
> Good point. I was using Fedora 36 sparse package. Using sparse compiled from
> source, I now see again the warnings without the patch and no warnings with the
> patch applied. So the patch looks good. Are you going to send it as a fix for
> 6.0-rc1 ?

Hi Damien,

It is not clear to me why I have not yet received any feedback from 
Steven Rostedt on that patch. I will try to ping Steven off-list. If 
necessary I will repost that patch.

Best regards,

Bart.
