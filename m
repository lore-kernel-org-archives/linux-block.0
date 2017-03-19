Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH RFC 00/14] Add the BFQ I/O Scheduler to blk-mq
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1489859192.2339.12.camel@sandisk.com>
Date: Sun, 19 Mar 2017 08:14:51 -0400
Cc: "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "fchecconi@gmail.com" <fchecconi@gmail.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "broonie@kernel.org" <broonie@kernel.org>,
 Arianna Avanzini <avanzini.arianna@gmail.com>,
 "tj@kernel.org" <tj@kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Message-Id: <DDB42872-878A-4CB1-AEB1-073D03F1F908@linaro.org>
References: <20170304160131.57366-1-paolo.valente@linaro.org> <1488848390.3125.14.camel@sandisk.com> <81048010-02AB-4A7A-8C10-FAF7E3242DCC@linaro.org> <1489509154.2676.6.camel@sandisk.com> <A8A05E9B-2FDF-4986-833E-166D92DFEF4F@linaro.org> <CACRpkdZhA8FY2FH_fnTsnPotZoZwX5qUfhdavWLwfzcnLkZUMQ@mail.gmail.com> <1489859192.2339.12.camel@sandisk.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 18 mar 2017, alle ore 13:46, Bart Van Assche =
<bart.vanassche@sandisk.com> ha scritto:
>=20
> On Sat, 2017-03-18 at 18:09 +0100, Linus Walleij wrote:
>> On Sat, Mar 18, 2017 at 11:52 AM, Paolo Valente
>> <paolo.valente@linaro.org> wrote:
>>>> Il giorno 14 mar 2017, alle ore 16:32, Bart Van Assche =
<bart.vanassche@sandisk.com> ha scritto:
>>>> (...) what should
>>>> a developer do who only has access to a small subset of all the =
storage
>>>> devices that are supported by the Linux kernel and hence who can =
not run the
>>>> benchmark against every supported storage device?
>>=20
>> Don't we use the community for that? We are dependent on people
>> downloading and testing our code eventually, I mean sure it's good if
>> we make some reasonable effort to test changes we do, but we are
>> only humans, and we get corrected by the experience of other humans.
>=20
> Hello Linus,
>=20
> Do you mean relying on the community to test other storage devices =
before
> or after a patch is upstream? Relying on the community to file bug =
reports
> after a patch is upstream would be wrong. The Linux kernel should not =
be
> used for experiments. As you know patches that are sent upstream =
should
> not introduce regressions.
>=20
> My primary concern about BFQ is that it is a very complicated I/O =
scheduler
> and also that the concepts used internally in that I/O scheduler are =
far
> away from the concepts we are used to when reasoning about I/O =
devices.

Hi Bart,
could you elaborate a little bit more on this?  To hopefully help you
highlight where the problem is, here is a summary of what the patches
introduce.

1.  BFQ engine.  This initial piece of code has been obtained mainly
by copying (verbatim) CFQ, replacing all cfq_ prefixes with bfq_,
replacing the round-robin algorithm at the hearth of BFQ with wf2q+, a
well-know and widely studied variant of the classical wfq algorithm,
and, finally, by adapting the code around the new engine to accomodate
the latter.  In particular, budgets, measured in number of sectors, are
used instead of time slices, to achieve bandwidth fairness.

2. Support for cgroups and hierarchical scheduling.

3.  Heuristics to improve service quality and boost throughput.  These
additional pieces are introduced and documented one by one.  The most
complex are: improving responsiveness by privileging the I/O of
interactive applications, improving audio/video playback/streaming by
privileging their I/O, boosting throughput with interleaved I/O (such
as KVM I/O) by merging the queues associated with the processes doing
such an I/O, boosting throughput for applications that span several
processes.

Which of these contributions contain deviations from the I/O concepts
you are used to, and what are these deviations?

Thanks,
Paolo


> I'm
> concerned that this will make the BFQ I/O scheduler hard to maintain.
>=20
> Bart.
