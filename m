Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B89C43603
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 16:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0884922527
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 16:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="T6xkncOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbfLLQ11 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Dec 2019 11:27:27 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:46675 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbfLLQ11 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Dec 2019 11:27:27 -0500
Received: by mail-io1-f54.google.com with SMTP id t26so3377004ioi.13
        for <linux-block@vger.kernel.org>; Thu, 12 Dec 2019 08:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L2CjDVtbtRmSS9p/ZMC2e8zHEfBbFA8EoUfM5bDUuwA=;
        b=T6xkncOLY8LZ+5xON4nDUfI/fzvqKg69ZBb0XfMIjL9EDlMcrpyTzYV3jPEUECIu7e
         /6VePkJbfJ02IxgtjhVi7zhODL3RzicRz8RUUxTG9FMA0/+l2gwHg1lkXa+9Xz19lG5P
         RIW0WHds+gFZXVLHMoYOU2aVxFfugcJGN8+IRth7RzCBvBQvkKfr6RZdZFv3XFAGcEv8
         0jvtGdkjF2LOv6J2oK0OhlmGZ96TS3op6ZjE2hRprquRNtnWc1QVP2D5xZElq0NP++dH
         FdY9uKj1DamP/Cer06/nmE/izvRIUNoXzSdvxib0JD4MDAk3nsjsBw7M9wgtvidm7gjA
         sI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L2CjDVtbtRmSS9p/ZMC2e8zHEfBbFA8EoUfM5bDUuwA=;
        b=I5+zoxnv7s2kpCGcmlQyz4SEzEO6FBq15XMoeQQ7DZfrPc+IP/Y3v7L7BwrC4DOQ+X
         jGV1N4kKDl8gs2w80gyydZlzNdO5vc0hcMmwANX0o2cKqn/Ka60Pc4BVteJz+Mx79+Ol
         Q97sXTxsTWGa4OL5M6tsadMXIEPDDqocrR5KQU0sy2L9I79Li3GUnTdL4UuHe6/YWcyy
         ehjeFoENMZ0ISueb71imLB7BRYqSXOHQH6NTyIQ+6d3L9EGompQfqaZg8OsfrXlvREya
         cZJhJGNXoZIW22sLR3DTEsGXYYcrA+K2ilH43mkoQq2xf9GNnoWUl8nnb0yKBiK29fv8
         2qFQ==
X-Gm-Message-State: APjAAAW2MGjF9560vuYBgd6r0wMzbwRevJ2Cyr/ZwR3RTh3NHfdUxONY
        aANyVnxmqHFAT6AqYOH0QNpTJA==
X-Google-Smtp-Source: APXvYqxoJV4anqq+qDAdhKogptjDsSD2zTMOztmiodrLP2ZIGIITw+1PsHhlCWyUyDRKNb2x5gMkZA==
X-Received: by 2002:a05:6638:304:: with SMTP id w4mr8644279jap.81.1576168046416;
        Thu, 12 Dec 2019 08:27:26 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k7sm1836770ilg.49.2019.12.12.08.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 08:27:25 -0800 (PST)
Subject: Re: [PATCH v2] blk-cgroup: remove blkcg_drain_queue
To:     jgq516@gmail.com, tj@kernel.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
References: <20191212155200.13403-1-guoqing.jiang@cloud.ionos.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3f8133d5-fb25-a588-3cd8-b3b6dbfae4c8@kernel.dk>
Date:   Thu, 12 Dec 2019 09:27:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212155200.13403-1-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/12/19 8:52 AM, jgq516@gmail.com wrote:
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> 
> Since blk_drain_queue had already been removed, so this function
> is not needed anymore.

Applied, thanks.

-- 
Jens Axboe

