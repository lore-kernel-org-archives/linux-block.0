Return-Path: <SRS0=MX1A=5N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A876EC43331
	for <linux-block@archiver.kernel.org>; Sat, 28 Mar 2020 03:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793B52073B
	for <linux-block@archiver.kernel.org>; Sat, 28 Mar 2020 03:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585365219;
	bh=FbzAYDFJXzmdRzyIumoWFqteCyW0V2FlhYpXUFfmxzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iyGXnWzbJ2KCZUrcvkFDVnRt3/WBeIaRXO9nRb3qDjn3X6I62CdN6CFGXzcekpTV2
	 jCCXSgSJnMXkSUxqJkP+x/Alw0oUKpFpbwHUqODS7xaO++oAxGg5wRu1AiMbqAi3yF
	 bIQHtcQWsxXNEYOZkpxX2A9FPMoXsRWlW6Y68flk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgC1DNi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Mar 2020 23:13:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgC1DNi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Mar 2020 23:13:38 -0400
Received: from keith-busch (unknown [8.36.226.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C066B206F1;
        Sat, 28 Mar 2020 03:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585365218;
        bh=FbzAYDFJXzmdRzyIumoWFqteCyW0V2FlhYpXUFfmxzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hw4n6WYF/b0nwXuMtAR4O8d9WF0AzmD48b21Onp+hN0hhauXFnKwFSwoDSbbLsKBR
         c9H+qxhk7BChOx18SfZS+Oy02BmkK7PtYEAuXFh50aQh3VYBbQyPtrXLFCadj36zug
         wsqbBMujsonkIfjskkxvzVy6wXXnto2/9GlAN5sM=
Date:   Fri, 27 Mar 2020 21:13:35 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Tokunori Ikegami <ikegami.t@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting
 value
Message-ID: <20200328031334.GA18429@keith-busch>
References: <20200323182324.3243-1-ikegami.t@gmail.com>
 <BYAPR04MB4965BAF4C0300E1206B049A586F00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <cff52955-e55c-068a-44a6-8ed4edc0696f@gmail.com>
 <20200324000237.GB15091@redsun51.ssa.fujisawa.hgst.com>
 <6b73db44-ca3f-4285-0c91-dc1b1a5ca9f1@gmail.com>
 <dc3a3e88-f062-b7df-dd18-18fb76e68e0c@gmail.com>
 <20200327181825.GA8356@redsun51.ssa.fujisawa.hgst.com>
 <CACVXFVM=rT=86JrmAkySTg=gknfFL8Q1NU0uXWzoDMKMyL_mow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACVXFVM=rT=86JrmAkySTg=gknfFL8Q1NU0uXWzoDMKMyL_mow@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 28, 2020 at 10:11:57AM +0800, Ming Lei wrote:
> On Sat, Mar 28, 2020 at 2:18 AM Keith Busch <kbusch@kernel.org> wrote:
> >
> > This is actually even more confusing. We do not support 256MB transfers
> > within a single command in the pci nvme driver anymore. The max is 4MB,
> > so I don't see how increasing the max segments will help: you should be
> > hitting the 'max_sectors' limit if you don't hit the segment limit first.
> 
> That looks a bug for passthrough req, because 'max_sectors' limit is only
> checked in bio_add_pc_page(), not done in blk_rq_append_bio(), something
> like the following seems required:

Shouldn't bio_map_user_iov() or bio_copy_user_iov() have caught the
length limit before proceeding to blk_rq_append_bio()?
