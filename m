Return-Path: <SRS0=lp7R=4I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4191C11D04
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 12:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08D520679
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 12:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgBTMIA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Feb 2020 07:08:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:33058 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbgBTMIA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Feb 2020 07:08:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3BC53AC3A;
        Thu, 20 Feb 2020 12:07:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DB9C41E0D3D; Thu, 20 Feb 2020 13:07:56 +0100 (CET)
Date:   Thu, 20 Feb 2020 13:07:56 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        axboe@kernel.dk, linux-block@vger.kernel.org, bvanassche@acm.org
Subject: Re: [PATCH] bdi: fix use-after-free for bdi device
Message-ID: <20200220120756.GE13232@quack2.suse.cz>
References: <20200212213344.GE80993@mtj.thefacebook.com>
 <fd9d78b9-1119-27cc-fa74-04cb85d4f578@huawei.com>
 <20200213034818.GE88887@mtj.thefacebook.com>
 <fa6183c5-b92c-c431-37ab-09638f890f6c@huawei.com>
 <20200213135809.GH88887@mtj.thefacebook.com>
 <f369a99d-e794-0c1b-85cf-83b577fb0f46@huawei.com>
 <20200214140514.GL88887@mtj.thefacebook.com>
 <32a14db2-65e0-5d5c-6c53-45b3474d841d@huawei.com>
 <20200219125505.GP16121@quack2.suse.cz>
 <59a8851e-7ba2-e70d-36d8-be47829a7581@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59a8851e-7ba2-e70d-36d8-be47829a7581@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 20-02-20 19:07:01, Yufen Yu wrote:
> Hi,
> 
> On 2020/2/19 20:55, Jan Kara wrote:
> > Hi!
> > 
> > On Sat 15-02-20 21:54:08, Yufen Yu wrote:
> 
> > 
> > I've now noticed there's commit 68f23b8906 "memcg: fix a crash in wb_workfn
> > when a device disappears" from end of January which tries to address the
> > issue you're looking into. Now AFAIU the code is till somewhat racy after
> > that commit so I wanted to mention this mostly so that you fixup also the
> > new bdi_dev_name() while you're fixing blkg_dev_name().
> > 
> > Also I was wondering about one thing: If we really care about bdi->dev only
> > for the name, won't we be much better off with just copying the name to
> > bdi->name on registration? Sure it would consume a bit of memory for the
> > name copy but I don't think we really care and things would be IMO *much*
> > simpler that way... Yufen, Tejun, what do you think?
> > 
> 
> I think copying the name to bdi->name is also need protected by lock.
> Otherwise, the reader of bdi->name may read incorrect value when
> re-registion have not copy the name completely. Right? So, I also think
> using RCU to protect object lifetimes may be a better way.

OK, fair enough. :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
