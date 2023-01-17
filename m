Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B5CC6379F
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 17:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbjAQRX0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbjAQRWo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 12:22:44 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C514995E
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 09:22:13 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id v6so6182962ilq.3
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 09:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=234+MD27vmhgqQsVMsLRlUDYdnzacqLjy74bkan3xpU=;
        b=Tb4c/RUWZKB70Q11NjDcKTz0RMnDz0uqu7nlIwfUPQq/AMHwLUsmiBx0SPpnFAS9oy
         UGILu6gNqWY/5g61hq7dDHBPrzELCr5QHjSh4fIKDbE3Y4QQp9qIR3zV5jSwAkUGWshJ
         csIvrVrfj+vo6rPM+e2QT0e7YKFL+2Me33tm6nNVdCINa2Qdo5+rSGxiAB973tUuZulf
         r8fOdvXuqRFo6Dtt90YF4hirclBQg2YE19wYd/wdktffardYAb27TueS84HaHp5TeY6r
         Ra/33VCVPTBw9E4Q5o5qGv88rhu3x0IiEIuih8h2aftuNazmzwdrHPDHE/FaDNXfWLbx
         1Nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=234+MD27vmhgqQsVMsLRlUDYdnzacqLjy74bkan3xpU=;
        b=vEWk2toWEhHlwZTMp9LE+tUoP+pNUvl6mpX7Wsm3ib4qVGdPkZKSWgCMmhH9fFShhb
         t1o8e5dr80nwcBj2/AymqetJjoJPhzmNPl5Scvyy1/McY/lPcDtIBsuEziuOwMwgIPvv
         6Svp/k29K9js9cIIyG+v5QydyHDuWkymBilvc+ZADhlV+Qirr387LRYDVCGEktOY166M
         HPl3eRHPPC1ttmULYyN6NkDbV1a9tGKS+1myUTFkFX3sR8VDaBWaJlOFtaNjQ97qojzL
         +wXrbQyJT+3PGoTRUqofNIh43NEBBacQjbAYv6FCqaljitE4AbIHJVZmzeGtw3cxOzTq
         5LWQ==
X-Gm-Message-State: AFqh2koq1mT68FCxx/1g7r9JeoCwl7Wd6sH4ihu4Loisi7EbxXuQ/QyX
        sra1z1NRwGwNF/lSkELn83PTAA==
X-Google-Smtp-Source: AMrXdXuP0gTSiYL33O17ZkpmhX60gHFIXB5GHQo9xSTua27n0geU/0UscZ0NFmdhXudkM9fzhn4zSg==
X-Received: by 2002:a92:d6cd:0:b0:30e:cd95:c25b with SMTP id z13-20020a92d6cd000000b0030ecd95c25bmr617069ilp.0.1673976132612;
        Tue, 17 Jan 2023 09:22:12 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z68-20020a0293ca000000b0039e784a32b3sm9006010jah.88.2023.01.17.09.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:22:12 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <80d4511011d7d4751b4cf6375c4e38f237d935e3.1673955390.git.asml.silence@gmail.com>
References: <80d4511011d7d4751b4cf6375c4e38f237d935e3.1673955390.git.asml.silence@gmail.com>
Subject: Re: [PATCH for-next] block: fix hctx checks for batch allocation
Message-Id: <167397613212.16764.278326761461874055.b4-ty@kernel.dk>
Date:   Tue, 17 Jan 2023 10:22:12 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-78c63
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 17 Jan 2023 11:42:15 +0000, Pavel Begunkov wrote:
> When there are no read queues read requests will be assigned a
> default queue on allocation. However, blk_mq_get_cached_request() is not
> prepared for that and will fail all attempts to grab read requests from
> the cache. Worst case it doubles the number of requests allocated,
> roughly half of which will be returned by blk_mq_free_plug_rqs().
> 
> It only affects batched allocations and so is io_uring specific.
> For reference, QD8 t/io_uring benchmark improves by 20-35%.
> 
> [...]

Applied, thanks!

[1/1] block: fix hctx checks for batch allocation
      (no commit info)

Best regards,
-- 
Jens Axboe



