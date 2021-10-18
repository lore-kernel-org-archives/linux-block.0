Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D67C433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 21:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5CE561027
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 21:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhJRVpG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 17:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhJRVpG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 17:45:06 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCE5C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 14:42:54 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id y4so12250531plb.0
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 14:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LY6T9ymFruKs6NMBZ2llZXv4ELG7NuQfo8otcDECv1c=;
        b=MY7CzKDkNryZn2Vb1xaABRZul6Zcud5p+EXVokTmyYxY9E45a9Mmg8MLCYQPJoL1Mj
         1DmhCyO1EiqlkZEvj5lMnnpjInaxLptduovsdyV8CGG7p6wSsgyXMBC/c81WTnvksG3j
         XE/g3N1AGVSrFN04gJ3jx50dY4F8xTw/52TySU6Cr+MudnSlxnaOSTyEkhZk8XpatAJP
         9FdImPkKhrUCken/Zkh1/ffyAgWJoGGVl6tFvxHSMZPVVffS6LG+J0H7iqLE3E92WFRF
         yK5sp0zkomDzNKF8TTww+RrNocNKJhZjzzjO4UtcObk1TIZHguZ4CAC8a6+LjacPUsd2
         90UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LY6T9ymFruKs6NMBZ2llZXv4ELG7NuQfo8otcDECv1c=;
        b=K9XNrpkEt2Y5VxT3MyB/ClynFRSPbigWDN9Kb59n9L3kRb41MUbbR4dM4cAxlRQ8Q7
         YbZBWUrq6Vo9xPWzz3MjU56aqmD/7+qXcTtuWEgMFUcKypU1JgRCgBOjS4tqp3qN2/ux
         sVriT/wubh8Ul8+ddPSPdlKZF204qPdVyclLvsrEds+jFBun2Qau3gCW+iZzxNvwZXeS
         775QNheaRQgPJsari3sUS1CSwRPCGnZvWvPzV2a9f97hzhhVgsVs0DhejeM6rYdVregp
         W25f6RYAhPtH8D6mCYVzG1ul9u/k+ZULoG6p0MW0ua04dcNJnGueqzYsySWT3Qo4VhBA
         3rjw==
X-Gm-Message-State: AOAM533jwLP1Lfn/XIoKMqmccNyLC0sPp3Nt+56qS6KYT8QtbzGa/M2P
        AGnrAFLOh8IR8+4fOgV/4DnHVrO9G6xDCbxY
X-Google-Smtp-Source: ABdhPJxsTMyxmBwNQunw7lmlnA7zgbVUEs2flIc2nm9tEcP/dseS8T7KAZoMx57tUoWVrGVO+RfkzA==
X-Received: by 2002:a17:90b:1e4f:: with SMTP id pi15mr1633342pjb.231.1634593374082;
        Mon, 18 Oct 2021 14:42:54 -0700 (PDT)
Received: from localhost.localdomain ([2600:380:4a2d:7994:f51f:596c:ef50:c5c0])
        by smtp.gmail.com with ESMTPSA id w13sm375317pjc.29.2021.10.18.14.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 14:42:53 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/3] blk_mq_rq_ctx_init() optimisations
Date:   Mon, 18 Oct 2021 15:42:49 -0600
Message-Id: <163459336626.437265.18265519350698264777.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634589262.git.asml.silence@gmail.com>
References: <cover.1634589262.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 18 Oct 2021 21:37:26 +0100, Pavel Begunkov wrote:
> Restore the original version of the patches. Mostly the same as was
> sent out by Jens, but those were squashed and a couple of details
> is missing.
> 
> Pavel Begunkov (3):
>   block: skip elevator fields init for non-elv queue
>   block: blk_mq_rq_ctx_init cache ctx/q/hctx
>   block: cache rq_flags inside blk_mq_rq_ctx_init()
> 
> [...]

Applied, thanks!

[1/3] block: skip elevator fields init for non-elv queue
      commit: 4f266f2be822eacd70aca2a7a53c4a111be79acb
[2/3] block: blk_mq_rq_ctx_init cache ctx/q/hctx
      commit: 605f784e4f5faecf6c78070c6bf446e920104f9f
[3/3] block: cache rq_flags inside blk_mq_rq_ctx_init()
      commit: 128459062bc994355027e190477c432ec5b5638a

Best regards,
-- 
Jens Axboe


