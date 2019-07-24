Return-Path: <SRS0=+4Fh=VV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30955C76186
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 01:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2922238C
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 01:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfGXBpZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jul 2019 21:45:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57902 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728455AbfGXBpZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 21:45:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 605783082E10;
        Wed, 24 Jul 2019 01:45:24 +0000 (UTC)
Received: from ming.t460p (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9559A60BEC;
        Wed, 24 Jul 2019 01:45:16 +0000 (UTC)
Date:   Wed, 24 Jul 2019 09:45:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     davidc502 <davidc502@tds.net>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: fstrim error - AORUS NVMe Gen4 SSD
Message-ID: <20190724014510.GD22421@ming.t460p>
References: <fb510e33-5c81-6d62-fcde-a2989b3a1a8f@tds.net>
 <20190723021928.GF30776@ming.t460p>
 <4a7ec7aa-f6ee-f9dc-4a17-38f2b169c721@tds.net>
 <20190723043803.GB13829@ming.t460p>
 <38cf2485-727b-268d-f42c-6c53b971cb87@tds.net>
 <5ef41ec4-abb8-90bf-e2eb-8a62f51ad951@tds.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ef41ec4-abb8-90bf-e2eb-8a62f51ad951@tds.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 24 Jul 2019 01:45:24 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 23, 2019 at 04:56:10PM -0500, davidc502 wrote:
> Ming,
> 
> On 7/23/19 4:38 PM, davidc502 wrote:
> > Hello,
> > 
> > On 7/22/19 11:38 PM, Ming Lei wrote:
> > > Hi,
> > > 
> > > On Mon, Jul 22, 2019 at 09:39:07PM -0500, davidc502 wrote:
> > > > See attached:  nvme_io_trace.log
> > > > 
> > > > 
> > > > On 7/22/19 9:19 PM, Ming Lei wrote:
> > > > > Hi,
> > > > > 
> > > > > On Sat, Jul 20, 2019 at 09:41:24PM -0500, davidc502 wrote:
> > > > > >    Hello,
> > > > > > 
> > > > > >    I've assembled a X570 board with a 1TB AORUS NVMe Gen4 SSD.
> > > > > > 
> > > > > >    When attempting to fstrim the NVMe, I receive the following error.
> > > > > >    davidc502@Ryzen-3900x:~$ sudo fstrim -a -v
> > > > > >    fstrim: /boot/efi: FITRIM ioctl failed: Input/output error
> > > > > >    fstrim: /: FITRIM ioctl failed: Input/output error
> > > > > > 
> > > > > >    Anyhow, I have put some details below which might be
> > > > > > helpful. Note that
> > > > > > this NVMe is supposed to be TRIM and SMART compliant.
> > > > > > The SMART outputs are
> > > > > > available using the utility “nvme-cli”.
> > > > > >    I am willing to provide whatever command outputs that
> > > > > > are needed to help
> > > > > > solve this issue.
> > > > > > 
> > > > > >    OS= Ubuntu 18.4.2 LTS
> > > > > >    Different Kernels I’ve tried = 5.1.16, 5.2 rc7, and 4.18
> > > > > >    fstrim version =  fstrim from util-linux 2.31.1
> > > > > >    Firmware version for Aorus NVMe = EGFM11.0
> > > > > > 
> > > > > I saw discard timeout on HGST 1.6TB NVMe, not sure if yours
> > > > > is same with
> > > > > that one.
> > > > > 
> > > > > Could you collect logs via the following steps?
> > > > > 
> > > > > Suppose your nvme disk name is /dev/nvme0n1:
> > > > > 
> > > > > 1) queue limits log:
> > > > > 
> > > > >     #(cd /sys/block/nvme0n1/queue && find . -type f -exec
> > > > > grep -aH . {} \;)
> > > > > 
> > > > > 
> > > > > 2) NVMe IO trace
> > > > > 
> > > > > - enable nvme IO trace before running fstrim:
> > > > > 
> > > > >     #echo 1  > /sys/kernel/debug/tracing/events/nvme_setup_cmd/enable
> > > > >     #echo 1  >
> > > > > /sys/kernel/debug/tracing/events/nvme_complete_rq/enable
> > > > > 
> > > > > - run fstrim
> > > > > 
> > > > > - after the fstrim failure is triggered, disable the nvme io
> > > > > trace & post the log:
> > > > > 
> > > > >     #echo 0  > /sys/kernel/debug/tracing/events/nvme_setup_cmd/enable
> > > > >     #echo 0  >
> > > > > /sys/kernel/debug/tracing/events/nvme_complete_rq/enable
> > > > > 
> > > > >     #cp    /sys/kernel/debug/tracing/trace /root/nvme_io_trace.log
> > > > > 
> > > > > 
> > > > > 
> > > > > thanks,
> > > > > Ming
> > > > 
> > > > Hello Ming
> > > > 
> > > > Thank you for the quick reply --  See attached
> > >  From the IO trace, discard command(nvme_cmd_dsm) is failed:
> > > 
> > >    kworker/15:1H-462   [015] .... 91814.342452: nvme_setup_cmd:
> > > nvme0: disk=nvme0n1, qid=7, cmdid=552, nsid=1, flags=0x0, meta=0x0,
> > > cmd=(nvme_cmd_dsm nr=0, attributes=4)
> > >            <idle>-0     [013] d.h. 91814.342708: nvme_complete_rq:
> > > nvme0: disk=nvme0n1, qid=7, cmdid=552, res=0, retries=0, flags=0x0,
> > > status=8198
> > > 
> > > And the returned error code is 0x8198, I am not sure how to parse the
> > > 'Command Specific Status Values' of 0x98, maybe Christoph, Keith or
> > > our other
> > > NVMe guys can help to understand the failure.
> > > 
> > > 
> > > Thanks,
> > > Ming
> > 
> > Long story short we have 3 new PCI Gen 4 SSD - NVMe drives from
> > Gigabyte. But actually, Gigabyte is just putting their name on it as I
> > believe it is actually from "Phison".
> > 
> > Here is the website where you can see the new drives --
> > https://www.gigabyte.com/Solid-State-Drive/Gen-4
> > 
> > I have opened a ticket with Gigabyte, and have inquired about any
> > available firmware updates. It will take 3-5 days to hear back from
> > them, but will report back the finding.
> > 
> > Thank you for taking a look at the tracing file, and hopefully that
> > gives enough insight as to what might be happening.
> > 
> > Best Regards,
> > 
> > David
> > 
> > 
> I have attempted to CC ilnux-nvme@lists.infradead.org, but receive a
> immediate notification " 550 Unknown recipient ".  So it just gets bounced
> back to me.

It should have been linux-nvme@lists.infradead.org.

Thanks,
Ming
