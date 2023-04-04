Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0935AC6FD1D
	for <linux-block@archiver.kernel.org>; Tue,  4 Apr 2023 22:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjDDWL7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Apr 2023 18:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236122AbjDDWL7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 18:11:59 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EFBEE
        for <linux-block@vger.kernel.org>; Tue,  4 Apr 2023 15:11:56 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso35383989pjb.3
        for <linux-block@vger.kernel.org>; Tue, 04 Apr 2023 15:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680646316;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbWVsPRbHIBbR9kLT5KB4TeQj8+SBqxBKles1oDkc8g=;
        b=uLaj7C8i2eFHo6crqyq/FCi7oeK2GfLWiYV/YHPQJr78WD73Ud28Bh1ykW0SYkLHKI
         MyrVvUxXkCTnjjXkiWguvTt3jcVcS/FU1WBeDxg22fnh6eQH8+SJgi8X0XtfsHIR5PGN
         injOE93KEfB+JpEf5tf9oT3+gWRVrY2u/IadEdfbS7E6m1/JxwRZBmC6hPmm0T01b2HD
         eb7UAMp9kEGSL6IKhkiTyQ1sIel/JKaQSq9W/LQYdtNy3c/PY7JGRqiLZ3+4rIUU+U9V
         PXIIPTCw8O8d/4yazEHYJGGDnzmkqZAjQ/wRrpacszqc9vi/2VFH17BbdKW8SiNwUNWP
         G1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680646316;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbWVsPRbHIBbR9kLT5KB4TeQj8+SBqxBKles1oDkc8g=;
        b=JLu/lXNRVgXXg30d0cS8a83INjh8fbpnfsWDVcqCd23DDbiRdIVfvfSC+LvvZ/jIYN
         Ucg3Z0S313U3PMeKh5ilVfOYvIWwpkmxNzDeEDZwMlvGjDmjsruO9rdQIfB5Bkmw+d0s
         B6UDd6FSFyECfv5am1CIP/xvO03LkuZMZuUQHi8X/o6l6z7NFptrqJb/h9ckM731cDjq
         mNEuUT5249AW9w71nWFt9iSQPs3tMGlDaESNRmtmfLRbxFBOH/n5b4hP+9EeT27JAI6K
         8NAlh88FgVHluFV/32ZpRl/UDZwBMcK4titceEhcrVXKBZk5gH4cOsnCPnJJE3OsPxrE
         uFlQ==
X-Gm-Message-State: AAQBX9euAB2dIWc5ywNLw5ZITdGtgcDrv6q40Vl0F7+AAoVT5xiV58o2
        OmWplOIP1Sm1TGtfFiKmhfBOfng87n89m9S9kpZc3w==
X-Google-Smtp-Source: AKy350aP/w7A+A+vnnvzdmbiQSqefdgL7bgYMkWOxu1R/yhPR7Ph+KKypm4ZiAYLhbsuNl4m2oIzdg==
X-Received: by 2002:a05:6a20:9383:b0:da:4b41:8606 with SMTP id x3-20020a056a20938300b000da4b418606mr4514868pzh.5.1680646316056;
        Tue, 04 Apr 2023 15:11:56 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 9-20020aa79149000000b0062dd28aaca6sm9157370pfi.212.2023.04.04.15.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 15:11:55 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Keith Busch <kbusch@meta.com>
Cc:     Keith Busch <kbusch@kernel.org>, stable@kernel.org,
        Martin Belanger <Martin.Belanger@dell.com>,
        Daniel Wagner <dwagner@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
In-Reply-To: <20230331180056.1155862-1-kbusch@meta.com>
References: <20230331180056.1155862-1-kbusch@meta.com>
Subject: Re: [PATCHv2] blk-mq: directly poll requests
Message-Id: <168064631491.88378.6153219751322337145.b4-ty@kernel.dk>
Date:   Tue, 04 Apr 2023 16:11:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 31 Mar 2023 11:00:56 -0700, Keith Busch wrote:
> Polling needs a bio with a valid bi_bdev, but neither of those are
> guaranteed for polled driver requests. Make request based polling
> directly use blk-mq's polling function instead.
> 
> When executing a request from a polled hctx, we know the request's
> cookie, and that it's from a live blk-mq queue that supports polling, so
> we can safely skip everything that bio_poll provides.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: directly poll requests
      commit: 38a8c4d1d45006841f0643f4cb29b5e50758837c

Best regards,
-- 
Jens Axboe



