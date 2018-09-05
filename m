Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:50654 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeIEOOx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Sep 2018 10:14:53 -0400
Received: by mail-it0-f43.google.com with SMTP id j81-v6so9050082ite.0
        for <linux-block@vger.kernel.org>; Wed, 05 Sep 2018 02:45:28 -0700 (PDT)
From: Kashyap Desai <kashyap.desai@broadcom.com>
References: <eccc46e12890a1d033d9003837012502@mail.gmail.com>
 <20180829084618.GA24765@ming.t460p> <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com>
 <CACVXFVM7nGxpyq0_jfshgBOTx5B+PuCDmN43SfPTCkENJRLpMg@mail.gmail.com>
 <615d78004495aebc53807156d04d988c@mail.gmail.com> <alpine.DEB.2.21.1808312207390.1349@nanos.tec.linutronix.de>
 <486f94a563d63c4779498fe8829a546c@mail.gmail.com> <alpine.DEB.2.21.1809010020520.1349@nanos.tec.linutronix.de>
 <602cee6381b9f435a938bbaf852d07f9@mail.gmail.com> <alpine.DEB.2.21.1809021357000.1349@nanos.tec.linutronix.de>
 <66256272c020be186becdd7a3f049302@mail.gmail.com> <alpine.DEB.2.21.1809031719460.1383@nanos.tec.linutronix.de>
 <dd1c5df55aa99cf4a37bcc58e77e840a@mail.gmail.com> <f436fa6a-b865-fadb-4f77-44309ff84405@163.com>
In-Reply-To: <f436fa6a-b865-fadb-4f77-44309ff84405@163.com>
MIME-Version: 1.0
Date: Wed, 5 Sep 2018 15:15:20 +0530
Message-ID: <c0f779f1d5ef131c39f9397f97d453e8@mail.gmail.com>
Subject: RE: Affinity managed interrupts vs non-managed interrupts
To: Dou Liyang <dou_liyang@163.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Ming Lei <tom.leiming@gmail.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shivasharan Srikanteshwara
        <shivasharan.srikanteshwara@broadcom.com>,
        linux-block <linux-block@vger.kernel.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> Hi Thomas, Kashyap,
>
> At 09/04/2018 06:29 PM, Kashyap Desai wrote:
> >>> I am using " for-4.19/block " and this particular patch "a0c9259
> >>> irq/matrix: Spread interrupts on allocation" is included.
> >>
>
> IMO, this patch is just used for non-managed interrupts.
>
> >> So if all 16 have their effective affinity set to CPU0 then that's
> > strange
>
> But, all these 16 are managed interrupts, and will be assigned vectors
> by assign_managed_vector():
> {
>      cpumask_and(vector_searchmask, vector_searchmask, affmsk);
>      cpu = cpumask_first(vector_searchmask);
>
>      ...
>      vector = irq_matrix_alloc_managed(vector_matrix, cpu);
>      ...
> }
>
> Where we always used the *first* cpu in the vector_searchmask(0-71), not
> the suitable one. So I guess this situation happened.
>
> Shall we also spread the managed interrupts on allocation?


Hi Dou,

I tried your proposed patch. Using patch, It is not assigning effective irq
to CPU = 0 , but it pick *one* cpu from 0-71 range.
Eventually, effective cpu is always *one* logical cpu. Behavior is
different, but impact is still same.
