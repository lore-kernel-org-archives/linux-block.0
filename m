Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FAAEB64D7
	for <linux-block@archiver.kernel.org>; Wed, 21 Jun 2023 19:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjFUTS5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 15:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjFUTS4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 15:18:56 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87F29D
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 12:18:54 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6687b209e5aso828622b3a.0
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 12:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687375134; x=1689967134;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2f5WgisLHrIWjLexoZ09o20/sSiq7obDMxM9Nt3mzM=;
        b=MFs2hhyLqE95D3XGAodnd5kAGGol4bAb872r0SmuAsVZFlxxLbD9xt/0aI6Rv9XWpP
         vHZ6F0v5pRv0l8yfy3rHD5iSef8KCAfXYJCl9/h4MwKKBpiscq652CgG0F05IDy9jiiH
         IXEPE4n7eVBRT9FcOhDjjY5aqA5T9TV9YG445ilHZ/OlOCRsTH8uBECDIsnq4kwOhA2d
         eo8GN0xytS/GDdS0mTcucX/596bcWXkHAlkMlQVM2/L/G1yIEQmG4jP7PLbz/AsHH6Yn
         TFzK/I06QIXtBFIv6Cp6vyHbw2m6yZlobpV6DhhvDPhZbTnk91xyZ3LHCA24xfkyEI5y
         5o9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687375134; x=1689967134;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2f5WgisLHrIWjLexoZ09o20/sSiq7obDMxM9Nt3mzM=;
        b=BEkRPfRMz3R/9McohcXpmZHjczkNqJfgg9JUNVGRgyogMpIsqWzOksFU22limDlMAz
         qKvyyUvIgpRAJLYgpUZrWiJPwWlHqilDqGp0AVJ+/b/qT93iMT0JUOGb11jMdZ7KAYIq
         rixETkdE9Y4NeDtP7+aKa557T4nwdfumxUQvJVxpyEx/BERXSS20ZiSbK3sTiA8JlNeS
         ghMXM0RKukC2u6ReQqdwy6dRbNE2XPQtWUkksNXkrDh0uu2Re1/fsP2/4xhX0LMFKe3x
         TM8zbJE63s2qgKkowBcaZx26sNlhBN3DmWS/b9OnY/HHqBp2D8u0i6H91MJvHbB4OKap
         T+TA==
X-Gm-Message-State: AC+VfDzcVwRlLPvhXcYRrZ4nQs5xnzLHm0Rp+pla7J/dmCEjJTYufTsm
        oHDEKKAGu7zhemAIElAmmZ+r9Q==
X-Google-Smtp-Source: ACHHUZ5Zmpuyilg9cg3JXNoGpox5uxNgnkCfRKW7H0PVHbnwhgDQ5TMrE7eBlvoPax8v5yDdbrwg7g==
X-Received: by 2002:a05:6a00:1d13:b0:668:6eed:7c15 with SMTP id a19-20020a056a001d1300b006686eed7c15mr11695637pfx.2.1687375134337;
        Wed, 21 Jun 2023 12:18:54 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p23-20020a62ab17000000b00668843bee48sm3210075pff.218.2023.06.21.12.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:18:53 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20230621165054.743815-1-bvanassche@acm.org>
References: <20230621165054.743815-1-bvanassche@acm.org>
Subject: Re: [PATCH] block: Improve kernel-doc headers
Message-Id: <168737513327.4025420.681034468992529474.b4-ty@kernel.dk>
Date:   Wed, 21 Jun 2023 13:18:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 21 Jun 2023 09:50:54 -0700, Bart Van Assche wrote:
> Fix the documentation of the devt_from_partuuid() return value.
> 
> Fix the following two recently introduced kernel-doc warnings:
> 
> block/bdev.c:570: warning: Function parameter or member 'hops' not described in 'bd_finish_claiming'
> block/early-lookup.c:46: warning: Function parameter or member 'devt' not described in 'devt_from_partuuid'
> 
> [...]

Applied, thanks!

[1/1] block: Improve kernel-doc headers
      commit: 017fb83ee0612595ec70c65ddd83472706b02a50

Best regards,
-- 
Jens Axboe



