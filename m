Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEC9C43334
	for <linux-block@archiver.kernel.org>; Fri, 15 Jul 2022 14:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiGOOmO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jul 2022 10:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbiGOOmN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jul 2022 10:42:13 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4206D74DC2
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 07:42:12 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id b12so2617446ilh.4
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 07:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=JJO3eK9CCRDZQPsPVO2SIonKTmKiRQIT6+C7SJk65cE=;
        b=oCCC/Rxv5r/07zAkLCxohyLT4SU/w9VWnaoQlaueB/vEa2hI3PNYD120bo+OvFNkml
         w8clXD0suqJ1v/oLVrvFpMUvos05KKWxwufooTj6+9q6/9mcEVhOhJ/j8Jqk0pPm4xNe
         ZHj4WlrP/zwa1cRHAoDajUBoJwZlkIm+ojzbTbKHHuPkfiG9qkrVsHkWOaY4vZ/oD0mM
         rAUTazE/AINLYPWdgIljREf8GgPuDIj34KWvTG03gPUap9Vm4dQhkQfv72UQYFnJIhTo
         yGDordU7Gags0CZZ+7mL+XXv2i3s5ryIm8LBGWMlAQ2dYGr8/N79c+QHWGEBs0QEjAla
         q1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=JJO3eK9CCRDZQPsPVO2SIonKTmKiRQIT6+C7SJk65cE=;
        b=hgIFKJ2wNi2meyqZwldmH1LMGHJlHYq7ymAUR5naShj7N67anWjYGnutklT9wBW89l
         YEJJR/4sE4x70ZxwlgBs9EjZbHRugIIwiiVOZ+1BavceYTACEC2C9nVLC2SGlw8aFkmq
         xV1IpptvtxIz9C4u5SqQ+9tL4srRlNup+FHl8htGyRswyUzvWx8s6CC4TjdkdXg+bsnP
         fSg8kU7ezVdPGyjwn/opnHFZBwz3MhSP8CWIm05I3iOaJDiohmMoRKjojMouGMNCYGMT
         fFpJsPoxpwd9VHL0E36CIIC1iM4iDuH3sTtfZkweQCZunVdbvUmaAfbzUlR55o0vA+cv
         HpmQ==
X-Gm-Message-State: AJIora9ZYoym9PfgKBNMJS60ihHbPj8P1GmT5fwexEv2YZoDOsULDUW3
        YO33YOsRYRRIjk2G7lrs+ZGR/uD8mTpg5A==
X-Google-Smtp-Source: AGRyM1t8EuOCbqRZwsSjfrNspQLmBq3VcakPvYIsbLuuVs1AyOcokQuDJfKiEqg78xmQLmtTvDi5rw==
X-Received: by 2002:a05:6e02:170a:b0:2dc:685c:5fdd with SMTP id u10-20020a056e02170a00b002dc685c5fddmr7426742ill.274.1657896131473;
        Fri, 15 Jul 2022 07:42:11 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k19-20020a023353000000b00331a3909e46sm1977165jak.68.2022.07.15.07.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 07:42:10 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com
Cc:     vincent.fu@samsung.com, linux-block@vger.kernel.org
In-Reply-To: <20220715142847.188275-1-ming.lei@redhat.com>
References: <20220715142847.188275-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2] null_blk: cleanup null_init_tag_set
Message-Id: <165789613045.273640.16090335610544459299.b4-ty@kernel.dk>
Date:   Fri, 15 Jul 2022 08:42:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 15 Jul 2022 22:28:47 +0800, Ming Lei wrote:
> The passed 'nullb' can be NULL, so cause null ptr reference.
> 
> Fix the issue, meantime cleanup null_init_tag_set for avoiding to add
> similar issue in future.
> 
> Meantime set BLK_MQ_F_NO_SCHED if g_no_sched is true in case of NULL
> device, same with BLK_MQ_F_TAG_HCTX_SHARED.
> 
> [...]

Applied, thanks!

[1/1] null_blk: cleanup null_init_tag_set
      commit: dec7e933d65dbc6eaa6c7fd8f960df164a20dd4d

Best regards,
-- 
Jens Axboe


