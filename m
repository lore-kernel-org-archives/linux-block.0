Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD10C433F5
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 13:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345567AbiC3NCf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Mar 2022 09:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345547AbiC3NCe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Mar 2022 09:02:34 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6013A165A88
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 06:00:48 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id d65so13006172qke.5
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 06:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JKBEI+rTrucdMmAykodBJnjRrK7pFFvDZ/jgsyxJpqM=;
        b=ZdgvW8LjgNL6YoqgHEh9gCT/a5BIEEXhlqaP97vLxTw5UtMyWwZgMFoScg41CskVB5
         tfMc3uKjFABrduUmfVVkRLPZMnDclwcFUEMNSYizSlVlLS4Cd1MArP6pc0/518t70bGn
         bpXnOF4LwesYzcGZuUUFRmY5SJ04C+LezJNIr4BgOJ5Sczzn/GnzoKITfFSLprFCsTyx
         zZO8/lzwF0pNVYBojwrJCtCG9mmLOAuLtcz+TfGA4ArRPEXMlYYFYPHJblLHUZqqQPNQ
         oJKncFZRx8keTMZvVHfEluKg6hVvsYHpFxir/BDXwROVBfk7CLo3OHP5QpZ5nvfSqsXF
         a5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JKBEI+rTrucdMmAykodBJnjRrK7pFFvDZ/jgsyxJpqM=;
        b=JNOg+r+wEGe4JKlWS3t+hgBDP2ntkskjt/kDc02JFj8hBY5H3Xq4k58zSSIcjaPIOz
         idRrW+37olTKMf3rUWTM2rjg1hs9Wcfcwboog6H096ibOx+2e4AGRk10XiZWjSsetrUn
         Xe94ELMRwS0+gBfjd8wXiSlNSWusKVy3loBUcBKI0El/hKB+433SQX/9+OpOJrIMFa4u
         MorkYYqIP+rM21KXK1ZPWmPIAj1IaeRUMKzHEBgmZScoEw/W3PLrl88gMTnFQpumAuRC
         tvae0QLV6ahUYfGFp1IK++T5wMIzi8EHIqJtXQaYc0R/vq3QYGDzypE0ed1agyTF6HdW
         Uhig==
X-Gm-Message-State: AOAM5312puHNcAixSqrhhpq/HooGUZ4Qt2LEDaqoMjQGObQ0FpxhmPHE
        WHx3lBjKMgp993tqDoIKjmPkZW8Q0QihmA==
X-Google-Smtp-Source: ABdhPJyv3AWwhtvS2UE867VEhAMipuhh9WVFgBcj0BauMpWiZotNv82wxTieALZfY6uEjLrGUXMVxw==
X-Received: by 2002:a37:9d7:0:b0:67e:85d2:2417 with SMTP id 206-20020a3709d7000000b0067e85d22417mr23645632qkj.753.1648645247377;
        Wed, 30 Mar 2022 06:00:47 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id b202-20020ae9ebd3000000b0067b11d53365sm10850997qkg.47.2022.03.30.06.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 06:00:46 -0700 (PDT)
Date:   Wed, 30 Mar 2022 09:00:46 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     CGEL <cgel.zte@gmail.com>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] block/psi: make PSI annotations of submit_bio only work
 for file pages
Message-ID: <YkRUfuT3jGcqSw1Q@cmpxchg.org>
References: <20220316063927.2128383-1-yang.yang29@zte.com.cn>
 <YjiMsGoXoDU+FwsS@cmpxchg.org>
 <623938d1.1c69fb81.52716.030f@mx.google.com>
 <YjnO3p6vvAjeMCFC@cmpxchg.org>
 <20220323061058.GA2343452@cgel.zte@gmail.com>
 <62441603.1c69fb81.4b06b.5a29@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62441603.1c69fb81.4b06b.5a29@mx.google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 30, 2022 at 08:34:08AM +0000, CGEL wrote:
> On Wed, Mar 23, 2022 at 06:11:03AM +0000, CGEL wrote:
> > On Tue, Mar 22, 2022 at 09:27:58AM -0400, Johannes Weiner wrote:
> > > On Tue, Mar 22, 2022 at 02:47:42AM +0000, CGEL wrote:
> > > > On Mon, Mar 21, 2022 at 10:33:20AM -0400, Johannes Weiner wrote:
> > > > > On Wed, Mar 16, 2022 at 06:39:28AM +0000, cgel.zte@gmail.com wrote:
> > > > > > From: Yang Yang <yang.yang29@zte.com.cn>
> > > > > > 
> > > > > > psi tracks the time spent on submitting the IO of refaulting file pages
> > > > > > and anonymous pages[1]. But after we tracks refaulting anonymous pages
> > > > > > in swap_readpage[2][3], there is no need to track refaulting anonymous
> > > > > > pages in submit_bio.
> > > > > > 
> > > > > > So this patch can reduce redundant calling of psi_memstall_enter. And
> > > > > > make it easier to track refaulting file pages and anonymous pages
> > > > > > separately.
> > > > > 
> > > > > I don't think this is an improvement.
> > > > > 
> > > > > psi_memstall_enter() will check current->in_memstall once, detect the
> > > > > nested call, and bail. Your patch checks PageSwapBacked for every page
> > > > > being added. It's more branches for less robust code.
> > > > 
> > > > We are also working for a new patch to classify different reasons cause
> > > > psi_memstall_enter(): reclaim, thrashing, compact, etc. This will help
> > > > user to tuning sysctl, for example, if user see high compact delay, he
> > > > may try do adjust THP sysctl to reduce the compact delay.
> > > > 
> > > > To support that, we should distinguish what's the reason cause psi in
> > > > submit_io(), this patch does the job.
> > > 
> > > Please submit these patches together then. On its own, this patch
> > > isn't desirable.
> > I think this patch has it's independent value, I try to make a better
> > explain.

You missed the point about it complicating semantics.

Right now, the bio layer annotates stalls from queue contention. This
is very simple. The swap code has relied on it in the past. It doesn't
now, but that doesn't change what the concept is at the bio layer.

You patch explicitly codifies that the MM handles swap IOs, and the
lower bio layer handles files. This asymmetry is ugly and error prone.

If you want type distinction, we should move it all into MM code, like
Christoph is saying. Were swap code handles anon refaults and the page
cache code handles file refaults. This would be my preferred layering,
and my original patch did that: https://lkml.org/lkml/2019/7/22/1070.

But it was NAKed, and I had to agree with the argument. The page cache
code is not very centralized, and the place where we deal with
individual pages (and detect refaults) and where we submit bios (where
the stalls occur) is spread out into multiple filesystems. There are
180 submit_bio() calls in fs/; you'd have to audit which ones are for
page cache submissions, and then add stall annotations or use a new
submit_bio_cache() wrapper that handles it. Changes in the filesystem
could easily miss this protocol and silently break pressure detection.

I would prefer the annotations to be at this level, I just don't see
how to do it cleanly/robustly. Maybe Christoph has an idea, he
understands the fs side much better than I do.
