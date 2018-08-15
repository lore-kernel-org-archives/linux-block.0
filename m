Return-Path: <linux-scsi-owner@vger.kernel.org>
MIME-Version: 1.0
From: Kashyap Desai <kashyap.desai@broadcom.com>
Date: Wed, 15 Aug 2018 21:44:33 +0530
Message-ID: <CAHsXFKFVUJUi3VMrB=iRxFjspt4q-zQgWP60k6GAaUCB-BGb2A@mail.gmail.com>
Subject: irq poll and threaded isr interrupt polling
To: linux-block@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Peter Rivera <peter.rivera@broadcom.com>,
        Steve Hagan <steve.hagan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Hi,


I refer below thread for interrupt polling related discussion for
storage devices (NVME/HBA).


http://lists.infradead.org/pipermail/linux-nvme/2017-January/007749.html


I am trying to evaluate the similar concept to reduce interrupts using
irq-poll and threaded ISR. Below is high level changes I did in my
experiment.



In megaraid_sas driver, I schedule irq poll using =E2=80=9Cirq_poll_sched=
=E2=80=9D and
disable that particular IRQ line. I was expecting more completion
after I disable irq line, but in most of the cases  just one
completion happened from irq poll context. It must be due to host side
processing is much faster than IO processing at back end device.
Similar observation was posted in above mentioned thread as well. I
added manual wait using =E2=80=9Cudelay()=E2=80=9D and wait for some more t=
ime in irq
poll context. Using additional wait, I am able to reduce interrupt per
seconds and performance impact on latency is not visible since I
choose udelay(1). One drawback I see is overall CPU utilization goes
up since driver is using extra delay to reduce interrupts.



To overcome CPU utilization issue, I switch to threaded ISR and
replace udelay() with usleep().  Using threaded interrupt based
polling CPU utilization goes to normal.



I am trying to understand what is a drawback using threaded ISR and
doing interrupt polling from threaded ISR.  One problem I understood
is threaded ISR can be preempted by other high priority context (most
likely soft/hard interrupt).  If threaded interrupt is running on some
CPU-x and some other device is also requesting interrupt on same
CPU-x, there can be latency introduced because CPU-x will complete ISR
before it can run threaded ISR.



Thanks, Kashyap
