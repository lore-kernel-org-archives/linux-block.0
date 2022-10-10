Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5890DC433F5
	for <linux-block@archiver.kernel.org>; Mon, 10 Oct 2022 14:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiJJO1Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 10:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJJO1Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 10:27:24 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FA953D21
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 07:27:22 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id f23so10529853plr.6
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 07:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lXZVugAjzZt/AOOtKb1zujcaKt0Ww0HY8XVrW1TZGQ=;
        b=sH7ANBjDG9yr63HNRtGX8baxzSpeCvB8v7bw8cgeKXHX9AwUwmhX9UjBfU0PGJgA4f
         ZFNpaVfqwmokrACzfiJi+pSlKsAb60JQWxfyFEo2baB/2mGnBc1gmxqTF+6T1zlVUTWd
         LW/xjtJCt9tJMnYijL1nB2v9QPlJbnU+d3LW4VU8TkaR3UBRASfofLlMhjryb0/GvVEk
         tVtw97iL3lvlVO33Uk3p11EyENCB7BmCTqjN8HmQI0ACdmxmps7KdkNUyRXMCB240LUL
         Yql7jTOZSK3c3G054nQrTGNe1nHW95Z8Qa5TEQweQ/v1LBMD9necMbMW/RYtwo9pnkCk
         dH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8lXZVugAjzZt/AOOtKb1zujcaKt0Ww0HY8XVrW1TZGQ=;
        b=z90i3fxemkT9bPsLhNuCtXNj4jyK8el7F/DQoHfOFmeCiUxSlbUzbC50jEgOPSJGpT
         G6SSA9gw4o/7XsrmLkTwnmsJmDqwF4UZew11sMipAwpp7+OVfl6jJwZxb56yjb1NukD8
         b+Tm4Jkrbp9bjRcv/b0x+x36EJlcJ3tc4jNH6+tyrccCoh30BnjFZm2k4VTl5A1q+WVH
         UrKnZcpxXP7TbmJ7aFkfJ4Mlfl5FOV0eC9CvUm9GJGIaS2Cs4qHyzdawXVXgytk4TG/g
         kvXhVhYHi3bhly1FaKKK6Enr3Pz2jY8+xSv5nhiFjn5yzCuKi/rN0jzo0IGeE3j3LpTg
         HaVg==
X-Gm-Message-State: ACrzQf15nQEXELQsnNuOYUNteNOpUgWwgFURQMUMl3SU0v4GW4+ASR/+
        NTib8iTVnzfcQEICNuLA8e5YeqMwrZdOfaAV
X-Google-Smtp-Source: AMsMyM7wE9SNzofNNs5fo82ZnGSZ7k9sozC1BvOX51ik7k6afiHn48Ve+jfQ4EeS58Sjq/QK6XEitQ==
X-Received: by 2002:a17:90b:3901:b0:20b:210d:d5d9 with SMTP id ob1-20020a17090b390100b0020b210dd5d9mr20327884pjb.83.1665412042306;
        Mon, 10 Oct 2022 07:27:22 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s15-20020a170902ea0f00b0016d72804664sm6712315plg.205.2022.10.10.07.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 07:27:21 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Brian Foster <bfoster@redhat.com>, linux-block@vger.kernel.org
Cc:     Nico Pache <npache@redhat.com>, Joel Savitz <jsavitz@redhat.com>
In-Reply-To: <20221003133534.1075582-1-bfoster@redhat.com>
References: <20221003133534.1075582-1-bfoster@redhat.com>
Subject: Re: [PATCH v2] block: avoid sign extend problem with default queue flags mask
Message-Id: <166541204131.3814.10062171487438834420.b4-ty@kernel.dk>
Date:   Mon, 10 Oct 2022 08:27:21 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 3 Oct 2022 09:35:34 -0400, Brian Foster wrote:
> request_queue->queue_flags is unsigned long, which is 8-bytes on
> 64-bit architectures. Most queue flag modifications occur through
> bit field helpers, but default flags can be logically OR'd via the
> QUEUE_FLAG_MQ_DEFAULT mask. If this mask happens to include bit 31,
> the assignment can sign extend the field and set all upper 32 bits.
> 
> This exact problem has been observed on a downstream kernel that
> happens to use bit 31 for QUEUE_FLAG_NOWAIT. This is not an
> immediate problem for current upstream because bit 31 is not
> included in the default flag assignment (and is not used at all,
> actually). Regardless, fix up the QUEUE_FLAG_MQ_DEFAULT mask
> definition to avoid the landmine in the future.
> 
> [...]

Applied, thanks!

[1/1] block: avoid sign extend problem with default queue flags mask
      commit: ca5eebda3e1c1a58a1c5a337da393ed6734593e3

Best regards,
-- 
Jens Axboe


