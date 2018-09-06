Return-Path: <linux-block-owner@vger.kernel.org>
Received: from m12-13.163.com ([220.181.12.13]:49338 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbeIFOuQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Sep 2018 10:50:16 -0400
Subject: Re: Affinity managed interrupts vs non-managed interrupts
To: Thomas Gleixner <tglx@linutronix.de>,
        Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Ming Lei <tom.leiming@gmail.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shivasharan Srikanteshwara
        <shivasharan.srikanteshwara@broadcom.com>,
        linux-block <linux-block@vger.kernel.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
References: <eccc46e12890a1d033d9003837012502@mail.gmail.com>
 <20180829084618.GA24765@ming.t460p>
 <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com>
 <CACVXFVM7nGxpyq0_jfshgBOTx5B+PuCDmN43SfPTCkENJRLpMg@mail.gmail.com>
 <615d78004495aebc53807156d04d988c@mail.gmail.com>
 <alpine.DEB.2.21.1808312207390.1349@nanos.tec.linutronix.de>
 <486f94a563d63c4779498fe8829a546c@mail.gmail.com>
 <alpine.DEB.2.21.1809010020520.1349@nanos.tec.linutronix.de>
 <602cee6381b9f435a938bbaf852d07f9@mail.gmail.com>
 <alpine.DEB.2.21.1809021357000.1349@nanos.tec.linutronix.de>
 <66256272c020be186becdd7a3f049302@mail.gmail.com>
 <alpine.DEB.2.21.1809031719460.1383@nanos.tec.linutronix.de>
 <dd1c5df55aa99cf4a37bcc58e77e840a@mail.gmail.com>
 <f436fa6a-b865-fadb-4f77-44309ff84405@163.com>
 <c0f779f1d5ef131c39f9397f97d453e8@mail.gmail.com>
 <alpine.DEB.2.21.1809051235180.1416@nanos.tec.linutronix.de>
From: Dou Liyang <dou_liyang@163.com>
Message-ID: <d2a6f7cf-31df-de17-82e3-eccb9cc73ed8@163.com>
Date: Thu, 6 Sep 2018 18:14:50 +0800
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1809051235180.1416@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Thomas,

At 09/05/2018 06:38 PM, Thomas Gleixner wrote:
> Oh well. This was not intended to magically provide the solution you want
> to have. It merily changed the behaviour of the managed interrupt
> selection, which is a valid thing to do independent of the stuff you want
> to see.
> 

Thank you for clarifying it, I will send the patch independently.

> As I said that needs more thought and I really can't tell when I have a
> time slot to look at that.
> 

In this period, I am willing to be a volunteer to try to do that you
said in the previous reply. May I?


Thanks
	dou
