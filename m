Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC23C433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Jul 2022 23:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237658AbiGYXB4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jul 2022 19:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237652AbiGYXB4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jul 2022 19:01:56 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94514248EB
        for <linux-block@vger.kernel.org>; Mon, 25 Jul 2022 16:01:53 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id q41-20020a17090a1b2c00b001f2043c727aso11603907pjq.1
        for <linux-block@vger.kernel.org>; Mon, 25 Jul 2022 16:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=46K29R/jzyxgb2qSaTV9iMS7TQPCalfZVfhX2Tr92gY=;
        b=CIaHQMCs5XgyB1WYNkmfhOi7jd/IYdCWke0DlBatUWbzMxBkNArtPdRWi90eBcE7ZU
         0A3WCdfrALjJymKpX2+4qoQPsEBAFPScYl1wc3JX/2inncWIeim2M9vQfGq/mSMmsR4s
         4VBdu25E76ZR5QBIY56alMfW32wkuhV7upB2bR8mxKHr6Om2UIS3PXjlqPW63w/rVrgj
         ECwWTQwLuY0vRiUOYwiL5eMXB7GocuUkYUrhIVS2s6x+jKgqV5Spct4v/TMT7T11BLHs
         G2zR8WjA5GdOWE1f6z3j6uX+rfC8aILXhoEf+C5M1y48Tk/Gsod7vXBNUuaq3MNF/8aT
         Nlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=46K29R/jzyxgb2qSaTV9iMS7TQPCalfZVfhX2Tr92gY=;
        b=Qoqin/QuNEMLXWeobF42ocYQ1N7ETMcSP0V29tr4FpstRrlX04l/Y1d4TvTE7HMP2a
         X7UNo9bdvSOwOmfrXzVZZxWj3zO78of3V/fdUCqfLj9rbAHRKG9ItjTwZc2aj7ltkZsz
         NuGd0t3up2uog9pyFmnyxaGqo78G+2VeoIZHYIDbfbA5M0CaJKvWfZFpjQrWpWHFnfLR
         iCW/7v3rSgh4HLHGgfyZIEdjR3A4qS2ZNbcLP27tQJa6wqatojc+RtDaKjOkEWy2YyJz
         LZTXwvDVRSnG8FgDRF3rMep061JfYUmkJZg4Ahke4OnzHTJAwVt1/AltRQpInSFqWhIr
         BZzg==
X-Gm-Message-State: AJIora/zO/SzFn35AgSE5zt2oVOhnhGSSRGYagkT0HEjzstPNJaksb95
        gXh9jhjfSQbMgukDs8hizBVmxA==
X-Google-Smtp-Source: AGRyM1sBYRQJfc/HWpmo8/5mg+wOFnvP9N5PLTvA5O8z4Xakspc4+PQVo+SumV5LXkcdWrBeMwfdQQ==
X-Received: by 2002:a17:902:778c:b0:16d:9d4d:51f9 with SMTP id o12-20020a170902778c00b0016d9d4d51f9mr498919pll.19.1658790113013;
        Mon, 25 Jul 2022 16:01:53 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902e88300b0016d2f0b67e0sm9648333plg.309.2022.07.25.16.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 16:01:52 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     houtao1@huawei.com, yukuai1@huaweicloud.com, josef@toxicpanda.com,
        yukuai3@huawei.com, joe@perches.com
Cc:     nbd@other.debian.org, yi.zhang@huawei.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20220723082427.3890655-1-yukuai1@huaweicloud.com>
References: <20220723082427.3890655-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v2] nbd: add missing definition of pr_fmt
Message-Id: <165879011117.1265523.8426782568331317022.b4-ty@kernel.dk>
Date:   Mon, 25 Jul 2022 17:01:51 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 23 Jul 2022 16:24:27 +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> commit 1243172d5894 ("nbd: use pr_err to output error message") tries
> to define pr_fmt and use short pr_err() to output error message,
> however, the definition is missed.
> 
> This patch also remove existing "nbd:" inside pr_err().
> 
> [...]

Applied, thanks!

[1/1] nbd: add missing definition of pr_fmt
      commit: b182198426ac3130f3543b1ad67855a84c4c5af2

Best regards,
-- 
Jens Axboe


