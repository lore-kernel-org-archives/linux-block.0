Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444C4C433EF
	for <linux-block@archiver.kernel.org>; Sat, 18 Sep 2021 00:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AB5B61179
	for <linux-block@archiver.kernel.org>; Sat, 18 Sep 2021 00:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbhIRAFC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Sep 2021 20:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhIRAFC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Sep 2021 20:05:02 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052BEC061574
        for <linux-block@vger.kernel.org>; Fri, 17 Sep 2021 17:03:40 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so11135753pjr.1
        for <linux-block@vger.kernel.org>; Fri, 17 Sep 2021 17:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R6i+W+EoLU/2rBj4+e2SaLzuquW8bdEJaHFtJMdW89k=;
        b=wfwTHnZzjxucMcdequzdsZjnx/UqchPJLWWfJj6UqG8wdXEu2lb+ZG/1HyQ5pKcutR
         gb4faFtIQ0PMMqooTfEFwz7MQMPwEzhLqyiciHnzax33AoHC+bG8eOP3c0ALPWBu+8zY
         zKNY7Hze+trGsmtL99aBggItwUzPyTHtOV5I+ANA+CbmVKqFyZk9fsvzDVwGHIU2VfZp
         d9RbiMzrk9HbXqx0RwiLxQ4M5vSkmQUeDOnH2MX9PNetJLkQ6/FW+UCFgx4eYQObd/pa
         wzz0/xbjaOoOOL+0lPbtanwRC8ii/SB1VHA9m4FY3nfPwpWszRx7ZQY++DZdzHjhvYE+
         wFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R6i+W+EoLU/2rBj4+e2SaLzuquW8bdEJaHFtJMdW89k=;
        b=cIdxOg8gc8rd0qWd/aAEBaxeZLpVLQotfCveu29btXYubTAl7eiDKCd6FfoQYUqCTc
         77qSQpLTbu1Ntd+wo0AuPIhDA9LPbeHpSYqQWd5ppCkHJ28Yy0HNVurUnwQRyLy1FRJy
         dm6z2my9sxw42hdtV01dGfEqFP5WedvkP4K0vAzOIld3ZyXAdClttwGDXboNVo0i44pg
         x4x2qjdNadGh8Hs5iOzb8JQPFdeDTEfLyuFIaDkO6UEWGRVO+/wTc0XVQ6E8h77VSYVP
         Txugw4idnFkPPSO7XqrXe/N8wl144gndSumSS4cL2Yu2sNQln3UL+pXRXwJx7KEpjFNr
         5/lw==
X-Gm-Message-State: AOAM531w0qe962jR9kxKJ86M0M9QCJzqL435+wC6AUDLDzNMzrYMoZCM
        4Shd8xHjC6jIWeReUhxAPqSl6cgKf/zFmg==
X-Google-Smtp-Source: ABdhPJzuO9f5UV07Uw7hq7nNmmJKa9n5B68Atjf4cKrrA0zH+s70Sr4+FZWOFjYeasnHCJGGeZI9Dw==
X-Received: by 2002:a17:90a:db95:: with SMTP id h21mr15328732pjv.11.1631923419420;
        Fri, 17 Sep 2021 17:03:39 -0700 (PDT)
Received: from relinquished.localdomain ([2601:602:8b80:8e0::8b71])
        by smtp.gmail.com with ESMTPSA id u24sm7683618pfm.27.2021.09.17.17.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 17:03:38 -0700 (PDT)
Date:   Fri, 17 Sep 2021 17:03:38 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     bvanassche@acm.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2 blktests] nvmeof-mp/001: fix failure when
 CONFIG_NVME_HWMON enabled
Message-ID: <YUUs2i4RGjUpH2tJ@relinquished.localdomain>
References: <20210917030911.25646-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917030911.25646-1-yi.zhang@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 17, 2021 at 11:09:11AM +0800, Yi Zhang wrote:
> skip checking ng0n1/hwmon5 in count_devices
> 
> $ use_siw=1  ./check nvmeof-mp/001
> nvmeof-mp/001 (Log in and log out)                           [failed]
>     runtime  3.695s  ...  4.002s
>     --- tests/nvmeof-mp/001.out	2021-09-12 05:35:17.866892187 -0400
>     +++ /root/blktests/results/nodev/nvmeof-mp/001.out.bad	2021-09-12 06:49:25.621880616 -0400
>     @@ -1,3 +1,3 @@
>      Configured NVMe target driver
>     -count_devices(): 1 <> 1
>     +count_devices(): 3 <> 1
>      Passed
> $ ls -l /sys/class/nvme-fabrics/ctl/*/*/device
> lrwxrwxrwx. 1 root root 0 Sep 12 06:49 /sys/class/nvme-fabrics/ctl/nvme0/hwmon5/device -> ../../nvme0
> lrwxrwxrwx. 1 root root 0 Sep 12 06:49 /sys/class/nvme-fabrics/ctl/nvme0/ng0n1/device -> ../../nvme0
> lrwxrwxrwx. 1 root root 0 Sep 12 06:49 /sys/class/nvme-fabrics/ctl/nvme0/nvme0n1/device -> ../../nvme0
> 
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
> V2: update regex to hwmon[0-9]+|ng[0-9]+n[0-9]+
> 
> ---
>  tests/nvmeof-mp/001 | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.
