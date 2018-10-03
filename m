Return-Path: <paolo.valente@linaro.org>
MIME-Version: 1.0
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk> <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538582091.205649.20.camel@acm.org> <C7FEB750-D993-44EC-B3CB-0639DF68CD26@linaro.org>
In-Reply-To: <C7FEB750-D993-44EC-B3CB-0639DF68CD26@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
Date: Wed, 3 Oct 2018 18:09:58 +0200
Message-ID: <CAD7QDb3BrnrDZu+OyOgAX+D6HzbO_PrSjcWwS2Eyp9K=hRuuUQ@mail.gmail.com>
Subject: Re: [PATCH] block: BFQ default for single queue devices
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, Linus Walleij <linus.walleij@linaro.org>,
	linux-block <linux-block@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>,
	linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
	Ulf Hansson <ulf.hansson@linaro.org>, Richard Weinberger <richard@nod.at>,
	Artem Bityutskiy <dedekind1@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Jan Kara <jack@suse.cz>,
	Andreas Herrmann <aherrmann@suse.com>, Mel Gorman <mgorman@suse.com>,
	Chunyan Zhang <zhang.chunyan@linaro.org>, Linux-Kernal <linux-kernel@vger.kernel.org>,
	"'Paolo Valente' via bfq-iosched" <bfq-iosched@googlegroups.com>,
	Oleksandr Natalenko <oleksandr@natalenko.name>, Mark Brown <broonie@kernel.org>
Content-Type: multipart/alternative; boundary="000000000000c1947705775545db"
List-ID: <linux-block@vger.kernel.org>

--000000000000c1947705775545db
Content-Type: text/plain; charset="UTF-8"

Il mer 3 ott 2018, 18:02 Paolo Valente <paolo.valente@linaro.org> ha
scritto:

>
>
> > Il giorno 03 ott 2018, alle ore 17:54, Bart Van Assche <
> bvanassche@acm.org> ha scritto:
> >
> > On Wed, 2018-10-03 at 08:29 +0200, Paolo Valente wrote:
> >> [1] https://lkml.org/lkml/2017/2/21/791
> >> [2] http://algo.ing.unimo.it/people/paolo/disk_sched/results.php
> >> [3] https://lwn.net/Articles/763603/
> >
> > From [2]: "BFQ loses about 18% with only random readers, because the
> number
> > of IOPS becomes so high that the execution time and parallel efficiency
> of
> > the schedulers becomes relevant." Since the number of I/O patterns for
> which
> > results are available on [2] is limited and since the number of devices
> for
> > which test results are available on [2] is limited (e.g. RAID is
> missing),
> > there might be other cases in which configuring BFQ as the default would
> > introduce a regression.
> >
>
> From [3]: none with throttling loses 80% of the throughput when used
> to control I/O.
>

Of course, the same happens with mq-deadline plus throttling, sorry.

Paolo

>
>

--000000000000c1947705775545db
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">=
Il mer 3 ott 2018, 18:02 Paolo Valente &lt;<a href=3D"mailto:paolo.valente@=
linaro.org">paolo.valente@linaro.org</a>&gt; ha scritto:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex"><br>
<br>
&gt; Il giorno 03 ott 2018, alle ore 17:54, Bart Van Assche &lt;<a href=3D"=
mailto:bvanassche@acm.org" target=3D"_blank" rel=3D"noreferrer">bvanassche@=
acm.org</a>&gt; ha scritto:<br>
&gt; <br>
&gt; On Wed, 2018-10-03 at 08:29 +0200, Paolo Valente wrote:<br>
&gt;&gt; [1] <a href=3D"https://lkml.org/lkml/2017/2/21/791" rel=3D"norefer=
rer noreferrer" target=3D"_blank">https://lkml.org/lkml/2017/2/21/791</a><b=
r>
&gt;&gt; [2] <a href=3D"http://algo.ing.unimo.it/people/paolo/disk_sched/re=
sults.php" rel=3D"noreferrer noreferrer" target=3D"_blank">http://algo.ing.=
unimo.it/people/paolo/disk_sched/results.php</a><br>
&gt;&gt; [3] <a href=3D"https://lwn.net/Articles/763603/" rel=3D"noreferrer=
 noreferrer" target=3D"_blank">https://lwn.net/Articles/763603/</a><br>
&gt; <br>
&gt; From [2]: &quot;BFQ loses about 18% with only random readers, because =
the number<br>
&gt; of IOPS becomes so high that the execution time and parallel efficienc=
y of<br>
&gt; the schedulers becomes relevant.&quot; Since the number of I/O pattern=
s for which<br>
&gt; results are available on [2] is limited and since the number of device=
s for<br>
&gt; which test results are available on [2] is limited (e.g. RAID is missi=
ng),<br>
&gt; there might be other cases in which configuring BFQ as the default wou=
ld<br>
&gt; introduce a regression.<br>
&gt; <br>
<br>
>From [3]: none with throttling loses 80% of the throughput when used<br>
to control I/O.<br></blockquote></div></div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">Of course, the same happens with mq-deadline plus throttling=
, sorry.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div=
 dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
</blockquote></div></div></div>

--000000000000c1947705775545db--
