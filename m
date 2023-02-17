Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B82C05027
	for <linux-block@archiver.kernel.org>; Fri, 17 Feb 2023 13:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjBQNEc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Feb 2023 08:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjBQNEb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2023 08:04:31 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923CD604D8
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 05:04:30 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 71so587919pfy.4
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 05:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1676639070;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+4ysGVGMuyUFyZSOBy7DKa0C78HhFuzH8aKH0vaYZM=;
        b=Dfh6+HkGfqr5EzF8UfcT4HuEMVsDhqiTt0sEbDUkwgLK+SUAKdRFHd1j+4sWLkqutv
         HOaoTJuL6QREuuSxuEd9AeXJDhBrRSbhpHH6HdjUtiCj4tOBzY5R5csbuu39G1iYwUgN
         ThyrCHBM0UlRClTkMB21w16Waek6YZfS0IPjU8PpSyyTT8Nm18m90Vlgah4DjB7p4PlN
         F+nMRDWZKO/tKe2nPCj8/GtjmE0aT2QNXSNUuLRTLyZlpebA2su7nCMGxDwrTwaZe2ag
         uGS7B5TiTkFSZte2/MXpAY14kMOeh1+e0R+eYwcgjwDL0NoswYv2QVLNqTAjhJmieT7J
         He5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676639070;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+4ysGVGMuyUFyZSOBy7DKa0C78HhFuzH8aKH0vaYZM=;
        b=NscVS7FoMCClT4AjrSUi7B9aN4mv9L61FMXCl/n2uQWNWE7SZ5ky9m/fpRKNK78hG4
         r/WCUl3Zhf6yQb13FFb3lwRUPYyoGvMUdpJfL2OIi7Wyuyn4BiDXh2mTSXPEtoobyQoG
         E5xnRoFXt27nfxwqKZV3q18o4r4CA7AxHH3/PCkPIPpquRWYpqZ52aD4/NkLtbaAmtBY
         Cchg9DsVOLdXJX2vKFG1IptotuqwaaJvn/8ygMadpRjPg/+7wg9DV9bA1XGFZUNiCy97
         W8SplQz337L0c0nw+dFOt4J4Bh3Ea43OKJJ4Zb1dzlBsP9ad3nckooiCAlsH+as3iFsW
         rInQ==
X-Gm-Message-State: AO0yUKUBQVfW4NzVMWynwavfbICbgq0O/00qnZh2vnLQ88F/tzgsraY2
        Oso/SUcDCWdKCWZfNRIO86b68+lU3jvRoxGW
X-Google-Smtp-Source: AK7set/Kml4CvgYfwbcj+fF7Fm9bbaXo8txc81VneOowTiLjwPH4iv210eP6mbmLH5zp2dJ2r/6+nw==
X-Received: by 2002:a05:6a00:f0d:b0:5a8:abe2:fee2 with SMTP id cr13-20020a056a000f0d00b005a8abe2fee2mr1418931pfb.2.1676639069726;
        Fri, 17 Feb 2023 05:04:29 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 4-20020aa79244000000b0056b4c5dde61sm3112720pfp.98.2023.02.17.05.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 05:04:29 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     hch@lst.de, gost.dev@samsung.com, linux-block@vger.kernel.org
In-Reply-To: <20230217121442.33914-1-p.raghav@samsung.com>
References: <CGME20230217121602eucas1p1b85aa17f46f6b602446a9d83ccf67708@eucas1p1.samsung.com>
 <20230217121442.33914-1-p.raghav@samsung.com>
Subject: Re: [PATCH] brd: use radix_tree_maybe_preload instead of
 radix_tree_preload
Message-Id: <167663906905.49468.3962408162457312685.b4-ty@kernel.dk>
Date:   Fri, 17 Feb 2023 06:04:29 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ada30
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 17 Feb 2023 17:44:44 +0530, Pankaj Raghav wrote:
> Unconditionally calling radix_tree_preload_end() results in a OOPS
> message as the preload is only conditionally called for
> gfpflags_allow_blocking().
> 
> [   20.267323] BUG: using smp_processor_id() in preemptible [00000000] code: fio/416
> [   20.267837] caller is brd_insert_page.part.0+0xbe/0x190 [brd]
> [   20.269436] Call Trace:
> [   20.269598]  <TASK>
> [   20.269742]  dump_stack_lvl+0x32/0x50
> [   20.269982]  check_preemption_disabled+0xd1/0xe0
> [   20.270289]  brd_insert_page.part.0+0xbe/0x190 [brd]
> [   20.270664]  brd_submit_bio+0x33f/0xf40 [brd]
> 
> [...]

Applied, thanks!

[1/1] brd: use radix_tree_maybe_preload instead of radix_tree_preload
      commit: 6c940bf10024977b9367072d6cd7616945262dad

Best regards,
-- 
Jens Axboe



