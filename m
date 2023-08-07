Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33286C001DB
	for <linux-block@archiver.kernel.org>; Mon,  7 Aug 2023 18:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjHGSfu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Aug 2023 14:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjHGSft (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Aug 2023 14:35:49 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75AF171A;
        Mon,  7 Aug 2023 11:35:47 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68706b39c4cso3320936b3a.2;
        Mon, 07 Aug 2023 11:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691433347; x=1692038147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qYdZSCc+lWFBEoy0MsLkmlOcN3Ycl5yGhNiUGh+G3Wo=;
        b=rwMceHVWVF5yq5k8dNRbisgosp+Igjm7t0GEEF1JJS/4hwQw32zeTPFw6XITuBWr98
         ObV4C6LocfpPueJjDJi1CAPFhnNcWRrcFlH+Sq29Lgi3OZsMGuzj748EAqBbpwyOpLjL
         2Dj6qUOZA+WWtbQSzqhm3aPPPz1z5y2+sPEhPQnT3W++90swT/W/gdzjfAWuyM+SXNOH
         6s+PGjfWvoAokH/fYDnOhJ7hyTMzuQ/47pqwySFFp5Dn0xZXpwoaLWuWgQ8DZ0xw5Lo/
         nnSjk+JVoeLDWdbbPnuOz41Yps+Sh8Tky12/wiLLOcrn+zlZnE7TT1zuQDqkm3DKRNfs
         R1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691433347; x=1692038147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYdZSCc+lWFBEoy0MsLkmlOcN3Ycl5yGhNiUGh+G3Wo=;
        b=QrVe5yygLb1ExBiScb2FJW0qrF+cepd44qu9HDTiPq3ED/Vbp1/wcitSnbdwyUF9nC
         gbIrp7m+l0Z5pFwXlM+7KU1oFBI4YTWhRyHB35Mg0rgHqvvdctWvv+sMo7m22E+SUooJ
         5hZZpux8j4cKr6VhqnFqmkGxZvQw6jtpQd0WmO85qYeqTjtejAD15ceQ2EjI/a8HZPlj
         Vlx/tx7CaIsUc6BNKAzoruukNl3t/s5GKC83UlPrDo4d9+9Bt6QZy0wId2/uBU4iUqog
         a0E/t0t4ultvP7u/vrikw0e7sCx4x+Y4ANKCFnFYudzwrLjNwK0spzx8bwtOvPTxYJpH
         i61A==
X-Gm-Message-State: AOJu0Yx3NZ1x3vD/9BDqGjyeCJsJ5bBBepi37WI4TYDI9qqx825ixM8X
        u502y5cpgjfNV6532UKiw4+Ykt9Swzk=
X-Google-Smtp-Source: AGHT+IGOEGDWDV7CWoHsarKUk08ylKf/FZAlKkW7egrTm9P6KvMiTEz/5yNa79rTe2CNAEBCAqccyA==
X-Received: by 2002:aa7:88c9:0:b0:687:35ab:d21f with SMTP id k9-20020aa788c9000000b0068735abd21fmr10691894pff.22.1691433347044;
        Mon, 07 Aug 2023 11:35:47 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9d5d])
        by smtp.gmail.com with ESMTPSA id u2-20020aa78482000000b00666b3706be6sm6473621pfn.107.2023.08.07.11.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 11:35:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 7 Aug 2023 08:35:45 -1000
From:   Tejun Heo <tj@kernel.org>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
Subject: Re: [PATCH] blk-iocost: fix queue stats accounting
Message-ID: <ZNE5gcu1oWVAxps6@slm.duckdns.org>
References: <20230804070609.31623-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804070609.31623-1-chengming.zhou@linux.dev>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 04, 2023 at 03:06:09PM +0800, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The q->stats->accounting is not only used by iocost, but iocost only
> increase this counter, never decrease it. So queue stats accounting
> will always enabled after using iocost once.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
