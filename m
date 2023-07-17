Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AA0EB64DC
	for <linux-block@archiver.kernel.org>; Mon, 17 Jul 2023 14:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjGQOTG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jul 2023 10:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjGQOS6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jul 2023 10:18:58 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BA31715
        for <linux-block@vger.kernel.org>; Mon, 17 Jul 2023 07:18:51 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-66d6a9851f3so1031288b3a.0
        for <linux-block@vger.kernel.org>; Mon, 17 Jul 2023 07:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689603530; x=1692195530;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmjgRKbp9Bfg8n+oU4PLGE+EeOXhQe9CxhjO5mOrAjQ=;
        b=h/1vU9v9IFIj0iHZM0L5nziwQySFMCeKZXGCU1oIAHkfo+c8r5yw7A7ZfjkjpkNmY8
         iAASot4yvb8MixQdku43oesne2l0beUWfyAYFDwL2i7RFiWWmzGi8WE5WWpY6xHfvBQ9
         7CGP7H+Jho+zITTKM0/8pPLrTmScKVOhCPxDaiHZd8AtrIc45QI36b64xCf7I48x2N0E
         ceeDHtmtqqKaOtf9o+EXiKGpXG3X3uqznKW0GOToRg9EuCu+zxa89VXWk6N3GeX80QM2
         n3Ob6eYf0JtUwtVasDXzwoN4vA2XhsMdpR/kkdrFqRigpMDWT/ksbXjZYi2IpIbuZQyU
         O8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689603530; x=1692195530;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmjgRKbp9Bfg8n+oU4PLGE+EeOXhQe9CxhjO5mOrAjQ=;
        b=TXW0p8gU0b0FxJxTq2HIi2i8OZ9hfvmIYSRZ6oD6M1U33xRS28TRAnVJ4p/8qVGQzV
         caz13XZI8xcRCicuHI7f5PkIAIX2JKXXcge5A0k/wyhHJBlH5GhP9jy+X9TsS49iHy7d
         ZiHy1Ukz1oA9arzzANDz8ismjv7CFEV39p6GgHtZKs0+sYpyQyaHkReokLn/Fm9cc4Ng
         oa7N7nmQJB7+D7RAAfGj3hCcfs3qC1IaEtYUbBZ8tPz4AcHjKL6xQs3wVGTfMMPqMMjQ
         mHpOZxIpog4Gli3kU/+5yr0RGc5RsPEibcC6JtKks0PIy0Laz2H9Hqq3okJOjOtLq8gD
         yVHQ==
X-Gm-Message-State: ABy/qLYqu4oLBAWQCekdBcm4IcJ9+5H3B6HUSRdq4Q2Zz3ESL3AoU8kp
        J1OnVM+EWNyLTKn6ra6jt1LB6Q==
X-Google-Smtp-Source: APBJJlGdAGa4ETafgV/Veo9yZFmO91zn/b7SFTRHq6mKXhejtm1CMFHeDA4Jd3jcWcIFhHfLMiPDwQ==
X-Received: by 2002:a05:6a20:3c89:b0:100:b92b:e8be with SMTP id b9-20020a056a203c8900b00100b92be8bemr8556102pzj.2.1689603530396;
        Mon, 17 Jul 2023 07:18:50 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p16-20020a637f50000000b0055fedbf1938sm4110628pgn.31.2023.07.17.07.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 07:18:49 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com, hch@lst.de, bvanassche@acm.org,
        chengming.zhou@linux.dev
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
In-Reply-To: <20230717040058.3993930-1-chengming.zhou@linux.dev>
References: <20230717040058.3993930-1-chengming.zhou@linux.dev>
Subject: Re: [PATCH v4 0/4] blk-mq: optimize flush and request size
Message-Id: <168960352900.993352.5723079486795964605.b4-ty@kernel.dk>
Date:   Mon, 17 Jul 2023 08:18:49 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 17 Jul 2023 12:00:54 +0800, chengming.zhou@linux.dev wrote:
> v4:
>  - Rebase on the updated block/master branch, which include a flush bugfix
>    from Christoph. Please help to check patch 04. Thanks!
>  - Add a bugfix patch 02 for post-flush requests, put before other flush optimizations.
>  - Collect Reviewed-by tags from Ming and Christoph. Thanks!
>  - [v3] https://lore.kernel.org/lkml/20230707093722.1338589-1-chengming.zhou@linux.dev/
> 
> [...]

Applied, thanks!

[1/4] blk-mq: use percpu csd to remote complete instead of per-rq csd
      commit: 660e802c76c89e871c29cd3174c07c8d23e39c35
[2/4] blk-flush: fix rq->flush.seq for post-flush requests
      commit: 28b241237470981a96fbd82077c8044466b61e5f
[3/4] blk-flush: count inflight flush_data requests
      commit: b175c86739d38e41044d3136065f092a6d95aee6
[4/4] blk-flush: reuse rq queuelist in flush state machine
      commit: 81ada09cc25e4bf2de7d2951925fb409338a545d

Best regards,
-- 
Jens Axboe



