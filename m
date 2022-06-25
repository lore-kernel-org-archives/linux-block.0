Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8986FC433EF
	for <linux-block@archiver.kernel.org>; Sat, 25 Jun 2022 17:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbiFYRCL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Jun 2022 13:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiFYRCK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Jun 2022 13:02:10 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD8F15827
        for <linux-block@vger.kernel.org>; Sat, 25 Jun 2022 10:02:09 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id w6so5233541pfw.5
        for <linux-block@vger.kernel.org>; Sat, 25 Jun 2022 10:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Lyqt/8xMEJfXAgB3QKmRd6F7TnQPwfOqSXGZzoVDZfQ=;
        b=GKyB12Ox3fecbB0aczZrQiVi9Yk1LyO8cPu3c2kKBUH1BT+1W+EY6I8OAsoG9EsvBS
         zYFm1eocUpAjMrmj7ORwrzVmA2kgYrzk0AwJwPbj2R7kNdllfBPVmwOYIH1izdWkztxR
         hxdPzm11ROPR4s0Jp/UDa57jBUnQ4YWYxjg6Lko6XNxxreOaNVoZYl8hGPvlg6fh9U4c
         G8sB0seKY6Lhu/l8C6rO2ORpMjINBZ1xVVbDTIQGwUud6WPG3RN2N8s7a/3+m5NhQhbf
         FzAnZjREKXw3B1Pa8Akz65REc/UCjYtKxEcxef0DMmHGUiX8j0LdF9DNd5i61QTD+Vkk
         yi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Lyqt/8xMEJfXAgB3QKmRd6F7TnQPwfOqSXGZzoVDZfQ=;
        b=5PGTuv7EOublhr6kv0IL1Q446NPKD7v266q1J47icZgCfTbPvDEe5bI1GTLOBhqwaE
         P0NmNKnCXGh+NJAnvsWffWgGMO5gGh+I+GJmofRa0o04ANWOYd1dMn+Vqah5pFRqS/z4
         S4jHCFyvU56HHWi9T5DawSLHRo56p99BB7Jh1c+Lbh1fMO15ClKX87L5MLNHFfw3NkH5
         +uxI2g0LmJ85+zVXGKq4XFRuhl0zIbavf+oigDz2fLY80fGAqZdoeSbUZK61VNssUDea
         HB4Yx5k6qkl7vOZrzNJz5sywOGeRG7Rw1bCFpmTcqLnbQzxdutFzLTer3G7IO1DKco5J
         /vdw==
X-Gm-Message-State: AJIora+ZgeOSb4pLzpBg7gAbAOI1SFYFVOpRtvl+4Av0HuwCQzgRy7Uj
        GronxOSM1aG6hYxiQEGxrMlEUQ==
X-Google-Smtp-Source: AGRyM1vOj1AtuviiNYkSsNdFzXCEmg0WINR16xuef7hYkKJP7AoH8til4kjwwPRyRlHFEbtkida7oQ==
X-Received: by 2002:aa7:8008:0:b0:51a:cae3:7563 with SMTP id j8-20020aa78008000000b0051acae37563mr5099164pfi.16.1656176528722;
        Sat, 25 Jun 2022 10:02:08 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id r19-20020a170902e3d300b00163f8ddf160sm3932508ple.161.2022.06.25.10.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 10:02:08 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     wuchi.zero@gmail.com, mwilck@suse.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20220605145835.26916-1-wuchi.zero@gmail.com>
References: <20220605145835.26916-1-wuchi.zero@gmail.com>
Subject: Re: [PATCH] lib/sbitmap: Fix invalid loop in __sbitmap_queue_get_batch()
Message-Id: <165617652775.121867.397759941071832869.b4-ty@kernel.dk>
Date:   Sat, 25 Jun 2022 11:02:07 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 5 Jun 2022 22:58:35 +0800, wuchi wrote:
> 1. Getting next index before continue branch.
> 2. Checking free bits when setting the target bits. Otherwise,
> it may reuse the busying bits.
> 
> 

Applied, thanks!

[1/1] lib/sbitmap: Fix invalid loop in __sbitmap_queue_get_batch()
      (no commit info)

Best regards,
-- 
Jens Axboe


