Return-Path: <SRS0=c8VV=ZU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499E0C432C0
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 17:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E690215F1
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 17:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vgcY+1/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfK1Rlr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Nov 2019 12:41:47 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36581 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfK1Rlr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Nov 2019 12:41:47 -0500
Received: by mail-pg1-f195.google.com with SMTP id k13so13202415pgh.3
        for <linux-block@vger.kernel.org>; Thu, 28 Nov 2019 09:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=eK2bOxyHmzuaYq0XrGFlwguXBcIvJbbPkj4a8PHz/Gs=;
        b=vgcY+1/3ymIZELnwyjKvbe42CneSntXlY5ChCNLbJOgyzld+6a78pAixex8EqHQvM4
         5It+6lWM/auCLtHti2AeG1H7CYqAzLi9YlzvHzY8Ib0RH1GFKLeGYLaoSLQTX8PHb/jC
         jrbpJ86LJtfOpWdpwNYwB4FEbUwRjZNoreiUo+B1x5f0w08O5TYn4ItpNZHN/OE9aauE
         ZXQNSgDnLrWh93RDTNzSWBexdETZwGA4jZ6j+nGwbS9d3Q7PNYqc2Y7kPL+a8zduYnGh
         y40ozFQqa28AzKPu6m9Kgz8P270VIeo1DWQN5TnBN05fvgy7cuQEtXGJ2gXcaCCVqvH2
         MGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eK2bOxyHmzuaYq0XrGFlwguXBcIvJbbPkj4a8PHz/Gs=;
        b=tLiWNajWhUNgtbs0NihZYFFDRAO3MTLIbCK9bQ/YbSItwBRYU0T5iAlo1XxsAhSOYk
         KXP1SOt4KKx/VfRpt93lWUe/9zGylrEOTLCiv/S0w4AsMDLk3+8HFb9sYIzXqKOTVcvc
         Rw9J+EgICmtgkUGXBptZaGhNFpe47uz5OlhQR1NB4moQkcKjL7Yoy+nndMlj5uysgzdr
         gXoENttIuEhqNlu7MLSI16qOJElsH15NDrCB/SpJMFVZgF6Yyrb3Dv1sJ9abPC1tiUF3
         dLIlZjwspJ7GvE/37vqYHjt9Re5lVgooerEtlv31avX0PS2msUVeI7/WpzWgzHjiZ7kM
         aA8A==
X-Gm-Message-State: APjAAAV38mXNlDh/dIeUA0t18W1Fj6DpjFCyD0aa0tBRglRy2zUP6K4G
        2T2x9BNO5X3WxrWBB3n//CIZdTqpqlh/Eg==
X-Google-Smtp-Source: APXvYqzWT+Xt4x0hM1PqXey3gXlLFyt4OTEDC+qZ/1rHXPXBgzo5Fsz1+bjLdCFKVM+nYqUAVqVvnw==
X-Received: by 2002:a63:5fd7:: with SMTP id t206mr10248832pgb.281.1574962906348;
        Thu, 28 Nov 2019 09:41:46 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:a930:60a8:686e:252a? ([2605:e000:100e:8c61:a930:60a8:686e:252a])
        by smtp.gmail.com with ESMTPSA id h26sm20399067pfo.93.2019.11.28.09.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 09:41:45 -0800 (PST)
Subject: Re: [PATCH 0/3] drivers/block: Remove unneeded semicolon
To:     zhengbin <zhengbin13@huawei.com>, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org
References: <1574910572-42062-1-git-send-email-zhengbin13@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <32174dcc-ada8-ba8e-b000-47ed8e4c725e@kernel.dk>
Date:   Thu, 28 Nov 2019 09:41:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1574910572-42062-1-git-send-email-zhengbin13@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/27/19 7:09 PM, zhengbin wrote:
> zhengbin (3):
>    drbd: Remove unneeded semicolon
>    block: sunvdc: Remove unneeded semicolon
>    ataflop: Remove unneeded semicolon
> 
>   drivers/block/ataflop.c       | 2 +-
>   drivers/block/drbd/drbd_req.c | 2 +-
>   drivers/block/sunvdc.c        | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Jens Axboe

