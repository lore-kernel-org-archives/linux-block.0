Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E98EC678D4
	for <linux-block@archiver.kernel.org>; Fri,  3 Mar 2023 04:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjCCEAt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Mar 2023 23:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCCEAs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2023 23:00:48 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A7930EB5
        for <linux-block@vger.kernel.org>; Thu,  2 Mar 2023 20:00:47 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so1070275pjz.1
        for <linux-block@vger.kernel.org>; Thu, 02 Mar 2023 20:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1677816047;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VO74g2mNwHzYzU/yV1CgDrAplD3wm5JXJvrOGFj1g+g=;
        b=Q0HB6OhEUr/Ky/FMXyw9StC+oN+s1rWS3xgRvmCnXM0u/BFQakixnYF7Bj28gwKJgn
         oFl9Ov3u7xyynlDVXgDbDnz6tiUrQtzgHLf2idOLJn81cNKeDaxA9aDArLBeiP9SCgQx
         Ctk9xKat1JjCfVf3mb7Z756+x8n/6fqZDOfgUgyw57dvoNgvKXeJtTLG+o8zSmvviKpg
         Y4c3x498wQkTAdgBQ4c/fnKz7GqWBUvpDI3pdGwLkajwdPRxMjx+NAD021ZrUf2tJXP0
         sZA9Z2rMkUEl9UsrI/DmxN6mgt3Wb77iJlwhngcTfZn+oS9Wu6onpRxy7Fe5WQZvg6gQ
         t8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677816047;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VO74g2mNwHzYzU/yV1CgDrAplD3wm5JXJvrOGFj1g+g=;
        b=i/nLMutmxJFauXWaj+EVbqBwq5hX+HfIFDo2I67xEirxM1QZSdnTSUCwQzbsyzmhS9
         ySNJm+A4+MKDwNe2zrW9cc7xcjQpxwGS7TiQM+hpUKb7scsKVMccoDyVtqER2j0ynxwn
         RWzWnqCg/0LGQJRF3kQVbA2Jfaewh9v76ulcoqXvlh063aZnK8zgyCI+BIVCYloYVSGU
         7GYiv2kuCR2+o9+AFaKKPCjPaj9g6nnhD3C7REoR346ulFG/j/vkGODBn4K+26YNOoTs
         yHrlKnAZJaBVbGcy+MI+A0sJKmP2E+OuLQHxR3b7anBeRglwWdgwbIRVdSnXxAQGQE9V
         kj8Q==
X-Gm-Message-State: AO0yUKXsLUh6PmABR5wUIC8pmrZ1vcpakMTXb4Dd6zn6HdAV1GDdEUTA
        hgrBYXigL8ImXNmCNFmWKgUg1GF9QGNZzovv
X-Google-Smtp-Source: AK7set/uNWyGtRPehTwL47DKKom5XL9HpMg9zcRF+pvE9PUmTVBtVsOF2bq8/Jsgp1lT4Xv1v2+SPA==
X-Received: by 2002:a17:902:d4d0:b0:19a:8202:2dad with SMTP id o16-20020a170902d4d000b0019a82022dadmr776157plg.2.1677816046820;
        Thu, 02 Mar 2023 20:00:46 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b20-20020a170902d31400b0019a7363e752sm396753plc.276.2023.03.02.20.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 20:00:46 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        Uday Shankar <ushankar@purestorage.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20230301000655.48112-1-ushankar@purestorage.com>
References: <20230301000655.48112-1-ushankar@purestorage.com>
Subject: Re: [PATCH v3] blk-mq: enforce op-specific segment limits in
 blk_insert_cloned_request
Message-Id: <167781604577.209443.3783406495581654903.b4-ty@kernel.dk>
Date:   Thu, 02 Mar 2023 21:00:45 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ebd05
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 28 Feb 2023 17:06:55 -0700, Uday Shankar wrote:
> The block layer might merge together discard requests up until the
> max_discard_segments limit is hit, but blk_insert_cloned_request checks
> the segment count against max_segments regardless of the req op. This
> can result in errors like the following when discards are issued through
> a DM device and max_discard_segments exceeds max_segments for the queue
> of the chosen underlying device.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: enforce op-specific segment limits in blk_insert_cloned_request
      commit: 49d24398327e32265eccdeec4baeb5a6a609c0bd

Best regards,
-- 
Jens Axboe



