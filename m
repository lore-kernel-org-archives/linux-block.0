Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE79EC433F5
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 14:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FE3C61213
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 14:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhJUOj6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhJUOj5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 10:39:57 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5465C0613B9
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 07:37:41 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 34-20020a9d0325000000b00552cae0decbso734272otv.0
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 07:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=dDWiDipIHK5HS6MeBxjwAzx3AX6EeZz5LXZckVi1/bo=;
        b=GK5V02ISlYBHzpOBLF1zpta1GjhfAs9dy2MvUVgN5TUFpyOInmeAsVfJP+6ah1rZVv
         bNIlx97VDxD5ozhsnrZZdE3Yn1O3JsA5IdMmdE6ZkcdhXHQFcVyTXcjjAMTie4cXf+0U
         WM8isIKKkZJEZffuGxvnr5jfzL6xGo6TW6NawGLgOIgbYFVPAFy7PeKfOXv8/SZx2kFp
         ljkEVIabkyc9VzhlUyVw2hH0o4ouYSc0MspRk+qCO98md3YCz7CxX0GlMRcHmHdfrtBb
         OBxSugbTXw0jsGomAnItJKwo1ZJplwg0mTw/1ARmCBWIfNuOQRepNV7ep24Dwe5pv7yz
         J3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=dDWiDipIHK5HS6MeBxjwAzx3AX6EeZz5LXZckVi1/bo=;
        b=zHzPmXMOQI9zCbDiuT2gHKUN4OxNnmABjX0fEF1a3/F4gWXgvyWFFiKATb8vF3vhHj
         qwJpE6Otn7r9a0aYYOXiYTO+hHPCaPD8XI+Ba6EexolDxVzbr72pNhBglvoyKE9QJKDW
         2Ek2y8uVY5itAKKt+oc3iT5FM8F9O3sMFKFB8MerErL26DsYnAYOLMGFDD1c84r3XOhG
         kdrp/r2ZAhxORUJNZEfFiBhgJAp28XTPQwPhwH/AQTL8Wh62ow500uYWiIAE100BN0e9
         Nlv+wVn8ECBGoFVgY+j96PgHWNOJbBxhcjx2NrEXLh9wvlzamUUWBNP2AWa25V0s8HWp
         I9fg==
X-Gm-Message-State: AOAM53230RhEZoy1eSTYrxjx8MLPiamfCiF3QwZJJ5NLlyT4NpMORKpk
        nqZX2I3JZSaqd69NvANFZ2REOg==
X-Google-Smtp-Source: ABdhPJxNL5QPcUrTS8+siBt4FYmfmiwU2xtnsVC3wrzxIslvK3bC3TMz4siO5gWkpAxAhnVJjJ67WQ==
X-Received: by 2002:a9d:20a3:: with SMTP id x32mr4783922ota.91.1634827061206;
        Thu, 21 Oct 2021 07:37:41 -0700 (PDT)
Received: from [127.0.1.1] ([2600:380:783a:c43c:af64:c142:4db7:63ac])
        by smtp.gmail.com with ESMTPSA id bk8sm1131310oib.57.2021.10.21.07.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:37:40 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>
In-Reply-To: <cover.1634822969.git.asml.silence@gmail.com>
References: <cover.1634822969.git.asml.silence@gmail.com>
Subject: Re: [PATCH v2 0/2] optimise blk_try_enter_queue()
Message-Id: <163482705916.41758.93518625125015139.b4-ty@kernel.dk>
Date:   Thu, 21 Oct 2021 08:37:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 21 Oct 2021 14:30:50 +0100, Pavel Begunkov wrote:
> Kill extra rcu_read_lock/unlock() pair in blk_try_enter_queue().
> Testing with io_uring (high batching) with nullblk:
> 
> Before:
> 3.20%  io_uring  [kernel.vmlinux]  [k] __rcu_read_unlock
> 3.05%  io_uring  [kernel.vmlinux]  [k] __rcu_read_lock
> 
> [...]

Applied, thanks!

[1/2] percpu_ref: percpu_ref_tryget_live() version holding RCU
      commit: 3b13c168186c115501ee7d194460ba2f8c825155
[2/2] block: kill extra rcu lock/unlock in queue enter
      commit: e94f68527a35271131cdf9d3fb4eb3c2513dc3d0

Best regards,
-- 
Jens Axboe


