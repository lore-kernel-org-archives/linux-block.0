Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967F1C677F1
	for <linux-block@archiver.kernel.org>; Mon, 16 Jan 2023 16:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjAPQCp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Jan 2023 11:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjAPQBu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2023 11:01:50 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AF823862
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 08:01:40 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id q5so3338752pjh.1
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 08:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOJn3wS3KaLs6GJKewX/FweGyqsXLb3UQ+ewziaYEJY=;
        b=d1AK46xwVySZG1F1Beno0yDzk6pEnXEU4sGRTGUufps5MeM0PmeiUi/wONItGnX4fo
         wz6UkoFvm8V0u+vJo3Z7YCrC9JGiBS1hq6JdUMRm82hhR4aHJ9+63kS+7eu+/Wzd3gon
         kGKFbcGhi6orgz4uZqfDsXh7vLezmHiBbvW3YDLvrVAm5V6RL10BoBGqQQtH6oZlBWRD
         hCbCovAgfWe6a1dXbwPKhNYcieBlF7Yd9bOAYAedfp/1ufWbe3mLZAt4Y6h6275JezXd
         PWI3iQbjL54I0hEmanUx1WuL4w1kZVBeW4dtNiHQGMHsS33KUxhCqVt0NB9W+Ffoso7f
         qvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tOJn3wS3KaLs6GJKewX/FweGyqsXLb3UQ+ewziaYEJY=;
        b=jnJlclQIR1dACEA/Qt1kchJrsU5VMgQ8BVKdaDBjQKoF9sbRbShdkfyDH6i10az3Tz
         A85FJ19VBYJBnFME2a0K8dbjqGQP35rwVlQg9uitG2A+z48+Fb1zkEgD5JPcIAMTz1kB
         kkHaLIBgngm3aItZQGt8kvPiVQhLePKWujK+HrFdRy/mepBGpOgJUCwAC/Ix5QAxKsbP
         5SvTEBjnVvt8beDPZH2SOdF2zsNBiCBgBEeQjxjuLBH/wZ+Hg9xbrSaQNIbukSSxKO6C
         ILbN3zkKnZ2LQwz947aahLkwR2IZHLgjbbmD72/15Q/aAGB9zckGiYqZRku1TQm57baq
         ro4w==
X-Gm-Message-State: AFqh2koXxV5mWnlB7d6xSJvNJeTK88AntrHcIw70LO5r3LGVUvMvlQnO
        4vThz3DeozBqMslo/iEROzkIh5Mc6KmOqdV/
X-Google-Smtp-Source: AMrXdXsVvVmKK8LKCEsmktI9PnRqjHnFt3w+3tMeoZcmzZOzaEpqbg6IhF/CCsVMZATp/tHMb/eHKA==
X-Received: by 2002:a17:902:8c87:b0:194:6979:7f2e with SMTP id t7-20020a1709028c8700b0019469797f2emr85005plo.0.1673884899298;
        Mon, 16 Jan 2023 08:01:39 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k7-20020a170902ce0700b001885d15e3c1sm19525162plg.26.2023.01.16.08.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 08:01:38 -0800 (PST)
Message-ID: <c5631d66-3627-5d04-c810-c060c9fd7077@kernel.dk>
Date:   Mon, 16 Jan 2023 09:01:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: don't allow multiple bios for IOCB_NOWAIT issue
Cc:     Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we're doing a large IO request which needs to be split into multiple
bios for issue, then we can run into the same situation as the below
marked commit fixes - parts will complete just fine, one or more parts
will fail to allocate a request. This will result in a partially
completed read or write request, where the caller gets EAGAIN even though
parts of the IO completed just fine.

Do the same for large bios as we do for splits - fail a NOWAIT request
with EAGAIN. This isn't technically fixing an issue in the below marked
patch, but for stable purposes, we should have either none of them or
both.

This depends on: 613b14884b85 ("block: handle bio_split_to_limits() NULL return")

Cc: stable@vger.kernel.org # 5.15+
Fixes: 9cea62b2cbab ("block: don't allow splitting of a REQ_NOWAIT bio")
Link: https://github.com/axboe/liburing/issues/766
Reported-and-tested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/fops.c b/block/fops.c
index 50d245e8c913..a03cb732c2a7 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -368,6 +368,14 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 			return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
 		return __blkdev_direct_IO_async(iocb, iter, nr_pages);
 	}
+	/*
+	 * We're doing more than a bio worth of IO (> 256 pages), and we
+	 * cannot guarantee that one of the sub bios will not fail getting
+	 * issued FOR NOWAIT as error results are coalesced across all of
+	 * them. Be safe and ask for a retry of this from blocking context.
+	 */
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		return -EAGAIN;
 	return __blkdev_direct_IO(iocb, iter, bio_max_segs(nr_pages));
 }
 
-- 
Jens Axboe

