Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740E5E6FE41
	for <linux-block@archiver.kernel.org>; Fri, 22 Sep 2023 14:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjIVOw6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Sep 2023 10:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjIVOwv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2023 10:52:51 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2A4CCE
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2023 07:52:45 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-79f96830e4dso16632039f.1
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2023 07:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695394364; x=1695999164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGBYO+nGsfARnhytIjtXueAfrl2OO+PPabMy9Va5wj4=;
        b=Gsozdjr0yB6Dukx9DZaNaIoQQGxkGWQr0NlfaevtP6a268LG0IUOXFm+vUA50udr1e
         WY3Z7E+8/wPsY012JCscRuy/PMc2CzjiyLbjSgaE29wHvqXvVkD2HIqZM9WBLBDbgZvN
         MirjtCmZghtqBN6TXVc3St6eg0VYwWVxXYXFbZpSGF6KM7vBs6dEgyc++lqiVHv7ywD8
         u971FtQUiGTFr/46V+cWuRHFh5Xt3lzycCirO2DfGFCmFqZfHRlyjsJncMpneyXzTiS6
         jwe/XYPEEhSVPT1J1ZzixcVk6Pyt62Gmt2C/qyHH9hca+wvBVOlE/YoslVj6yDOeNSNA
         ljoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695394364; x=1695999164;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGBYO+nGsfARnhytIjtXueAfrl2OO+PPabMy9Va5wj4=;
        b=oCNrGFFx211Ybpn/8Z98bhdlMed5uzbM4FfCnZuqRdPfUCxIEws0+pm8nsSVGJ19VF
         b29q47oKi1YjJKAZ6Abi9IbM9/NIsGH39oGbqy3lMaO2vBgbGYl+Ve4pDKlrwu1z9U77
         1CZGWBBf8Ki6w70a1w65jfIYOjBnKgOId75XrknPw8NiK5AbnN5CyOm8+pCflp82wYTk
         QK4t/5kxd7bEjsLf3QI/FichLTE+RtqSZvEloSbe+FYRmm/wgj/lEZw/QNTYUt/O0d29
         BOt0+ErdLCWB9J4TDxYFhZXfxFSUWpCZp1oU/6KKa2EGA02vHzMZVpbm+WnbGJP4hNfw
         jMTw==
X-Gm-Message-State: AOJu0YzM+XhrZGxzoUa7aECmLbxYE2Mj9CpYyOvxYZSX5OTGdnXxpXqT
        Db+6kYNHvKlNWLEY5slpDrTisw==
X-Google-Smtp-Source: AGHT+IHL+yk7dBzL5o0l69gGgjqHjcXQNUnZMdMJ4Sb6UB7QjvTxV14vW94S8kAVl6A/F98FWOzisg==
X-Received: by 2002:a05:6602:3788:b0:792:7c78:55be with SMTP id be8-20020a056602378800b007927c7855bemr9005827iob.0.1695394364539;
        Fri, 22 Sep 2023 07:52:44 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id f6-20020a056638022600b0042b2d43ee3fsm1017020jaq.82.2023.09.22.07.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 07:52:43 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@lst.de, ming.lei@redhat.com, bvanassche@acm.org,
        chengming.zhou@linux.dev
Cc:     kbusch@kernel.org, mst@redhat.com,
        damien.lemoal@opensource.wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20230913151616.3164338-1-chengming.zhou@linux.dev>
References: <20230913151616.3164338-1-chengming.zhou@linux.dev>
Subject: Re: [PATCH v2 0/5] blk-mq: optimize queue_rqs() support
Message-Id: <169539436327.239461.11694929564219340558.b4-ty@kernel.dk>
Date:   Fri, 22 Sep 2023 08:52:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 13 Sep 2023 15:16:11 +0000, chengming.zhou@linux.dev wrote:
> Changes in v2:
>   - Drop the patch that fixes a potential race in request timeout
>     from this series.
>   - Rebased on the newest block/for-next branch.
> 
> The current queue_rqs() support has limitation that it can't work on
> shared tags queue, which is resolved by patch 1-3. We move the account
> of active requests to where we really allocate the driver tag.
> 
> [...]

Applied, thanks!

[1/5] blk-mq: account active requests when get driver tag
      commit: b8643d682669994b3f57c3440df3d4f9cb735f35
[2/5] blk-mq: remove RQF_MQ_INFLIGHT
      commit: 48554df6bf2b1e83f70749bf4b4d7914f8b3c01d
[3/5] blk-mq: support batched queue_rqs() on shared tags queue
      commit: 434097ee375fff36bc5037524609ffd6199f11da
[4/5] blk-mq: update driver tags request table when start request
      commit: 217b613a53d3a430aa2e5d1523819dc271f02ff0
[5/5] block/null_blk: add queue_rqs() support
      commit: d78bfa1346ab1fe04d20aa45a0678d1fc866f37c

Best regards,
-- 
Jens Axboe



