Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E8BC001B0
	for <linux-block@archiver.kernel.org>; Fri, 11 Aug 2023 14:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbjHKOoV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Aug 2023 10:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjHKOoT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Aug 2023 10:44:19 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E7D273E
        for <linux-block@vger.kernel.org>; Fri, 11 Aug 2023 07:44:18 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so32815281fa.2
        for <linux-block@vger.kernel.org>; Fri, 11 Aug 2023 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691765056; x=1692369856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fzzxpoBivTWB9apRtvcogCMy87dGbkIhtMO84KwSnPA=;
        b=ehzwx7Lk0GTB0ywn/JPmQicguYXoK0MPlO+gwqWBshovk+XVM2fOFB/FH6Po5UxRF2
         Mpgm3pnzFbC4UtTvJ5RhHlYtk3Px8kKRhB9GamWy5SxK4XVrqSjPvII3LwwMfThoqFjM
         WhSajoSdSQCekApmygGnLgEF2vN62ab1Vs3rdlxvGJmWKxkvehNQ2Xh3gkUKk1acW1wO
         PuRMfHIfIfhUBkngO/fRJ+mi3dLVo+cvo5dQ5xgxJ9USq3wwoDLS8lo9s8nuQsAm8HTC
         BiqfM1Jtcx8FNmx+MPA8SBi8nDR6XLo4PVlwZuprhkP7MX3kvo+LCmYOeg90aflTwWZ+
         THzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691765056; x=1692369856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzzxpoBivTWB9apRtvcogCMy87dGbkIhtMO84KwSnPA=;
        b=k824Va/KBPu3mH9JDvirSudENQycyd/tXDlTlDp1hAaSpRG9LBZmuxSa0yrIIB0+N+
         /YxoIxqsj9yBIAzVKadsFetpcTvesIyPP8Nrtl3gN5CxJ2Di/Qxyqpsufu1SsK+qbEDx
         RcS42IRaeXwfNrFdmkZJL69VRWa343jTnjjFgGcg+L2uvAKsfJlJmcuczVsXe7zcOUBy
         llp5LwZFHsbpyDCudUMLH546gxZO5KdzUWFczxlYeCG5QCmG+56lPmBlghsOcXkrEQ82
         HZX2uHztuGypoe+pdkNrYUytBHii0QVeIlpk+9GhDTFKxG4MAW2bD0TzrUdl+U51Dhsq
         v8FQ==
X-Gm-Message-State: AOJu0YwPSc7rsXXlDr2VdT9VAdKH0L4QZl9dHPODuqW1odpp6cJJ3ITc
        J82UJwdEtLvDJz672p1gpyS/ZQ==
X-Google-Smtp-Source: AGHT+IEpawbN3fjGpk/kjYUSlNzDpdDV/YNZaUlVkD4KrSgNGhHT62PjzqnSHzOO6NYqpVBawfHl4w==
X-Received: by 2002:a2e:3318:0:b0:2b9:601d:2ce with SMTP id d24-20020a2e3318000000b002b9601d02cemr1835088ljc.35.1691765056562;
        Fri, 11 Aug 2023 07:44:16 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l4-20020a1ced04000000b003fe61c33df5sm8420704wmh.3.2023.08.11.07.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 07:44:16 -0700 (PDT)
Date:   Fri, 11 Aug 2023 17:44:13 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH] ublk: fix 'warn: variable dereferenced before check
 'req'' from Smatch
Message-ID: <f358d643-ec79-4ea5-910e-c21dce63218a@kadam.mountain>
References: <20230811135216.420404-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811135216.420404-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 11, 2023 at 09:52:16PM +0800, Ming Lei wrote:
> The added check of 'req_op(req) == REQ_OP_ZONE_APPEND' should have been
> done after the request is confirmed as valid.
> 
> Actually here, the request should always been true, so add one
> WARN_ON_ONCE(!req), meantime move the zone_append check after
> checking the request.
> 
> Cc: Andreas Hindborg <a.hindborg@samsung.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Fixes: 29802d7ca33b ("ublk: enable zoned storage support")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 3650ef209344..be76db54db1f 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1400,11 +1400,13 @@ static void ublk_commit_completion(struct ublk_device *ub,
>  
>  	/* find the io request and complete */
>  	req = blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
> +	if (WARN_ON_ONCE(unlikely(!req)))

WARN_ON_ONCE() already has an unlikely() built in.

regards,
dan carpenter

