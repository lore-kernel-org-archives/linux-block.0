Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7CDC433EF
	for <linux-block@archiver.kernel.org>; Tue,  3 May 2022 20:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbiECUGl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 May 2022 16:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiECUGk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 May 2022 16:06:40 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271C1403C6
        for <linux-block@vger.kernel.org>; Tue,  3 May 2022 13:03:07 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso3260392pjb.1
        for <linux-block@vger.kernel.org>; Tue, 03 May 2022 13:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Gyo7p1AtxXy3OgpPnsjbR9TlbxDuPZSB+of7dHJ2RMo=;
        b=3pX2qCinYh2eo9o/rkSsVGt01ooT/iXFPmfOkwtsldcQvJz24MxqHnl/Hr8ltkxC3h
         X/wRgfvMCJOnbRzuEhbVwp/pqK83sM+K4K8ftd4NwvrS5TaigDDGmHrrwm1VM7/SdiBs
         6Z2sFKQm6h34JWOMOIxuNaoUWXigNiXhWrhooOAUAwUZhevhXhVLeJz3aDPCY06vPUJn
         WPH5OrTg675AnBBNAH5MtUsjSPh850UCznU0JmhjhgXiYR2T/Os6CltUPRkbEh8KnKwO
         Zcqwn7kjOrhCWqj0sLXbZc2wf4dGZon3NRS0fSMtFgfJ6LaS2xTr4XqUF/+wolRtkYuP
         wNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Gyo7p1AtxXy3OgpPnsjbR9TlbxDuPZSB+of7dHJ2RMo=;
        b=4ZtiQFaNwWOBkJ/qv6P6uLybcIbLZQIuHWw51ou+aY/Ktt+uT4Quid8PX5xIYV/Fl/
         RtVQawRxzRyW5BhsiREaS+IA8ZO7Ww2w2F0/L259hAufMCcS1y18Dfe1xahF38DN4vuB
         iZqKjMVH5/n1AEwHxYW5LvGIVVIQJ4XiQz0PBRyNvk971vovEIB+17H25AE8Jr8QSkCX
         ztgi/YpNuSrRy1hgcqdIAhqD+ATdgKtQue/X2DcVyt26+US/NICbty6we41nLBJ3WQx7
         xHzlqeHWhrM/IMamAF2MrnSlr3/7KNjS+JYfLz11hYk/XCnCzKZZ9Kf5uNDjinhBSZ8o
         t/sQ==
X-Gm-Message-State: AOAM533SR5N1x60tRv5ampM6c3gs1nCXuz/R2j933ldfmmrzs43R3JgQ
        aJgdakdKpDCL54xwkmJ8mNydkpZkCHIXfw==
X-Google-Smtp-Source: ABdhPJzhEnDltRxihueKjH6BGUMUATPCpDAcRxxF/TAOCMFUs+vBqrdjFNnGfhodyRqF7ET5EGFTng==
X-Received: by 2002:a17:902:ea46:b0:15d:dbc:34f2 with SMTP id r6-20020a170902ea4600b0015d0dbc34f2mr17793422plg.60.1651608186591;
        Tue, 03 May 2022 13:03:06 -0700 (PDT)
Received: from [127.0.1.1] ([8.34.116.185])
        by smtp.gmail.com with ESMTPSA id g20-20020aa78194000000b0050dc762818fsm6727619pfi.105.2022.05.03.13.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 13:03:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, damien.lemoal@opensource.wdc.com
Cc:     josef@toxicpanda.com
In-Reply-To: <20220420005718.3780004-1-damien.lemoal@opensource.wdc.com>
References: <20220420005718.3780004-1-damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v2 0/4] null_blk cleanup and device naming improvements
Message-Id: <165160818579.3632.8221777293051469775.b4-ty@kernel.dk>
Date:   Tue, 03 May 2022 14:03:05 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 20 Apr 2022 09:57:14 +0900, Damien Le Moal wrote:
> The first 3 patches of this series are simple code cleanups.
> 
> The last patch changes the device naming scheme for devices created
> through configfs: the configfs device directory name is used as the disk
> name. This name is also checked against potentially exiting nullb
> devices created during modprobe when the nr_device module option is not
> 0.
> 
> [...]

Applied, thanks!

[1/4] block: null_blk: Fix code style issues
      commit: 8ea7b68edc5fd7b257759fa8588f7f8b57fedd51
[2/4] block: null_blk: Cleanup device creation and deletion
      commit: 2fdd541e4c7288f09077842654adc925b81ec620
[3/4] block: null_blk: Cleanup messages
      commit: 12e995654f2ef62dad1205629a3cd3c2d7cd405b
[4/4] block: null_blk: Improve device creation with configfs
      commit: 9986ac16c508d613b371a902a0c53b22bac195ee

Best regards,
-- 
Jens Axboe


