Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3747C4338F
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 19:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78BAF60C3F
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 19:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhHLTLH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Aug 2021 15:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhHLTLH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 15:11:07 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28183C061756
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 12:10:42 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id q2so8518279plr.11
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 12:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ecQqLURuszt+LcX/N0G20mW9g+t4lnqlID1YZtHlRAw=;
        b=lekreo2ixVPUuGN6A1l1H3xYWSieJExdyVTrcBx3ggb1ewnRCGFgcjPIt5NNHtNFVk
         SSbTWcP7S3E88In5YW00varBg2QeHEwVO4Auso3XxtyHOPpmCzmGLtuBpMNj/tDxK3yp
         +HB9JQEdKKEV0Fp/0AgXOwvI6+KgKr5kC7wSNCehK9ZrrJW3pfgER1CTrQ93HWbJs1TT
         xsPk1RlCb/uUkTh4tkLVAnNpAnO/MKyAswCbrNyM4y8y9RSYGU1LYd9KBV+CxMp331pt
         uHYr/Q4BVQ2U5TaPTle9WIN0vESOWKUdgl3QvUh7ymSVxoVpZGtt0fMMURl2oa1MtvqE
         fVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ecQqLURuszt+LcX/N0G20mW9g+t4lnqlID1YZtHlRAw=;
        b=P9ChQlAeBOv830xa1Wa8/UO6GdlMLEBWzZB0MtNOn3HLio33C4D0LdoqFDH+h03jEx
         kvy0E36M8lbgIiJDivRUDNTFt5FmJoS6xkPHwW0+GyI9qG9JpaWoV+ZBWT+EL+E+I2Ir
         JbLxiweU1xeGSqA404tMKzNxlciHBY3lhuc+ISY790nT3l2KtKfKvd63Vnj87Xi8nciw
         xn0xn2pPY5O9lx1J4Bzdo3aCUBcWKjtlT9ctwiAKurc56ECK58k8D8ke+YkMdy7FY9G9
         AbRHz5RXf9QK75C1WDz8hiIlIHysMptQ7up1PVfvPa0YdtnzFwMXdh88OCYfTpA763rQ
         9mRw==
X-Gm-Message-State: AOAM530lxVAQtcL/Ktjl/J+0BtjVnHyi2G5dbWbOu8m4LdzTxlb/Kx5T
        EmRSRrCHW0WdGlt6mE8n+Hc=
X-Google-Smtp-Source: ABdhPJwAXGVVLPGyxgP8x/H6mbGdEQM75NVArX70uLufkC8h6iC76LS3n7sER23JaYZXVgh/HHL3Fw==
X-Received: by 2002:a63:d044:: with SMTP id s4mr5212675pgi.32.1628795441631;
        Thu, 12 Aug 2021 12:10:41 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:90ad])
        by smtp.gmail.com with ESMTPSA id nv11sm11284755pjb.48.2021.08.12.12.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 12:10:41 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 12 Aug 2021 09:10:36 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH block-5.14] Revert "block/mq-deadline: Add cgroup support"
Message-ID: <YRVyLCwG7zUVacJa@mtj.duckdns.org>
References: <YRQL2dlLsQ6mGNtz@slm.duckdns.org>
 <035f8334-3b69-667d-be91-92dcab9dc887@acm.org>
 <YRQhlPBqAlkJdowG@mtj.duckdns.org>
 <00e13a7b-6009-a9d7-41ba-aae82f5813de@acm.org>
 <YRVfmWnOyPYl/okx@mtj.duckdns.org>
 <9441b463-50f8-e7c3-51ec-e4bc581da627@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9441b463-50f8-e7c3-51ec-e4bc581da627@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Thu, Aug 12, 2021 at 12:56:47PM -0600, Jens Axboe wrote:
> On the surface, #2 makes the most sense. But you'd then have to apply
> some scaling before it reaches the hardware side or is factored in by
> the underlying scheduler, or you could have a high priority from a
> cgroup that has small share of the total resources, yet ends up being
> regarded as more important than a lower priority request from a cgroup
> that has a much higher share of the total resources.

I don't think hardware side support is all that useful for mainstream
use cases. Whatever is controlling IO has to own the queue by being
the most throttling portion of the pipeline anyway and at least my
experience has been that what matters a lot more is the overall rate
of throttling rather than how specific IO is handled - ie. you can try
to feed one IO at a time to a SSD with the right priority marking but
it won't do much good if the sequence includes a lot of back-to-back
writes which can saturate some portion of the SSD in terms of
buffering and GC. Also, the configuration granularity is too coarse to
adapt to generic use cases and the history is pretty clear on optional
advanced features on mainstream storage devices.

> Hence not really sure it makes a lot of sense... We could probably come
> up with some heuristics that make some sense, but they'd still just be
> heuristics.

Yeah, I have a hard time imagining a sane and logical mapping between
cgroup IO control and hardware prioritization features. For use cases
and hardware configuration which can benefit from prioritization on
the hardware side, I think the right solution is doing it outside the
cgroup framework, or at least the usual IO controllers.

Thanks.

-- 
tejun
