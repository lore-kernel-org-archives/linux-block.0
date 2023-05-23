Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA95C7EE26
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 17:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbjEWRN6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 13:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238018AbjEWRN5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 13:13:57 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FB4CA
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 10:13:56 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3357ea1681fso1212825ab.1
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 10:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684862035; x=1687454035;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWrKaN938503ei9lTkEyE57nCrbnfRgFai+3tZIgHbE=;
        b=K5dfnzgm+tNmGD65hLQqZn/mXCAvIPNiBR1SGDkmXR2ybCabAilLHV+EJGU8h53JWm
         nxVDq7Nk8JQgt0OD5Ekmm3ExrKZDhoFNsNZvnafrAx2/4O7W1L3a9ablJfu2ERuInQgx
         7pVcg7NiErWDQTykxwOLJugxBsOQ3CPHiPqz8hD9QtOFwzl9vE3lW3xQkL28xKtb2TSX
         25KyAltSZRseTLx18xWrZX+n0fic6fGOfUvUHF0iNrCsy4IzPpdvwCYCSyk2PeWklZGr
         kkfbnu6zt3v8xvtCRIuV56VaG6eIWH8svdxnIfMZdi3cCCtqZkr3x3//fi2rbrztjbx9
         EKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684862035; x=1687454035;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWrKaN938503ei9lTkEyE57nCrbnfRgFai+3tZIgHbE=;
        b=F3TyQSsT1aLdhrZNJ659v1rcujGtnl2vhaEsxdlVmIqHtcbPvZdgUVSEh4hdDYPSiA
         EIo3IOX3Okd4sJOAwic9HMccG3k+bHzco7SsS8ow242Wh8NUWJaRq4H5tbRmalJcio+r
         bg5/ikWiV9yDlLyaEM1e7tn6NwHxneoLlL8Z3iDxdUWDbMrtL8JedLp993vwTivj1eOP
         HQ3sJAwDextvZhJDz7KE1aHV5Y7oXxk/MH7FGKFXhuDkM60Ee1Tmhyo7Um4G4jhDXKCK
         bQxGE6YZtYTsf3E9c1AOKKy3Yzin+n0T4euMiVfAv/IOuwSfJaagAjVW/Hc5hUZ/N7qU
         VUFw==
X-Gm-Message-State: AC+VfDyeT4dnLqrkyn9OkTCKbM9mC53ymER74Tb/ZESTazMVfGQIbtnZ
        O4YNbqbXzSLQsm9YA5/j1fXP7g==
X-Google-Smtp-Source: ACHHUZ4CCcOcqZdnQ5/73VvbEeniX7BQ65QjdNhltU7Lfcv0/jo/hCNK8dKsj1N0H/pa27m2h+ylTw==
X-Received: by 2002:a05:6e02:482:b0:32a:eacb:c5d4 with SMTP id b2-20020a056e02048200b0032aeacbc5d4mr7205497ils.0.1684862035596;
        Tue, 23 May 2023 10:13:55 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u7-20020a02aa87000000b00411a1373aa5sm2524580jai.155.2023.05.23.10.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:13:55 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linan666@huaweicloud.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230522085355.1740772-1-linan666@huaweicloud.com>
References: <20230522085355.1740772-1-linan666@huaweicloud.com>
Subject: Re: [PATCH] block: remove redundant req_op in
 blk_rq_is_passthrough
Message-Id: <168486203451.398377.3948384027405149003.b4-ty@kernel.dk>
Date:   Tue, 23 May 2023 11:13:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 22 May 2023 16:53:55 +0800, linan666@huaweicloud.com wrote:
> op &= REQ_OP_MASK in blk_op_is_passthrough() is exactly what req_op() do.
> Therefore, it is redundant to call req_op() for blk_op_is_passthrough().
> 
> 

Applied, thanks!

[1/1] block: remove redundant req_op in blk_rq_is_passthrough
      commit: 712fd23a90eed6a73ea5135a500e59d30356d4f1

Best regards,
-- 
Jens Axboe



