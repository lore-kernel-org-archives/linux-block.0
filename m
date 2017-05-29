Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38215 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbdE2Ji0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 May 2017 05:38:26 -0400
Received: by mail-wm0-f51.google.com with SMTP id e127so52130192wmg.1
        for <linux-block@vger.kernel.org>; Mon, 29 May 2017 02:38:25 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: BFQ: the purpose of idle rb-tree in bfq_service_tree
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <ac72a25b-c96d-6c3a-8108-9cd546a882c3@huawei.com>
Date: Mon, 29 May 2017 11:38:21 +0200
Cc: linux-block@vger.kernel.org
Message-Id: <6C00EE5A-DAD7-4E40-AF16-6032674BEF4B@linaro.org>
References: <ac72a25b-c96d-6c3a-8108-9cd546a882c3@huawei.com>
To: Hou Tao <houtao1@huawei.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 25 mag 2017, alle ore 15:18, Hou Tao <houtao1@huawei.com> ha =
scritto:
>=20
> Hi Paolo,
>=20
> I am reading the code of BFQ scheduler and having a question about the =
purpose
> of idle rb-tree in bfq_service_tree.
>=20

Hi,
thank you very much for this question.  It concerns the most complex
part, conceptually, of BFQ: its very small but non-trivial scheduling
engine.  So this question is a great opportunity for me to
re-describe again this part, and hopefully clarify it even better by
replying to your possible next questions.

> =46rom the comment in code, the idle rb-tree is used to keep the =
bfq_queue which
> doesn't have any request and has a finish time greater than the vtime =
of the
> service tree.
>=20
> The only function that I can find and reveals the purpose of the idle =
rb-tree is
> __bfq_activate_entity(). In this function, when the activated queue =
had been on
> the idle tree, the start time of the queue will be reset to the =
greater value
> between min_vstart and finish time. It seems to me that the idle =
rb-tree is used
> to delay the schedule of the queue which issues requests periodically, =
but I don't
> known why the delay is needed. Could you please explain the purpose of =
the idle
> rb-tree in bf_service_tree and its main scenario ?
>=20


You have already gone so in depth, that I'll have to pay a lot of
attention to being correct :) I'll try to be as short as possible, but
not omit any relevant detail in this first reply.

The idle tree serves actually two purposes.

This first is the one you are asking about: guaranteeing that the
finish time of an idle entity can still be considered valid.  In this
respect, the underlying question is: why is it important that the new
(virtual) start time of a queue is never lower than both its last =
(virtual)
finish time and that other stared min_vstart quantity?

To answer this question, let me add just an extra bit of information:
one of the core operations of BFQ, or more precisely, of its engine
B-WF2Q+, is to constantly update a quantity called system virtual
time.  This quantity tracks the service provided by the ideal system
that BFQ emulates.  This ideal system magically serves all competing
(active) queues at the same time, providing each queue with a fraction
of the total bandwidth equal to ratio between the weight of the queue
and the sum of the weights of all active queues.  Skipping any precise
but boring definition, in the ideal system the next budget of a queue
starts to be served exactly when the system virtual time becomes equal
to the (virtual) start time of the queue, and finishes to be served
exactly when the system virtual time becomes equal to the (virtual)
finish time of the queue.  Intuitively, the system virtual time
magically summarizes, in one number, the point at which the ideal
system is in serving every active queue.

What's the purpose of the system virtual time?  Enabling queues to be
assigned exactly the (virtual) start time that guarantees that they
receive an amount of service as close as possible to the ideal one.
I.e., such that they do not receive too much, because their (virtual)
start time is too low than that of the other queues, or that they
receive too little, because their (virtual) start time is too high.

How does the system virtual time let BFQ achieve this goal?  The
system virtual time comes into play in the following case: an idle
queue becomes active again, at a time t, *after* the last budget of
the queue would have finished to be served in the ideal system.
According to what I wrote above, at time t the system virtual time,
which hereafter we call call V for brevity, is higher than the virtual
finish time of the queue (it was equal to the finish time when the
ideal system finished to served this budget, then it has grown to
higher values).  Of course, the new budget of the queue would
immediately start to be served in the ideal system at time t.  Still
according to what I wrote above, numerically, this means that the
(virtual) start time of the queue must be equal to V.  In this
respect, the quantity min_vstart that you mention is computed exactly
as a function of V, and for our purposes here can be considered to be
just equal to V.  So, to sum up, and calling for brevity S the virtual
start time of the queue, the formula you have seen just assigns S=3DV in
this case.  It can be proven mathematically that this assignment,
combined with the serve-queues-in-timestamp order of BFQ, is exactly
what is needed to let BFQ approximate the ideal service as close as
possible.

If you are still reading, and do not have already a terrible headache,
you may now ask: why in that formula we don't just assign S=3DV, but
compute S=3Dmax(V, F), where F is the last value of the (virtual) finish
time of the queue?  The reason stems from the second case to consider:
an idle queue that becomes active again at a time instant t *before*
when the ideal system would have finished the last budget of the
queue!  This can easily happen, because the real system serves one
queue at a time, while the ideal system serves all queues at the same
time, but serves each queue 'slowly'.  So, if there are several queues
waiting to be served in the real system, the one that is served first
will certainly finish its budget before the time instant at which it
would have slowly finished its budget in the ideal system.  If this
queue also becomes idle after this budget is served, then it may
become active again so soon that the ideal system has not yet finished
the last budget of the queue.  To approximate the ideal system
closely, the new budget of the queue MUST NOT be served soon, because
the ideal system is still serving the old budget!

Again, numerically, this translates into the fact that, at time t, the
system virtual time V is still *lower* than the current (virtual)
finish time F of the queue.  And here is where the max in the formula
S=3Dmax(V, F) come insto play: it guarantees that, in this case, the new
(virtual) start time S of the queue is equal to F, i.e., to the value
that V will finally reach exactly when it starts to serve the next
budget of the queue.  Then, also in this case, the (virtual) start
time S of the queue will match as close as possible what happens in
the ideal system, and serving the queue according to its timestamps
will let BFQ provide the queue with a service as close as possible to
the ideal one.

If you still have energies and will to read, then, shortly, the other
use of the idle tree is to keep the "sum of the weights" up-to-date.
This quantity is equal to the sum of the weights of (only) the queues
that are active in the ideal system.  To correctly update V, BFQ needs
to know this value.  And, according to second case discussed above, a
queue may STILL REMAIN active in the ideal system for a while, even
after it has become idle in the real system.  The purpose of the idle
tree is to keep track exactly of these zombie queues: (it can be
proven mathematically that, according to the rules by which an idle
queue is inserted into and removed from the idle tree,) only when an
idle queue can be finally removed from the idle tree, the weight of
such a queue can be subtracted from the sum of the weights for the
ideal system.

I guess it's better (or even already to late :) ) if I stop here.  As
you can imagine, I'm willing to answer any further question, hopefully
more synthetically now that I should have brought to the table all
relevant details.

Thanks,
Paolo

> Thanks,
> Tao
>=20
