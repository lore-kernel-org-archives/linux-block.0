Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4FEC433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Apr 2022 01:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbiDLBU6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Apr 2022 21:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbiDLBU5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Apr 2022 21:20:57 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CB463F2
        for <linux-block@vger.kernel.org>; Mon, 11 Apr 2022 18:18:42 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id md4so8572382pjb.4
        for <linux-block@vger.kernel.org>; Mon, 11 Apr 2022 18:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=7zb6q1clRNVhF0nkskjbfPH7YAOizM8520PoPHZpcOw=;
        b=O7uwwzHGxTRiODkFwH9ivMlDft0Tl2AIFEZwulB/Qoqhzakw0M5Pr0WHUsU3KXP9H2
         wkj8Cq7lBfEbdiOG6WxF87/wazWOkLDju5SMx6jl26dv/Hy1OiBgTEXG6898eZcz2pt0
         CDDXM9PghdlqBkxgzmVCnm3aDVy8WdgIw/kJUUCFJbk7FayxWN4dml8+NPL6ld8CSm+T
         P5xin+G5p8WyYwl0rdBels5U9Z+K6uGBDN5fq1EaGY+h+Tv2p2jBK/KDlCm9it6QMjuH
         gJ3zXyH+wbuC2pGUxRVy9dCaT5Gm1pw50gbt8IIYVRAFTSN3TdBgj94PlFG0vPLV5hQa
         vBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=7zb6q1clRNVhF0nkskjbfPH7YAOizM8520PoPHZpcOw=;
        b=dTEv0QuLl/OEx1nAsv6Xfqq2N9CYdhLpRD6a+2TUGNnJp27TQYAn5sIR7E8gXeWWAn
         /ZycTp638C2dI1Q6R96jTmpwqcYE0TraGHX6vtO0IWEuyOZPD8gPziaIx6qszc80UPg4
         32MQWdO0PV073BeoLFm7/8JKkQOcnZG5gBv2yxr7RURl1z7NcoMZZhgsEgXiU0ewraCM
         jByo62abCTs/tI0H40U5A2Up1kWPJyKnxdIeNlnAwwV1Tg5H8vjyQDRF/+mYSp+aeBlt
         E9dgKAOnhz+seIsIDWgbyPUo4MYxtO4LSOFdpzGqkJ7u/D61nqMm2o0anaR568kfxrM0
         ZrYA==
X-Gm-Message-State: AOAM531gR4jvpshVrHBDulpgnn6oMGvKZgrgnN1do6emF/x/861k79gD
        kDyCU8AcI9VC71Qx/Ym3b6E7SwmRSzgTkw==
X-Google-Smtp-Source: ABdhPJyELxhsPSt5QpmyGIAa7Xr9IhqeHkFbLogqUSu+AT9i/cLN1dmFY8AdTxDbHLR7TpH4yEZPpA==
X-Received: by 2002:a17:903:183:b0:158:7083:4ae9 with SMTP id z3-20020a170903018300b0015870834ae9mr5753119plg.75.1649726321769;
        Mon, 11 Apr 2022 18:18:41 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g5-20020a056a0023c500b004fae15ab86dsm36262964pfc.52.2022.04.11.18.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 18:18:41 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     kbusch@kernel.org, linux-block@vger.kernel.org,
        torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20220327173316.315-1-kbusch@kernel.org>
References: <20220327173316.315-1-kbusch@kernel.org>
Subject: Re: [PATCH] block: move lower_48_bits() to block
Message-Id: <164972632075.287454.14684936901752798558.b4-ty@kernel.dk>
Date:   Mon, 11 Apr 2022 19:18:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 27 Mar 2022 11:33:16 -0600, kbusch@kernel.org wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The function is not generally applicable enough to be included in the core
> kernel header. Move it to block since it's the only subsystem using it.
> 
> 

Applied, thanks!

[1/1] block: move lower_48_bits() to block
      commit: 868e6139c5212e7d9de8332806aacfeafb349320

Best regards,
-- 
Jens Axboe


