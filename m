Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8167C433EF
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 13:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349051AbiA1Nik (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 08:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349024AbiA1Nid (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 08:38:33 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349A8C061714
        for <linux-block@vger.kernel.org>; Fri, 28 Jan 2022 05:38:33 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d5so6489792pjk.5
        for <linux-block@vger.kernel.org>; Fri, 28 Jan 2022 05:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=is6S4jElVQxIZHKKeJ+uOPT+PZ499bwGOBOByve3Wqc=;
        b=pgdwWCc9Z8paSvapjeT876SWKb54JtsvY5vIptMdL1evVDEFpDSj5UWqDPJs6jKeAa
         G/NfGlgRl3Z6en35n4+FjhpHbD8hXjz8LNDX1ut2YFYjCK2Qsp1VjrVOmnBH+lnBsys0
         8Z1EGtkCBKxKwUS+OdtknAAj+sHFz5NvsFCmPPuakhSdsyYumm2c1O4U8RM+ZQPZ7l6r
         FbgN1AjTCEjDmzvg9PMBXoIX4JULIGsnjIl2UyoGYDCi8LT9YJDIUyhQmYJUwXGAWvUy
         5I947V+twaWqFmR5FOnYfxV8kqVMYA52EOOvRkeJckK5M9sMPleOQ1fm27nTWarRfxTW
         lmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=is6S4jElVQxIZHKKeJ+uOPT+PZ499bwGOBOByve3Wqc=;
        b=miSBKFpGGcNGxzkxgekN0c5dy6ZAhGzrWUdahVZPQeRPnYy9iXsqdZgWMizRXspjsx
         M1DgdzEDrap6SnHzljlK68bABdIAnFtc65n5Q9O5t6bqpMb9KMcwYWEXHEqw8B+DytxW
         p5M8QO1Ti2fH1H5lRsGVVkLpmwRvht+vbztNVfuQXJPV2ppVe8pEl04HkJVUUidX/h0G
         d8RJBXGAKKl3aJrJ15WQrSWrBHFuzT395MNw7QYaaeziQXBvYefmDhc9vbZzUbG/9ov6
         ZT3L2kjnqqCy4JvZfCe4ce35aofcFVNJBkKFApEn6jstue5bpBGTZsSec4Fle06VBXDq
         rIPg==
X-Gm-Message-State: AOAM530v4g4Jopg0SBmAVFWj5KLzXwaOdaqwmtodB5TmUwmDz5gkonSQ
        NERWE/AU7Wzj2ycliKYlj1RQJg==
X-Google-Smtp-Source: ABdhPJxJrzuPfUKSSu+77kxCEcP4C5CMCDjHXJgujfWUfsNG4a9hKWqGRmbMvVVK6rcQonP73yOFFA==
X-Received: by 2002:a17:90a:4811:: with SMTP id a17mr9839741pjh.159.1643377112676;
        Fri, 28 Jan 2022 05:38:32 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id b14sm10009771pfm.17.2022.01.28.05.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 05:38:32 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-block@vger.kernel.org
In-Reply-To: <20220128043454.68927-1-jiapeng.chong@linux.alibaba.com>
References: <20220128043454.68927-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] block: fix boolreturn.cocci warning
Message-Id: <164337711017.260343.398701118435973656.b4-ty@kernel.dk>
Date:   Fri, 28 Jan 2022 06:38:30 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 28 Jan 2022 12:34:54 +0800, Jiapeng Chong wrote:
> Return statements in functions returning bool should use true/false
> instead of 1/0.
> 
> ./block/bio.c:1081:9-10: WARNING: return of 0/1 in function
> 'bio_add_folio' with return type bool.
> 
> 
> [...]

Applied, thanks!

[1/1] block: fix boolreturn.cocci warning
      commit: 7fc6fce0c96ff6db540a974b9b9dc38e241543a5

Best regards,
-- 
Jens Axboe


