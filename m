Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48594C4332F
	for <linux-block@archiver.kernel.org>; Wed,  4 Jan 2023 16:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239828AbjADQOU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Jan 2023 11:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239749AbjADQOI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Jan 2023 11:14:08 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79153C391
        for <linux-block@vger.kernel.org>; Wed,  4 Jan 2023 08:13:55 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id 3so18227377iou.12
        for <linux-block@vger.kernel.org>; Wed, 04 Jan 2023 08:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZbRoRpfsZCnipMc5wHqe++LgY2iEfHUJdOupJwsA9A=;
        b=L32E5TdWcM6SWW6XRopEZfIZ5HTYyxZ+Dj2phBUTNR2geFA65/XGYcPFSkoEnEsUkh
         93rxw8fasi2mo7JjAudmu9v1bvT+uGqowUW9e8RinGHLtac8t+bZbQBlIjXSZxRyq8bM
         6iPB5NN+T5SgPPdSBiSoVbF3XPsY29gMAcY3UkO8jPk60a/5tbpXjyB3ZAWhpvYErsHc
         epUSZgdlljCN2I4SOpF5cmaVRUWWfy/ZP/1nP3mYMwYa1CfvP2pUoyYdNzbwcJKKs6FF
         5A7/0aiNTL4pcNaGA78DDdAyjE3cOfERVlUBXvQ4qNYgkLCe/MhpdXFB0p/LWQdMZwi1
         SBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZbRoRpfsZCnipMc5wHqe++LgY2iEfHUJdOupJwsA9A=;
        b=ZEq/fk+xvLB6CY3t/yb/VSZ/L9BUk9y4bBrmRyjwYJVWRUWnpARBTVLfn84D5FPrKk
         0/ud7OsVDTMiLKarw1CVoPEmNMq9RwSENktlSOoro7KZJSSXDfB0VAnooWq4BaILBlI3
         iIQ11qiRUmPHwHss3IvXA8NF6PPy9vA/HMLxGupPtLN6qi9Wtda9Nt84NvZ0pPaDfS+K
         9oGi0QLrUdk2SRE8ZpKLtCJNCutD24hNKvWmWqKMXw8xMEalcUuZBpWZNfTVHRU5loGN
         3113bmDLOHLwFbH08akSPCLF3g7hMdMNyAJ0+FaxE+togSRx0dGK+240vtvyvk/lJ46i
         cgpg==
X-Gm-Message-State: AFqh2krS1dZIMm3+qDKajoaiRJYmYaR+uStvqtWeQNVYQeToCfhRLQzx
        zgvc5e1ijFUBb0XCMim/eZBhRlnXNUjUKTLd
X-Google-Smtp-Source: AMrXdXvALsj9IDrP7DGlhtW0mUhXr2/p6ZeBLg+mQzFtn6Y5o3rFtBxWhEsL+01oeILUrbudvjQY0Q==
X-Received: by 2002:a05:6602:24d2:b0:6dd:f251:caf7 with SMTP id h18-20020a05660224d200b006ddf251caf7mr5603808ioe.0.1672848834974;
        Wed, 04 Jan 2023 08:13:54 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i17-20020a056638381100b0039d8bcd822fsm11181349jav.166.2023.01.04.08.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 08:13:54 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20230104133235.836536-1-ming.lei@redhat.com>
References: <20230104133235.836536-1-ming.lei@redhat.com>
Subject: Re: [PATCH] ublk: honor IO_URING_F_NONBLOCK for handling control command
Message-Id: <167284883385.63338.15259506441051586608.b4-ty@kernel.dk>
Date:   Wed, 04 Jan 2023 09:13:53 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-7ab1d
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 04 Jan 2023 21:32:35 +0800, Ming Lei wrote:
> Most of control command handlers may sleep, so return -EAGAIN in case
> of IO_URING_F_NONBLOCK to defer the handling into io wq context.
> 
> 

Applied, thanks!

[1/1] ublk: honor IO_URING_F_NONBLOCK for handling control command
      commit: 6a894753cef6494feb7e5332a95477f31212ebe9

Best regards,
-- 
Jens Axboe


