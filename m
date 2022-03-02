Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C57C433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 23:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiCBXuV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Mar 2022 18:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiCBXuU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Mar 2022 18:50:20 -0500
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7469D244A06
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 15:49:33 -0800 (PST)
Received: by mail-pl1-f182.google.com with SMTP id 9so2975065pll.6
        for <linux-block@vger.kernel.org>; Wed, 02 Mar 2022 15:49:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=27harkJvt3GbkEUzd97hE61qyRwT0mO4luQz+C9YIVY=;
        b=DdHq5ZP+f5JDXYc8ClDxOP1ZXcXsodD5KES9mNg/AUOSCQffw4+tMC+4r39FvkfNpd
         zSreW8rfuHAOQ2BuqrVLF38l6V7gQITeWy5/2Ti4GMJdd9Pyi2iOxY/CfMMpffzlAHxW
         6IIQ6hHZ0w6tfXz6pLyO0NCPVQJaqj7KyhUWGHonQpD79uJVPaQvf5K8YCPNJxN8eBzm
         EZiU5ON/n+vX2lNifVpHHSzlOgTxwe+tFJ1QCU8Uuou2FpXdYF9+UXRfikaQNU2oP7gf
         H1lwR4idoVgKWDwV7Z2JFeUS26ij6kvo6329NQuDwdJ4h75t+OnNoDduQKElBQASt/tb
         T4RQ==
X-Gm-Message-State: AOAM533cnnkO7kr0UOIavJJB70250bmzHMUcnpPinpGwhwztm+srj/s/
        yASCgHC5zuavK1o1CPYUcLLRiYHIhSs=
X-Google-Smtp-Source: ABdhPJxqr04ho8Sf+nOJf9uzDiSKIAwAy2mFLuUc3UFVCMr4d+Uzjzb7WW+wppBuBw6DqL0IfkWtMQ==
X-Received: by 2002:a17:902:ccc6:b0:14f:88e6:8040 with SMTP id z6-20020a170902ccc600b0014f88e68040mr33506847ple.13.1646264446627;
        Wed, 02 Mar 2022 15:40:46 -0800 (PST)
Received: from garbanzo (136-24-173-63.cab.webpass.net. [136.24.173.63])
        by smtp.gmail.com with ESMTPSA id q194-20020a6275cb000000b004f396541cecsm253220pfc.155.2022.03.02.15.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 15:40:45 -0800 (PST)
Date:   Wed, 2 Mar 2022 15:40:43 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kanchan Joshi <joshi.k@samsung.com>,
        Dave Jones <davej@codemonkey.org.uk>
Cc:     lsf-pc@lists.linux-foundation.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Towards more useful nvme passthrough
Message-ID: <20220302234043.wlacvj223rcymc4b@garbanzo>
References: <CGME20220228093018epcas5p137f53cb05ce95fed2ac173b8fddf2eee@epcas5p1.samsung.com>
 <20220228092511.458285-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220228092511.458285-1-joshi.k@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 28, 2022 at 02:55:11PM +0530, Kanchan Joshi wrote:
> I'd like a propose a session to go over:
> 
> - What are the issues in having the above work (uring-cmd and new nvme
> passthru) merged?

It sounds like we just needed to settle on the formats. And a few more
eyeballs / reviewed-by's. No? And it sounds like Jens is about to punt
a new series :)

> - What would be other useful things to add in nvme-passthru. For
> example- lack of vectored-io for passthru was one such missing piece.
> That is covered from nvme 5.18 onwards [4]. But are there other things
> that user-space would need before it starts treating this path as a
> good alternative to kernel-bypass?

I think it would be good to split this into two parts:

 * io-uring cmd extensions
 * what can be extended for nvme

io-uring cmd is not even upstream yet, so I don't think folks widely really
realize the potential yet. So I think it's a bit too early to tell here,
and so we should go out and preach at things like Plumbers and other
conferences with a few nice demos of what can be done. nvme being one
use case, but I think it would help to get other users active and not
just vaporware.

The problem I'm seeing with this effort too is it relies too heavily
on the nvme passthrough being the only use case so far, and that's
a bit too involved. So I'd like to encourage other simple users
to consider helping here.

Granted this is like looking for a nail when you're hammer. And so
the only way to not have it be that way is to aim smaller, a simple
real demo of something useful. I don't know.. I'd think something like
trinity might have a field day with this.

> - Despite the numbers above, nvme passthru has more room for
> efficiency e.g. unlike regular io, we do copy_to_user to fetch
> command, and put_user to return the result. Eliminating some of this
> may require new ioctl. There may be other opinions on what else needs
> overhaul in this path.

I think we are being to hard on ourselves. Start small, and, get some
basic stuff up. And allow for flexibility for improvement. I think
at this point we have more than proof of concept no but something
tangible?

> - What would be a good way to upstream the tests? Nvme-cli may not be
> very useful. Should it be similar to fio’s sg ioengine. But
> unlike sg, here we are combining ng with io_uring, and one would want
> to retain all the tunables of io_uring (register/fixed buffers/sqpoll
> etc.)

If the goal was to help open the door for unsupported commands then
in so far as upstream is concerned shouldn't we only care about the
generic plumbing? ie, specific commands / which might not yet be
baked for general consumption (like zone append) are left to up to
implementors to figure out where they test. Let's use zone append
as an example. Without a raw block interface to it, we can use this
framework, ideally.. but yeah how do we test? Are vendors all going
to agree to use microbenches with io-uring cmd?

> - All the above is for 2.0 passthru which essentially forms a direct
> path between io_uring and nvme. And io_uring and nvme programming
> model share many similarities. For 3.0 passthru, would it be crazy to
> think of trimming the path further by eliminating the block-layer and
> doing stuff without “struct request”. There is some interest in
> developing user-space block device [5] and FS anyway.

I failed to capture where 2.0 and 3.0 are defined. Can you elaborate?

  Luis
