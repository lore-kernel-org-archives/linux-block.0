Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D5FC76188
	for <linux-block@archiver.kernel.org>; Mon,  3 Apr 2023 18:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjDCSAv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Apr 2023 14:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjDCSAl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Apr 2023 14:00:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00E635A5
        for <linux-block@vger.kernel.org>; Mon,  3 Apr 2023 11:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17D066145D
        for <linux-block@vger.kernel.org>; Mon,  3 Apr 2023 18:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9698C433D2;
        Mon,  3 Apr 2023 18:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680544820;
        bh=OAdREJ98WBCtXKCCtZaL+kKO7LD1uHZwB9WFPjq8K74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qa7GrQ2bKTddu1wlPxosCMS6U1ezmYu2wgF9fqT2JSfSUaXd+ujyy3IO8G3+B1Xyu
         vck0maujpj4QLaZth7kAqF/bPqsJ9pDvN9jXP82GwqloKRK2pbZK2la8TbY0UslP5X
         LdIQiut22SY+zZhi/0/D3M0bjy4ov7VVwMKO8p58iBN0g0BOASCm7vAWptWMTyFirc
         fwUxZ3+SP1tdq2lsrJsouBc7O2AeJ0yPlDZodnpivc/5rlmG5WkihwVo+tHey5EWMd
         zhoc+hImWUQB5w5dREWr7CgEGjS+JdyV1Hlp7C97mZxHcxhFFTyOMm8wyFzcywnTDa
         V1X9tM19Fl+lw==
Date:   Mon, 3 Apr 2023 12:00:17 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Laurence Oberman <loberman@redhat.com>
Cc:     minlei@redhat.com, jmeneghi@redhat.com,
        "Hellwig, Christoph" <hch@infradead.org>, axboe@fb.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Issue with discard with NVME and Infinibox Storage
Message-ID: <ZCsUMR3uLx+vPoOp@kbusch-mbp.dhcp.thefacebook.com>
References: <d1dbb7c5eca51993e9988849ab2e43e800ecb067.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1dbb7c5eca51993e9988849ab2e43e800ecb067.camel@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 03, 2023 at 01:35:22PM -0400, Laurence Oberman wrote:
> Hello Ming and Christoph
> 
> Issue with Infinibox storage
> ----------------------------
> Really discovered 2 issues here 
> 
> Issue 1
> Kernels 5.15 to 5.18 inclusive recognize the discard support on the
> Infinibox device but they fail in the nvme_setup_discard function call

This first i ssue should be fixed with this commit:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=37f0dc2ec78af0c3f35dd05578763de059f6fe77

> Issue 2
> Trying to narrow this down.
> 5.19 and higher (6.3 included), no longer support discard on the
> Infinibox device and log this message so I cannot run the test for the
> discard issue
> 
> [   35.989809] nvme nvme1: new ctrl: NQN "nqn.2020-
> 01.com.infinidat:36000-subsystem-696", addr 192.168.1.2:4420
> [   64.810437] XFS (nvme1n1): mounting with "discard" option, but the
> device does not support discard
> [   64.812298] XFS (nvme1n1): Mounting V5 Filesystem 6763a33f-18cc-
> 4a26-894b-8b0f8d79a98a
> 
> I then bisected between 5.18 and 5.19 to this commit
> 
> 1a86924e4f464757546d7f7bdc469be237918395 is the first bad commit


> commit 1a86924e4f464757546d7f7bdc469be237918395
> Author: Tom Yan <tom.ty89@gmail.com>
> Date:   Fri Apr 29 12:52:43 2022 +0800
> 
>     nvme: fix interpretation of DMRSL
>     
>     DMRSLl is in the unit of logical blocks, while max_discard_sectors
> is
>     in the unit of "linux sector".
>     
>     Signed-off-by: Tom Yan <tom.ty89@gmail.com>
>     Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
>  drivers/nvme/host/core.c | 6 ++++--
>  drivers/nvme/host/nvme.h | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> 
> Note that Infindat mentioned this in our case they logged with us
> They say they fully adhere to TP4040 MDTS.
> Towards NVMe-oF 2.0 specification, TP4040  - Max Data Transfer for non-
> IO Commands (MDTS) was released with additional fields to control these
> parameters.
> These parameters are supported in kernel versions 5.15 and above.  ****
> 
> Our storage target will reply with 0 for bit 2 of the ONCS, indicating
> UNMAP is supported based on the DMRL, DMRSL, and DMSL values. 
> (older kernels will interpret these values as UNMAP NOT SUPPORTED)
> 
> 
> Let me know your thoughts please. for both issues

The commit you found unconditionally sets the discard queue limit to the
reported DMRSL, so it sounds like your target is reporting DMRSL as '0'. Prior
to that commit, we'd use that value only if it was non-zero. I hope that helps.
