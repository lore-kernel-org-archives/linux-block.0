Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D545C433FE
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 13:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235570AbiCVN3a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 09:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbiCVN33 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 09:29:29 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C472CCBA
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 06:28:00 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id gi14so2807633qvb.0
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 06:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F6f3afV4tqtncF73mZhO2dGGO3BMaajonDRieyQCctk=;
        b=Bkl2XAz6E8KGmYNmKGhq2KqHYHZulnIzry2lGn5C0jSspo+Oj1bGpBF7hRebnGm1ro
         gUxe+Z1iIWvYN+soEo1YYLxJG0AYb1JzTDdMxHFwPfhu0vJQahs6KAl0X7HZSZS+HGDZ
         RQDPlBS0zxYVzblUj9IltsrR2Q6xsv+HbHSAQ2OpYkQoN3c/TpI4QY7FrS3Du1MHHEk5
         xMfrQmvwR2JNO29BzZ8MWEOTFEeSFqDOO0eN+AdmssOkpO6tMjoKKPv58LWUzBYWJKw3
         RHopVEXO8j8Xl/DZZKB7zfPr67zMIlXhVKSZSmK8BDrnpRnukEMqe55+Sqz+ojEx9aW0
         wyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F6f3afV4tqtncF73mZhO2dGGO3BMaajonDRieyQCctk=;
        b=ymPyzdk33i7dY43iC0FSA9AGmJ5qTDFlvrlDztfraHywsLR3SGmUk+1VIoPKuQAmR7
         BG+9i/DxODCt2zjJYbHLu1bkJsvUeU7IHjnasoSZh7Mk9KGqu0U8/jrPPzIKxIbKyL+3
         qfraAg/fgpTIqG3J0HW7xOjTp7LWobWiO2mgxjrZgK/X60a/693mib4xPqoPVaYjLiPT
         i5ZSq0OO9K8Ry+4GZTwYxQrR8D2qCe3apc7EpxMyYW6dgw11UxxaPfJ+PIXZFO82F+wY
         mk3/D8BGi1618isBSi6VAoPAYAjjKjLdANCZv4puHn+pskM3qdrRNPXHTiYpQivV0YoG
         Cypg==
X-Gm-Message-State: AOAM531B5b7PYmzb1k4QTL45pbnjLEef6oT3zopC6USKW+iaps/5TF4e
        4mXiJE1VH7KqhKX8iy+wJBHL6Px9AsTcTw==
X-Google-Smtp-Source: ABdhPJxyu3mAkevGNq3TrkT+TrWR/F8CTnpZC9QiUtL8T0XWIE+cAVlAe4rnnsYArb7XiDZ32JeJUQ==
X-Received: by 2002:a0c:fc46:0:b0:440:f78f:f4c4 with SMTP id w6-20020a0cfc46000000b00440f78ff4c4mr16130924qvp.108.1647955679440;
        Tue, 22 Mar 2022 06:27:59 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id l126-20020a37bb84000000b0067b3c2bcc0dsm9349493qkf.1.2022.03.22.06.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 06:27:59 -0700 (PDT)
Date:   Tue, 22 Mar 2022 09:27:58 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     CGEL <cgel.zte@gmail.com>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] block/psi: make PSI annotations of submit_bio only work
 for file pages
Message-ID: <YjnO3p6vvAjeMCFC@cmpxchg.org>
References: <20220316063927.2128383-1-yang.yang29@zte.com.cn>
 <YjiMsGoXoDU+FwsS@cmpxchg.org>
 <623938d1.1c69fb81.52716.030f@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <623938d1.1c69fb81.52716.030f@mx.google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 22, 2022 at 02:47:42AM +0000, CGEL wrote:
> On Mon, Mar 21, 2022 at 10:33:20AM -0400, Johannes Weiner wrote:
> > On Wed, Mar 16, 2022 at 06:39:28AM +0000, cgel.zte@gmail.com wrote:
> > > From: Yang Yang <yang.yang29@zte.com.cn>
> > > 
> > > psi tracks the time spent on submitting the IO of refaulting file pages
> > > and anonymous pages[1]. But after we tracks refaulting anonymous pages
> > > in swap_readpage[2][3], there is no need to track refaulting anonymous
> > > pages in submit_bio.
> > > 
> > > So this patch can reduce redundant calling of psi_memstall_enter. And
> > > make it easier to track refaulting file pages and anonymous pages
> > > separately.
> > 
> > I don't think this is an improvement.
> > 
> > psi_memstall_enter() will check current->in_memstall once, detect the
> > nested call, and bail. Your patch checks PageSwapBacked for every page
> > being added. It's more branches for less robust code.
> 
> We are also working for a new patch to classify different reasons cause
> psi_memstall_enter(): reclaim, thrashing, compact, etc. This will help
> user to tuning sysctl, for example, if user see high compact delay, he
> may try do adjust THP sysctl to reduce the compact delay.
> 
> To support that, we should distinguish what's the reason cause psi in
> submit_io(), this patch does the job.

Please submit these patches together then. On its own, this patch
isn't desirable.
