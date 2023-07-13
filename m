Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD65C0015E
	for <linux-block@archiver.kernel.org>; Thu, 13 Jul 2023 18:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjGMSbU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jul 2023 14:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjGMSbU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jul 2023 14:31:20 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82CA2D49
        for <linux-block@vger.kernel.org>; Thu, 13 Jul 2023 11:31:18 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-785ccd731a7so12705139f.0
        for <linux-block@vger.kernel.org>; Thu, 13 Jul 2023 11:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689273078; x=1689877878;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Sg87cEYeWMB6yYseQ4SjGuYhfzXrqT0VWVgvI9gUao=;
        b=5G66KJ5FDNm9G2/e9SL9UO1FqJdRu76kki5mG3ANpiwrA8TfvoEVHKoTv++bPUJRv0
         KuB0ML+nzEzOhLi7YNeX+b3mKSBE9NyqTVNiiUX5ASXKCaU0maSbTWKF2T+aNbO1b//1
         LI9W6/jcGGTP/YnZkF2iOvg3NTOVQ6IYavIQ6TWnrrEKFtVIeqvEYAas5a/sMXzvtgMN
         vwaBKRHJ2BnDrq7na1UJreDe7knpCr26myl2TlXujtTdPO8S33CSftmozbmsc/czVwby
         QNoHdDu6TK85gf1DKOBTwSxshxwtYpUlS5SJtpF1J8/h+8Bq27e+ppiaGSBiEGx55ZwF
         pbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689273078; x=1689877878;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Sg87cEYeWMB6yYseQ4SjGuYhfzXrqT0VWVgvI9gUao=;
        b=ielgWuX2fac1Tvy70Rg66+1v2nmvpGIsv1vgxg59sP2Uq3ipNrzpgQsdavtVSTe67/
         T2fBqWCXXKpoVlsrYZ6Lw3BKVF2n8+6Q24l5y3ESFUIsW0zyD0/re5cBAsm5Rlp2edL0
         vaeYU3lM/KKHtIIfblCYdGi/yAWb+zS2DubahFv3OmKverd27KBaOIKAk/A/Yry1mw5L
         tF4CqAGQVeKaqH78+j4Kn2g+gykWk2mXomKj9ofMRGTyCLyUnu8phNS9BwQkNM/vGoMj
         Qdsr2RAGjma49rSRSnXu2VdXqECwDVhN6vce/3OFpSTxQ7HqSXb+eDesi3wqPKPIhnF/
         I3Cg==
X-Gm-Message-State: ABy/qLYRPevZ+Xqv+n36liSXYJlA5btNi7vPKeWw8Z5RVkKMWVgUpCEa
        GHvB1JIzO9JJtR9oJQQdOnUTsw==
X-Google-Smtp-Source: APBJJlFg744e8fSspcr/ts17lJ2WHR9lKLwe/Kn5bBBmB113WrTkm3T6wK/+pgh1jRF//f2xT2nYYQ==
X-Received: by 2002:a6b:b7c1:0:b0:783:6ec1:65f6 with SMTP id h184-20020a6bb7c1000000b007836ec165f6mr2264242iof.1.1689273078146;
        Thu, 13 Jul 2023 11:31:18 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id g10-20020a02cd0a000000b0042b28813816sm2078332jaq.14.2023.07.13.11.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 11:31:17 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@lst.de, tj@kernel.org, ming.lei@redhat.com,
        chengming.zhou@linux.dev
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
In-Reply-To: <20230710105516.2053478-1-chengming.zhou@linux.dev>
References: <20230710105516.2053478-1-chengming.zhou@linux.dev>
Subject: Re: [PATCH v5] blk-mq: fix start_time_ns and alloc_time_ns for
 pre-allocated rq
Message-Id: <168927307722.553980.1947848634070794553.b4-ty@kernel.dk>
Date:   Thu, 13 Jul 2023 12:31:17 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 10 Jul 2023 18:55:16 +0800, chengming.zhou@linux.dev wrote:
> The iocost rely on rq start_time_ns and alloc_time_ns to tell saturation
> state of the block device. Most of the time request is allocated after
> rq_qos_throttle() and its alloc_time_ns or start_time_ns won't be affected.
> 
> But for plug batched allocation introduced by the commit 47c122e35d7e
> ("block: pre-allocate requests if plug is started and is a batch"), we can
> rq_qos_throttle() after the allocation of the request. This is what the
> blk_mq_get_cached_request() does.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: fix start_time_ns and alloc_time_ns for pre-allocated rq
      commit: 5c17f45e91f5035c1b317e93b3dfb01088ac2902

Best regards,
-- 
Jens Axboe



