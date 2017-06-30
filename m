Return-Path: <milosz@adfin.com>
MIME-Version: 1.0
In-Reply-To: <20170629212503.15110-1-hch@lst.de>
References: <20170629212503.15110-1-hch@lst.de>
From: Milosz Tanski <milosz@adfin.com>
Date: Thu, 29 Jun 2017 21:11:29 -0400
Message-ID: <CANP1eJHRVsepWfo0=_CDvBnteYFedkUxtcyaap-R+cerhCd+5A@mail.gmail.com>
Subject: Re: non-blockling buffered reads
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>, Mel Gorman <mgorman@suse.de>,
	Volker Lendecke <Volker.Lendecke@sernet.de>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, linux-block@vger.kernel.org
Content-Type: multipart/alternative; boundary="001a113f9750ddfb020553231843"
List-ID: <linux-block@vger.kernel.org>

--001a113f9750ddfb020553231843
Content-Type: text/plain; charset="UTF-8"

On Thu, Jun 29, 2017 at 5:25 PM, Christoph Hellwig <hch@lst.de> wrote:

> This series resurrects the old patches from Milosz to implement
> non-blocking buffered reads.  Thanks to the non-blocking AIO code from
> Goldwyn the implementation becomes pretty much trivial.  As that
> implementation is in the block tree I would suggest that we merge
> these patches through the block tree as well.  I've also forward
> ported the test Milosz sent for recent xfsprogs to verify it works
> properly, but I'll still have to address the review comments for it.
> I'll also volunteer to work with Goldwyn to properly document the
> RWF_NOWAIT flag in the man page including this change.
>

I had update patches for the man pages; so I'll check tomorrow if I can dig
up the changes and I'll forward them on.


>
> Here are additional details from the original cover letter from Milosz,
> where the flag was still called RWF_NONBLOCK:
>
>
> Background:
>
>  Using a threadpool to emulate non-blocking operations on regular buffered
>  files is a common pattern today (samba, libuv, etc...) Applications split
> the
>  work between network bound threads (epoll) and IO threadpool. Not every
>  application can use sendfile syscall (TLS / post-processing).
>
>  This common pattern leads to increased request latency. Latency can be
> due to
>  additional synchronization between the threads or fast (cached data)
> request
>  stuck behind slow request (large / uncached data).
>
>  The preadv2 syscall with RWF_NONBLOCK lets userspace applications bypass
>  enqueuing operation in the threadpool if it's already available in the
>  pagecache.
>
>
> Performance numbers (newer Samba):
>
>  https://drive.google.com/file/d/0B3maCn0jCvYncndGbXJKbGlhejQ/
> view?usp=sharing
>  https://docs.google.com/spreadsheets/d/1GGTivi-
> MfZU0doMzomG4XUo9ioWtRvOGQ5FId042L6s/edit?usp=sharing
>
>
> Performance number (older):
>
>  Some perf data generated using fio comparing the posix aio engine to a
> version
>  of the posix AIO engine that attempts to performs "fast" reads before
>  submitting the operations to the queue. This workflow is on ext4
> partition on
>  raid0 (test / build-rig.) Simulating our database access patern workload
> using
>  16kb read accesses. Our database uses a home-spun posix aio like queue
> (samba
>  does the same thing.)
>
>  f1: ~73% rand read over mostly cached data (zipf med-size dataset)
>  f2: ~18% rand read over mostly un-cached data (uniform large-dataset)
>  f3: ~9% seq-read over large dataset
>
>  before:
>
>  f1:
>      bw (KB  /s): min=   11, max= 9088, per=0.56%, avg=969.54, stdev=827.99
>      lat (msec) : 50=0.01%, 100=1.06%, 250=5.88%, 500=4.08%, 750=12.48%
>      lat (msec) : 1000=17.27%, 2000=49.86%, >=2000=9.42%
>  f2:
>      bw (KB  /s): min=    2, max= 1882, per=0.16%, avg=273.28, stdev=220.26
>      lat (msec) : 250=5.65%, 500=3.31%, 750=15.64%, 1000=24.59%,
> 2000=46.56%
>      lat (msec) : >=2000=4.33%
>  f3:
>      bw (KB  /s): min=    0, max=265568, per=99.95%, avg=174575.10,
>                   stdev=34526.89
>      lat (usec) : 2=0.01%, 4=0.01%, 10=0.02%, 20=0.27%, 50=10.82%
>      lat (usec) : 100=50.34%, 250=5.05%, 500=7.12%, 750=6.60%, 1000=4.55%
>      lat (msec) : 2=8.73%, 4=3.49%, 10=1.83%, 20=0.89%, 50=0.22%
>      lat (msec) : 100=0.05%, 250=0.02%, 500=0.01%
>  total:
>     READ: io=102365MB, aggrb=174669KB/s, minb=240KB/s, maxb=173599KB/s,
>           mint=600001msec, maxt=600113msec
>
>  after (with fast read using preadv2 before submit):
>
>  f1:
>      bw (KB  /s): min=    3, max=14897, per=1.28%, avg=2276.69,
> stdev=2930.39
>      lat (usec) : 2=70.63%, 4=0.01%
>      lat (msec) : 250=0.20%, 500=2.26%, 750=1.18%, 2000=0.22%,
> >=2000=25.53%
>  f2:
>      bw (KB  /s): min=    2, max= 2362, per=0.14%, avg=249.83, stdev=222.00
>      lat (msec) : 250=6.35%, 500=1.78%, 750=9.29%, 1000=20.49%, 2000=52.18%
>      lat (msec) : >=2000=9.99%
>  f3:
>      bw (KB  /s): min=    1, max=245448, per=100.00%, avg=177366.50,
>                   stdev=35995.60
>      lat (usec) : 2=64.04%, 4=0.01%, 10=0.01%, 20=0.06%, 50=0.43%
>      lat (usec) : 100=0.20%, 250=1.27%, 500=2.93%, 750=3.93%, 1000=7.35%
>      lat (msec) : 2=14.27%, 4=2.88%, 10=1.54%, 20=0.81%, 50=0.22%
>      lat (msec) : 100=0.05%, 250=0.02%
>  total:
>     READ: io=103941MB, aggrb=177339KB/s, minb=213KB/s, maxb=176375KB/s,
>           mint=600020msec, maxt=600178msec
>
>  Interpreting the results you can see total bandwidth stays the same but
> overall
>  request latency is decreased in f1 (random, mostly cached) and f3
> (sequential)
>  workloads. There is a slight bump in latency for since it's random data
> that's
>  unlikely to be cached but we're always trying "fast read".
>
>  In our application we have starting keeping track of "fast read"
> hits/misses
>  and for files / requests that have a lot hit ratio we don't do "fast
> reads"
>  mostly getting rid of extra latency in the uncached cases. In our real
> world
>  work load we were able to reduce average response time by 20 to 30%
> (depends
>  on amount of IO done by request).
>
>  I've performed other benchmarks and I have no observed any perf
> regressions in
>  any of the normal (old) code paths.
>



