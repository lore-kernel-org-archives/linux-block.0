Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEDCC43603
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 15:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0628E214AF
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 15:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="M0wjhN6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbfLLPpZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:45:25 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38812 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbfLLPpZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Dec 2019 10:45:25 -0500
Received: by mail-ed1-f68.google.com with SMTP id i6so2192077edr.5
        for <linux-block@vger.kernel.org>; Thu, 12 Dec 2019 07:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Wj0vB/2klCNy1PcPwHyaDosaSN9l/KjNCHs0715Ab+0=;
        b=M0wjhN6CrkDSzuBqmVUpC7P4l3xgcAH56Kp3RNjJzAtBHUWOPPPWduknJbXTi5ecIJ
         gQHqW2ydah0+cbrGu0s8jD+oeRAiBnl5KVu6hyUFHPZI0d/oZi4vYRk3QEoRVUN4a79z
         ukd07Vw2GroUWnEfmyPnflkwj0TVpaZNENPCTb7jpHAPKFe9lUi6xDoXuWSQ38KwwHAQ
         3zxW07mVMDM/FwdrQCcLh6CXuE356Fj71X3p2zn8oT8vXQbAw2mAphcBweQ7BHqUcMM3
         Rb7L6a+fSeiWAzZZpgkCec916AfkC/lClABhsP7aWOSxIqEAChBN0KpKkL1jNcOLCcZk
         736A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Wj0vB/2klCNy1PcPwHyaDosaSN9l/KjNCHs0715Ab+0=;
        b=KKWtN1dBsGMmAofSKYmV4p0GXRN4fzdSGZ+vmc1NxnL7+8BLmT2gLssQA5n0kkU4gP
         C1XGeoMnd8Be4gacS/liMjJgOEEmxu7Vz0PrmwWZZwhyygN5iqELJPMuCfLZJC8hnugh
         1divYOHXNhzSJsBwt/cTFi8t0O5bMJMp9OhCx7vg5yPDjhHCZfObf8Vf2PfQ2BRWpwZv
         lKdCj6eFSqePtigzgdr4nK8unvpWFAMvkwZRCxFHyJH2jznHHjHd4pUG+HWmy6mco+45
         KilAfKUbrJEqe2KXf8FJasNJ+W/NFSBNCTwOwqe9i7RWjk88/4QNULDjH3Z/0i94Qi2e
         tNkw==
X-Gm-Message-State: APjAAAWq3YYGFMEbY1KJkwLYAb4F9IhntWuAEGHmqXa6q1JYg3oqx1ZI
        37aq6OfDxOvsgVuGKd94vbyK0U+wuE0=
X-Google-Smtp-Source: APXvYqyNgmEXkcZNQmz/NV/+6HEGrTVWy7x//ZeXMfqOae8r1kOMjILPqWm8qf3O5pvQowwVShZp9w==
X-Received: by 2002:a17:906:fcd2:: with SMTP id qx18mr10183701ejb.230.1576165523495;
        Thu, 12 Dec 2019 07:45:23 -0800 (PST)
Received: from ?IPv6:2a02:247f:ffff:2540:1467:8db0:560a:58ea? ([2001:1438:4010:2540:1467:8db0:560a:58ea])
        by smtp.gmail.com with ESMTPSA id p6sm13538eja.63.2019.12.12.07.45.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 07:45:22 -0800 (PST)
Subject: Re: [PATCH] blk-cgroup: remove blkcg_drain_queue
To:     Jens Axboe <axboe@kernel.dk>, tj@kernel.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org
References: <20191212140851.19107-1-guoqing.jiang@cloud.ionos.com>
 <0cb5895c-aa35-b65a-83bf-81f5444e562f@kernel.dk>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <adc0412c-6f91-4db7-cd54-3c78d837161c@cloud.ionos.com>
Date:   Thu, 12 Dec 2019 16:45:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0cb5895c-aa35-b65a-83bf-81f5444e562f@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 12/12/19 4:17 PM, Jens Axboe wrote:
> On 12/12/19 7:08 AM, jgq516@gmail.com wrote:
>> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>>
>> Since blk_drain_queue had already been removed, so this function
>> is not needed anymore.
> You should remove it from include/linux/blk-cgroup.h as well.
>

Ok, will send a new version.

Thanks,
Guoqing
