Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0A1C05027
	for <linux-block@archiver.kernel.org>; Mon, 30 Jan 2023 03:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjA3DET (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Jan 2023 22:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbjA3DET (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Jan 2023 22:04:19 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DBC1BAE5
        for <linux-block@vger.kernel.org>; Sun, 29 Jan 2023 19:04:18 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id mi9so716805pjb.4
        for <linux-block@vger.kernel.org>; Sun, 29 Jan 2023 19:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZ6yrQ8QtaF+R4KmbpHk9smJ4moMIfGYvuFm4fbV6sc=;
        b=UdmzHx0zsT7cWmAEfDg3Pvx9yJhOEKanG2EXeWgIdwce6Me6hEj2X4Fd/tukd5ugfa
         FP8S2r8lRPk1z5J5+VNGZxevrDVZ8hQQdBJkU1iCQOR4utbSuqvR6HoRSZI2huRh4iam
         erL4WKX3HEIiS/TnXDYPpDECgAmeFH8NxvxllsjTRNjSmpTW+v9LwOv3TC8bUrjszDAJ
         u+Trn4UyXbDfGqreWnCbe1E+3d0xrMh65MNPOHIyxeeMlf0khBlc4yST/M43zxSEAthC
         Nj5R1sg3OZQHWW5i49QdXUrRAQvkNATID2IOHf0C+hEQ7/EIW7AcbqIX0pmP0yWArtJz
         xh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZ6yrQ8QtaF+R4KmbpHk9smJ4moMIfGYvuFm4fbV6sc=;
        b=GFo2Fx7y8mJKPq9EpI9Yewz6L+dIyfRVG7kh5PbKbY+dObms7ealPpVusjS1d/vHVc
         SkiD6gg3/azVK0hewOLEsinmgdxnEO9jFUmMbBvCkyRsF0PKGbTY5LdkgXayp9N6L3hb
         f4ily6Wr9p55QLyQurqfkdgbS4mATqbca6sEzPq0BoKPnRo5b7hoztWyRzrlK8/RX0Tf
         qMzqPDLFObL8cquJsmcyDj6vLwWNk/fzwqSv2XVGNmzSULhf5SjwazXp4Kgn/KlJ9E6t
         ZCuTwtdp+7apJDLN7iXv29+4djaGm15EKcFgJDdXJZjQfPh9EwM1phUhM9qKLdCxouFZ
         Hxgg==
X-Gm-Message-State: AFqh2kryYnFQFNtQBec/nIA00jMBUm8TRKldxa0c/1c8Ln9Kf1fd8Q9X
        /Vp8478zBOpsh58EP7cZyLnqP5LQoN/8FX1c
X-Google-Smtp-Source: AMrXdXtNC0YC4yCuWmeGwlvLEC/vsMCLN4G3Xe7itukdLDlq37sr1l45AqKpaL+PAvHwwcRna1KmGg==
X-Received: by 2002:a17:90a:af91:b0:226:df9a:969c with SMTP id w17-20020a17090aaf9100b00226df9a969cmr11145645pjq.0.1675047857186;
        Sun, 29 Jan 2023 19:04:17 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n29-20020a638f1d000000b004d3f518eea7sm5667103pgd.94.2023.01.29.19.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 19:04:16 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, josef@toxicpanda.com, paolo.valente@linaro.org,
        yukuai3@huawei.com, jack@suse.cz, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com
In-Reply-To: <20230130014136.591038-1-yukuai1@huaweicloud.com>
References: <20230130014136.591038-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v2 block-6.2] block, bfq: fix uaf for bfqq in
 bic_set_bfqq()
Message-Id: <167504785585.199828.6199773692964530920.b4-ty@kernel.dk>
Date:   Sun, 29 Jan 2023 20:04:15 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 30 Jan 2023 09:41:36 +0800, Yu Kuai wrote:
> After commit 64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'"),
> bic->bfqq will be accessed in bic_set_bfqq(), however, in some context
> bic->bfqq will be freed, and bic_set_bfqq() is called with the freed
> bic->bfqq.
> 
> Fix the problem by always freeing bfqq after bic_set_bfqq().
> 
> [...]

Applied, thanks!

[1/1] block, bfq: fix uaf for bfqq in bic_set_bfqq()
      (no commit info)

Best regards,
-- 
Jens Axboe



