Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6153BC64EC4
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 15:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjAaPAL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Jan 2023 10:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjAaPAB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2023 10:00:01 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F422917A
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 06:59:59 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id d10so10213608pgm.13
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 06:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WG1fZYP+yCG0Jh5SMESUd2pwQUPy+PlEtU4xMUS5Zmo=;
        b=LxkRzHLhEsnaKST+UGlt3MXu+hrtEvDSU20tL4vJXCBItTfMAn4Bb1Jpaq9g7eSpcL
         VDx/r8M2hZ9QYMbuM5iNEAWHkhvXYHRAdGpVhAAek2EqtXgmD6C9PthbyqWHBP73YC68
         32TddzqKCNqpyEsafKNmPdhtsccRzFy5dHgTpFuTeMhLCpOqZypFkQC8+cQu5K0dVaWF
         LCSvCiNQZpPL9aVhNwyHgO6X5RDtK/nhC/bJl0cy1Yr2MLR0Q58YPpiHnqu4DQ1uGehl
         XIpZekfpwSKFgLVGqysfqG0gdduAymWwmd4T7Fb6jLyDUnEqnGX3Uu80yyT0LBe5zWgc
         Fzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WG1fZYP+yCG0Jh5SMESUd2pwQUPy+PlEtU4xMUS5Zmo=;
        b=f6eR6kmgVktjUzHqGSeZKFas2ZNOwj5u4IT07tdb33ljBx/pBqzOvWxAsDabymUQCw
         gbeiaqGff3nC+1oGQCnObRpYS88N/A6GuNZFxBPBreCayGqZ3A+VrpOkm7ujKiVwIM4Z
         9mtX3AfgLGShLYNy8AU0AT4IpAYVZRPPNAjt4y+DF44y8gV+jdwm1MPHfTDvul1nYS7i
         oZy4QhCtsMVs/L2vMl5gLfhFdvBVYb6ZSOr6b1kcjeJctq9XzG5IL6DU2uiWiLpUqvbg
         cce1ZfjVZp/tRNtl4aV50G8u1UgQ7pkGWOdYJk6yrit/KLPy5KGWzHsa9SOatWLFQMaw
         jSKg==
X-Gm-Message-State: AO0yUKW7F4CfoqtkOVh0F8NcC83jdKvwbcPlco51bkZaKEA8KjVzgE8Z
        toP16rccykYjgz+pdW83DHyXHw==
X-Google-Smtp-Source: AK7set8pR4tasK5WEcAi4eE7oGEz+7KqAuMPUO6UddW97wjBPXl+tQWEbuPdGJGIKLlGKiZVUkWtRQ==
X-Received: by 2002:a05:6a00:24cd:b0:593:dc7c:98b1 with SMTP id d13-20020a056a0024cd00b00593dc7c98b1mr3485383pfv.3.1675177198447;
        Tue, 31 Jan 2023 06:59:58 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id bm6-20020a056a00320600b0058d9623e7f1sm9636811pfb.73.2023.01.31.06.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 06:59:58 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
In-Reply-To: <20230131040446.214583-1-ming.lei@redhat.com>
References: <20230131040446.214583-1-ming.lei@redhat.com>
Subject: Re: [PATCH for-6.3 1/1] ublk_drv: only allow owner to open
 unprivileged disk
Message-Id: <167517719776.22325.4028955533692482010.b4-ty@kernel.dk>
Date:   Tue, 31 Jan 2023 07:59:57 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 31 Jan 2023 12:04:46 +0800, Ming Lei wrote:
> Owner of one unprivileged ublk device could be one evil user, which
> can grant this disk's privilege to other users deliberately, and
> this way could be like making one trap and waiting for other users
> to be caught.
> 
> So only owner to open unprivileged disk even though the owner
> grants disk privilege to other user. This way is reasonable too
> given anyone can create ublk disk, and no need other's grant.
> 
> [...]

Applied, thanks!

[1/1] ublk_drv: only allow owner to open unprivileged disk
      commit: 48a9051980242128f844defe44c7e83217f79872

Best regards,
-- 
Jens Axboe



