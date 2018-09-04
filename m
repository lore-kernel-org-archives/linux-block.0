Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:37827 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbeIDOyG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Sep 2018 10:54:06 -0400
Received: by mail-it0-f53.google.com with SMTP id h20-v6so4135064itf.2
        for <linux-block@vger.kernel.org>; Tue, 04 Sep 2018 03:29:36 -0700 (PDT)
From: Kashyap Desai <kashyap.desai@broadcom.com>
References: <eccc46e12890a1d033d9003837012502@mail.gmail.com>
 <20180829084618.GA24765@ming.t460p> <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com>
 <CACVXFVM7nGxpyq0_jfshgBOTx5B+PuCDmN43SfPTCkENJRLpMg@mail.gmail.com>
 <615d78004495aebc53807156d04d988c@mail.gmail.com> <alpine.DEB.2.21.1808312207390.1349@nanos.tec.linutronix.de>
 <486f94a563d63c4779498fe8829a546c@mail.gmail.com> <alpine.DEB.2.21.1809010020520.1349@nanos.tec.linutronix.de>
 <602cee6381b9f435a938bbaf852d07f9@mail.gmail.com> <alpine.DEB.2.21.1809021357000.1349@nanos.tec.linutronix.de>
 <66256272c020be186becdd7a3f049302@mail.gmail.com> <alpine.DEB.2.21.1809031719460.1383@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809031719460.1383@nanos.tec.linutronix.de>
MIME-Version: 1.0
Date: Tue, 4 Sep 2018 15:59:34 +0530
Message-ID: <dd1c5df55aa99cf4a37bcc58e77e840a@mail.gmail.com>
Subject: RE: Affinity managed interrupts vs non-managed interrupts
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ming Lei <tom.leiming@gmail.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shivasharan Srikanteshwara
        <shivasharan.srikanteshwara@broadcom.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>
> On Mon, 3 Sep 2018, Kashyap Desai wrote:
> > I am using " for-4.19/block " and this particular patch "a0c9259
> > irq/matrix: Spread interrupts on allocation" is included.
>
> Can you please try against 4.19-rc2 or later?
>
> > I can see that 16 extra reply queues via pre_vectors are still
assigned to
> > CPU 0 (effective affinity ).
> >
> > irq 33, cpu list 0-71
>
> The cpu list is irrelevant because that's the allowed affinity mask. The
> effective one is what counts.
>
> > # cat /sys/kernel/debug/irq/irqs/34
> > node:     0
> > affinity: 0-71
> > effectiv: 0
>
> So if all 16 have their effective affinity set to CPU0 then that's
strange
> at least.
>
> Can you please provide the output of
> /sys/kernel/debug/irq/domains/VECTOR ?

I tried 4.19-rc2. Same behavior as I posted earlier. All 16 pre_vector irq
has effective CPU = 0.

Here is output of "/sys/kernel/debug/irq/domains/VECTOR"

# cat /sys/kernel/debug/irq/domains/VECTOR
name:   VECTOR
 size:   0
 mapped: 360
 flags:  0x00000041
Online bitmaps:       72
Global available:  13062
Global reserved:      86
Total allocated:     274
System: 43: 0-19,32,50,128,236-255
 | CPU | avl | man | act | vectors
     0   169    17    32  33-49,51-65
     1   181    17     4  33,36,52-53
     2   181    17     4  33-36
     3   181    17     4  33-34,52-53
     4   181    17     4  33,35,53-54
     5   181    17     4  33,35-36,54
     6   182    17     3  33,35-36
     7   182    17     3  33-34,36
     8   182    17     3  34-35,53
     9   181    17     4  33-34,52-53
    10   182    17     3  34,36,53
    11   182    17     3  34-35,54
    12   182    17     3  33-34,53
    13   182    17     3  33,37,55
    14   181    17     4  33-36
    15   181    17     4  33,35-36,54
    16   181    17     4  33,35,53-54
    17   182    17     3  33,36-37
    18   181    17     4  33,36,54-55
    19   181    17     4  33,35-36,54
    20   181    17     4  33,35-37
    21   180    17     5  33,35,37,55-56
    22   181    17     4  33-36
    23   181    17     4  33,35,37,55
    24   180    17     5  33-36,54
    25   181    17     4  33-36
    26   181    17     4  33-35,54
    27   181    17     4  34-36,54
    28   181    17     4  33-35,53
    29   182    17     3  34-35,53
    30   182    17     3  33-35
    31   181    17     4  34-36,54
    32   182    17     3  33-34,53
    33   182    17     3  34-35,53
    34   182    17     3  33-34,53
    35   182    17     3  34-36
    36   182    17     3  33-34,53
    37   181    17     4  33,35,52-53
    38   182    17     3  34-35,53
    39   182    17     3  34,52-53
    40   182    17     3  33-35
    41   182    17     3  34-35,53
    42   182    17     3  33-35
    43   182    17     3  34,52-53
    44   182    17     3  33-34,53
    45   182    17     3  34-35,53
    46   182    17     3  34,36,54
    47   182    17     3  33-34,52
    48   182    17     3  34,36,54
    49   182    17     3  33,51-52
    50   181    17     4  33-36
    51   182    17     3  33-35
    52   182    17     3  33-35
    53   182    17     3  34-35,53
    54   182    17     3  33-34,53
    55   182    17     3  34-36
    56   181    17     4  33-35,53
    57   182    17     3  34-36
    58   182    17     3  33-34,53
    59   181    17     4  33-35,53
    60   181    17     4  33-35,53
    61   182    17     3  33-34,53
    62   182    17     3  33-35
    63   182    17     3  34-36
    64   182    17     3  33-34,54
    65   181    17     4  33-35,53
    66   182    17     3  33-34,54
    67   182    17     3  34-36
    68   182    17     3  33-34,54
    69   182    17     3  34,36,54
    70   182    17     3  33-35
    71   182    17     3  34,36,54

>
> > Ideally, what we are looking for 16 extra pre_vector reply queue is
> > "effective affinity" to be within local numa node as long as that numa
> > node has online CPUs. If not, we are ok to have effective cpu from any
> > node.
>
> Well, we surely can do the initial allocation and spreading on the local
> numa node, but once all CPUs are offline on that node, then the whole
thing
> goes down the drain and allocates from where it sees fit. I'll think
about
> it some more, especially how to avoid the proliferation of the affinity
> hint.

Thanks for looking this request. This will help us to implement WIP
megaraid_sas driver changes.  I can test any patch you want me to try.

>
> Thanks,
>
> 	tglx
