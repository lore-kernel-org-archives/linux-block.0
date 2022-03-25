Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6890AC433EF
	for <linux-block@archiver.kernel.org>; Fri, 25 Mar 2022 20:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiCYUW4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Mar 2022 16:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiCYUWz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Mar 2022 16:22:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C0C5BE7E;
        Fri, 25 Mar 2022 13:21:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD3A161B4D;
        Fri, 25 Mar 2022 20:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F75C340F0;
        Fri, 25 Mar 2022 20:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648239679;
        bh=NI/tQG4hVTVWq79zOQmM8sUwmhGulbjsd23+yJzyFSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AL1Ve4KHrr/Q28xrLFQaIqApsHJhXf44i5nVIkeH+0NkudaGVn4/sv+mOG5f2PZP4
         h3N94wsvX/6lbHCpwuFF8V7hhpgt4b345x0p4dJBnBsYh7XN+dWO4eMaNnWw2FwKEi
         zj94JuO21PitOFsYOrZQMIRwyQ8Jgd2SrgCBCVOxPl2L2TyMVogdAmDvrjkmDua5Kg
         jB8Wb9efTMyTw6Jjc4sAsrfpOynZXOpJZ5srMk4FyWxaeV526KDAjHwEXBuoRo0ylf
         08RMeJaXYwwzqr25sNZT8vp6R/8FsLNmGJtiwpgdekuUYaTypJ00SKBxqkr38yuRjY
         SLmAKt+AVioCw==
Date:   Fri, 25 Mar 2022 20:21:17 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Jens Axboe <axboe@kernel.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: next: BUG: sleeping function called from invalid context at
 block/blk-sysfs.c:766
Message-ID: <Yj4kPcW0Zw2Xv+jY@gmail.com>
References: <CA+G9fYtZpazsDTQo9N-4U=T5QvEKTu_xDi=W+1_7ng51306LYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtZpazsDTQo9N-4U=T5QvEKTu_xDi=W+1_7ng51306LYg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 24, 2022 at 02:04:23PM +0530, Naresh Kamboju wrote:
> While running kselftest zram test cases on Linux next-20220324 the kernel BUG
> reported on arm64 Qcom db845 development board.
> 
> metadata:
>   git_ref: master
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git_sha: b61581ae229d8eb9f21f8753be3f4011f7692384
>   git_describe: next-20220323
>   kernel_version: 5.17.0
>   kernel-config: https://builds.tuxbuild.com/26mKdspULB326eo6s22cXZzYhmt/config

next-20220323 or next-20220324?  Your report is inconsistent.  If it's the
former, I'd guess this was already fixed by:

	commit d578c770c85233af592e54537f93f3831bde7e9a (linux-block/for-5.18/block)
	Author: Ming Lei <ming.lei@redhat.com>
	Date:   Wed Mar 23 09:13:08 2022 +0800

	    block: avoid calling blkg_free() in atomic context

