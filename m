Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1818C433FE
	for <linux-block@archiver.kernel.org>; Mon, 17 Oct 2022 18:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiJQS1b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Oct 2022 14:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiJQS11 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Oct 2022 14:27:27 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1839F74DF0
        for <linux-block@vger.kernel.org>; Mon, 17 Oct 2022 11:27:21 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id r19so8263269qtx.6
        for <linux-block@vger.kernel.org>; Mon, 17 Oct 2022 11:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zmaKaOskyDEP07VNlz3xmfh/tqhUu/L+2TquVBpNhZY=;
        b=irazOzM4ASvlywgucqMF4REBu2/swLVa43rA8LaqSR7jySzDQIligyjApbjGDuRMnS
         vQ9T4lVgXghfnASSDN1i8Xm5LuOSSmKrQeI+6Q3lSUMmcQ+S1ZMTwud4rwmdl2bKdUJb
         5A06jqIl6l0Q2ioGWFm1rgsyyv4+WVSI4vYkLYIuU7cq4ky+UG4BGvxh1YPFxlUM/mIS
         Aw95Uxl1xiMYZ1r6HA1cYcy6yLf9NSiyJC6i/20sgvkT64Wy2hfytLqNbB9lJrafEKAJ
         uYrMCySQfhbY4F4nodfn5APsYFVG5AQ69EqSfJVLIC4k3huk52b7fymAHztEqux5yncf
         8vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmaKaOskyDEP07VNlz3xmfh/tqhUu/L+2TquVBpNhZY=;
        b=cznFFka9WhMSopB/UG/ErDmcJp3aeOXSx+y4tG7/NUib4vmJL35+1S9UTDwJ7MNoN6
         6LTWqrdc9YWDXor7A4eau01iCpGaZNSPKTuEnVARYAvmsUQ7r/XNpDLNoZskyTc13Bz/
         BR9OS+oGWK5sJktk26wzGh/hWhWuPTprweNscteilBCmG5Fq1AQrNfaKWlQVun0VhfPq
         uPg+3IoiniT2dwQZZarkwvX16761h6N4hAtOisLnrBTPwQ5gn8OoJ2iSyX/xXy0FRV5N
         NAfXmMTWD/0YewB/0nVb8+jGhEsi8TlXxSxX61BEdu1jVe0Trv2dCuSPzGDz87bqisx5
         Vu4Q==
X-Gm-Message-State: ACrzQf0cC9CWdXMRK5iTQHXNjmIhp5vmVbaHlXvGPWZBP8gAU4XrF0Dc
        ZIWMMe8/O0GzZQGchrtTAdSBdLCgnWokyQ==
X-Google-Smtp-Source: AMsMyM4igYNUwBf0hwVsh4teTfB3/xMYGqk+IWEEDwmgjOt9x5IrU4vFE39yv2doSWS5Ujoe43UXCA==
X-Received: by 2002:a05:622a:209:b0:39c:d88f:20ed with SMTP id b9-20020a05622a020900b0039cd88f20edmr9863627qtx.131.1666031240047;
        Mon, 17 Oct 2022 11:27:20 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id dt27-20020a05620a479b00b006b9c9b7db8bsm388323qkb.82.2022.10.17.11.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:27:19 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:27:18 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] block: Replace struct rq_depth with unsigned int in
 struct iolatency_grp
Message-ID: <Y02ehhyqSSLIV5ZS@localhost.localdomain>
References: <20220929074055.30080-1-shikemeng@huawei.com>
 <20220929074055.30080-4-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929074055.30080-4-shikemeng@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 29, 2022 at 03:40:55PM +0800, Kemeng Shi wrote:
> We only need a max queue depth for every iolatency to limit the inflight io
> number. Replace struct rq_depth with unsigned int to simplfy "struct
> iolatency_grp" and save memory.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
