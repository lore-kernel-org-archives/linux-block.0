Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3391C433EF
	for <linux-block@archiver.kernel.org>; Mon, 16 May 2022 12:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbiEPMUa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 May 2022 08:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbiEPMU3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 May 2022 08:20:29 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD582CDC8
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 05:20:26 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id h24so8611231pgh.12
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 05:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=KiHgPRQNMM51hvm96SqNj33U6OXbW6qZzYEx0pv+WEQ=;
        b=lgPqdq84TcmO/n5+xA+cuAOzIElmdxREfkewtW2D0BhxlqDQWSnsf07w8aekQ7VCms
         RuHnLDvLLF1cuVxcGaHsMiuLDWim3UtCkMc4xGy4ByFcMabhhNXZhrqG0IgoaxXq39uF
         spbM9UuoAD1m0+lCH/zC7Mci5QNuuQbe6QdQfuAZVCruHw7KFA6RlQOLPB6+/qzRC7oJ
         hyZiqOo3hYBEU2aU5VHCXGZSiWjPza304U1dlpJqKGfjrrW6QUIDHzlaXuI0bNthUImY
         R/AarvweTj1NVetd3vgMA9he1qEY69zcAVjoINB+7R0E0WE4RTj911w74WYrMv+gZ84j
         F/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=KiHgPRQNMM51hvm96SqNj33U6OXbW6qZzYEx0pv+WEQ=;
        b=BLUADqHGTwmfl6AVb6qsx48kL8ss4ZSg/qFiejlyMlsQFpJmFkoeQJ75j4YTPrOZz/
         eKzZNJmCtUeCPJGC/iG3wyIUWk8Ff2lt/SU4ZoBf1byP2ZQmGcqtfzhtvW9TT8ARh2qo
         lOqrgxdnSD5YbjBxljFrUGfzyF7u8djDA9dAGawPoHb6dtjj6bP7cPQ42exDZrlUfAyB
         EJSC/SjKV4kQSecuXF3nAfUQGltfL5Sj2Q1UXXTeBRh3KnQW/s9Ak7b/2FbBF9spKxLO
         TWDXqRTkAScu3rsDcySGZXtvs7SKfivWimIevHWyXyaUnn4G3qLsEv4kxTU0WyV4V+qU
         trhQ==
X-Gm-Message-State: AOAM531qTncm34/FvY733bPMYVGyRbK1aoPNoPcfagAtQoXdXDEF7slX
        h/xy4+zTL7hQ//RqDRqolgVxzeYuqAG5dg==
X-Google-Smtp-Source: ABdhPJzfMPeDythetyHLEbcX8r99P4NlIIOCE7Gh+INnjSrFzi9IWiEZ+HhqI8NeeOl9CLyLf+qg9Q==
X-Received: by 2002:a05:6a00:cc4:b0:50d:e9db:6145 with SMTP id b4-20020a056a000cc400b0050de9db6145mr17232353pfv.56.1652703625903;
        Mon, 16 May 2022 05:20:25 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z21-20020aa785d5000000b0050dc76281c8sm6811476pfn.162.2022.05.16.05.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 05:20:25 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     xieyongji@bytedance.com, josef@toxicpanda.com
Cc:     nbd@other.debian.org, zero.xu@bytedance.com,
        linux-block@vger.kernel.org
In-Reply-To: <20220322080639.142-1-xieyongji@bytedance.com>
References: <20220322080639.142-1-xieyongji@bytedance.com>
Subject: Re: [PATCH] nbd: Fix hung on disconnect request if socket is closed before
Message-Id: <165270362494.10115.13881054748910771179.b4-ty@kernel.dk>
Date:   Mon, 16 May 2022 06:20:24 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 22 Mar 2022 16:06:39 +0800, Xie Yongji wrote:
> When userspace closes the socket before sending a disconnect
> request, the following I/O requests will be blocked in
> wait_for_reconnect() until dead timeout. This will cause the
> following disconnect request also hung on blk_mq_quiesce_queue().
> That means we have no way to disconnect a nbd device if there
> are some I/O requests waiting for reconnecting until dead timeout.
> It's not expected. So let's wake up the thread waiting for
> reconnecting directly when a disconnect request is sent.
> 
> [...]

Applied, thanks!

[1/1] nbd: Fix hung on disconnect request if socket is closed before
      commit: 491bf8f236fdeec698fa6744993f1ecf3fafd1a5

Best regards,
-- 
Jens Axboe


