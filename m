Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBE2C7EE24
	for <linux-block@archiver.kernel.org>; Mon,  5 Jun 2023 09:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjFEJ3Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Jun 2023 05:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjFEJ3Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Jun 2023 05:29:16 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95195A7
        for <linux-block@vger.kernel.org>; Mon,  5 Jun 2023 02:29:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30e412a852dso817978f8f.0
        for <linux-block@vger.kernel.org>; Mon, 05 Jun 2023 02:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20221208.gappssmtp.com; s=20221208; t=1685957353; x=1688549353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g2THcfh8s/E8A9Q3W+8XFt0p7Au/U9ACqLSkFJ7lxEE=;
        b=UvBj2Hz/ZyBpE3lZSzXKA6ngq0oc0HTbjyhRG8nzmfnlVnJ4qkk3+a5nd2qQmveFDj
         t71ab8pGB7bQWWjRGYYkk712PmUXzLv0IcSD6VwwLiN1U1Srhh5C5KJJ25HLZz9qxSco
         03Aop4Wo7ynqXbjPiNrKjqdwKF9Vi1HhYUQUjuZCpMU1ILl8xjVmcmTsu7htky31FXR6
         JVTuXJ4bCLrDt80cC9mSJSlqO5cfCRWnNcJ7gLLXyS8jQhlV9vJXKTqCrjlpxRMTvbXc
         fFVwrq/Wuc3c1IWXFkEPNsY55LGFeL1PfwdSlQSwl+9UNF0e5V6fLAfVVx4+ctOCAX5a
         6tJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685957353; x=1688549353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2THcfh8s/E8A9Q3W+8XFt0p7Au/U9ACqLSkFJ7lxEE=;
        b=CoJ+ymKDWwCQMIGjRJh6Vn/HLXky8yDu8r/lPWWs1Rumvu04+uiwH1rvglOC3tAc3F
         gfCt/PP5/XaYgy0bmM6l0GJ3sCCQgaCY81hbYDEq625ql82CNrmCjaVeDPC3PWNpo8rU
         hi6Di7xLSvNwpgWxz7ELJW/mPsUE1vQjXWICg/COMCNktUxGEl5TR5OpoFUHFxfrvJYF
         pRaxBNA9GvljOVjSpb2pYGyVZS7GbDRzU4h42k40XgWECFoBmkIgsGOUqbrVoP4hPSeF
         /ht51EMHg42P3DFoLzh4bqJTzd999H/Sy0QiLI5EaScVCbPCIsOADgWkdq164eHh0YVt
         BdmA==
X-Gm-Message-State: AC+VfDwanwzFR5iVsx/09LfXWhCYP0Kofb847vLzEqfnpslPSkPdwHm6
        lob7sX/DGwqY4aPh+te4/8BDmHIsKNFYlZhri5NJsw==
X-Google-Smtp-Source: ACHHUZ4IzU7/FDO3TZ9CMu/B7p9RSwV7e1VVEtKPAbfQjjSYbz4yBn6ModbRKB7EWAwlhO/cTJ4RMQ==
X-Received: by 2002:a5d:65ca:0:b0:307:a075:2709 with SMTP id e10-20020a5d65ca000000b00307a0752709mr4179957wrw.68.1685957353048;
        Mon, 05 Jun 2023 02:29:13 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id n18-20020a5d4c52000000b0030ae901bc54sm9095163wrt.62.2023.06.05.02.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 02:29:12 -0700 (PDT)
Message-ID: <2135eb9d-b673-1a0d-6698-d73de60fa00d@linbit.com>
Date:   Mon, 5 Jun 2023 11:29:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drbd: stop defining __KERNEL_SYSCALLS__
To:     Christoph Hellwig <hch@lst.de>, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        axboe@kernel.dk
References: <20230601151646.1386867-1-hch@lst.de>
Content-Language: en-US
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
In-Reply-To: <20230601151646.1386867-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am 01.06.23 um 17:16 schrieb Christoph Hellwig:
> __KERNEL_SYSCALLS__ hasn't been needed since Linux 2.6.19 so stop
> defining it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/drbd/drbd_main.c     | 1 -
>  drivers/block/drbd/drbd_receiver.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index 83987e7a5ef275..54223f64610a05 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -37,7 +37,6 @@
>  #include <linux/notifier.h>
>  #include <linux/kthread.h>
>  #include <linux/workqueue.h>
> -#define __KERNEL_SYSCALLS__
>  #include <linux/unistd.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sched/signal.h>
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> index 8c2bc47de4735e..0c9f54197768d6 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -27,7 +27,6 @@
>  #include <uapi/linux/sched/types.h>
>  #include <linux/sched/signal.h>
>  #include <linux/pkt_sched.h>
> -#define __KERNEL_SYSCALLS__
>  #include <linux/unistd.h>
>  #include <linux/vmalloc.h>
>  #include <linux/random.h>

Looks right.

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
