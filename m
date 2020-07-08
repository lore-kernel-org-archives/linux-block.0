Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C70C433DF
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 23:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03B2320708
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 23:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cMbzoT4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgGHXOd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 19:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgGHXOc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jul 2020 19:14:32 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8668DC08C5C1
        for <linux-block@vger.kernel.org>; Wed,  8 Jul 2020 16:14:31 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id k27so89214pgm.2
        for <linux-block@vger.kernel.org>; Wed, 08 Jul 2020 16:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qXlCDNHI0ZK15y0LOuAYzGPtynusnw7LtwDb5Yj2OtE=;
        b=cMbzoT4XhkOdRuftJN/OiPsYT9RozDw+GuQh01xrUOP3mEW5tEUjydfcb4W+DKVzne
         TFfUTMUinXgvBqCBfHGgOVgQJzkXgqOGy28APv540LEKujTVtjrvU97kbdrHqETQKtaw
         RxfU1Mj6GTpbQeKCFE4jR13nkdUzsgeldvzxXoT9HJ1fzXpuM/Ep2USaPDxgdcyvZAzd
         /jZjEoDC//LUR2Vf0Zhf0IGE23c90oPClyOfNFgWvDrq1zo1M5Bgvo6f9IqIwZwMBEpc
         Bs9RuI54YBgJOxg3wIrkIpXX8DSkg4acxak06jwvZXv2M3RmK5zy1eWHCosB7prsXkuL
         YrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qXlCDNHI0ZK15y0LOuAYzGPtynusnw7LtwDb5Yj2OtE=;
        b=KZUDerhpH+g2r759aC/fPdIvMDpCeXQ7W6PXAu5AK+YnNcmU3jRPAdhzUVe/6rLT6k
         0O2FM6oAqLWYk+u16EDQ6z9FDG0VbqHluN//NM7zOy9wLxbmYy19UUGV3jGNjQ4xa1ko
         CiXRDzbqnhN9CjWaJqIYHTZjUa2CHfQLlCGUJ6OfKXVyIDB0MFS/7SWB1WW7kWXGE3In
         eTLxj9JFknBn4LSexptY8IganLQeubDtdruQUUMC9W3Gx4rd70sr6ykbaNU0ndXG07sC
         6V5NwCBwBCZo6ubLI5ATn2sV9SuEJx8dNDQpx7NlTIb3eiMXlNjGCLaoz0hljWyVcWne
         j7Cg==
X-Gm-Message-State: AOAM53181jSKFfuVsannL3YrFNUm8DiKVgxwdZCevh7UGJr42hA6zsuL
        76BXwoYsY7AY63RTPEJgTGfG7Q==
X-Google-Smtp-Source: ABdhPJwxXRU58dnJ8SaVTE59SieM0UMi6WQspGfeG513juta/gCc2a5inFjMHD1HHOikaeJsZTW/MA==
X-Received: by 2002:a63:7741:: with SMTP id s62mr50514486pgc.332.1594250070946;
        Wed, 08 Jul 2020 16:14:30 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id n137sm721427pfd.194.2020.07.08.16.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 16:14:30 -0700 (PDT)
Subject: Re: remove dead bdi congestion leftovers
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, dm-devel@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200701090622.3354860-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b5d6df17-68af-d535-79e4-f95e16dd5632@kernel.dk>
Date:   Wed, 8 Jul 2020 17:14:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200701090622.3354860-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/1/20 3:06 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> we have a lot of bdi congestion related code that is left around without
> any use.  This series removes it in preparation of sorting out the bdi
> lifetime rules properly.

Please run series like this through a full compilation, for both this one
and the previous series I had to fix up issues like this:

drivers/md/bcache/request.c: In function ‘bch_cached_dev_request_init’:
drivers/md/bcache/request.c:1233:18: warning: unused variable ‘g’ [-Wunused-variable]
 1233 |  struct gendisk *g = dc->disk.disk;
      |                  ^
drivers/md/bcache/request.c: In function ‘bch_flash_dev_request_init’:
drivers/md/bcache/request.c:1320:18: warning: unused variable ‘g’ [-Wunused-variable]
 1320 |  struct gendisk *g = d->disk;
      |                  ^

Did the same here, applied it.

-- 
Jens Axboe

