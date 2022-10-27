Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42EDECAAA1
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 23:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbiJ0X1K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Oct 2022 19:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbiJ0X1J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2022 19:27:09 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B83E857F4
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 16:27:08 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y13so3289520pfp.7
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 16:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mx+NR9XtTVDRMSjLNdvpOi8c5jYotdfvey+eZA893Ho=;
        b=eSv/NtVn0Z+xpMsJF8vonRLfyj3R2oxoc37l7TMQdBtF2dEgFvvVwc9J0lq8v0bROe
         bBSIsZo3vs7e6JQwcR1yfpD6GsAPEazzYo9Mr2i6LFQ0b8L/SS/n2JtqCoodREpyWYy6
         Dqjtxwcs9e3EEaorKCaHn5HIkG1nijIbNU1BfPBq3ifL9qrbvaoMN46tHzU5nGPUkLCM
         /yLm/2hdKI+REdeMVegcQFxVcUX1Nui4uGOxzGfcTx1emCn2ZXH79BqtIrz8ioCOkbSY
         GkzUyX30Mc0FHiQJ7rtkG5wCHz5e3AII4Dn/juokg+ASyFKMzViff+NhnUshaYCReh+1
         eDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mx+NR9XtTVDRMSjLNdvpOi8c5jYotdfvey+eZA893Ho=;
        b=VYOifh3kdZozQVfzofi+dD5n0uuq0m987b/ZPS3dX/JoQmA6v6zC0ibAWFHmDGTMId
         eAFp3UwdGXPDwjZ0WaLFA6iBSbEntd42zdlIOLtPfNZxp/71jRd6BU3q3bN4X29x2oCz
         etcj57zBUUo+b6WSjcqAT9+qrqKnHvKcx8gRt0waTlQHDfs2GxrthrF4Kaa8WCJArbRo
         ue1Wpm0sjXZzzjdf8XwbLnbFwlpGqmiOqTHmPv36EiAe9yI1XeaXXoLIeyVDjARWZyK6
         uNhNomo/rCXzNorwaJvfEUdtEhZB4/1X7jueQh26uMQB+e80355eb4dtoB4v+cgyjAQu
         EvLw==
X-Gm-Message-State: ACrzQf1nwV55UrLyGyPBhJoTlJzKbZkorKMfZ1PhKKsO1nqyE0G7pFLR
        7HDHPopD2AQcC7ITYktIXBzJyogv3l14Ki7l
X-Google-Smtp-Source: AMsMyM4syElyp/q9c+GGhP8msFOOd2dj6clKy9GJlMUQ6SbpHU6I7fhLsugPhN//SA9cUH+X5M9V5g==
X-Received: by 2002:aa7:8502:0:b0:56c:349e:c18b with SMTP id v2-20020aa78502000000b0056c349ec18bmr14325616pfn.1.1666913227578;
        Thu, 27 Oct 2022 16:27:07 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k12-20020aa7972c000000b0056cc538baf0sm276560pfg.114.2022.10.27.16.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 16:27:07 -0700 (PDT)
Message-ID: <983a4fda-5e42-3a26-81f6-65e8cd343f8e@kernel.dk>
Date:   Thu, 27 Oct 2022 17:27:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH for-6.1 0/2] iopoll bio pcpu cache fix
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
References: <cover.1666886282.git.asml.silence@gmail.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1666886282.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/27/22 4:14 PM, Pavel Begunkov wrote:
> There are ways to deprive bioset mempool of requests using pcpu caches
> and never return them back, which breaks forward progress guarantees bioset
> tried to provide. Fix it.
> 
> Pavel Begunkov (2):
>   mempool: introduce mempool_is_saturated
>   bio: don't rob bios from starving bioset
> 
>  block/bio.c             | 2 ++
>  include/linux/mempool.h | 5 +++++
>  2 files changed, 7 insertions(+)
> 

This isn't really a concern for 6.1 and earlier, because the caching is
just for polled IO. Polled IO will not be grabbing any of the reserved
inflight units on the mempool side, which is what guarantees the forward
progress.

It'll be a concern for the 6.2 irq based general caching, so it would
need to be handled there. So perhaps this can be a pre-series for a
reposting of that patchset.

-- 
Jens Axboe
