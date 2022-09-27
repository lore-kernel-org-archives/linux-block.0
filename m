Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47AEC54EE9
	for <linux-block@archiver.kernel.org>; Tue, 27 Sep 2022 15:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiI0P7V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Sep 2022 11:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiI0P7S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2022 11:59:18 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD9A1B95DA
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 08:59:18 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id 138so8073834iou.9
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 08:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=0BSobskebz2JWZUVzlUk/kAq3/1UmnXxEYTK5P+Oz+c=;
        b=NK1Syfl1IQIt1lqSrpHTasA+YS/1Up5DOP62KLYgDw7XQsCwh9LlsBsK4DP5FYMAGl
         Ejxp7bCQbyLA8FIGNbR0W18inORbclFSHe6J4TkfMPdDD+XIcCVizSj5q52SKTg89s/k
         W6ALMIPaVyTYZrmVQeOJ6RD27RNvTX3dU+WEUV7Vu9PLm+Fw9RsWXo+pC/58m1eSzJKq
         NEOJLUizkKlFZS8A8s1oTIsHv8gn5WMENdSRSDBaWMreFy2BlkK92/yAZ70OJLm3vWu0
         VxtiNWwHDpb9RMQBJqRPYwIVl8IXw2Zo5FdtyTCPWBeAIUG/f76/yZLo6MiNy5Tq8uTq
         LXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0BSobskebz2JWZUVzlUk/kAq3/1UmnXxEYTK5P+Oz+c=;
        b=C4Ou/GvrW9zGh5ZbtvEAizMqp54AKuU4TBGhP9GfXw9/vbiENC/UDLzA70705xuVdR
         dL6zuhKjHyn+bVFzDuIFnmDH3kM3YxcOO9YFhLEdFRTie8Tcs12mYd2IBfqXD2NX6/31
         rA4Y9TYNwl/Zvvyw1yb+Id38BiS7YerxlBnx/lmVhQ7UzeD2v7aYm0jJL+twRbhSo8o2
         nlS4DiCmnhxnRPbsQQmeNPE07cWELupp7WvSSB1DuuKqqlh/+F0CQMpQWCQn8hNoZ2cT
         gnOGjA2gEYcrxaqLDsHF68XIK8NALKGk99C4qWKBSHeq9x5+VX+kNIGWKywo+pekBtgw
         YnBw==
X-Gm-Message-State: ACrzQf2qNl4EbeRRiWRVwca95rBdTMwKC6tMJfQD3ja1LuColgTrQWPz
        9QmhIxE30ePCHdQePE1nBIZe0A==
X-Google-Smtp-Source: AMsMyM5Ylu1N09RKtjwJD5z8Fviv5ebH8Oh5Fga5xEt9whldPVVhPyT8CJnsrLrufPu8TL+7M5EAjw==
X-Received: by 2002:a6b:3e8b:0:b0:6a0:cb10:e1f3 with SMTP id l133-20020a6b3e8b000000b006a0cb10e1f3mr12174010ioa.149.1664294357650;
        Tue, 27 Sep 2022 08:59:17 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y41-20020a02952c000000b0035672327fe5sm743760jah.149.2022.09.27.08.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:59:16 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Keith Busch <kbusch@fb.com>, linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Keith Busch <kbusch@kernel.org>
In-Reply-To: <20220927155652.3260724-1-kbusch@fb.com>
References: <20220927155652.3260724-1-kbusch@fb.com>
Subject: Re: [PATCHv2] blk-mq: use quiesced elevator switch when reinitializing queues
Message-Id: <166429435670.148580.12973845523376491573.b4-ty@kernel.dk>
Date:   Tue, 27 Sep 2022 09:59:16 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 27 Sep 2022 08:56:52 -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The hctx's run_work may be racing with the elevator switch when
> reinitializing hardware queues. The queue is merely frozen in this
> context, but that only prevents requests from allocating and doesn't
> stop the hctx work from running. The work may get an elevator pointer
> that's being torn down, and can result in use-after-free errors and
> kernel panics (example below). Use the quiesced elevator switch instead,
> and make the previous one static since it is now only used locally.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: use quiesced elevator switch when reinitializing queues
      commit: 8237c01f1696bc53c470493bf1fe092a107648a6

Best regards,
-- 
Jens Axboe


