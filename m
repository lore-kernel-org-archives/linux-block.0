Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED90C433EF
	for <linux-block@archiver.kernel.org>; Mon, 23 May 2022 14:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbiEWOPx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 May 2022 10:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236939AbiEWOPw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 May 2022 10:15:52 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525E659943
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 07:15:51 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id hh4so12588486qtb.10
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 07:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TeTm3K7EF1EHFf4zmoe+1aSPiBLGVwE736RxR6JriQw=;
        b=dUgXLYssqjZOWLLmGZ0Y4NRp9EshPYtG+0fwuB/KWuaOLfXyG0etFLRwpPjzLGby9u
         OQoAmsd3vaBSwoXAu+BB0gKbAXMa/mJJqJNO2aNn9Z7Jv5IhKyIbzS806hyNENGwtWYS
         Dq0chKEovCxugRgG8xQBCDm4wNtyDrfH6FqFlfVNq7I7Jbqdt+34VIoglN/XLkMN8Vds
         eI766KmxRlTbhXjW5hoH0fdi9s10E7pSk5ISpsWrWfySDKpXnqgYcY4oOdxDsR6//zYh
         usPENfThWB9sGRfV4iB6gfwHrVfgOxn/C1PQEJqBya0H5C2IOYB82vaPEb/uw88Un+xK
         h6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TeTm3K7EF1EHFf4zmoe+1aSPiBLGVwE736RxR6JriQw=;
        b=CRjzjCS8xH9f+QfWyg/jHjCKhaCN9C2ppCicDVvQc1m2Er01KM6Ca2M/YPNsncoFqP
         Sk2in8Neg0SVLPMEiaA2QFvdDSyXeth1XIkjD3KtN5urZRU4GMmxj5gqMB2RD5XPZkdy
         bZYdKAsdRfI4mcZlx2j/1Co78y8eME33XU9rZOlf2a2hhAqJXSvfGG3KZTWpMq7FkNHO
         6PBq6yovxxsb7t5mdCF8R1n8J/f/y5wWoKVeDv4zHEISYC0fkZ9uiBUzUst3qaaX8wpO
         T2VjUZ4TOit5T/MIg2j9L7t4a4a6BxkZYTtVEMLKrHz3Byx8jA5L5WUTwV6KuFQ+LFAB
         ncWA==
X-Gm-Message-State: AOAM531Is859VWMYxfIurTL80rs28NOehDAZsySipgWW+5iDwN2KKc/6
        kRxZnQY+0FTYZYrsX3RfYtSrSw==
X-Google-Smtp-Source: ABdhPJyYSwBudmx7Eh413f6ybyywikS0oqi8vmZ/dzTR4gPFdR6wC52IyA/VVVnXlTeoeq9xmWHmSQ==
X-Received: by 2002:ac8:5915:0:b0:2f3:db7f:7ad8 with SMTP id 21-20020ac85915000000b002f3db7f7ad8mr16039086qty.77.1653315350326;
        Mon, 23 May 2022 07:15:50 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w36-20020a05622a192400b002f39b99f69dsm4250366qtc.55.2022.05.23.07.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:15:49 -0700 (PDT)
Date:   Mon, 23 May 2022 10:15:48 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v3 5/6] nbd: fix possible overflow on 'first_minor'
 in nbd_dev_add()
Message-ID: <YouXFG5+HEie9muN@localhost.localdomain>
References: <20220521073749.3146892-1-yukuai3@huawei.com>
 <20220521073749.3146892-6-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521073749.3146892-6-yukuai3@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 21, 2022 at 03:37:48PM +0800, Yu Kuai wrote:
> From: Zhang Wensheng <zhangwensheng5@huawei.com>
> 
> When 'index' is a big numbers, it may become negative which forced
> to 'int'. then 'index << part_shift' might overflow to a positive
> value that is not greater than '0xfffff', then sysfs might complains
> about duplicate creation. Because of this, move the 'index' judgment
> to the front will fix it and be better.
> 
> Fixes: b0d9111a2d53 ("nbd: use an idr to keep track of nbd devices")
> Fixes: 940c264984fd ("nbd: fix possible overflow for 'first_minor' in nbd_dev_add()")
> Signed-off-by: Zhang Wensheng <zhangwensheng5@huawei.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
