Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576CBC433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 02:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiKBCLi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 22:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiKBCLe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 22:11:34 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9BC1F617
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 19:11:30 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id b185so15137274pfb.9
        for <linux-block@vger.kernel.org>; Tue, 01 Nov 2022 19:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMwht8Kpuf4LTPdcGCutOruwBCb0mDtYIKt07DMBo4E=;
        b=3tM2CRKuvgSzDtO4YVhoaV1qCBEevMeRGgXGrmtKFAev/snlKP5Xk6nNeRdBCAP6B0
         VZZ1RkVha8lmm8QlrzbOLgbzk/oEJLb6KXV5DIspagBlE7prEN7VNxRg66/Xx9/6EEr5
         qDo+fMediXpg2y4tK0/cGWFw7vX7DgQismTRejAH5dC/j20lcsejEnhAg8YsM7fe84Db
         OwKwWnOMj2a95PzEx2MY6SckIx55uRbT++lNNE5UXKMXot23Yl3VzsMrASwHoZsXP7SY
         O4Ki5GqPakLrQqljsMvzRR5lUGVmtboW0JSadNNszzhifG9lhJz/ViHZImbU9sijLq+3
         W8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMwht8Kpuf4LTPdcGCutOruwBCb0mDtYIKt07DMBo4E=;
        b=GFc8HQmviieVIeB+dYJVcq/gwuthlZYBy8ZXP+5Ni0u0Ctk2NXbJTP+u/XpN+8435o
         YbW592WZYDXk1hYe+VW64+/0ZWT0W2sYegD82+DILjIzhc18mP2xYGVnLKJnxlSKr0Cu
         jKgASlotTwdoQVhEakWfodCOyla/suHJsE/a5Aa29Nfa2fFzXQz+Pc9FSDIQvo2mgLZX
         VJ0/Y8urpbp7lh92FMLedD7Is324Ium2GJCAQ3y5CtoaC7ggMN/cRKhWSMktSCtQYyBC
         seku/VejkCmAnyNo9ymliW5YHFT61TSQTkow4zD+9Khr3L1kdFDTLmWz3qwrdmLAjTHz
         IsoQ==
X-Gm-Message-State: ACrzQf04Ipn5j2HrmTCIgEg0FTat88NW9BvQTbGWUSd/FFk7n2InX2yB
        Br4h+JZzc6mdZA5lnznk/Qq78Zvz0SkG4CoD
X-Google-Smtp-Source: AMsMyM4mGiPfonebz8lFJ7kC7vx4c5XsK1r4ARLkgHxS1AY/xvIlHCobStZ6m2tfZTgTgMizeaf3ew==
X-Received: by 2002:aa7:83c8:0:b0:56d:8e07:4618 with SMTP id j8-20020aa783c8000000b0056d8e074618mr11391621pfn.33.1667355089608;
        Tue, 01 Nov 2022 19:11:29 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id i59-20020a17090a3dc100b00202618f0df4sm232036pjc.0.2022.11.01.19.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 19:11:29 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     jack@suse.cz, Yu Kuai <yukuai1@huaweicloud.com>,
        paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, cgroups@vger.kernel.org, yukuai3@huawei.com
In-Reply-To: <20221102022542.3621219-1-yukuai1@huaweicloud.com>
References: <20221102022542.3621219-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next v4 0/5] multiple cleanup patches for bfqd
Message-Id: <166735508849.16539.13483811523178998202.b4-ty@kernel.dk>
Date:   Tue, 01 Nov 2022 20:11:28 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2 Nov 2022 10:25:37 +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Changes in v4:
>  - move first two patches from v3 into another thread.
>  - add patch 1
> 
> Changes in v3:
>  - resend v2 with new mail address
> 
> [...]

Applied, thanks!

[1/5] block, bfq: remove set but not used variable in __bfq_entity_update_weight_prio
      commit: 060d9217d356a28e1bcfd2df0c8bf59aa24a12ce
[2/5] block, bfq: factor out code to update 'active_entities'
      commit: e5c63eb4b59f9fb9b28e29d605a4dabbeff7772e
[3/5] block, bfq: cleanup bfq_activate_requeue_entity()
      commit: f6fd119b1ae2c4f794dffc87421cf4ce2414401e
[4/5] block, bfq: remove dead code for updating 'rq_in_driver'
      commit: 918fdea3884ca8de93bd0e8ad02545eb8e3695d6
[5/5] block, bfq: don't declare 'bfqd' as type 'void *' in bfq_group
      commit: aa625117d6f67e33fab280358855fdd332bb20ab

Best regards,
-- 
Jens Axboe


