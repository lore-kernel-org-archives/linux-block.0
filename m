Return-Path: <SRS0=A/1A=5J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9FAC4332B
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 00:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E602073E
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 00:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585008165;
	bh=9h+COxG3dUR5Z7sMol7GPWLKBIoXa3RTvIi0eIZQFNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gRL85s56EhId46zHGLqWRFN2W9fWyxNeVyqPU8Amb7aIbzgmGn/f5wYZFppJMzSBD
	 Q6C0PL8mh8RvyqbqXNdzI9D3OENKwfFnBnQ9Q2Qon+K4ULdcowaWJPPip1xpvDwR/T
	 rcDn+vS/6aI3096EbZYh1y3MzgPT2s9evSY+mUQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgCXACp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 20:02:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727299AbgCXACp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 20:02:45 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAABD20714;
        Tue, 24 Mar 2020 00:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585008164;
        bh=9h+COxG3dUR5Z7sMol7GPWLKBIoXa3RTvIi0eIZQFNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y72qe8us04JI4/jbnHCI05+loK0a2vU4llpoBB700KoZC3Bd4C362yD04axp8LYMD
         c32uenVv31ZbdZX6kxDQ7Tv28BQjQ3oeOTWgygq/uuED22FF9bV0MEqffNYWPXUXhW
         /Hbhfn5/G6ohdrVp/Q3xFS5Lz7sxIt++fV5zgSqA=
Date:   Tue, 24 Mar 2020 09:02:37 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Tokunori Ikegami <ikegami.t@gmail.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting
 value
Message-ID: <20200324000237.GB15091@redsun51.ssa.fujisawa.hgst.com>
References: <20200323182324.3243-1-ikegami.t@gmail.com>
 <BYAPR04MB4965BAF4C0300E1206B049A586F00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <cff52955-e55c-068a-44a6-8ed4edc0696f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cff52955-e55c-068a-44a6-8ed4edc0696f@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 24, 2020 at 08:09:19AM +0900, Tokunori Ikegami wrote:
> Hi,
> > The change looks okay, but why do we need such a large data length ?
> > 
> > Do you have a use-case or performance numbers ?
> 
> We use the large data length to get log page by the NVMe admin command.
> In the past it was able to get with the same length but failed currently
> with it.
>
> So it seems that depended on the kernel version as caused by the version up.

We didn't have 32-bit max segments before, though. Why was 16-bits
enough in older kernels? Which kernel did this stop working?

> Also I have confirmed that currently failed with the length 0x10000000
> 256MB.

If your hitting max segment limits before any other limit, you should be
able to do larger transfers with more physically contiguous memory. Huge
pages can get the same data length in fewer segments, if you want to
try that.

But wouldn't it be better if your application splits the transfer into
smaller chunks across multiple commands? NVMe log page command supports
offsets for this reason.
