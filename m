Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729DBC6FD1D
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 19:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjC0TXT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 15:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjC0TXS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 15:23:18 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A63C2
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 12:23:17 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-752fe6c6d5fso5716039f.1
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 12:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679944997;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bo4etPzwchUNM36+UbkkC8cDk2gXIaAG6yT2M6I8Bks=;
        b=kU9Vn6VaR5c8ZMrwETv7Zj1L4kAi1OYwtFINolBDgHnKF3RqJFUiph1bwNx63M0kuG
         FluslyXhwl9Fvv6KEc3VNYD3Ooap6qA3YEynI111VRPVjE91pwyJ2mFypshczWGgqZDz
         sdRj9YwWePNrv45C78PyTNIbKQRnUcGI3oZ7rrqgoth1Ul4a2AUQUjVbOMovetDjADC9
         eqJhbCg09a2iXD8zBdZrtJrb6pwb6+17Q276+0Ywt5SxVy315KW4A/YCjfa+QqeZZ83/
         BGTdUKLe3p+hf96cs5M6Cf9k2F2anyhgS5K05CJMn55g7QCVnYCBWED28TzgmtnV9Nps
         XE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679944997;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bo4etPzwchUNM36+UbkkC8cDk2gXIaAG6yT2M6I8Bks=;
        b=5hvAxRUBgHdKhI307vt9JQtE08RhBPHy9rd+ZQ21EfsTMX7hRpUMdMsiFi5UjQ2X5s
         9x2FvJsYtkt0OPR6iMSgoPxG+O7NpUppzrW7XVTW6o/1QtOIHG3Me6XrXIKSzTreqnhl
         H7ZylYv4tlztnCKz94GwIxS5hvTUwm8biR2XhurgWYPJI22+H89rhBEii37hvTQQvg2C
         OBwAIzo+3PZ5C/tDQjoJd2Uz8LMUt3c/aGCH/zhG1dEeKN3FsrEa9tP6bs44wEpWtNaG
         FANC+yCdPjtdWu5WsgZfnewJNs81N+yf8uGaZzynaGWNkgsXqTHYvIQWSU6Js03p8DN5
         EaqQ==
X-Gm-Message-State: AO0yUKWyJ6ViKny74EAjeHt+I/t/pTm02YFZ48Qo1t0+xSgLpJN3uapI
        xRFrDkzM/FQkMlDvJP+jSP3Rb5C5V4RUY/62jsQY5g==
X-Google-Smtp-Source: AK7set+EWjUoyBRlgbGc6cdmLcEghvfLHQhzNVj2krodCaJn2IiPR3O/vt8MyloD189C8s/CXbNO/Q==
X-Received: by 2002:a05:6602:3405:b0:758:9c9e:d6c6 with SMTP id n5-20020a056602340500b007589c9ed6c6mr7770449ioz.2.1679944997120;
        Mon, 27 Mar 2023 12:23:17 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id p5-20020a056638190500b003ff471861a4sm9147439jal.90.2023.03.27.12.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 12:23:16 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
In-Reply-To: <20230327073427.4403-1-kch@nvidia.com>
References: <20230327073427.4403-1-kch@nvidia.com>
Subject: Re: [PATCH 0/2] block: remove unnecessary helpers
Message-Id: <167994499651.195882.6032878246056598727.b4-ty@kernel.dk>
Date:   Mon, 27 Mar 2023 13:23:16 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-20972
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 27 Mar 2023 00:34:25 -0700, Chaitanya Kulkarni wrote:
> There is only one caller for __blk_account_io_start() and
> __blk_account_io_done(), both function are small enough to fit in their
> respective callers blk_account_io_start() and blk_account_io_done().
> 
> Remove both the functions and opencode in the their respective callers
> blk_account_io_start() and blk_account_io_done().
> 
> [...]

Applied, thanks!

[0/2] block: remove unnecessary helpers
      (no commit info)
[1/2] block: open code __blk_account_io_start()
      commit: 06965037ce942500c1ce3aa29ca217093a9c5720
[2/2] block: open code __blk_account_io_done()
      commit: 06965037ce942500c1ce3aa29ca217093a9c5720

Best regards,
-- 
Jens Axboe