-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com

--001a113f9750ddfb020553231843
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Thu, Jun 29, 2017 at 5:25 PM, Christoph Hellwig <span dir=3D"ltr">&l=
t;<a href=3D"mailto:hch@lst.de" target=3D"_blank">hch@lst.de</a>&gt;</span>=
 wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">This series re=
surrects the old patches from Milosz to implement<br>
non-blocking buffered reads.=C2=A0 Thanks to the non-blocking AIO code from=
<br>
Goldwyn the implementation becomes pretty much trivial.=C2=A0 As that<br>
implementation is in the block tree I would suggest that we merge<br>
these patches through the block tree as well.=C2=A0 I&#39;ve also forward<b=
r>
ported the test Milosz sent for recent xfsprogs to verify it works<br>
properly, but I&#39;ll still have to address the review comments for it.<br=
>
I&#39;ll also volunteer to work with Goldwyn to properly document the<br>
RWF_NOWAIT flag in the man page including this change.<br></blockquote><div=
><br></div><div>I had update patches for the man pages; so I&#39;ll check t=
omorrow if I can dig up the changes and I&#39;ll forward them on.</div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Here are additional details from the original cover letter from Milosz,<br>
where the flag was still called RWF_NONBLOCK:<br>
<br>
<br>
Background:<br>
<br>
=C2=A0Using a threadpool to emulate non-blocking operations on regular buff=
ered<br>
=C2=A0files is a common pattern today (samba, libuv, etc...) Applications s=
plit the<br>
=C2=A0work between network bound threads (epoll) and IO threadpool. Not eve=
ry<br>
=C2=A0application can use sendfile syscall (TLS / post-processing).<br>
<br>
=C2=A0This common pattern leads to increased request latency. Latency can b=
e due to<br>
=C2=A0additional synchronization between the threads or fast (cached data) =
request<br>
=C2=A0stuck behind slow request (large / uncached data).<br>
<br>
=C2=A0The preadv2 syscall with RWF_NONBLOCK lets userspace applications byp=
ass<br>
=C2=A0enqueuing operation in the threadpool if it&#39;s already available i=
n the<br>
=C2=A0pagecache.<br>
<br>
<br>
Performance numbers (newer Samba):<br>
<br>
=C2=A0<a href=3D"https://drive.google.com/file/d/0B3maCn0jCvYncndGbXJKbGlhe=
jQ/view?usp=3Dsharing" rel=3D"noreferrer" target=3D"_blank">https://drive.g=
oogle.com/file/<wbr>d/<wbr>0B3maCn0jCvYncndGbXJKbGlhejQ/<wbr>view?usp=3Dsha=
ring</a><br>
=C2=A0<a href=3D"https://docs.google.com/spreadsheets/d/1GGTivi-MfZU0doMzom=
G4XUo9ioWtRvOGQ5FId042L6s/edit?usp=3Dsharing" rel=3D"noreferrer" target=3D"=
_blank">https://docs.google.com/<wbr>spreadsheets/d/1GGTivi-<wbr>MfZU0doMzo=
mG4XUo9ioWtRvOGQ5FId<wbr>042L6s/edit?usp=3Dsharing</a><br>
<br>
<br>
Performance number (older):<br>
<br>
=C2=A0Some perf data generated using fio comparing the posix aio engine to =
a version<br>
=C2=A0of the posix AIO engine that attempts to performs &quot;fast&quot; re=
ads before<br>
=C2=A0submitting the operations to the queue. This workflow is on ext4 part=
ition on<br>
=C2=A0raid0 (test / build-rig.) Simulating our database access patern workl=
oad using<br>
=C2=A016kb read accesses. Our database uses a home-spun posix aio like queu=
e (samba<br>
=C2=A0does the same thing.)<br>
<br>
=C2=A0f1: ~73% rand read over mostly cached data (zipf med-size dataset)<br=
>
=C2=A0f2: ~18% rand read over mostly un-cached data (uniform large-dataset)=
<br>
=C2=A0f3: ~9% seq-read over large dataset<br>
<br>
=C2=A0before:<br>
<br>
=C2=A0f1:<br>
=C2=A0 =C2=A0 =C2=A0bw (KB=C2=A0 /s): min=3D=C2=A0 =C2=A011, max=3D 9088, p=
er=3D0.56%, avg=3D969.54, stdev=3D827.99<br>
=C2=A0 =C2=A0 =C2=A0lat (msec) : 50=3D0.01%, 100=3D1.06%, 250=3D5.88%, 500=
=3D4.08%, 750=3D12.48%<br>
=C2=A0 =C2=A0 =C2=A0lat (msec) : 1000=3D17.27%, 2000=3D49.86%, &gt;=3D2000=
=3D9.42%<br>
=C2=A0f2:<br>
=C2=A0 =C2=A0 =C2=A0bw (KB=C2=A0 /s): min=3D=C2=A0 =C2=A0 2, max=3D 1882, p=
er=3D0.16%, avg=3D273.28, stdev=3D220.26<br>
=C2=A0 =C2=A0 =C2=A0lat (msec) : 250=3D5.65%, 500=3D3.31%, 750=3D15.64%, 10=
00=3D24.59%, 2000=3D46.56%<br>
=C2=A0 =C2=A0 =C2=A0lat (msec) : &gt;=3D2000=3D4.33%<br>
=C2=A0f3:<br>
=C2=A0 =C2=A0 =C2=A0bw (KB=C2=A0 /s): min=3D=C2=A0 =C2=A0 0, max=3D265568, =
per=3D99.95%, avg=3D174575.10,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stdev=3D3452=
6.89<br>
=C2=A0 =C2=A0 =C2=A0lat (usec) : 2=3D0.01%, 4=3D0.01%, 10=3D0.02%, 20=3D0.2=
7%, 50=3D10.82%<br>
=C2=A0 =C2=A0 =C2=A0lat (usec) : 100=3D50.34%, 250=3D5.05%, 500=3D7.12%, 75=
0=3D6.60%, 1000=3D4.55%<br>
=C2=A0 =C2=A0 =C2=A0lat (msec) : 2=3D8.73%, 4=3D3.49%, 10=3D1.83%, 20=3D0.8=
9%, 50=3D0.22%<br>
=C2=A0 =C2=A0 =C2=A0lat (msec) : 100=3D0.05%, 250=3D0.02%, 500=3D0.01%<br>
=C2=A0total:<br>
=C2=A0 =C2=A0 READ: io=3D102365MB, aggrb=3D174669KB/s, minb=3D240KB/s, maxb=
=3D173599KB/s,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mint=3D600001msec, maxt=3D600113msec<br>
<br>
=C2=A0after (with fast read using preadv2 before submit):<br>
<br>
=C2=A0f1:<br>
=C2=A0 =C2=A0 =C2=A0bw (KB=C2=A0 /s): min=3D=C2=A0 =C2=A0 3, max=3D14897, p=
er=3D1.28%, avg=3D2276.69, stdev=3D2930.39<br>
=C2=A0 =C2=A0 =C2=A0lat (usec) : 2=3D70.63%, 4=3D0.01%<br>
=C2=A0 =C2=A0 =C2=A0lat (msec) : 250=3D0.20%, 500=3D2.26%, 750=3D1.18%, 200=
0=3D0.22%, &gt;=3D2000=3D25.53%<br>
=C2=A0f2:<br>
=C2=A0 =C2=A0 =C2=A0bw (KB=C2=A0 /s): min=3D=C2=A0 =C2=A0 2, max=3D 2362, p=
er=3D0.14%, avg=3D249.83, stdev=3D222.00<br>
=C2=A0 =C2=A0 =C2=A0lat (msec) : 250=3D6.35%, 500=3D1.78%, 750=3D9.29%, 100=
0=3D20.49%, 2000=3D52.18%<br>
=C2=A0 =C2=A0 =C2=A0lat (msec) : &gt;=3D2000=3D9.99%<br>
=C2=A0f3:<br>
=C2=A0 =C2=A0 =C2=A0bw (KB=C2=A0 /s): min=3D=C2=A0 =C2=A0 1, max=3D245448, =
per=3D100.00%, avg=3D177366.50,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stdev=3D3599=
5.60<br>
=C2=A0 =C2=A0 =C2=A0lat (usec) : 2=3D64.04%, 4=3D0.01%, 10=3D0.01%, 20=3D0.=
06%, 50=3D0.43%<br>
=C2=A0 =C2=A0 =C2=A0lat (usec) : 100=3D0.20%, 250=3D1.27%, 500=3D2.93%, 750=
=3D3.93%, 1000=3D7.35%<br>
=C2=A0 =C2=A0 =C2=A0lat (msec) : 2=3D14.27%, 4=3D2.88%, 10=3D1.54%, 20=3D0.=
81%, 50=3D0.22%<br>
=C2=A0 =C2=A0 =C2=A0lat (msec) : 100=3D0.05%, 250=3D0.02%<br>
=C2=A0total:<br>
=C2=A0 =C2=A0 READ: io=3D103941MB, aggrb=3D177339KB/s, minb=3D213KB/s, maxb=
=3D176375KB/s,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mint=3D600020msec, maxt=3D600178msec<br>
<br>
=C2=A0Interpreting the results you can see total bandwidth stays the same b=
ut overall<br>
=C2=A0request latency is decreased in f1 (random, mostly cached) and f3 (se=
quential)<br>
=C2=A0workloads. There is a slight bump in latency for since it&#39;s rando=
m data that&#39;s<br>
=C2=A0unlikely to be cached but we&#39;re always trying &quot;fast read&quo=
t;.<br>
<br>
=C2=A0In our application we have starting keeping track of &quot;fast read&=
quot; hits/misses<br>
=C2=A0and for files / requests that have a lot hit ratio we don&#39;t do &q=
uot;fast reads&quot;<br>
=C2=A0mostly getting rid of extra latency in the uncached cases. In our rea=
l world<br>
=C2=A0work load we were able to reduce average response time by 20 to 30% (=
depends<br>
=C2=A0on amount of IO done by request).<br>
<br>
=C2=A0I&#39;ve performed other benchmarks and I have no observed any perf r=
egressions in<br>
=C2=A0any of the normal (old) code paths.<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature"><div dir=3D"ltr">Milosz Tanski<br>CTO<br>16 East 34th =
Street, 15th floor<br>New York, NY 10016<br><br>p: 646-253-9055<br>e: <a hr=
ef=3D"mailto:milosz@adfin.com" target=3D"_blank">milosz@adfin.com</a><br></=
div></div>
</div></div>

--001a113f9750ddfb020553231843--
