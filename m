Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0146E776E9
	for <linux-block@archiver.kernel.org>; Tue,  3 Oct 2023 02:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238973AbjJCCFk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Oct 2023 22:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238955AbjJCCFk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Oct 2023 22:05:40 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5F09B
        for <linux-block@vger.kernel.org>; Mon,  2 Oct 2023 19:05:37 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-27909dabf1cso90763a91.1
        for <linux-block@vger.kernel.org>; Mon, 02 Oct 2023 19:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1696298737; x=1696903537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRcjc2hBSOekgkWKiY4CMq6tRdwKpz67PdIgVrIx4Q4=;
        b=GGX/grzuOwoxtoKNSFAFSv1h1AyJMddm2qa5rDgSG0hyBSYzxNgkrJqT8xL907vrbW
         tZXxjQMtu/82mZa7JwL9DqGmrEky8252Rno6224dOf5mt0qsR3SQvYdWo6mebLGry/dC
         MEEDGQ/9TnHt6BgIOi+KJS2KShrpZiFt/pDMHybMBwrY+eTpfJyri5+ygrQcj/RZCLAV
         j6QxNDUAXOW7zgOFu06g8p6OlZjqwrVKRElVlmBo0pWZ7bhbUF3PB1ZWGcfbijdGmA3n
         9TUE/PESddi/cwGNaIDHr/kOx0wXAmPm4dOJ7m6B8vXJFUji1v43dbJCu26eCe5edmKJ
         Mdog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696298737; x=1696903537;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRcjc2hBSOekgkWKiY4CMq6tRdwKpz67PdIgVrIx4Q4=;
        b=ncTj2xklvimIaOEqGCFyN9NiETW2gF2aoe6oMQEu0/dDwSqThIPRjn1a4eeRielj+M
         cOzeusg4YTBzCW+lJILLQ4GQPQxqdtzVWCynshgTtFa6up7SHmj64H7viteJ6Phu4WTq
         6Ksv3xBM1hP8jdMWmEvdwOxMfmq6EDeYpNrdh0jep18nnGlrPoc9U2rRsguSg8su+CcI
         rkvtfqHhbALJWcQajGwZ9g8hiWjXo3lrVu5JZxHkaQu6ven8khUhnkkShIv00s45xi2N
         aSOStO1DHkJ3McKXMOxyZKp+2Snp5KJ4q8mc/zqNqspAAZkBLD35CZQpj9IE/sgEqeq3
         za4Q==
X-Gm-Message-State: AOJu0YxwtvQ86M/IsmngQTA+/kgb5Pv4xX5xZfXQ7a+hT4czlsCdTQKK
        EaCzOF+ePR6D4BXSbI8TKubopg==
X-Google-Smtp-Source: AGHT+IFFeF2RSw73sMGZA2WckEmTqV1VHRudpN9DZ8owBcqThI47QPnkBvfL1UY8TLFPtVytoXwG2w==
X-Received: by 2002:a05:6a00:4691:b0:693:38c5:4d6d with SMTP id de17-20020a056a00469100b0069338c54d6dmr12489933pfb.2.1696298737213;
        Mon, 02 Oct 2023 19:05:37 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id q28-20020a638c5c000000b005742092c211sm160428pgn.64.2023.10.02.19.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 19:05:36 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Cc:     Gabriel Krisman Bertazi <krisman@suse.de>,
        Anuj Gupta <anuj20.g@samsung.com>
In-Reply-To: <20230928124327.135679-1-ming.lei@redhat.com>
References: <20230928124327.135679-1-ming.lei@redhat.com>
Subject: Re: [PATCH V5 0/2] io_uring: cancelable uring_cmd
Message-Id: <169629873580.1745606.14847062358187411158.b4-ty@kernel.dk>
Date:   Mon, 02 Oct 2023 20:05:35 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 28 Sep 2023 20:43:23 +0800, Ming Lei wrote:
> Patch 1 retains top 8bits of  uring_cmd flags for kernel internal use.
> 
> Patch 2 implements cancelable uring_cmd.
> 
> git tree(with ublk change)
> 
> 	https://github.com/ming1/linux/commits/uring_exit_and_ublk
> 
> [...]

Applied, thanks!

[1/2] io_uring: retain top 8bits of uring_cmd flags for kernel internal use
      commit: 528ce6781726e022bc5dc84034360e6e8f1b89bd
[2/2] io_uring: cancelable uring_cmd
      commit: 93b8cc60c37b9d17732b7a297e5dca29b50a990d

Best regards,
-- 
Jens Axboe



