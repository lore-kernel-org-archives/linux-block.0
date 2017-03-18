Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <A8A05E9B-2FDF-4986-833E-166D92DFEF4F@linaro.org>
References: <20170304160131.57366-1-paolo.valente@linaro.org>
 <1488848390.3125.14.camel@sandisk.com> <81048010-02AB-4A7A-8C10-FAF7E3242DCC@linaro.org>
 <1489509154.2676.6.camel@sandisk.com> <A8A05E9B-2FDF-4986-833E-166D92DFEF4F@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 18 Mar 2017 18:09:41 +0100
Message-ID: <CACRpkdZhA8FY2FH_fnTsnPotZoZwX5qUfhdavWLwfzcnLkZUMQ@mail.gmail.com>
Subject: Re: [PATCH RFC 00/14] Add the BFQ I/O Scheduler to blk-mq
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "fchecconi@gmail.com" <fchecconi@gmail.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, Arianna Avanzini <avanzini.arianna@gmail.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "tj@kernel.org" <tj@kernel.org>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Sat, Mar 18, 2017 at 11:52 AM, Paolo Valente
<paolo.valente@linaro.org> wrote:
>> Il giorno 14 mar 2017, alle ore 16:32, Bart Van Assche <bart.vanassche@sandisk.com> ha scritto:

>> (...) what should
>> a developer do who only has access to a small subset of all the storage
>> devices that are supported by the Linux kernel and hence who can not run the
>> benchmark against every supported storage device?

Don't we use the community for that? We are dependent on people
downloading and testing our code eventually, I mean sure it's good if
we make some reasonable effort to test changes we do, but we are
only humans, and we get corrected by the experience of other humans.

>> Do developers who do not
>> fully understand the BFQ algorithms and who run into a performance problem
>> have any other option than trial and error for fixing such performance issues?
>
> Hi Bart,
> maybe I got your point even before, but I did not reply consistently.
> You are highlighting an important problem, which, I think, can be
> stated in more general terms: if one makes a change in any complex
> component, which, in its turn, interacts with complex I/O devices,
> then it is hard, if ever possible, to prove, that that change will
> cause no regression with any possible device, just by speculation.
> Actually, facts show that this often holds even for simple components,
> given the complexity of the environment in which they work.  Of
> course, if not only the component is complex, but who modifies it does
> not even fully understand how that component works, then regressions
> on untested devices are certainly more probable.

You are running a host of benchmarks on a host of devices, using
the fio tool that Jens devised for this kind of tests. What more can be
asked? More tests, more devices?

If you increase the amount of proof that is requested for any change
to any computer program not to cause unintended side effects or
regressions, you will eventually end up with the brick wall
"solve the halting problem".

Alternatively "test it forever on all systems in the world".

It eventually becomes absurd.

This actually occurred to me .. in a certain mission-critical algorithm
my department was requested to "prove that this will run to completion".
I was baffled and said that what they were requesting was that I
solve the halting problem. It turned out they just wanted something like
a comprehensible test suite.

Yours,
Linus Walleij
