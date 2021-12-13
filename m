Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F28C433EF
	for <linux-block@archiver.kernel.org>; Mon, 13 Dec 2021 18:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239164AbhLMShw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Dec 2021 13:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238764AbhLMShr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Dec 2021 13:37:47 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33806C061574
        for <linux-block@vger.kernel.org>; Mon, 13 Dec 2021 10:37:47 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id m9so19720670iop.0
        for <linux-block@vger.kernel.org>; Mon, 13 Dec 2021 10:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=iYNAJEaqKj1UFQWUZSbKjYI7Uf/DEHaF8kT7uXYJ4F0=;
        b=UE1kiaWY4ttpMEJ188vPlJxMzmcZyVCtmJjqu6cZ6nRMuhFuRpqV3glvUkP0uWoccC
         WMdRPGsigC5SVCtXbOlHkoHR+Q/s0tmPQ5Uvto5kuIexLMk5B9qiHa202A12aAZxsOJW
         cQbhsAmrUdezH0IcFEuN4NaBzkYu2DHu4N4bhvryj74kv2hvo84EJ+Sf6Fxy7yHu+IO7
         hUVcfvbe2EL/j4E9wZrPzAgM4gdbMKzo7+0EwShLTfu0oMF7qd2BIAVVr0zGdSvl1n5Z
         nPZD+njbttIEWY3NWwFsAUicrcE2k6ZSTnp7dOP6qcEgXoYjsKhEJzwkxFbBAM9JhHBy
         Yj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=iYNAJEaqKj1UFQWUZSbKjYI7Uf/DEHaF8kT7uXYJ4F0=;
        b=T3dgQYWw3vIUfSjjEG6D4bEJn8Pxn7FE765hvOiYf2vl4+y7hNkVSTRawvB8QwlbfB
         kXW0bMPOGaKCx9jmUIh9XMLdp73NISAioY/u0+MJ7j+SfQMzPZ0t9IlQCJwiARxMwwMJ
         rekBgrwYw3Mn5xd/bsZxPm3fc2rnes3KtyQ9ngJZYbm/GMFZqcoSQ5A56fOmp1O8UtWX
         u8jF2X5cG9RNdnnH5eFE2J7cMEmeVtxvq5QWgdiCFGZIfYxBm6UNSyesBt3iCBE5HUGO
         zZhOxP/EcJ1DimiUJD8cCPQoRL7uhNQzimWnEub87Gkwgdx5oMKvjDrohv2Yip4/gGV9
         CI/Q==
X-Gm-Message-State: AOAM533TgOF0uF3fIdHfXRLS5WxY7QLchO6b1s5mBJxokxS+kXMb4fdg
        wLmJm2HGorXBb7Aawh0fsVXNuEpr0RFC8Q==
X-Google-Smtp-Source: ABdhPJzc/Loxsk19MNdEj8v9STZdz6G05dQrC2yeUXZVAf2ZqhCTQVoDzZZKVXKMnVywL8q/Rej4pA==
X-Received: by 2002:a6b:b490:: with SMTP id d138mr362397iof.180.1639420666537;
        Mon, 13 Dec 2021 10:37:46 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-2faa6b4daa2sm5930173.177.2021.12.13.10.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 10:37:46 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-block <linux-block@vger.kernel.org>
In-Reply-To: <1ed7df28-ebd6-71fb-70e5-1c2972e05ddb@i-love.sakura.ne.jp>
References: <1ed7df28-ebd6-71fb-70e5-1c2972e05ddb@i-love.sakura.ne.jp>
Subject: Re: [PATCH (resend)] loop: make autoclear operation asynchronous
Message-Id: <163942066589.142827.14236433787011010905.b4-ty@kernel.dk>
Date:   Mon, 13 Dec 2021 11:37:45 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 13 Dec 2021 21:55:27 +0900, Tetsuo Handa wrote:
> syzbot is reporting circular locking problem at __loop_clr_fd() [1], for
> commit 87579e9b7d8dc36e ("loop: use worker per cgroup instead of kworker")
> is calling destroy_workqueue() with disk->open_mutex held.
> 
> This circular dependency cannot be broken unless we call __loop_clr_fd()
> without holding disk->open_mutex. Therefore, defer __loop_clr_fd() from
> lo_release() to a WQ context.
> 
> [...]

Applied, thanks!

[1/1] loop: make autoclear operation asynchronous
      commit: 322c4293ecc58110227b49d7e47ae37b9b03566f

Best regards,
-- 
Jens Axboe


