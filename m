Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC06EB64DA
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 20:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjFPU0V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jun 2023 16:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFPU0U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 16:26:20 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E391035B8
        for <linux-block@vger.kernel.org>; Fri, 16 Jun 2023 13:26:19 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-25eb3db3004so659807a91.0
        for <linux-block@vger.kernel.org>; Fri, 16 Jun 2023 13:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686947179; x=1689539179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9FfLZ5DVOu2O5wllApQ8jRTCEnm2MRDvE7gAnnhRkRw=;
        b=E9lT9zlTfjKJQfMzS2eeQb/qXg03+k1z3wkDwlrjvz9PfvOhFfX4A33Bl4P2To5hBI
         ar81Ja2PUtWtWL9eGUo3UAe/pW589oX9HYPmUsBzYMXQ6/MTpBByND2Mp4/52RpPP6od
         JCaMEvK7fTBfHSF4ok3gJCpHHbZU+u0xmSZLt9/sET/gy+FbrlaZ+4QUOrDWc9hXjOad
         zdeWxzmv+wcTvBuqzdJIyT1rvw+qhql3fNEkRtX/3Up0tC/n86BZhy1Ad+id6DMFKXYz
         41QH4pfHwNvjN+Y/kFanAiydzg6AFw/y7nS0cdnIWuP0NjrQxT1Tmqi/ce9ds/brB8yM
         85Zg==
X-Gm-Message-State: AC+VfDxqFpKVzpHO4XxbYsP945UqDEq/xyR79BfcSvdLCToCnQBWMJh+
        0H/L8gQJe7A3x4v4cBEYAro=
X-Google-Smtp-Source: ACHHUZ6YPsqUrjdFiAawx/J+Px0hTqIyBxG3zjZCqO81yp1ZlhG43tba2z+zrSzfa+z3wPmSBCibTA==
X-Received: by 2002:a17:90a:307:b0:25e:9541:58 with SMTP id 7-20020a17090a030700b0025e95410058mr2489019pje.40.1686947179183;
        Fri, 16 Jun 2023 13:26:19 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id ft22-20020a17090b0f9600b0023fcece8067sm1771777pjb.2.2023.06.16.13.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 13:26:18 -0700 (PDT)
Message-ID: <d0dce017-390e-301f-1c85-0970c91ed80d@acm.org>
Date:   Fri, 16 Jun 2023 13:26:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 0/8] Support limits below the page size
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sandeep Dhavale <dhavale@google.com>,
        Juan Yescas <jyescas@google.com>
References: <20230612203314.17820-1-bvanassche@acm.org>
 <5041fc15-2c6c-b91e-6fb6-5eac740f75eb@kernel.dk>
 <20230615041537.GB4281@lst.de> <1d55e942-5150-de4c-3a02-c3d066f87028@acm.org>
 <20230616070237.GC29500@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230616070237.GC29500@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/16/23 00:02, Christoph Hellwig wrote:
> But it seems like no one is insisting on using it with larger than 4k
> page sizes.

The Android common kernel (ACK) team is working on bringing up 16K page 
size support. This involves kernel changes and also changes in user 
space code. Once 16K page size support is ready, I expect that more 
users will ask for 16K page size support in Android and also that more 
users will ask for small segment size support.

Thanks,

Bart.
