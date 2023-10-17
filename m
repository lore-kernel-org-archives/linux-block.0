Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F7AC41513
	for <linux-block@archiver.kernel.org>; Tue, 17 Oct 2023 01:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbjJQBN5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Oct 2023 21:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbjJQBN4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Oct 2023 21:13:56 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D3CAB
        for <linux-block@vger.kernel.org>; Mon, 16 Oct 2023 18:13:54 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c9ba72f6a1so10566325ad.1
        for <linux-block@vger.kernel.org>; Mon, 16 Oct 2023 18:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697505234; x=1698110034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h8XXZAg8Y8R2xNXTg80HN8Iawj+RtpWcUU0FSf2sNEs=;
        b=zAZiveIX5jCVcDrU/48KHTv9efvq5Cfs6iZT1daGvrAsS/hxOtJ0/shiS6T6gjM6AL
         6WXAGaqtXiyBpfwmacxoSXzURhhKj2MIV1BblSFqenpwqj3IU8XqherfPGi7qY2/rMbD
         qMkk6cCQOOPoQ89XLDt+7JKZr92Pt6hp7CfRVhpXxJha1C/c/JXQVpuvpOC8xitsTLoc
         wPEiRvs9dMpVkytn1ilX2Ejnu9yBB2YPwpci4OVLwKoEL/AUZ5jf5U9fPlKAzrXbbkTT
         8DGkQHKYln//C3mDJ2SFwv6iHEj9bcna28qNYOkmO1ZYJ09dQig5vaMYiYbLvSkJ9wUC
         bH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697505234; x=1698110034;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8XXZAg8Y8R2xNXTg80HN8Iawj+RtpWcUU0FSf2sNEs=;
        b=wjFeCuquXZ5tG6OK13Q15o21m5IzXQsBKAYgaVcG8YDf4ECbsYGDda44lUhKYKSjYy
         UeRYbzGJldOXaBLzxNnNU9mhNqMRunRx4gZKFsR4IU6Q13PeWRwHyG1l0taCfpEDAyhl
         MkoYp2M4tuHTnRhT3vRR+kvh6eUAzuKbBS78TK80BVB6qSvcVEf1qp/Vpjqfuh68Lv5f
         LxJsIyXjOYCK9JB5qq+AMZTw/7qItmAPJaAV9VPBHCXUr4Pf3TqmvQvw2UX4rTrM2HZg
         BNprpkykCumB3nR6I800eMo9tufb7txm+syniyOleokuLOxkYMC0ugbPhsUSixqu5T3I
         N+Rw==
X-Gm-Message-State: AOJu0YwF0WAxiR4COa5nc06XcWYNXLIobIh64dJu6pTJitD4w2iTFHmC
        OFd43NmswclRAz7wIK52Tx+w2A==
X-Google-Smtp-Source: AGHT+IH676W+YZThA5g6JGJql6BmeUBN5fnZgt8nqzBRWdc3cTvb5MshHqkBpaWTJ2fuwIQyFwXM4Q==
X-Received: by 2002:a17:902:bd07:b0:1ca:28f3:569a with SMTP id p7-20020a170902bd0700b001ca28f3569amr877236pls.5.1697505233984;
        Mon, 16 Oct 2023 18:13:53 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id iy10-20020a170903130a00b001c9b35287aesm229774plb.88.2023.10.16.18.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 18:13:53 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20231009093324.957829-1-ming.lei@redhat.com>
References: <20231009093324.957829-1-ming.lei@redhat.com>
Subject: Re: [PATCH for-6.7/io_uring 0/7] ublk: simplify abort with
 cancelable uring_cmd
Message-Id: <169750523303.2166768.9866448914806482249.b4-ty@kernel.dk>
Date:   Mon, 16 Oct 2023 19:13:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 09 Oct 2023 17:33:15 +0800, Ming Lei wrote:
> Simplify ublk request & io command aborting handling with the new added
> cancelable uring_cmd. With this change, the aborting logic becomes
> simpler and more reliable, and it becomes easy to add new feature, such
> as relaxing queue/ublk daemon association.
> 
> Pass `blktests ublk` test, and pass lockdep when running `./check ublk`
> of blktests.
> 
> [...]

Applied, thanks!

[1/7] ublk: don't get ublk device reference in ublk_abort_queue()
      commit: a5365f65ea2244fef4d6b5076210b0fc4fe5c104
[2/7] ublk: make sure io cmd handled in submitter task context
      commit: fad0f2b5c6d8f4622ed09ebfd6c08817abbfa20d
[3/7] ublk: move ublk_cancel_dev() out of ub->mutex
      commit: 95290eef462aaec33fb6f5f9da541042f9c9a97c
[4/7] ublk: rename mm_lock as lock
      commit: 9b8ce170c0bc82c50bf0db6187e00d3a601df334
[5/7] ublk: quiesce request queue when aborting queue
      commit: e4a81fcd73422bdee366c3a076826d92ee8f2669
[6/7] ublk: replace monitor with cancelable uring_cmd
      commit: 3aa8ac4a0c293fcc1b83c4f1a515b66f1f0123a0
[7/7] ublk: simplify aborting request
      commit: ac7eb8f9b49c786aace696bcca13a60953ea9b11

Best regards,
-- 
Jens Axboe



