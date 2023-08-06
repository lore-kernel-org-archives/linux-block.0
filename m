Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BB9C04A6A
	for <linux-block@archiver.kernel.org>; Sun,  6 Aug 2023 07:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjHFHQN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Aug 2023 03:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHFHQM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 Aug 2023 03:16:12 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CD31FD4
        for <linux-block@vger.kernel.org>; Sun,  6 Aug 2023 00:16:07 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bbf0f36ce4so22510635ad.0
        for <linux-block@vger.kernel.org>; Sun, 06 Aug 2023 00:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691306167; x=1691910967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f1cC44qcZYBIcGUfzoCdu9nx9KiNTrSbTmLs8T1S274=;
        b=Kd5pIGopqU5EnXakxalZyW2dhaMcCG0JQLJjdJbyY8/i5b/iAVZ6jacxFc/WBGw7TZ
         lNFxcdciTl/M7gTrFLHB+GRtlfq/ThS2fd8T5o3/p18HTpelyOOezVaATrbOeY9HRuAP
         mnviOjpeni7zbextffZd5mlV9tbYweMErJY+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691306167; x=1691910967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1cC44qcZYBIcGUfzoCdu9nx9KiNTrSbTmLs8T1S274=;
        b=ergR4dmxOPpjdn/ZvKK6UVNYKTG7oTbQWs81rOK6WyON05RlorU5jglYNf9NWLhJ3I
         OdIzLy2UNvKyhACOgYhulQ/9YUTEr2gVo4UjqYZa2vu+vLu3Mff6/HkZc6t1g4J3BQY3
         2YuGVcn7nsZqyhfVujiKPJbtbMjBHSzdwFV6EeiPdzSaeUANpnGArMGfgXMWoYXNnBYg
         1w0v5NjZfcRXdxNWJnz164/8Uv4sxIXoabp7AlawONmMyO3MK7JTaTPI0SMODWd3pr7k
         SyZk5I3wUJsyNlbeRsx7A/BlzhxQ8nqENzOQE58RIwI7ZLTp28Y4SsFBu2tE2vowzmhG
         2UcA==
X-Gm-Message-State: AOJu0Yz57XPhPw9SbfZfWTa7XwxOCK3CB6k5KgPrDynwz8OxlM/6g0qx
        R/WEf9GoceSSoJWXZi+PdBYvfA==
X-Google-Smtp-Source: AGHT+IFEHBJ4DDuyqM/dQDN0aPzndo/IuYpJsH4xff2mPzui4ao44kG2ICtjSio+J2LQT8pzDs7LaA==
X-Received: by 2002:a17:902:e74c:b0:1b6:6b90:7c2f with SMTP id p12-20020a170902e74c00b001b66b907c2fmr5879078plf.55.1691306166662;
        Sun, 06 Aug 2023 00:16:06 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id p17-20020a170902ead100b001b03a1a3151sm4492969pld.70.2023.08.06.00.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 00:16:06 -0700 (PDT)
Date:   Sun, 6 Aug 2023 16:16:01 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>, minchan@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dusty Mabe <dusty@dustymabe.com>
Subject: Re: [PATCH] zram: take device and not only bvec offset into account
Message-ID: <20230806071601.GB907732@google.com>
References: <20230805055537.147835-1-hch@lst.de>
 <20230805074645.GA907732@google.com>
 <20230805081306.GA29615@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805081306.GA29615@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/08/05 10:13), Christoph Hellwig wrote:
> On Sat, Aug 05, 2023 at 04:46:45PM +0900, Sergey Senozhatsky wrote:
> > > Fixes: af8b04c63708 ("zram: simplify bvec iteration in __zram_make_request")
> > > Reported-by: Dusty Mabe <dusty@dustymabe.com>
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> Btw, are there any interesting test suites you want me to run on
> a > 4K page size system now that I do have this setup available?

I don't really have any special tests. I used to run fio, but switched
to a shell script that:

1) configures zram0 and adds zram1 as writeback
2) mkfs.ext4 on zram0, cp linux tar.gz, compile (in parallel)
3) deferred recompress (idle and size based)
4) idle writeback
5) re-reads all writtenback pages

I test on a system with 4K pages, tho, I probably need to get an image
with larger PAGE_SIZE.
