Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE77C77B7C
	for <linux-block@archiver.kernel.org>; Sun, 21 May 2023 02:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjEUC2M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 May 2023 22:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjEUCUk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 May 2023 22:20:40 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97007E42
        for <linux-block@vger.kernel.org>; Sat, 20 May 2023 19:18:54 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d61fff78aso21687b3a.1
        for <linux-block@vger.kernel.org>; Sat, 20 May 2023 19:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684635534; x=1687227534;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nt75QlqWGqvvFPlCh5zgc1jmIdql8tlsuTt/Cw9EgBE=;
        b=AA5Q1nUInuxcHf+Wgqv7y4ZdCzdfxxCBbGUiPqF+3t6PHazo1HwBPLC2TgEURv+LKf
         0OLoyqQ0kr/YW2boX2SPgxlgDY2ZtS4MLRxdjv6jH0KUIH3xLtPy5CsGIIgEK9itgmDl
         cNcRKsBw31sNAjLoOd+owNWR57Xxuo34lamglYLTPxe8v8dlHY3GvtB9yQ4WzYBEVpTu
         Bra9jdGwbnDxQiQXp7ClGDMhVG30mRuBENg59ouYojxq3Fm9ElqXWrYvHHqWOlhBZSXx
         Kfll56bRZ57fb4kT0M5gQGkU66KteLSlBw5RyK1tsv520oV+lQMltIRtPRkvHrxLTXJh
         pPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684635534; x=1687227534;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nt75QlqWGqvvFPlCh5zgc1jmIdql8tlsuTt/Cw9EgBE=;
        b=RSImXlvy+XHYW5+C6bgX9+lbkqVxmOkXfb7XyeSpgawYikQgtF/QkVOKKH3opbt+iW
         ATfkTcl1ElQmF5hcitnLXI+uW0YPjVzUOFJ4YqjXmdtnggsbDQ/eLqrislmU0rw/X9E8
         ppbiJse9erQAffYGQ6TIIWZRqJvBsssc+Kq+xsIU8GWyBiLxK5TosV8VoGAMOihzgQzB
         zDYKYTMHRV2KTu7Qq5O7Cj8uAC4VyJPhV8xdK1Jow7b5UoD9S16v4J5a3lA1OVX9TYpz
         ivzzW7rjryw23rOvmzwZHwACC5JdREynlUzBxtF2QnRHiEgx0I16XDdmlCJDYtKAOLL2
         5+3A==
X-Gm-Message-State: AC+VfDzzAJZP3a0M2DlJfDvo6Thp7mMJfpYvw0Vw67DheWR7BLT7V1zb
        v88URP9YNYXLvRxHJ+0ZDseX0zM3iQVnVUEYUCk=
X-Google-Smtp-Source: ACHHUZ6x6gnKWzKrYDjKm5VTs9SjJFEbkO5n49jX7ReV1BQ8HsCUCZlvUhifx0+YaD3twwGFcKfTww==
X-Received: by 2002:a17:90b:1c0e:b0:255:54c4:9a75 with SMTP id oc14-20020a17090b1c0e00b0025554c49a75mr1057532pjb.2.1684635534048;
        Sat, 20 May 2023 19:18:54 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090a4a0600b0023d386e4806sm1769795pjh.57.2023.05.20.19.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 19:18:53 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@inria.fr>
In-Reply-To: <20230520151134.459679-1-ming.lei@redhat.com>
References: <20230520151134.459679-1-ming.lei@redhat.com>
Subject: Re: [PATCH] ublk: fix build warning on iov_iter_get_pages2
Message-Id: <168463553286.618329.10207424112344195325.b4-ty@kernel.dk>
Date:   Sat, 20 May 2023 20:18:52 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Sat, 20 May 2023 23:11:34 +0800, Ming Lei wrote:
> Return type of iov_iter_get_pages2() is ssize_t instead of size_t, so
> fix it.
> 
> 

Applied, thanks!

[1/1] ublk: fix build warning on iov_iter_get_pages2
      commit: b8b637d770ef7aa9bc3971670cc8532b1f0d757e

Best regards,
-- 
Jens Axboe



