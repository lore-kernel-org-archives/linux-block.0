Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH RFC 00/14] Add the BFQ I/O Scheduler to blk-mq
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
 "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>
References: <20170304160131.57366-1-paolo.valente@linaro.org>
 <1488848390.3125.14.camel@sandisk.com>
 <81048010-02AB-4A7A-8C10-FAF7E3242DCC@linaro.org>
 <1489509154.2676.6.camel@sandisk.com>
 <A8A05E9B-2FDF-4986-833E-166D92DFEF4F@linaro.org>
 <CACRpkdZhA8FY2FH_fnTsnPotZoZwX5qUfhdavWLwfzcnLkZUMQ@mail.gmail.com>
 <1489859192.2339.12.camel@sandisk.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "fchecconi@gmail.com" <fchecconi@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "avanzini.arianna@gmail.com" <avanzini.arianna@gmail.com>,
 "tj@kernel.org" <tj@kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ad3c5bf2-cf6e-a7f4-d3fd-266247820b05@kernel.dk>
Date: Mon, 20 Mar 2017 14:40:45 -0400
MIME-Version: 1.0
In-Reply-To: <1489859192.2339.12.camel@sandisk.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 03/18/2017 01:46 PM, Bart Van Assche wrote:
> On Sat, 2017-03-18 at 18:09 +0100, Linus Walleij wrote:
>> On Sat, Mar 18, 2017 at 11:52 AM, Paolo Valente
>> <paolo.valente@linaro.org> wrote:
>>>> Il giorno 14 mar 2017, alle ore 16:32, Bart Van Assche <bart.vanassche@sandisk.com> ha scritto:
>>>> (...) what should
>>>> a developer do who only has access to a small subset of all the storage
>>>> devices that are supported by the Linux kernel and hence who can not run the
>>>> benchmark against every supported storage device?
>>
>> Don't we use the community for that? We are dependent on people
>> downloading and testing our code eventually, I mean sure it's good if
>> we make some reasonable effort to test changes we do, but we are
>> only humans, and we get corrected by the experience of other humans.
> 
> Hello Linus,
> 
> Do you mean relying on the community to test other storage devices
> before or after a patch is upstream? Relying on the community to file
> bug reports after a patch is upstream would be wrong. The Linux kernel
> should not be used for experiments. As you know patches that are sent
> upstream should not introduce regressions.

I think there are two main aspects to this:

1) Stability issues
2) Performance issues

For stability issues, obviously we expect BFQ to be bug free when
merged. In practical matters, this means that it doesn't have any known
pending issues, since we obviously cannot guarantee that the code is Bug
Free in general.

>From a performance perspective, using BFQ is absolutely known to
introduce regressions when used on certain types of storage. It works
well on single queue rotating devices. It'll tank your NVMe device
performance. I don't think think this is necessarily a problem. By
default, BFQ will not be enabled anywhere. It's a scheduler that is
available in the system, and users can opt in if they desire to use BFQ.
I'm expecting distros to do the right thing with udev rules here.

> My primary concern about BFQ is that it is a very complicated I/O
> scheduler and also that the concepts used internally in that I/O
> scheduler are far away from the concepts we are used to when reasoning
> about I/O devices. I'm concerned that this will make the BFQ I/O
> scheduler hard to maintain.

That is also my main concern, which is why I'm trying to go through the
code and suggest areas where it can be improved. It'd be great if it was
more modular, for instance, it's somewhat cumbersome to wade through
nine thousand lines of code. It's my hope that we can improve this
aspect of it.

Understanding the actual algorithms is a separate issue. But in that
regard I do think that BFQ is more forgiving than CFQ, since there are
actual papers detailing how it works. If implemented as cleanly as
possible, we can't really make it any easier to understand. It's not a
trivial topic.

-- 
Jens Axboe
