Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C99C433E6
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 20:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F94C22581
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 20:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbhAYULC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jan 2021 15:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731933AbhAYUKm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 15:10:42 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DC7C061573
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 12:10:01 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id p15so274596pjv.3
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 12:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hs6xkNFn8iXNmTz5beP/yl02mudT0fhWHk/cGN74INE=;
        b=nPBMa1xpMkvcqkqdYF9GmJmpFQThaHp6WmtUVwVVZTluJKAt5lnIR53Eh1J1tgxMjg
         WPa7W+s2kjvlYJSe87uxXuGfb7BFQARkGKOu+brOF8Gvxj1FDGhNxghw1aNYduEC8dlv
         nlNSBV9acoSX75FM0m9lv2E7XxT+oiVd1CQ/qNZzCgHwYmhiWCYxzAIcFUE6UhNsXd6+
         YJBb0H8HQfMSyeXpWASvLvoyYse86z7itnmKdW0IikY4uWDtI1I7ok0S4ZZdyVRONPGW
         CE6rdf8127S07IE+zkIgE69uCjIaw3QJ2rENxT7CehwwRRxy4hTZI/DFsOLDKWl5cd/R
         HY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=hs6xkNFn8iXNmTz5beP/yl02mudT0fhWHk/cGN74INE=;
        b=nCytMY8X0vm70A6Kvbg57fNXaUHJFFSQqyhIspcCUDjEo7ikf5ErFl1afFMVTL7cPY
         2TvfcyhsoTxcV4i1VPwsyX+uUJ8Hg+flaB/Wk7gULy+uIZdLEiSrybk/N6UeZ2gll0VI
         ua6l/3naj7wt2XXBAJQW2kt98y7QkgWbJPaVraF15Hv4+md1fcSOPP7J5Eglp8OMQvvk
         CSszfFMgAKNfNPrLJ2besKmT5E2iu7AJ+OfLrQiYvxz6diJ/aJl7XC+X9WR2dUeBdJlU
         Xi6iANzzgwtfGZcrB8JgGmohBvzboo0EfrrLjlyIsJya/8N3h0r3CRDcCPXbfGQ4Keah
         3XqA==
X-Gm-Message-State: AOAM530ovOx8FXRwep1xJQp2FuRWPMAhG8jdRrwIT8vsmbXVa1LAiIqE
        qnKY2MJDxPInFMtucyoXHpB86y4xywU=
X-Google-Smtp-Source: ABdhPJw9xSeqfrhBYwR21dZ3r4Iv29Dax5VuyhGpr1qTYoiEc/cFAvZWMoWPNyFrYi7q+ZJEuuE09A==
X-Received: by 2002:a17:90a:d02:: with SMTP id t2mr1902695pja.130.1611605401365;
        Mon, 25 Jan 2021 12:10:01 -0800 (PST)
Received: from google.com ([2620:15c:211:201:e8b4:4688:79de:94f3])
        by smtp.gmail.com with ESMTPSA id b65sm18849015pga.54.2021.01.25.12.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 12:09:59 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 25 Jan 2021 12:09:57 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Tian Tao <tiantao6@hisilicon.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: fix NULL check before some freeing functions is
 not needed
Message-ID: <YA8llWm/iJkeULZ0@google.com>
References: <1611562381-14985-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611562381-14985-1-git-send-email-tiantao6@hisilicon.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 25, 2021 at 04:13:01PM +0800, Tian Tao wrote:
> fixed the below warning:
> /drivers/block/zram/zram_drv.c:534:2-8: WARNING: NULL check
> before some freeing functions is not needed.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Acked-by: Minchan Kim <minchan@kernel.org>

Thanks.
