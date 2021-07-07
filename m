Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9863BC07E95
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 15:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EBF6619C6
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 15:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhGGPlh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jul 2021 11:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbhGGPlh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jul 2021 11:41:37 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4588BC061574
        for <linux-block@vger.kernel.org>; Wed,  7 Jul 2021 08:38:57 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id l26so3805724oic.7
        for <linux-block@vger.kernel.org>; Wed, 07 Jul 2021 08:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H/u+AYAwK9mJcG4oUWcnUGsuenx4nlYeOD13u9gKYw4=;
        b=hBe29YUOrYgfT6USN8t15IXPOdsaxaWTgbrLieT0ub7LIuxZQLgx28SKSKI2NneYaX
         3TfqswY3vdTXnPYj/gn7E2GPnw3fzQoZ4/2cKo2U8yYmk5UOaMGBZQV4FkLxJmLZXtVU
         WvhFUSJeZJD0jCIgSkOooNBIcaNQ9PF6I4tHzvnb41Q+vpQ2njGA69DOrhrmQUVwdRRi
         Sh9D/0WnPlX9q+V7H0eoW9RNCAufgJnb+iMaMGxTsP5RGsfxe2RomDZSsmI9qPJ6eHFr
         413hVjj1elDDIYi4tiXFVKvlOELXOGD7sQNBIzlhRADjBFfQJmRxGkGU8TIJv3VJCVld
         rESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H/u+AYAwK9mJcG4oUWcnUGsuenx4nlYeOD13u9gKYw4=;
        b=SC74hWVXuRE5LGcwXeaxDyQXlWXFAgd2TQQ72AEA1k5H1yj3jkF+j0gc1y1dkql/DZ
         fMWE8TS+COwZbhQ+lEAnm0B8f4xc/ahoX1DyCdtup6d4zYDEzSjEvQAi2DEC3HNvYi9o
         dYQKEvrx4Q9gEUjBRIVK6L2E4BUbuSkfqvQaue1jk48Z2BvZZQ1axhy2IX8M0hD0YBmi
         o7+ofVSdDmX47GDBmpn/WhMzBQt4tVNP+mp7admEKIp/FzGcPL474hYtRwkZ75s6dF8x
         xT1fqnORO5MlyZ4IBsHe635VnKZGdAmclNRpzz3tNQzOLFRiVvfEmN+gL86xA7DQAWbn
         9whA==
X-Gm-Message-State: AOAM531HjoHc2j4ZMNmhui4G1MgWtp/7yrEHd2xLppNGQuKQztqMslcl
        c1+IOPPsd5T83/uQsqPJti2vUw==
X-Google-Smtp-Source: ABdhPJxfpHgxHg2b3kqBMIvAO3jc3igdIVCQdUBIWCICtzLhDSXduDYBwRAIqIfJAgkrJZQnFRiyqg==
X-Received: by 2002:aca:d641:: with SMTP id n62mr154422oig.77.1625672336548;
        Wed, 07 Jul 2021 08:38:56 -0700 (PDT)
Received: from [192.168.1.170] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id o189sm4241409oif.54.2021.07.07.08.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 08:38:56 -0700 (PDT)
Subject: Re: [PATCH V2] blk-cgroup: prevent rcu_sched detected stalls warnings
 while iterating blkgs
To:     Yu Kuai <yukuai3@huawei.com>, tj@kernel.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
References: <20210707015649.1929797-1-yukuai3@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dc715155-f936-16ef-bcc4-3063988402ba@kernel.dk>
Date:   Wed, 7 Jul 2021 09:38:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707015649.1929797-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/6/21 7:56 PM, Yu Kuai wrote:
> We run a test that create millions of cgroups and blkgs, and then trigger
> blkg_destroy_all(). blkg_destroy_all() will hold spin lock for a long
> time in such situation. Thus release the lock when a batch of blkgs are
> destroyed.
> 
> blkcg_activate_policy() and blkcg_deactivate_policy() might have the
> same problem, however, as they are basically only called from module
> init/exit paths, let's leave them alone for now.

Applied, thanks.

-- 
Jens Axboe

