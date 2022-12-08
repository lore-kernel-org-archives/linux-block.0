Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D365C3A5A7
	for <linux-block@archiver.kernel.org>; Thu,  8 Dec 2022 16:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiLHQUQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Dec 2022 11:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiLHQUP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Dec 2022 11:20:15 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717A2AE4C9
        for <linux-block@vger.kernel.org>; Thu,  8 Dec 2022 08:20:14 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id o13so1209083ilc.7
        for <linux-block@vger.kernel.org>; Thu, 08 Dec 2022 08:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rgqBZ3uFNI/h6T8HpUKkmoQedKjgYsWFROeZ8YebM4=;
        b=vqBtQLqW+3MVCuOlb6qXeONN9af1mNtua+frx9RZmop1vht1R/RvkDRCPWV4UpgcdI
         wM3J1ua5XNHyWSunTTkdCvZiReucRWu8u+N6Bx1L9mlXLC6yFuuQtIdR4ez+VDBMZvFj
         om422svafQlJ+atSNFNXBEjfDWBsSm/XMYQvmUSw+GItcNCcxmvF3jsiEeFdLZOOgm2h
         5bGl92+9PVAK9yfiQ8z1UtSju8kg/reXrvTrIimAgyFpG/k4rsBNMH4IWvonGwbxQKzx
         eUICFsZqtRmmswI3ZBbPaEP9LlvfEqdC/u0HAGt4SnZJtCykAFQ+QU745Y763IGg20DV
         tWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rgqBZ3uFNI/h6T8HpUKkmoQedKjgYsWFROeZ8YebM4=;
        b=fedLyn/4CQgmrYF2yUOIFpezKD4tEJQ3nBHAlTov86oSc5ulwohcbRmVZlmijTo9H8
         w9zlGEb91C6L3HoeuUpsd98WwoZcb+rWARXuvBiTjHUdRvCVtsgOkbJxuSotv4bXBrxW
         58qgVW2EK/6g8tkU/KWgC2l39rnNXS4NLc7qj4GMx93xP/aQLfdRDZykNUFvv91ipzAk
         7EkSyaKz5W5e8PvMUq5IA/NSG6nKeO8110XD1q3g5f4GSOdmpeu0/RyyUCJHq49UiVVM
         yc0aPR5Qhf7lmKkrFdw28Az9qqFcLKh5DbMKzFLKage16QJ1Ll12A4/10yu1T4NbRJR2
         yRMw==
X-Gm-Message-State: ANoB5pmibFsSxFASk3SWHiHtIDVfABiCxu2IDMmFDGFRnXeSBYd2Tqfc
        tdCKj3DwhRz7iLQA5oshtIarMA==
X-Google-Smtp-Source: AA0mqf6ANJIg3cGeVXRosWTci0yfZhHrF8RANqn3bKkZRC8nYTCUvwDGuf1VdQ6IsvDW4zo9akGSyg==
X-Received: by 2002:a05:6638:2708:b0:38a:66d5:871c with SMTP id m8-20020a056638270800b0038a66d5871cmr4129841jav.199.1670516413755;
        Thu, 08 Dec 2022 08:20:13 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f11-20020a02a10b000000b0038a5083cfa7sm3573087jag.88.2022.12.08.08.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:20:13 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, josef@toxicpanda.com,
        Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com,
        liuzhiqiang26@huawei.com
In-Reply-To: <20221206093307.378249-1-shikemeng@huaweicloud.com>
References: <20221206093307.378249-1-shikemeng@huaweicloud.com>
Subject: Re: [PATCH v3] blk-cgroup: Fix typo in comment
Message-Id: <167051641300.134647.14873607646556634784.b4-ty@kernel.dk>
Date:   Thu, 08 Dec 2022 09:20:13 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-50ba3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 06 Dec 2022 17:33:07 +0800, Kemeng Shi wrote:
> Replace assocating with associating.
> Replace intiailized with initialized.
> 
> 

Applied, thanks!

[1/1] blk-cgroup: Fix typo in comment
      commit: 37754595e94779db869e6ef803f038fa956d08ff

Best regards,
-- 
Jens Axboe


