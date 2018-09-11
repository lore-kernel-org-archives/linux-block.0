Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:41823 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbeIKOQz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Sep 2018 10:16:55 -0400
Date: Tue, 11 Sep 2018 11:22:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shivasharan Srikanteshwara
        <shivasharan.srikanteshwara@broadcom.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: Affinity managed interrupts vs non-managed interrupts
Message-ID: <20180911092254.GB10330@lst.de>
References: <eccc46e12890a1d033d9003837012502@mail.gmail.com> <20180829084618.GA24765@ming.t460p> <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com> <CACVXFVM7nGxpyq0_jfshgBOTx5B+PuCDmN43SfPTCkENJRLpMg@mail.gmail.com> <615d78004495aebc53807156d04d988c@mail.gmail.com> <alpine.DEB.2.21.1808312207390.1349@nanos.tec.linutronix.de> <486f94a563d63c4779498fe8829a546c@mail.gmail.com> <alpine.DEB.2.21.1809010020520.1349@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.21.1809010020520.1349@nanos.tec.linutronix.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Sep 01, 2018 at 12:48:46AM +0200, Thomas Gleixner wrote:
> > We want some changes in current API which can allow us to  pass flags
> > (like *local numa affinity*) and cpu-msix mapping are from local numa node
> > + effective cpu are spread across local numa node.
> 
> What you really want is to split the vector space for your device into two
> blocks. One for the regular per cpu queues and the other (16 or how many
> ever) which are managed separately, i.e. spread out evenly. That needs some
> extensions to the core allocation/management code, but that shouldn't be a
> huge problem.

Note that there are some other uses cases for multiple sets of affinity
managed irqs.  Various network devices insist on having separate TX vs
RX interrupts for example.
