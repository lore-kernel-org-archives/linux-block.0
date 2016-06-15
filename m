Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54250 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753146AbcFONJl (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 15 Jun 2016 09:09:41 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5FD4ZZ2129889
	for <linux-block@vger.kernel.org>; Wed, 15 Jun 2016 09:09:41 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23jgpekek4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 15 Jun 2016 09:09:40 -0400
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-block@vger.kernel.org> from <gpiccoli@linux.vnet.ibm.com>;
	Wed, 15 Jun 2016 10:09:38 -0300
Subject: Re: [PATCH 06/13] irq: add a helper spread an affinity mask for
 MSI/MSI-X vectors
To: Christoph Hellwig <hch@lst.de>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
 <1465934346-20648-7-git-send-email-hch@lst.de>
 <57607D0E.1060907@linux.vnet.ibm.com> <20160615101045.GB16425@lst.de>
Cc: linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@fb.com, tglx@linutronix.de, bart.vanassche@sandisk.com
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Wed, 15 Jun 2016 10:09:33 -0300
MIME-Version: 1.0
In-Reply-To: <20160615101045.GB16425@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <5761538D.6060303@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Thanks for the responses Bart and Christoph.


On 06/15/2016 07:10 AM, Christoph Hellwig wrote:
> On Tue, Jun 14, 2016 at 06:54:22PM -0300, Guilherme G. Piccoli wrote:
>> On 06/14/2016 04:58 PM, Christoph Hellwig wrote:
>>> This is lifted from the blk-mq code and adopted to use the affinity mask
>>> concept just intruced in the irq handling code.
>>
>> Very nice patch Christoph, thanks. There's a little typo above, on
>> "intruced".
>
> fixed.
>
>> Another little typo above in "assining".
>
> fixed a swell.
>
>> I take this opportunity to ask you something, since I'm working in a
>> related code in a specific driver
>
> Which driver?  One of the points here is to get this sort of code out
> of drivers and into common code..

A network driver, i40e. I'd be glad to implement/see some common code to 
raise the topology information I need, but I was implementing on i40e 
more as a test case/toy example heheh...


>> - sorry in advance if my question is
>> silly or if I misunderstood your code.
>>
>> The function irq_create_affinity_mask() below deals with the case in which
>> we have nr_vecs < num_online_cpus(); in this case, wouldn't be a good idea
>> to trying distribute the vecs among cores?
>>
>> Example: if we have 128 online cpus, 8 per core (meaning 16 cores) and 64
>> vecs, I guess would be ideal to distribute 4 vecs _per core_, leaving 4
>> CPUs in each core without vecs.
>
> There have been some reports about the blk-mq IRQ distribution being
> suboptimal, but no one sent patches so far.  This patch just moves the
> existing algorithm into the core code to be better bisectable.
>
> I think an algorithm that takes cores into account instead of just SMT
> sibling would be very useful.  So if you have a case where this helps
> for you an incremental patch (or even one against the current blk-mq
> code for now) would be appreciated.

...but now I'll focus on the common/general case! Thanks for the 
suggestion Christoph. I guess would be even better to have a generic 
function that retrieves an optimal mask, something like 
topology_get_optimal_mask(n, *cpumask), in which we get the best 
distribution of n CPUs among all cores and return such a mask - 
interesting case is when n < num_online_cpus. So, this function could be 
used inside your irq_create_affinity_mask() and maybe in other places it 
is needed.

I was planning to use topology_core_id() to retrieve the core of a CPU, 
if anybody has a better idea, I'd be glad to hear it.

Cheers,


Guilherme


>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>

