Return-Path: <bjking1@us.ibm.com>
MIME-Version: 1.0
In-Reply-To: <92379297-9667-ae52-b05c-6c8a0ce4751c@kernel.dk>
Subject: Re: blk_mq_sched_insert_request: inconsistent {SOFTIRQ-ON-W} ->
 {IN-SOFTIRQ-W} usage
To: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman
 <mpe@ellerman.id.au>, brking@linux.vnet.ibm.com
From: "Brian J King" <bjking1@us.ibm.com>
Date: Fri, 28 Jul 2017 10:17:38 -0500
References: <87a83qfosu.fsf@concordia.ellerman.id.au>
 <073ed79c-11ce-e86c-a905-91fd28675d47@kernel.dk>
 <1501166846.2516.1.camel@wdc.com>
 <5b85a365-faa1-3987-9b6b-270399c30686@kernel.dk>
 <87lgn9dqx3.fsf@concordia.ellerman.id.au>
 <92379297-9667-ae52-b05c-6c8a0ce4751c@kernel.dk>
Content-type: multipart/alternative;
	Boundary="0__=09BB0BF8DFC04E1E8f9e8a93df938690918c09BB0BF8DFC04E1E"
Message-Id: <OF186C0C54.7E077412-ON8625816B.0053C88E-8625816B.00540312@notes.na.collabserv.com>
List-ID: <linux-block@vger.kernel.org>


--0__=09BB0BF8DFC04E1E8f9e8a93df938690918c09BB0BF8DFC04E1E
Content-Transfer-Encoding: quoted-printable
Content-type: text/plain; charset=US-ASCII

Jens Axboe <axboe@kernel.dk> wrote on 07/28/2017 09:25:48 AM:

> Can you try the below fix? Should be more palatable than the previous
> one. Brian, maybe you can take a look at the IRQ issue mentioned above?

Working on an ipr change to address the IRQ issue.

-Brian

--0__=09BB0BF8DFC04E1E8f9e8a93df938690918c09BB0BF8DFC04E1E
Content-Transfer-Encoding: quoted-printable
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body><p><tt><font size=3D"2">Jens Axboe &lt;axboe@kernel.dk&gt; wrot=
e on 07/28/2017 09:25:48 AM:<br><br>&gt; Can you try the below fix? Should =
be more palatable than the previous<br>&gt; one. Brian, maybe you can take =
a look at the IRQ issue mentioned above?</font></tt><br><br><tt><font size=
=3D"2">Working on an ipr change to address the IRQ issue.</font></tt><br><b=
r><tt><font size=3D"2">-Brian</font></tt><br><BR>
</body></html>

--0__=09BB0BF8DFC04E1E8f9e8a93df938690918c09BB0BF8DFC04E1E--
