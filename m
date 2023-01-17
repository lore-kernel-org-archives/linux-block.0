Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE08C46467
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 02:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbjAQCER (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Jan 2023 21:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbjAQCEQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2023 21:04:16 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A805023315
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 18:04:15 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v23so30849285pju.3
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 18:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SExj9sPYRI5nvri+f4hPOSN0wQyEHXBODvypNoBRz/E=;
        b=Gh1phClZGkEjfMyk7PFqNeMBC2BIMQscw5aErf3bX7JD7N4WENyYXGTvElDfKcp44g
         gR6v9FsUAlk3gLf+hll8ixHOu2Go53fjYr7VQw4w95GZqyidqq1U5/9JWWE6a9ksmjBx
         R7FDsKTErGWvXlNdJ1lh9Op1clvxpjFkY4/nJRgPJNEG2X6u0GbCcPWm3bnobYNDO1t1
         6SrPvB96sAFFi3J2LM9YgqfSuf39ca1gBny1IMzDsrP+RNhFbdFHORnBShPzbFGHE3A/
         SpzuwiNuEAVIP7kvNXqWXUUX9bIMkwC3jehvlsSwzEM/T6QBR2UBYgEkN7KNwXoa5LKq
         mUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SExj9sPYRI5nvri+f4hPOSN0wQyEHXBODvypNoBRz/E=;
        b=fciEWpmUHglz978Cog6jSvoRHicNSYZcByqxmaLjEszBpRJBSLlkWSBTf0Ph660zHF
         qeKvdwgDWjHsJhGmQBHnNlAH5K4vyFP038M8/QOp5Ruu7pCEs0w9NeknWgZGx9YyAwPb
         xS9hyBVhrTjUY+OlpROmx35uIDlitcg+L0MzaUDCJ9pftlERUndHmTjZOeoRJKLx0RRt
         thwinWPuyuavora/fvyiIylwLAfgukQVaCww5D70JL2mjBF5g7+GkBgPlkIUxpOGqPBH
         d2qC4+xhH33HKQrON7/eQdIK6/CGHbscnX3xeS9CYfTOEz3vnGKk1g/NRJrxbf7oNswN
         uLtQ==
X-Gm-Message-State: AFqh2krLFco54T7GLoX5y1+3jYFfhskSFMZa2ejO8O+KnjUZppFnmeSG
        2ALejT45y2ynTJVXNr0RunK2Uw==
X-Google-Smtp-Source: AMrXdXuylkNfB24jq6lP5eNrDj0l8ogCU88AsbWP5oRdsJ/+84Sp6SEdDIbnJnwlrTXObRb9zwkMkw==
X-Received: by 2002:a17:902:b611:b0:194:52ed:7a37 with SMTP id b17-20020a170902b61100b0019452ed7a37mr419970pls.4.1673921055052;
        Mon, 16 Jan 2023 18:04:15 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n3-20020a1709026a8300b0019492b949fbsm2860762plk.272.2023.01.16.18.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 18:04:14 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, josef@toxicpanda.com,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230103112833.2013432-1-yukuai1@huaweicloud.com>
References: <20230103112833.2013432-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH] blk-cgroup: fix missing pd_online_fn() while
 activating policy
Message-Id: <167392105396.441215.10700011927533380031.b4-ty@kernel.dk>
Date:   Mon, 16 Jan 2023 19:04:13 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-78c63
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 03 Jan 2023 19:28:33 +0800, Yu Kuai wrote:
> If the policy defines pd_online_fn(), it should be called after
> pd_init_fn(), like blkg_create().
> 
> 

Applied, thanks!

[1/1] blk-cgroup: fix missing pd_online_fn() while activating policy
      commit: e3ff8887e7db757360f97634e0d6f4b8e27a8c46

Best regards,
-- 
Jens Axboe



