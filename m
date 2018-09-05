Return-Path: <linux-block-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:59174 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIEPIR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Sep 2018 11:08:17 -0400
Date: Wed, 5 Sep 2018 12:38:30 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Kashyap Desai <kashyap.desai@broadcom.com>
cc: Dou Liyang <dou_liyang@163.com>, Ming Lei <tom.leiming@gmail.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shivasharan Srikanteshwara
        <shivasharan.srikanteshwara@broadcom.com>,
        linux-block <linux-block@vger.kernel.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: RE: Affinity managed interrupts vs non-managed interrupts
In-Reply-To: <c0f779f1d5ef131c39f9397f97d453e8@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1809051235180.1416@nanos.tec.linutronix.de>
References: <eccc46e12890a1d033d9003837012502@mail.gmail.com> <20180829084618.GA24765@ming.t460p> <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com> <CACVXFVM7nGxpyq0_jfshgBOTx5B+PuCDmN43SfPTCkENJRLpMg@mail.gmail.com> <615d78004495aebc53807156d04d988c@mail.gmail.com>
 <alpine.DEB.2.21.1808312207390.1349@nanos.tec.linutronix.de> <486f94a563d63c4779498fe8829a546c@mail.gmail.com> <alpine.DEB.2.21.1809010020520.1349@nanos.tec.linutronix.de> <602cee6381b9f435a938bbaf852d07f9@mail.gmail.com> <alpine.DEB.2.21.1809021357000.1349@nanos.tec.linutronix.de>
 <66256272c020be186becdd7a3f049302@mail.gmail.com> <alpine.DEB.2.21.1809031719460.1383@nanos.tec.linutronix.de> <dd1c5df55aa99cf4a37bcc58e77e840a@mail.gmail.com> <f436fa6a-b865-fadb-4f77-44309ff84405@163.com>
 <c0f779f1d5ef131c39f9397f97d453e8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 5 Sep 2018, Kashyap Desai wrote:
> > Shall we also spread the managed interrupts on allocation?
> 
> I tried your proposed patch. Using patch, It is not assigning effective irq
> to CPU = 0 , but it pick *one* cpu from 0-71 range.
> Eventually, effective cpu is always *one* logical cpu. Behavior is
> different, but impact is still same.

Oh well. This was not intended to magically provide the solution you want
to have. It merily changed the behaviour of the managed interrupt
selection, which is a valid thing to do independent of the stuff you want
to see.

As I said that needs more thought and I really can't tell when I have a
time slot to look at that.

Thanks,

	tglx
