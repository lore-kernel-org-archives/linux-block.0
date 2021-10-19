Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A315C433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 17:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B86D61355
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 17:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbhJSRNu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 13:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbhJSRNt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 13:13:49 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C42CC061746
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 10:11:37 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id h196so21263697iof.2
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 10:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9nNFJafehBF2DqCROwwySiwn6Y3GKArtLiVFqM+LLss=;
        b=tz6zldbs8fcCfLu5knqDo5ntX3sqxkUwSNWMqGEZAC3KskdYOHbBMmkiv67EWS/Bah
         1+uXFEgtfZhgtdk5uDDe1SIAlgPkEnWkv2UPrc8eXWjzDoKCk+9WvI90ZG76pQcOzSar
         rP92vjosZY5eE1kctMMfcdGh645wROW2w4lJSNx0N41MHH3qTqKr67ikByBtHCIdK+ne
         dChTZs+hWrkLrs6qGpreqdT0eO4eGu//Al0xBEPOYwOr0nTTjjqyRDICQ+Tt2A2obLb2
         VlkyFQXzaj9DiuOpia+tHj8x+ovqd7js+PDo5q7PLAizgsdUd+3msgGRujZqsuBa6NxX
         gmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9nNFJafehBF2DqCROwwySiwn6Y3GKArtLiVFqM+LLss=;
        b=KWtbwORVd4muDdBiJKU0b4Y2IXBxdtEhSBCOeQl0Dcx5Mc8Nf8Km4VFSdFOe0e+mDd
         i1yRRLPjhrd3y6v003h0AC83kCzyKatlURJccx8mAjqGL7V1+ddKWn22L41WroatGh1k
         JPXkIy823axMQWaVKtZj3AXhAlDqLNRqz05JFQEnzXyjF5F10nTTtzc6iWxTtIn430qJ
         E6eAFspygZwR7cuS0XyY9/TyIyJkh0WmGUgkBYSLve99n9TQsrce3xhZk/BZCXUGR1CJ
         TSSMdUsru1auC6uoz6vjAEw4Dp0cO+ychRy9Jhm6b0PALw+jPT/++FkIFILhYN69Vpj0
         3OnA==
X-Gm-Message-State: AOAM530pSDuvDZPvtWQxyGlQTIxGVFBkPLYzDPHIx6hfWZSlStQEvvJo
        QY33YsZmpv2GvsM6txi3sgEgHq2jR9gcLQ==
X-Google-Smtp-Source: ABdhPJwSZPVG9ANmMYck+JQNyN7Z2xQira/yIiKqjI3YZOb/AQHHuMA8TC+w/9jd1q/LhiCAELvLVA==
X-Received: by 2002:a05:6602:13c3:: with SMTP id o3mr19921409iov.142.1634663496451;
        Tue, 19 Oct 2021 10:11:36 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t12sm8518003ilp.43.2021.10.19.10.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 10:11:36 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-mq: don't handle non-flush requests in blk_insert_flush
Date:   Tue, 19 Oct 2021 11:11:34 -0600
Message-Id: <163466349198.667080.16319805997468516195.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211019122553.2467817-1-hch@lst.de>
References: <20211019122553.2467817-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 19 Oct 2021 14:25:53 +0200, Christoph Hellwig wrote:
> Return to the normal blk_mq_submit_bio flow if the bio did not end up
> actually being a flush because the device didn't support it.  Note that
> this is basically impossible to hit without special instrumentation given
> that submit_bio_checks already clears these flags usually, so we'd need a
> tight race to actually hit this code path.
> 
> With this the call to blk_mq_run_hw_queue for the flush requests can be
> removed given that the actual flush requests are always issued via the
> requeue workqueue which runs the queue unconditionally.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: don't handle non-flush requests in blk_insert_flush
      commit: d92ca9d8348fb12c89eac5928bd651c3a485d7b9

Best regards,
-- 
Jens Axboe


