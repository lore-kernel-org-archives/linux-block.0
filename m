Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E06EB64DD
	for <linux-block@archiver.kernel.org>; Fri, 21 Jul 2023 17:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjGURkr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jul 2023 13:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGURkq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2023 13:40:46 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4DB30D0
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 10:40:41 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-77dcff76e35so31767339f.1
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 10:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689961240; x=1690566040;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/RbUCEoLmLDcFVkwHPRFgVNwiHhTsraSaHqdd7+qPQ=;
        b=vQSz/cqm1UOZN57WZQpCPvjmNsgP/DjJ0pEqIVkao/dCv6TzMtu8z8EL1QlB3wfxLo
         9bBgW1DLwafgiPMbUOmfFc1uOd75J6tgi42M6OpmL18BmufL2zE+3mO7iO/hGqFqZ9f+
         QDee1VUEJcFv4Mslbo1wnW5Ohg4fNGzg8ydj71tJ2JTajDHdTEEVGcEpmIUYHWDWKmGn
         6EiisVOuQ1wciWJ4//BjYPGcmNCszNNd+8ZwYbNTZlwmwlDTZbc11wYvqb3cWvnfTggN
         VzWZ1Smgwotj/+uGy+ODivmVxAIjDfmx5UB5gXZ2fWerk4jUXRdQ4rCnRGpWW0Ip+gZw
         p5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689961240; x=1690566040;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/RbUCEoLmLDcFVkwHPRFgVNwiHhTsraSaHqdd7+qPQ=;
        b=fcOxFOninMbcLwufqg5ddI4HxJRegbEGuCyjNHzWJBml1Ik6n+DUQEGvgLbmehLnMG
         TMRpaLDrM5BFSvlCGgKvqqpJtF+gAJNjIml3dcKSgdLb8o2faOSYW5IFE2F+K+a8cUUE
         jfGAp1vOcJd8TZrl5TSbTTsUDqHISsVycS7Vy5IK8XNfZ7cwqG+Rkbv6aGR4PtpqGRd3
         sd2A5nCTbu1zO1B2MfOSso/PXQOMqoNUtZaecG6knJ590mAJkFS29Z4hEix9lcdhcEt+
         DUCWX+erLMuyl9AWVfPLLu2+KT4VrOFysTRfqs+Dn/PdqpUnjXng1GqU+LaLoG0UPG2p
         GNQA==
X-Gm-Message-State: ABy/qLbc0fj/G2SHL8YlXcc4AMogW8689uUzB5yJE0EUJ7sUxQyN70uh
        TM7iXLI3REQKZsQ2n8cVT2zTF5qsdejtUSocRZA=
X-Google-Smtp-Source: APBJJlHDHSdIy/PiqQN8ik29UNj44Nqx5Rg5xNcGHuwZPpB9fUd4S8kA6VebtGHRMgmu/tRColQUtw==
X-Received: by 2002:a92:908:0:b0:345:e438:7381 with SMTP id y8-20020a920908000000b00345e4387381mr2017728ilg.2.1689961240500;
        Fri, 21 Jul 2023 10:40:40 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id o9-20020a92dac9000000b00348abdfad8esm1053067ilq.32.2023.07.21.10.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 10:40:39 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, David Jeffery <djeffery@redhat.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Jan Kara <jack@suse.cz>
In-Reply-To: <20230721095715.232728-1-ming.lei@redhat.com>
References: <20230721095715.232728-1-ming.lei@redhat.com>
Subject: Re: [RFC PATCH] sbitmap: fix batching wakeup
Message-Id: <168996123953.417562.6869632973039501170.b4-ty@kernel.dk>
Date:   Fri, 21 Jul 2023 11:40:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 21 Jul 2023 17:57:15 +0800, Ming Lei wrote:
> Current code supposes that it is enough to provide forward progress by just
> waking up one wait queue after one completion batch is done.
> 
> Unfortunately this way isn't enough, cause waiter can be added to
> wait queue just after it is woken up.
> 
> Follows one example(64 depth, wake_batch is 8)
> 
> [...]

Applied, thanks!

[1/1] sbitmap: fix batching wakeup
      commit: 106397376c0369fcc01c58dd189ff925a2724a57

Best regards,
-- 
Jens Axboe



