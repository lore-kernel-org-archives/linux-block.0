Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A364C74A4B
	for <linux-block@archiver.kernel.org>; Tue, 14 Mar 2023 15:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjCNP00 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Mar 2023 11:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjCNP0Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2023 11:26:24 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDC2A9082
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 08:26:22 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id r4so2836803ilt.8
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 08:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678807581;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2JbrKBcPUv5w6FN5aEkd19VzJQEa/ECYGzxJeQI/FU=;
        b=fxH0oBHuuUv7/uAFPm1X0DWARWeANKrumeHKlTEuCwwMUDyMXM7+ZG3wg9QcUi5A4I
         5Kyly9LID8r7KxFUJb1Xnjm+c/3Y4tBM07UfIrPZvWZvSheyihgYtsxRUup2IGVlapX7
         wBObxq1rQPa5k4ONWsBAAmHMpfbDKUSHwmAD60qLBncikZ0u98Yqz592W26Gi4Dv/YB+
         bZ98Ilb6DujyXqbH8lyzY0BHi7g8HPdgzEcR2ebSg3+7yO0biDgFiTU7rD46zC+I0HKK
         LIpoXs9CZ0cmGSByJ8LPb8VKtpj0PXMmJHLxKSEG1r4WbNlS8WOsjVLEI74Ca0dn7d6D
         PT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678807581;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2JbrKBcPUv5w6FN5aEkd19VzJQEa/ECYGzxJeQI/FU=;
        b=gmNrkV+/r7zb8tlQxb8EuZ3sdI82AiSTFW1junkwh2qaFj8KA7asBvKfgAlfVBDwJC
         ugvCwQFUcj8NP1UP9neRLs58T3dzjI1VVPUU1XOgthXdqb5DEp7omD6JKpLb6y36WTLe
         Masu72fnSfBM3fj7dKTOTaFPOnam4IaICY92AB5VnsUhQqaSZQyn1XRQETfZa8U9itVD
         4sMjopakOOLHGfvhAB3qhK/eafj/Svj7nnWBaRyv+9Gq9uSPPwuZeMasf0e0AxFoM58y
         Rqv/CFe6Oo4RT8DacXANWed1PF2Njl0jLu7UiHI4uq5PKx54LUtQcdAWGqycgp+2K6ir
         O9tg==
X-Gm-Message-State: AO0yUKXIZLZi1GENKHQZIB3LgpGZpQUJ9eIdrO5T9FWp94oS2tGvfZXB
        i2xQg6lr41vQy5vU/cbyaSqG4JloSJrZE0nCgNoh7A==
X-Google-Smtp-Source: AK7set+WlREOwAI1eSuVqrVRMjOi7sQtzO3t3cR9/EXmuXqoUecSgQRTFVhoA8LsxauVaQLB9LJGaQ==
X-Received: by 2002:a92:7406:0:b0:322:fad5:5d8f with SMTP id p6-20020a927406000000b00322fad55d8fmr6003464ilc.2.1678807581329;
        Tue, 14 Mar 2023 08:26:21 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id q21-20020a02c8d5000000b00401079d97fasm858570jao.72.2023.03.14.08.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 08:26:20 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20230313093002.11756-1-jack@suse.cz>
References: <20230313093002.11756-1-jack@suse.cz>
Subject: Re: [PATCH] block: do not reverse request order when flushing plug
 list
Message-Id: <167880758083.151876.6376887177678438378.b4-ty@kernel.dk>
Date:   Tue, 14 Mar 2023 09:26:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-2eb1a
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 13 Mar 2023 10:30:02 +0100, Jan Kara wrote:
> Commit 26fed4ac4eab ("block: flush plug based on hardware and software
> queue order") changed flushing of plug list to submit requests one
> device at a time. However while doing that it also started using
> list_add_tail() instead of list_add() used previously thus effectively
> submitting requests in reverse order. Also when forming a rq_list with
> remaining requests (in case two or more devices are used), we
> effectively reverse the ordering of the plug list for each device we
> process. Submitting requests in reverse order has negative impact on
> performance for rotational disks (when BFQ is not in use). We observe
> 10-25% regression in random 4k write throughput, as well as ~20%
> regression in MariaDB OLTP benchmark on rotational storage on btrfs
> filesystem.
> 
> [...]

Applied, thanks!

[1/1] block: do not reverse request order when flushing plug list
      commit: 34e0a279a993debaff03158fc2fbf6a00c093643

Best regards,
-- 
Jens Axboe



