Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B5AC433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Dec 2021 04:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbhLUEIR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Dec 2021 23:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbhLUEIR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Dec 2021 23:08:17 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E5EC061574
        for <linux-block@vger.kernel.org>; Mon, 20 Dec 2021 20:08:16 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id b1so3326180ilj.2
        for <linux-block@vger.kernel.org>; Mon, 20 Dec 2021 20:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=wcY10LzqQUi0AjFR0O6bF2xCdpASAkSz2TK+xEczOQ0=;
        b=LxISMw/NSsA6k/eTb/D/Q208WA3x0tGp+Upac4SN4ODbfgEGvXLZ0ZZuGEc3TrhB6m
         xK7tktVpYUDDXhpWbWQZ3tWLvQ9o1NO+cKzYVWVBaxfTPZ2yNnCZhO3a7/tFN3Xoc1tf
         uYHwthyT8vMG11rgVLvqMznWMgj93M4gkDQzL4IptRwOXPKGUSjqAeE6ejAmwhl/C5lr
         OK0XL+RYRc0fP8BdIWhfD2YfPpaKl0oMl5D9i8nxlJLGn+aCAwZvJ682iEmX3mAhuMsC
         ZDzYxWuvGyDMtr9HRwL1SkROXHbnS2Z4y1ADcioYNOo6bKBEGt5SLCvNFiwzC9ri2Mjo
         Cb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=wcY10LzqQUi0AjFR0O6bF2xCdpASAkSz2TK+xEczOQ0=;
        b=ZqDlS3RUkUii4OA6T+grMVyWqGOD8QQ1hl1L28MPx/EYO58zsaPMRg8+95+T30pn+Q
         8xDbZYXED8fGHne8v5N8poHShjSha2kLCQ77/oBGASjvMcP/EDG422Q2jLjtno2kNivE
         HoJIU/loxqqOWnYyJQ8K31kqx08AncrI9Z5E9a8oHUiUkU4SKoJqKWuPr067+nOiQAXv
         VJnmVCpHb+hkEN+IzO7GI2CHJ37KP9p4y7MkZz40xNP5W9GIvOWSqLZK91liWOiaVQEb
         QUbHJbSF0sfVtIHO84NmPInoh++jMNwQ+0OYI32X7Z0264jHLQuJDJ7K35f8oWC9apzX
         4QXA==
X-Gm-Message-State: AOAM530+7swSeMs7ANKL/LcpqLdtNx4L19A55Mlc9b5on8fSo+cFlLOV
        pWENrVsuPLVaz60CJ9X0niZsBNI4gePNNw==
X-Google-Smtp-Source: ABdhPJzNC1TFc1ISI0tJa7fPZuEGqr+tMIAtllbD1zuEeGzc88NLUusGhPEKfacLjBbwd9ZnBayq5w==
X-Received: by 2002:a92:c744:: with SMTP id y4mr668996ilp.124.1640059695571;
        Mon, 20 Dec 2021 20:08:15 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id m6sm10561560ilh.4.2021.12.20.20.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 20:08:15 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20211221040436.1333880-1-ming.lei@redhat.com>
References: <20211221040436.1333880-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: call blk_exit_queue() before freeing q->stats
Message-Id: <164005969491.588738.16651932884687784884.b4-ty@kernel.dk>
Date:   Mon, 20 Dec 2021 21:08:14 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 21 Dec 2021 12:04:36 +0800, Ming Lei wrote:
> blk_stat_disable_accounting() is added in commit 68497092bde9
> ("block: make queue stat accounting a reference"), and called in
> kyber_exit_sched().
> 
> So we have to free q->stats after elevator is unloaded from
> blk_exit_queue() in blk_release_queue(). Otherwise kernel panic
> is caused.
> 
> [...]

Applied, thanks!

[1/1] block: call blk_exit_queue() before freeing q->stats
      commit: 37e11c3616f6182b6bd7f95a04df035b43464f39

Best regards,
-- 
Jens Axboe


