Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAC5C32771
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 01:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiIVBto (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 21:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiIVBtn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 21:49:43 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A42A471
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 18:49:42 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id jm5so6416339plb.13
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 18:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=22By44h8OOcabCfO6aZS2ibOHIBtRD/oPQBZNztMJxI=;
        b=Ftf1++B9x7/SAXj6lEX6wDU5OQLsfrpPHHyq0inrz2kJDUwF4+U4wGn16weMF7NSG3
         HYB/YNwq+alAjeQW8lqTqCHywJi4QyKO3eEjef6xOOVr6KNLUXfd9gfY4pj8ws9IHGkH
         Pk0/42xdIKGxi4MzvoKUNQE1QEOpdvzSF6WnOhIL3SQ0G7eMpKnmI5yfPIYLSozocJuY
         TYHdhV9BN722q3VZQ87T5tAEdXHtpbaYvu/07Wvjk1y2nFOesTzY1w5CFav0PLmbauQr
         D33wgiArjULM7pEbz0L4v5AcjgleulW0Qx9/3fKmx4B9KoTas9WutiBQ0oZ8sXoDZT3l
         SLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=22By44h8OOcabCfO6aZS2ibOHIBtRD/oPQBZNztMJxI=;
        b=wVgvuPYOQyijLGhzvQL9wzDTKy/YnBm8FHQWtjANuX4xeKNVz3vIb9Auw8/7EivaaO
         ixDfmTgkNAUD4WD3ID1NmnTQ1bHicczQc4NyTk8r7jHf2dUbyJRrUIHBYK8nAb2SPlJB
         d1l6EDOEHZIVqKNfO0avIj0xgBrMsFBeijNM9gMOYqSyZoYA1MScjxxgGg0vckkbNqZI
         Jgqj5jTSiugzk26rBPZ39jVHzgb/Fk4Pl/bUZyz6S/G6RbbIZ7PIKy2h+b0Pajl2go4W
         Kp/a22fLYQb4a5PAVKO33rGoLtHItvEMVog+BF5pmbc8ufvn7wL/9FWlrS7zwhoRboRA
         kUiQ==
X-Gm-Message-State: ACrzQf3uHnJp0dgeKJYcTf0dPibyD5MygvGHNuAsOFMCq8nz07vOv3Ag
        u0e2/zW2YFilmla6Ul+lm+72pn0MeNW81g==
X-Google-Smtp-Source: AMsMyM62U5oSRE/FgSykHkCaIV2Fi1fTagjvJh17WW+pGQqmfArc3HTRztOQcIeuhsMWh4H4kn12/g==
X-Received: by 2002:a17:902:b08b:b0:178:48b6:f5a8 with SMTP id p11-20020a170902b08b00b0017848b6f5a8mr906722plr.3.1663811381683;
        Wed, 21 Sep 2022 18:49:41 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z9-20020a170903018900b00177f4ef7970sm2755258plg.11.2022.09.21.18.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 18:49:41 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Justin Sanders <justin@coraid.com>,
        Liu Shixin <liushixin2@huawei.com>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220915023424.3198940-1-liushixin2@huawei.com>
References: <20220915023424.3198940-1-liushixin2@huawei.com>
Subject: Re: [PATCH] block: aoe: use DEFINE_SHOW_ATTRIBUTE to simplify aoe_debugfs
Message-Id: <166381138095.40508.2928958892755894942.b4-ty@kernel.dk>
Date:   Wed, 21 Sep 2022 19:49:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-355bd
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 15 Sep 2022 10:34:24 +0800, Liu Shixin wrote:
> Use DEFINE_SHOW_ATTRIBUTE helper macro to simplify the code.
> 
> 

Applied, thanks!

[1/1] block: aoe: use DEFINE_SHOW_ATTRIBUTE to simplify aoe_debugfs
      commit: 8ef859995dbcc5bdc4b0707c9130e130f53c1b08

Best regards,
-- 
Jens Axboe


