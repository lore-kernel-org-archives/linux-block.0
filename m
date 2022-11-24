Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E245C4332F
	for <linux-block@archiver.kernel.org>; Thu, 24 Nov 2022 03:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiKXDho (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Nov 2022 22:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiKXDhk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 22:37:40 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C456CD29A3
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 19:37:22 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id v3so537302pgh.4
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 19:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRcLwcLl9eQ9YiyNd5LQ3qwq83R+bkVF3DjeRvpyvcg=;
        b=xFHTz5IuJnw7zIw6wxSSmED5C+IGtRGCe2v5ccHjcCE5Aktf/5W1hzlloMxdT0Le1o
         z002aRLSkKvLxFsOHsHBwzmlbBe+GMixQMCltrjT9S8KJQlJXYpPelG8ke4KqUN934oT
         2hrsmZg53rSNO9/MkC0zpupWDBu4Lapf9cH9KphYpUI+piCx2wo3GT55foJqUbg7t3SR
         1TNnkQGQ390/ZHS7WVDM8l6zlwzopTwosQxeo/tt0Gm6JwGM/z4j5zGOV8EqGvi48f/m
         wCsfQrZ+N4ONc6+rGMWgAkAdkxFelvenlddU+9+aezD+c8bXmyo5aiHnrRmQZyXeuAoY
         Capw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRcLwcLl9eQ9YiyNd5LQ3qwq83R+bkVF3DjeRvpyvcg=;
        b=bqZxXF3iskgNCJNTghJRDmN6DojS00JyX6uotq3mK4zc76/RM4gADZSIGW0iH28fPq
         LPtcwAVMz76thX5cWzXmTf79XXAl0dph9ix8U4vFljBZiH6CMKXssI1i8MOjKwhRpz/y
         8s0pS8dldIH/T52tJkMKrwW0oMl+hZzMuNDZ+I2HZ89EXTrQC0cOjI/Ges/vfQyyT12Y
         k4/FSEJ1eAGdSQcs/qM7zUedfu6b3SxlXdwoiyDPSqsYJlEUVh3y14cJV74YZmzB5cic
         NlIOILSxQzMdpm7WaO0UVek7O4nM3UmeZVru//JmNe9cgYohk8X55YJViXoGXHXvV0Z9
         n+cA==
X-Gm-Message-State: ANoB5plTMfnqg+Ks9nLpHCfMKIQbHnnd4drSYIjWidf5/bHowFLXpEiW
        E25Q2MlkORU6tr3Wl1JGKULshg==
X-Google-Smtp-Source: AA0mqf4QTtHDmNKLBHGPLAMbaaRLhnYRVs13SZ5yADDQEaNMw3feHHnGy/KF0lItAA3306ARtt4sdA==
X-Received: by 2002:a63:db0a:0:b0:477:cc21:5766 with SMTP id e10-20020a63db0a000000b00477cc215766mr1753322pgg.524.1669261042093;
        Wed, 23 Nov 2022 19:37:22 -0800 (PST)
Received: from [127.0.0.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090a630300b0021870b2c7absm117688pjj.42.2022.11.23.19.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 19:37:21 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Andreas Hindborg <andreas.hindborg@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-block@vger.kernel.org
In-Reply-To: <20221121155645.396272-1-ming.lei@redhat.com>
References: <20221121155645.396272-1-ming.lei@redhat.com>
Subject: Re: [PATCH] ublk_drv: don't forward io commands in reserve order
Message-Id: <166926104058.22149.9267289540283878085.b4-ty@kernel.dk>
Date:   Wed, 23 Nov 2022 20:37:20 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-28747
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 21 Nov 2022 23:56:45 +0800, Ming Lei wrote:
> Either ublk_can_use_task_work() is true or not, io commands are
> forwarded to ublk server in reverse order, since llist_add() is
> always to add one element to the head of the list.
> 
> Even though block layer doesn't guarantee request dispatch order,
> requests should be sent to hardware in the sequence order generated
> from io scheduler, which usually considers the request's LBA, and
> order is often important for HDD.
> 
> [...]

Applied, thanks!

[1/1] ublk_drv: don't forward io commands in reserve order
      commit: 7d4a93176e0142ce16d23c849a47d5b00b856296

Best regards,
-- 
Jens Axboe


