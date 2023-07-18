Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443BCEB64DD
	for <linux-block@archiver.kernel.org>; Tue, 18 Jul 2023 11:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjGRLvq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jul 2023 07:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjGRLvq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jul 2023 07:51:46 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852BA18D
        for <linux-block@vger.kernel.org>; Tue, 18 Jul 2023 04:51:45 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6b9d68a7abaso1461898a34.3
        for <linux-block@vger.kernel.org>; Tue, 18 Jul 2023 04:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689681105; x=1692273105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bt8R0yrtkT9HdCJnGP8rK8VrJeyWRFxqKQi//6Da7GE=;
        b=YJJ7K/0vmJz/f04xwiyuKk8kOag7W4TZdVLfbvYI5skR6c9qDRXJf3IBzhvfNdTKpG
         QDOG9ERkhsPmY7HObV4nRjWRAs5JHSN0IH9jujsPACREffEOySDcNeJB9c6vgHKTNBNC
         pYlCYG6LLBBectUmpi+AiEP4U68mTQDH2bZkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689681105; x=1692273105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bt8R0yrtkT9HdCJnGP8rK8VrJeyWRFxqKQi//6Da7GE=;
        b=FGON0pvzIA/jtnSx1mrPhOnETgQiWqvxIq1Zp/7pxcIJ4x+ANsA2cUKpgimginSDeu
         XnBbxNGACX1Q9uHsMVGHKB/uX8pB1DWcLKJZhyZ4VcW37yB19tVAnyt10/2EMENlpIZD
         64cmCMgaFoupUIntJ+U0Azk5Ru6fPaJKwybmcChO32nkYUmkCuIYjEIE5LcTrnJ2GG8k
         pRYL8ADYy1ydeQ9j4+liJSwnF61dOr0oiElN54OQgfRRerY/fCcU48A6qS+9G2s9C9/R
         juTReoCw+a/relchwICO5h9YM/khYZs/n7+mZnakMXeSyONcVtQ0OAFvC8PNTrY48Q66
         uGxA==
X-Gm-Message-State: ABy/qLYq4ukly+4EzombCGqBmkPUoQSj1ugvig8E2MmgcdAIMyBHP//U
        rfcGel+OYo2ykawHhmBbvBpV9w==
X-Google-Smtp-Source: APBJJlGSwNzDZ/D1eNN/xuYf2/U12n4u2seCb7p9PhhFw0d5UTDFarbRz1lof9iuLAPo5qBk1Cw1ig==
X-Received: by 2002:a05:6358:94a1:b0:131:46b:3953 with SMTP id i33-20020a05635894a100b00131046b3953mr12476851rwb.13.1689681104734;
        Tue, 18 Jul 2023 04:51:44 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id ck23-20020a17090afe1700b00263fd82106asm1258194pjb.35.2023.07.18.04.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 04:51:44 -0700 (PDT)
Date:   Tue, 18 Jul 2023 20:51:39 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Huanpeng Xin <xinhuanpeng9@gmail.com>
Cc:     minchan@kernel.org, ngupta@vflare.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        xinhuanpeng <xinhuanpeng@xiaomi.com>,
        Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] zram: set zram bio priority to REQ_PRIO.
Message-ID: <20230718115139.GC57770@google.com>
References: <20230718071154.21566-1-xinhuanpeng9@gmail.com>
 <20230718074929.GD955071@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718074929.GD955071@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/07/18 16:49), Sergey Senozhatsky wrote:
> On (23/07/18 15:11), Huanpeng Xin wrote:
> > 
> > When the system memory pressure is high, set zram bio priority
> > to REQ_PRIO can quickly swap zarm's memory to backing device,
> > freeing up more space for zram.


This is not how zram writeback works. The only time you can be sure
that writeback frees memory is when you writeback ZRAM_HUGE objects,
because each such object uses a whole physical page on the zsmalloc
side. In any other case, compressed objects share physical pages that
zsmalloc pages consist of, so writeback simply punches wholes in zspages,
without actually freeing any memory immediately. You either need zspages
to becomes empty after writeback or pool compaction, otherwise writeback
does not save any memory, no matter how fast it works.
