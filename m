Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5709EC77B73
	for <linux-block@archiver.kernel.org>; Tue, 25 Apr 2023 03:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbjDYDOt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 23:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbjDYDOZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 23:14:25 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728DEAD01
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 20:14:13 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso5351183a12.1
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 20:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682392453; x=1684984453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KhNVYkLTzmbXjoyFBzocC/TOpuMyPoYNLjO0Vj2mibo=;
        b=disMM9XtLkiGCKZtd2OSxWABWw9EzU1/6D/IwdYByqFDWPUhm4xLI9xCnruU6GXByv
         lGfXjKJ/vPERVeRzbhxU/9YPp6HQoHLSsnwu4eszbZzg7xTp0v+lXC+MgYgjcW6csnZw
         RTQutquC9W2lPi7kSqusMCclIliGGDy8BjKOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682392453; x=1684984453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KhNVYkLTzmbXjoyFBzocC/TOpuMyPoYNLjO0Vj2mibo=;
        b=cRu+7g+iVbpLrPELMwSKN3dzirmqazqKsPjChGEhPvYTBJu0vgCx6PE7Qy8lLRHCyO
         Y5S4qagggobBpLLidVL3+aCmtUnvKjEECY+HppR/v4NH6Wk4u16Hpg5NEVVjx/CoA/T+
         CWCGNC7TmH98cDOz32wY1ck4XokwuWt0A0j3s7/FPuTPS9WVrpPiGZrO0//uYoMW4+Ki
         9TG8OnXuQeAU9Oj4FraVYnnfCO2W8M/1v6R5IKlzTZ6icut6aoQkRHeiBZHR5YRP5+jQ
         R+sogtg3GcoRBRHqub7+V0bsyNrrh9FbbsH6BcU8UH85gBFIFGd41AFsYVH6g48eJ0wy
         4uXA==
X-Gm-Message-State: AAQBX9dUY1n7R0ZkQ4izIuodD/h7HKzof5XnLsq0RyT18/40ykxpzBCm
        hIoQwlX1FVn02PWJZ7G7PnYqqw==
X-Google-Smtp-Source: AKy350ZRcs6vQaV2vbvFGrwyeov6O4WMuCeSbDK3CDrpizjg9yr8PKdiVHOflM1xqHZ8CUGlvZPBhg==
X-Received: by 2002:a17:903:32c1:b0:1a9:5093:a604 with SMTP id i1-20020a17090332c100b001a95093a604mr14818577plr.18.1682392452979;
        Mon, 24 Apr 2023 20:14:12 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id o3-20020a170902778300b001a1a07d04e6sm7173351pll.77.2023.04.24.20.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 20:14:12 -0700 (PDT)
Date:   Tue, 25 Apr 2023 12:14:06 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        axboe@kernel.dk, josef@toxicpanda.com, minchan@kernel.org,
        senozhatsky@chromium.org, colyli@suse.de,
        kent.overstreet@gmail.com, dlemoal@kernel.org,
        johannes.thumshirn@wdc.com, bvanassche@acm.org,
        vincent.fu@samsung.com, akinobu.mita@gmail.com,
        shinichiro.kawasaki@wdc.com, nbd@other.debian.org
Subject: Re: [PATCH V2 1/1] block/drivers: remove dead clear of random flag
Message-ID: <20230425031406.GA1496720@google.com>
References: <20230424234628.45544-1-kch@nvidia.com>
 <20230424234628.45544-2-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424234628.45544-2-kch@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/24 16:46), Chaitanya Kulkarni wrote:
> QUEUE_FLAG_ADD_RANDOM is not set before we clear it for "null_blk",
> "brd", "nbd", "zram", and "bcache" since by default we don't set
> "QUEUE_FLAG_ADD_RANDOM" to MQ ops.
> 
> Remove dead clear of QUEUE_FLAG_ADD_RANDOM in above listed drivers.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org> #zram
