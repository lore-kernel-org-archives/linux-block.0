Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FB9C4332F
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 13:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiJTNDk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 09:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiJTNDf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 09:03:35 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB721CE3E9
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 06:03:33 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id u71so19178282pgd.2
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 06:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CrWKVZtOI32J1eyiZca0oyo4c9aEVy1KXMgpcMBc2M=;
        b=7hI7lCivt4hx9vW2nR0DjQJmQ0HXCPZCnu0Pr7TM/bDO8uGWVGOdq69I7X/yhTvozo
         FZBowiYLhf1p6Ag4rKysrfyJJJvXRT0qCdz0TgTX2D72YmiUqr6eeJckZin7gptZc4CY
         gZZ5aCoCvQYK57fRrGcMOfoCx2FcrcQOcXaas2xxOcf+4q/A7tvLp2kAJan7XOo8gh84
         iouCbnEN4WKbm9CS7ygwL81MBZHqJFAfXfWQXI0F45RvWc1rm70obsjv5ZZPFRLU0zWT
         1KQjh+KjUfL+70epkmMRS9hrsGq0GOPHt2VjG70insx0oG2+RWlApfqgrj2rQ7pEhTVu
         RfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CrWKVZtOI32J1eyiZca0oyo4c9aEVy1KXMgpcMBc2M=;
        b=cFrLKpMGy91zH+p0/sQ1eartk4Raz0SsZP9KLw/bc8rhgr7XUqzeoMFM1tvd01AP4H
         g7AwM6W3kqKS7mvJdb63udRqkY1Jh1T5/vORK1q4pPfXrQEur//VOGlXieW6Yr2QvEwF
         4GN+RIf3T4+LTfnytQweBfjYwNuxrIdLWEeKv7ZAVNAagPAaY+3hcaJBFktGNP/q1wgD
         5aTpgafEFc+C9e6+2F/XlKd0Rma5ldDF30cnfsfV5X9kF9dBlBaZBFPRpfnfmR5Uc8a8
         7VBs2Tjg2MXJJ6rxY7Ubt05Ed5c0zwZXTLJNZ2F2k5YRaIHB6SMz+ldrNeCskxS8URvk
         aBwA==
X-Gm-Message-State: ACrzQf05oEKTEc7yQKA+p98eOBLh15Sbdv4tg6i6vptUhBamDYYfPnjG
        vdGXR80APDHcuG/Rnda+K1dbxg==
X-Google-Smtp-Source: AMsMyM5sNnwCGNjwAlRpdcKDHrFE28D3OQt1qPwY32jtVNeAEuKvWNefCzpg7qDZPOnCgE1pbCsNqA==
X-Received: by 2002:a63:5a41:0:b0:430:673e:1e13 with SMTP id k1-20020a635a41000000b00430673e1e13mr11902186pgm.435.1666271012904;
        Thu, 20 Oct 2022 06:03:32 -0700 (PDT)
Received: from [127.0.0.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id q5-20020aa79825000000b005695accca74sm2551230pfl.111.2022.10.20.06.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 06:03:32 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, mhiramat@kernel.org,
        Ye Bin <yebin@huaweicloud.com>, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, Ye Bin <yebin10@huawei.com>
In-Reply-To: <20221019033602.752383-1-yebin@huaweicloud.com>
References: <20221019033602.752383-1-yebin@huaweicloud.com>
Subject: Re: [PATCH v3 0/3] fix possible memleak in '__blk_trace_remove'
Message-Id: <166627101165.162941.2701658237902573676.b4-ty@kernel.dk>
Date:   Thu, 20 Oct 2022 06:03:31 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 19 Oct 2022 11:35:59 +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Diff v3 VS v2
> 1. Invert the check of 'blk_trace_{start,stop}' and return early from the
> function for the error case.
> 
> Diff v2 VS v1:
> 1. Introduce 'blk_trace_{start,stop}' helper instead of 'blk_trace_switch_state'.
> 2. Move stop block trace from '__blk_trace_remove' to 'blk_trace_cleanup'.
> 
> [...]

Applied, thanks!

[1/3] blktrace: introduce 'blk_trace_{start,stop}' helper
      commit: 60a9bb9048f9e95029df10a9bc346f6b066c593c
[2/3] blktrace: fix possible memleak in '__blk_trace_remove'
      commit: dcd1a59c62dc49da75539213611156d6db50ab5d
[3/3] blktrace: remove unnessary stop block trace in 'blk_trace_shutdown'
      commit: 2db96217e7e515071726ca4ec791742c4202a1b2

Best regards,
-- 
Jens Axboe


