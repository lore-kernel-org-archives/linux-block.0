Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB29C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 05:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97FA21780
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 05:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97FA21780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbeKNPkY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 10:40:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbeKNPkY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 10:40:24 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 22DEF307D856;
        Wed, 14 Nov 2018 05:38:41 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 583B145DE;
        Wed, 14 Nov 2018 05:38:38 +0000 (UTC)
Date:   Wed, 14 Nov 2018 00:38:37 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, hch@lst.de, axboe@kernel.dk
Cc:     Martin Wilck <mwilck@suse.com>, lijie <lijie34@huawei.com>,
        xose.vazquez@gmail.com, linux-nvme@lists.infradead.org,
        chengjike.cheng@huawei.com, shenhong09@huawei.com,
        dm-devel@redhat.com, wangzhoumengjian@huawei.com, hare@suse.de,
        christophe.varoqui@opensvc.com, bmarzins@redhat.com,
        sschremm@netapp.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: multipath-tools: add ANA support for NVMe device
Message-ID: <20181114053837.GA15086@redhat.com>
References: <1541657381-7452-1-git-send-email-lijie34@huawei.com>
 <2691abf6733f791fb16b86d96446440e4aaff99f.camel@suse.com>
 <20181112215323.GA7983@redhat.com>
 <20181113161838.GC9827@localhost.localdomain>
 <20181113180008.GA12513@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113180008.GA12513@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 14 Nov 2018 05:38:41 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 13 2018 at  1:00pm -0500,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Tue, Nov 13 2018 at 11:18am -0500,
> Keith Busch <keith.busch@intel.com> wrote:
> 
> > On Mon, Nov 12, 2018 at 04:53:23PM -0500, Mike Snitzer wrote:
> > > On Mon, Nov 12 2018 at 11:23am -0500,
> > > Martin Wilck <mwilck@suse.com> wrote:
> > > 
> > > > Hello Lijie,
> > > > 
> > > > On Thu, 2018-11-08 at 14:09 +0800, lijie wrote:
> > > > > Add support for Asynchronous Namespace Access as specified in NVMe
> > > > > 1.3
> > > > > TP 4004. The states are updated through reading the ANA log page.
> > > > > 
> > > > > By default, the native nvme multipath takes over the nvme device.
> > > > > We can pass a false to the parameter 'multipath' of the nvme-core.ko
> > > > > module,when we want to use multipath-tools.
> > > > 
> > > > Thank you for the patch. It looks quite good to me. I've tested it with
> > > > a Linux target and found no problems so far.
> > > > 
> > > > I have a few questions and comments inline below.
> > > > 
> > > > I suggest you also have a look at detect_prio(); it seems to make sense
> > > > to use the ana prioritizer for NVMe paths automatically if ANA is
> > > > supported (with your patch, "detect_prio no" and "prio ana" have to be
> > > > configured explicitly). But that can be done in a later patch.
> > > 
> > > I (and others) think it makes sense to at least triple check with the
> > > NVMe developers (now cc'd) to see if we could get agreement on the nvme
> > > driver providing the ANA state via sysfs (when modparam
> > > nvme_core.multipath=N is set), like Hannes proposed here:
> > > http://lists.infradead.org/pipermail/linux-nvme/2018-November/020765.html
> > > 
> > > Then the userspace multipath-tools ANA support could just read sysfs
> > > rather than reinvent harvesting the ANA state via ioctl.
> > 
> > I'd prefer not duplicating the log page parsing. Maybe nvme's shouldn't
> > even be tied to CONFIG_NVME_MULTIPATH so that the 'multipath' param
> > isn't even an issue.
> 
> I like your instincts, we just need to take them a bit further.
> 
> Splitting out the kernel's ANA log page parsing won't buy us much given
> it is userspace (multipath-tools) that needs to consume it.  The less
> work userspace needs to do (because kernel has already done it) the
> better.
> 
> If the NVMe driver is made to always track and export the ANA state via
> sysfs [1] we'd avoid userspace parsing duplication "for free".  This
> should occur regardless of what layer is reacting to the ANA state
> changes (be it NVMe's native multipathing or multipath-tools).
> 
> ANA and NVMe multipathing really are disjoint, making them tightly
> coupled only serves to force NVMe driver provided multipathing _or_
> userspace ANA state tracking duplication that really isn't ideal [2].
> 
> We need a reasoned answer to the primary question of whether the NVMe
> maintainers are willing to cooperate by providing this basic ANA sysfs
> export even if nvme_core.multipath=N [1].
> 
> Christoph said "No" [3], but offered little _real_ justification for why
> this isn't the right thing for NVMe in general.
...
> [1]: http://lists.infradead.org/pipermail/linux-nvme/2018-November/020765.html
> [2]: https://www.redhat.com/archives/dm-devel/2018-November/msg00072.html
...

I knew there had to be a pretty tight coupling between the NVMe driver's
native multipathing and ANA support... and that the simplicity of
Hannes' patch [1] was too good to be true.

The real justification for not making Hannes' change is it'd effectively
be useless without first splitting out the ANA handling done during NVMe
request completion (NVME_SC_ANA_* cases in nvme_failover_req) that
triggers re-reading the ANA log page accordingly.

So without the ability to drive the ANA workqueue to trigger
nvme_read_ana_log() from the nvme driver's completion path -- even if
nvme_core.multipath=N -- it really doesn't buy multipath-tools anything
to have the NVMe driver export the ana state via sysfs, because that ANA
state will never get updated.

> The inability to provide proper justification for rejecting a patch
> (that already had one co-maintainer's Reviewed-by [5]) _should_ render
> that rejection baseless, and the patch applied (especially if there is
> contributing subsystem developer interest in maintaining this support
> over time, which there is).  At least that is what would happen in a
> properly maintained kernel subsystem.
> 
> It'd really go a long way if senior Linux NVMe maintainers took steps to
> accept reasonable changes.

Even though I'm frustrated I was clearly too harsh and regret my tone.
I promise to _try_ to suck less.

This dynamic of terse responses or no responses at all whenever NVMe
driver changes to ease multipath-tools NVMe support are floated is the
depressing gift that keeps on giving.  But enough excuses...

Not holding my breath BUT:
if decoupling the reading of ANA state from native NVMe multipathing
specific work during nvme request completion were an acceptable
advancement I'd gladly do the work.

Mike
