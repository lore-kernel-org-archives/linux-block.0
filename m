Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:41780 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbeIKOHx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Sep 2018 10:07:53 -0400
Date: Tue, 11 Sep 2018 11:13:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dou Liyang <dou_liyang@163.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shivasharan Srikanteshwara
        <shivasharan.srikanteshwara@broadcom.com>,
        linux-block <linux-block@vger.kernel.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: Affinity managed interrupts vs non-managed interrupts
Message-ID: <20180911091354.GA9898@lst.de>
References: <602cee6381b9f435a938bbaf852d07f9@mail.gmail.com> <alpine.DEB.2.21.1809021357000.1349@nanos.tec.linutronix.de> <66256272c020be186becdd7a3f049302@mail.gmail.com> <alpine.DEB.2.21.1809031719460.1383@nanos.tec.linutronix.de> <dd1c5df55aa99cf4a37bcc58e77e840a@mail.gmail.com> <f436fa6a-b865-fadb-4f77-44309ff84405@163.com> <c0f779f1d5ef131c39f9397f97d453e8@mail.gmail.com> <alpine.DEB.2.21.1809051235180.1416@nanos.tec.linutronix.de> <d2a6f7cf-31df-de17-82e3-eccb9cc73ed8@163.com> <alpine.DEB.2.21.1809061244151.1570@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.21.1809061244151.1570@nanos.tec.linutronix.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 06, 2018 at 01:46:46PM +0200, Thomas Gleixner wrote:
> There are a few things we need to clarify upfront:
> 
> Right now the pre and post vectors are marked managed and their
> affinity mask is set to the irq default affinity mask.
> 
> The default affinity mask is by default ALL cpus, but it can be tweaked
> both on the kernel command line and via proc.
> 
> If that mask is only a subset of CPUs and all of them go offline
> then these vectors are shutdown in managed mode.
> 
> That means we need to set the affinity mask of the pre and post vectors to
> possible mask, but that doesn't make much sense either, unless there is a
> reason to have them marked managed.
> 
> I think the right solution for these pre/post vectors is to _NOT_ mark
> them managed and leave them as regular interrupts which can be affinity
> controlled and also can move freely on hotplug.

Yes, agreed.  Marking the pre/post vector as managed was a mistake
(and I don't think it even was intentional, at least on my part).
