Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1489859192.2339.12.camel@sandisk.com>
References: <20170304160131.57366-1-paolo.valente@linaro.org>
 <1488848390.3125.14.camel@sandisk.com> <81048010-02AB-4A7A-8C10-FAF7E3242DCC@linaro.org>
 <1489509154.2676.6.camel@sandisk.com> <A8A05E9B-2FDF-4986-833E-166D92DFEF4F@linaro.org>
 <CACRpkdZhA8FY2FH_fnTsnPotZoZwX5qUfhdavWLwfzcnLkZUMQ@mail.gmail.com> <1489859192.2339.12.camel@sandisk.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 18 Mar 2017 21:46:12 +0100
Message-ID: <CACRpkdYE=njGbN6QiV3+93ivNfTYtuhYaT8suXtmMAn-BTVzyw@mail.gmail.com>
Subject: Re: [PATCH RFC 00/14] Add the BFQ I/O Scheduler to blk-mq
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "fchecconi@gmail.com" <fchecconi@gmail.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "broonie@kernel.org" <broonie@kernel.org>,
	"avanzini.arianna@gmail.com" <avanzini.arianna@gmail.com>, "tj@kernel.org" <tj@kernel.org>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Sat, Mar 18, 2017 at 6:46 PM, Bart Van Assche
<Bart.VanAssche@sandisk.com> wrote:
> On Sat, 2017-03-18 at 18:09 +0100, Linus Walleij wrote:
>> On Sat, Mar 18, 2017 at 11:52 AM, Paolo Valente
>> <paolo.valente@linaro.org> wrote:
>> > > Il giorno 14 mar 2017, alle ore 16:32, Bart Van Assche <bart.vanassche@sandisk.com> ha scritto:
>> > > (...) what should
>> > > a developer do who only has access to a small subset of all the storage
>> > > devices that are supported by the Linux kernel and hence who can not run the
>> > > benchmark against every supported storage device?
>>
>> Don't we use the community for that? We are dependent on people
>> downloading and testing our code eventually, I mean sure it's good if
>> we make some reasonable effort to test changes we do, but we are
>> only humans, and we get corrected by the experience of other humans.
>
> Hello Linus,
>
> Do you mean relying on the community to test other storage devices before
> or after a patch is upstream?

I guess they should test it when it is in linux-next?

> Relying on the community to file bug reports
> after a patch is upstream would be wrong. The Linux kernel should not be
> used for experiments. As you know patches that are sent upstream should
> not introduce regressions.

Yeah still people introduce regressions and we have 7-8 release
candidates for each kernel because of this. Humans have flaws
I guess.

> My primary concern about BFQ is that it is a very complicated I/O scheduler
> and also that the concepts used internally in that I/O scheduler are far
> away from the concepts we are used to when reasoning about I/O devices. I'm
> concerned that this will make the BFQ I/O scheduler hard to maintain.

I understand that. Let's follow all rules of thumb that make code
easy to maintain.

We have pretty broad agreement on what makes code easy to
maintain on the syntactic level, checkpatch and some manual inspection
easily gives that.

I think where we need the most brainshare is in how to make semantics
maintainable. It's no fun reading terse code and try to figure out how
the developer writing it was thinking, so let's focus on anything we do not
understand and make it understandable, it seems Paolo is onto this task
for what I can tell.

Yours,
Linus Walleij
