Return-Path: <glommer@cloudius-systems.com>
MIME-Version: 1.0
In-Reply-To: <3AC74DA2-1076-406F-90E0-3ED818B9130C@unimore.it>
References: <1474592399-2790-1-git-send-email-glauber@scylladb.com> <3AC74DA2-1076-406F-90E0-3ED818B9130C@unimore.it>
From: Glauber Costa <glauber@scylladb.com>
Date: Fri, 23 Sep 2016 07:28:58 -0400
Message-ID: <CAD-J=zbT+TJYSQ7TzKZjP4J7uUo3fqEDqzU8g41nrLBVP81W0A@mail.gmail.com>
Subject: Re: [PATCH] cfq: fix starvation of asynchronous writes
To: Paolo Valente <paolo.valente@unimore.it>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-block@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: multipart/alternative; boundary=94eb2c0b66f09f268b053d2b1556
List-ID: <linux-block@vger.kernel.org>

--94eb2c0b66f09f268b053d2b1556
Content-Type: text/plain; charset=UTF-8

On Sep 23, 2016 6:22 AM, "Paolo Valente" <paolo.valente@unimore.it> wrote:
>
>
> > Il giorno 23 set 2016, alle ore 02:59, Glauber Costa <
glauber@scylladb.com> ha scritto:
> >
> > While debugging timeouts happening in my application workload
(ScyllaDB), I have
> > observed calls to open() taking a long time, ranging everywhere from 2
seconds -
> > the first ones that are enough to time out my application - to more
than 30
> > seconds.
> >
> > The problem seems to happen because XFS may block on pending metadata
updates
> > under certain circumnstances, and that's confirmed with the following
backtrace
> > taken by the offcputime tool (iovisor/bcc):
> >
> >    ffffffffb90c57b1 finish_task_switch
> >    ffffffffb97dffb5 schedule
> >    ffffffffb97e310c schedule_timeout
> >    ffffffffb97e1f12 __down
> >    ffffffffb90ea821 down
> >    ffffffffc046a9dc xfs_buf_lock
> >    ffffffffc046abfb _xfs_buf_find
> >    ffffffffc046ae4a xfs_buf_get_map
> >    ffffffffc046babd xfs_buf_read_map
> >    ffffffffc0499931 xfs_trans_read_buf_map
> >    ffffffffc044a561 xfs_da_read_buf
> >    ffffffffc0451390 xfs_dir3_leaf_read.constprop.16
> >    ffffffffc0452b90 xfs_dir2_leaf_lookup_int
> >    ffffffffc0452e0f xfs_dir2_leaf_lookup
> >    ffffffffc044d9d3 xfs_dir_lookup
> >    ffffffffc047d1d9 xfs_lookup
> >    ffffffffc0479e53 xfs_vn_lookup
> >    ffffffffb925347a path_openat
> >    ffffffffb9254a71 do_filp_open
> >    ffffffffb9242a94 do_sys_open
> >    ffffffffb9242b9e sys_open
> >    ffffffffb97e42b2 entry_SYSCALL_64_fastpath
> >    00007fb0698162ed [unknown]
> >
> > Inspecting my run with blktrace, I can see that the xfsaild kthread
exhibit very
> > high "Dispatch wait" times, on the dozens of seconds range and
consistent with
> > the open() times I have saw in that run.
> >
> > Still from the blktrace output, we can after searching a bit, identify
the
> > request that wasn't dispatched:
> >
> >  8,0   11      152    81.092472813   804  A  WM 141698288 + 8 <- (8,1)
141696240
> >  8,0   11      153    81.092472889   804  Q  WM 141698288 + 8
[xfsaild/sda1]
> >  8,0   11      154    81.092473207   804  G  WM 141698288 + 8
[xfsaild/sda1]
> >  8,0   11      206    81.092496118   804  I  WM 141698288 + 8 (
 22911) [xfsaild/sda1]
> >  <==== 'I' means Inserted (into the IO scheduler)
===================================>
> >  8,0    0   289372    96.718761435     0  D  WM 141698288 + 8
(15626265317) [swapper/0]
> >  <==== Only 15s later the CFQ scheduler dispatches the request
======================>
> >
> > As we can see above, in this particular example CFQ took 15 seconds to
dispatch
> > this request. Going back to the full trace, we can see that the xfsaild
queue
> > had plenty of opportunity to run, and it was selected as the active
queue many
> > times. It would just always be preempted by something else (example):
> >
> >  8,0    1        0    81.117912979     0  m   N cfq1618SN /
insert_request
> >  8,0    1        0    81.117913419     0  m   N cfq1618SN / add_to_rr
> >  8,0    1        0    81.117914044     0  m   N cfq1618SN / preempt
> >  8,0    1        0    81.117914398     0  m   N cfq767A  / slice
expired t=1
> >  8,0    1        0    81.117914755     0  m   N cfq767A  / resid=40
> >  8,0    1        0    81.117915340     0  m   N / served: vt=1948520448
min_vt=1948520448
> >  8,0    1        0    81.117915858     0  m   N cfq767A  / sl_used=1
disp=0 charge=0 iops=1 sect=0
> >
> > where cfq767 is the xfsaild queue and cfq1618 corresponds to one of the
ScyllaDB
> > IO dispatchers.
> >
> > The requests preempting the xfsaild queue are synchronous requests.
That's a
> > characteristic of ScyllaDB workloads, as we only ever issue O_DIRECT
requests.
> > While it can be argued that preempting ASYNC requests in favor of SYNC
is part
> > of the CFQ logic, I don't believe that doing so for 15+ seconds is
anyone's
> > goal.
> >
> > Moreover, unless I am misunderstanding something, that breaks the
expectation
> > set by the "fifo_expire_async" tunable, which in my system is set to the
> > default.
> >
> > Looking at the code, it seems to me that the issue is that after we make
> > an async queue active, there is no guarantee that it will execute any
request.
> >
> > When the queue itself tests if it cfq_may_dispatch() it can bail if it
sees SYNC
> > requests in flight. An incoming request from another queue can also
preempt it
> > in such situation before we have the chance to execute anything (as
seen in the
> > trace above).
> >
>
> The BFQ scheduler should not suffer from this issue, because it does
> not consider this condition at all for preemption.  Even better, BFQ
> performs preemption as a function of just one condition, which is
> formally proven not to break any request-delay guarantee.
>
> Would you be willing to give it a try?  It might solve or at least
> mitigate the specific latency problem addressed by your patch, and at
> the same time provide many other benefits, in terms of low latency and
> high throughput.

We are definitely interested in trying different elevators that could
benefit our workload. Specially because right now we don't really have a
default recommendation.

But just to be clear, I saw very early on that the problem didn't happen
with noop or deadline, so if this was just a characteristic of the CFQ I
would have stopped there.

I do believe however, as I have said in my commitlog message, that this is
just a bug. And no bug shall remain unfixed in my presence.

>
> If you are willing to try it, then in [1] you can find the last BFQ
> development branch, rebased against 4.8-rc7.  These commits add BFQ as an
> extra scheduler.
>
> Otherwise you can find BFQ for 4.7 here [2], and BFQ for 4.6 here [3].
>
> If you prefer patches, then you can find them in [4] for 4.7, or in
> [5] for 4.6.
>
> Finally, if you need details about BFQ, have a look at [6], or just ask!
>
> Thanks,
> Paolo
>
> [1] https://github.com/linusw/linux-bfq/tree/bfq-v8
> [2] https://github.com/linusw/linux-bfq/tree/bfq-v8-v4.7
> [3] https://github.com/linusw/linux-bfq/tree/bfq-v8-v4.6
> [4]
http://algogroup.unimore.it/people/paolo/disk_sched/patches/4.7.0-v8r3/
> [5]
http://algogroup.unimore.it/people/paolo/disk_sched/patches/4.6.0-v8r3/
> [6] http://algogroup.unimore.it/people/paolo/disk_sched/
>
> > This patch sets the must_dispatch flag if we notice that we have
requests
> > that are already fifo_expired. This flag is always cleared after
> > cfq_dispatch_request() returns from cfq_dispatch_requests(), so it
won't pin
> > the queue for subsequent requests (unless they are themselves expired)
> >
> > Care is taken during preempt to still allow rt requests to preempt us
> > regardless.
> >
> > Testing my workload with this patch applied produces much better
results.
> > From the application side I see no timeouts, and the open() latency
histogram
> > generated by systemtap looks much better, with the worst outlier at
131ms:
> >
>
>
>
> > Latency histogram of xfs_buf_lock acquisition (microseconds):
> > value |-------------------------------------------------- count
> >     0 |                                                     11
> >     1 |@@@@                                                161
> >     2 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  1966
> >     4 |@                                                    54
> >     8 |                                                     36
> >    16 |                                                      7
> >    32 |                                                      0
> >    64 |                                                      0
> >       ~
> >  1024 |                                                      0
> >  2048 |                                                      0
> >  4096 |                                                      1
> >  8192 |                                                      1
> > 16384 |                                                      2
> > 32768 |                                                      0
> > 65536 |                                                      0
> > 131072 |                                                      1
> > 262144 |                                                      0
> > 524288 |                                                      0
> >
> > Signed-off-by: Glauber Costa <glauber@scylladb.com>
> > CC: Jens Axboe <axboe@kernel.dk>
> > CC: linux-block@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
> >
> > Signed-off-by: Glauber Costa <glauber@scylladb.com>
> > ---
> > block/cfq-iosched.c | 13 ++++++++++---
> > 1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
> > index cc2f6db..5e24d88 100644
> > --- a/block/cfq-iosched.c
> > +++ b/block/cfq-iosched.c
> > @@ -3042,7 +3042,6 @@ static struct request *cfq_check_fifo(struct
cfq_queue *cfqq)
> >       if (ktime_get_ns() < rq->fifo_time)
> >               rq = NULL;
> >
> > -     cfq_log_cfqq(cfqq->cfqd, cfqq, "fifo=%p", rq);
> >       return rq;
> > }
> >
> > @@ -3420,6 +3419,9 @@ static bool cfq_may_dispatch(struct cfq_data
*cfqd, struct cfq_queue *cfqq)
> > {
> >       unsigned int max_dispatch;
> >
> > +     if (cfq_cfqq_must_dispatch(cfqq))
> > +             return true;
> > +
> >       /*
> >        * Drain async requests before we start sync IO
> >        */
> > @@ -3511,15 +3513,20 @@ static bool cfq_dispatch_request(struct
cfq_data *cfqd, struct cfq_queue *cfqq)
> >
> >       BUG_ON(RB_EMPTY_ROOT(&cfqq->sort_list));
> >
> > +     rq = cfq_check_fifo(cfqq);
> > +     if (rq)
> > +             cfq_mark_cfqq_must_dispatch(cfqq);
> > +
> >       if (!cfq_may_dispatch(cfqd, cfqq))
> >               return false;
> >
> >       /*
> >        * follow expired path, else get first next available
> >        */
> > -     rq = cfq_check_fifo(cfqq);
> >       if (!rq)
> >               rq = cfqq->next_rq;
> > +     else
> > +             cfq_log_cfqq(cfqq->cfqd, cfqq, "fifo=%p", rq);
> >
> >       /*
> >        * insert request into driver dispatch list
> > @@ -3989,7 +3996,7 @@ cfq_should_preempt(struct cfq_data *cfqd, struct
cfq_queue *new_cfqq,
> >        * if the new request is sync, but the currently running queue is
> >        * not, let the sync request have priority.
> >        */
> > -     if (rq_is_sync(rq) && !cfq_cfqq_sync(cfqq))
> > +     if (rq_is_sync(rq) && !cfq_cfqq_sync(cfqq) &&
!cfq_cfqq_must_dispatch(cfqq))
> >               return true;
> >
> >       /*
> > --
> > 2.5.5
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-block"
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> --
> Paolo Valente
> Algogroup
> Dipartimento di Scienze Fisiche, Informatiche e Matematiche
> Via Campi 213/B
> 41125 Modena - Italy
> http://algogroup.unimore.it/people/paolo/
>
>
>
>
>

--94eb2c0b66f09f268b053d2b1556
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Sep 23, 2016 6:22 AM, &quot;Paolo Valente&quot; &lt;<a hr=
ef=3D"mailto:paolo.valente@unimore.it">paolo.valente@unimore.it</a>&gt; wro=
te:<br>
&gt;<br>
&gt;<br>
&gt; &gt; Il giorno 23 set 2016, alle ore 02:59, Glauber Costa &lt;<a href=
=3D"mailto:glauber@scylladb.com">glauber@scylladb.com</a>&gt; ha scritto:<b=
r>
&gt; &gt;<br>
&gt; &gt; While debugging timeouts happening in my application workload (Sc=
yllaDB), I have<br>
&gt; &gt; observed calls to open() taking a long time, ranging everywhere f=
rom 2 seconds -<br>
&gt; &gt; the first ones that are enough to time out my application - to mo=
re than 30<br>
&gt; &gt; seconds.<br>
&gt; &gt;<br>
&gt; &gt; The problem seems to happen because XFS may block on pending meta=
data updates<br>
&gt; &gt; under certain circumnstances, and that&#39;s confirmed with the f=
ollowing backtrace<br>
&gt; &gt; taken by the offcputime tool (iovisor/bcc):<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 ffffffffb90c57b1 finish_task_switch<br>
&gt; &gt;=C2=A0 =C2=A0 ffffffffb97dffb5 schedule<br>
&gt; &gt;=C2=A0 =C2=A0 ffffffffb97e310c schedule_timeout<br>
&gt; &gt;=C2=A0 =C2=A0 ffffffffb97e1f12 __down<br>
&gt; &gt;=C2=A0 =C2=A0 ffffffffb90ea821 down<br>
&gt; &gt;=C2=A0 =C2=A0 ffffffffc046a9dc xfs_buf_lock<br>
&gt; &gt;=C2=A0 =C2=A0 ffffffffc046abfb _xfs_buf_find<br>
&gt; &gt;=C2=A0 =C2=A0 ffffffffc046ae4a xfs_buf_get_map<br>
&gt; &gt;=C2=A0 =C2=A0 ffffffffc046babd xfs_buf_read_map<br>
&gt; &gt;=C2=A0 =C2=A0 ffffffffc0499931 xfs_trans_read_buf_map<br>
&gt; &gt;=C2=A0 =C2=A0 ffffffffc044a561 xfs_da_read_buf<br>
&gt; &gt;=C2=A0 =C2=A0 ffffffffc0451390 xfs_dir3_leaf_read.constprop.16<br>
&gt; &gt;=C2=A0 =C2=A0 ffffffffc0452b90 xfs_dir2_leaf_lookup_int<br>
&gt; &gt;=C2=A0 =C2=A0 ffffffffc0452e0f xfs_dir2_leaf_lookup<br>
&gt; &gt;=C2=A0 =C2=A0 ffffffffc044d9d3 xfs_dir_lookup<br>
&gt; &gt;=C2=A0 =C2=A0 ffffffffc047d1d9 xfs_lookup<br>
&gt; &gt;=C2=A0 =C2=A0 ffffffffc0479e53 xfs_vn_lookup<br>
&gt; &gt;=C2=A0 =C2=A0 ffffffffb925347a path_openat<br>
&gt; &gt;=C2=A0 =C2=A0 ffffffffb9254a71 do_filp_open<br>
&gt; &gt;=C2=A0 =C2=A0 ffffffffb9242a94 do_sys_open<br>
&gt; &gt;=C2=A0 =C2=A0 ffffffffb9242b9e sys_open<br>
&gt; &gt;=C2=A0 =C2=A0 ffffffffb97e42b2 entry_SYSCALL_64_fastpath<br>
&gt; &gt;=C2=A0 =C2=A0 00007fb0698162ed [unknown]<br>
&gt; &gt;<br>
&gt; &gt; Inspecting my run with blktrace, I can see that the xfsaild kthre=
ad exhibit very<br>
&gt; &gt; high &quot;Dispatch wait&quot; times, on the dozens of seconds ra=
nge and consistent with<br>
&gt; &gt; the open() times I have saw in that run.<br>
&gt; &gt;<br>
&gt; &gt; Still from the blktrace output, we can after searching a bit, ide=
ntify the<br>
&gt; &gt; request that wasn&#39;t dispatched:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 8,0=C2=A0 =C2=A011=C2=A0 =C2=A0 =C2=A0 152=C2=A0 =C2=A0 81.=
092472813=C2=A0 =C2=A0804=C2=A0 A=C2=A0 WM 141698288 + 8 &lt;- (8,1) 141696=
240<br>
&gt; &gt;=C2=A0 8,0=C2=A0 =C2=A011=C2=A0 =C2=A0 =C2=A0 153=C2=A0 =C2=A0 81.=
092472889=C2=A0 =C2=A0804=C2=A0 Q=C2=A0 WM 141698288 + 8 [xfsaild/sda1]<br>
&gt; &gt;=C2=A0 8,0=C2=A0 =C2=A011=C2=A0 =C2=A0 =C2=A0 154=C2=A0 =C2=A0 81.=
092473207=C2=A0 =C2=A0804=C2=A0 G=C2=A0 WM 141698288 + 8 [xfsaild/sda1]<br>
&gt; &gt;=C2=A0 8,0=C2=A0 =C2=A011=C2=A0 =C2=A0 =C2=A0 206=C2=A0 =C2=A0 81.=
092496118=C2=A0 =C2=A0804=C2=A0 I=C2=A0 WM 141698288 + 8 (=C2=A0 =C2=A02291=
1) [xfsaild/sda1]<br>
&gt; &gt;=C2=A0 &lt;=3D=3D=3D=3D &#39;I&#39; means Inserted (into the IO sc=
heduler) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D&gt;<br>
&gt; &gt;=C2=A0 8,0=C2=A0 =C2=A0 0=C2=A0 =C2=A0289372=C2=A0 =C2=A0 96.71876=
1435=C2=A0 =C2=A0 =C2=A00=C2=A0 D=C2=A0 WM 141698288 + 8 (15626265317) [swa=
pper/0]<br>
&gt; &gt;=C2=A0 &lt;=3D=3D=3D=3D Only 15s later the CFQ scheduler dispatche=
s the request =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D&gt;<br>
&gt; &gt;<br>
&gt; &gt; As we can see above, in this particular example CFQ took 15 secon=
ds to dispatch<br>
&gt; &gt; this request. Going back to the full trace, we can see that the x=
fsaild queue<br>
&gt; &gt; had plenty of opportunity to run, and it was selected as the acti=
ve queue many<br>
&gt; &gt; times. It would just always be preempted by something else (examp=
le):<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 8,0=C2=A0 =C2=A0 1=C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 =C2=
=A0 81.117912979=C2=A0 =C2=A0 =C2=A00=C2=A0 m=C2=A0 =C2=A0N cfq1618SN / ins=
ert_request<br>
&gt; &gt;=C2=A0 8,0=C2=A0 =C2=A0 1=C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 =C2=
=A0 81.117913419=C2=A0 =C2=A0 =C2=A00=C2=A0 m=C2=A0 =C2=A0N cfq1618SN / add=
_to_rr<br>
&gt; &gt;=C2=A0 8,0=C2=A0 =C2=A0 1=C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 =C2=
=A0 81.117914044=C2=A0 =C2=A0 =C2=A00=C2=A0 m=C2=A0 =C2=A0N cfq1618SN / pre=
empt<br>
&gt; &gt;=C2=A0 8,0=C2=A0 =C2=A0 1=C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 =C2=
=A0 81.117914398=C2=A0 =C2=A0 =C2=A00=C2=A0 m=C2=A0 =C2=A0N cfq767A=C2=A0 /=
 slice expired t=3D1<br>
&gt; &gt;=C2=A0 8,0=C2=A0 =C2=A0 1=C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 =C2=
=A0 81.117914755=C2=A0 =C2=A0 =C2=A00=C2=A0 m=C2=A0 =C2=A0N cfq767A=C2=A0 /=
 resid=3D40<br>
&gt; &gt;=C2=A0 8,0=C2=A0 =C2=A0 1=C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 =C2=
=A0 81.117915340=C2=A0 =C2=A0 =C2=A00=C2=A0 m=C2=A0 =C2=A0N / served: vt=3D=
1948520448 min_vt=3D1948520448<br>
&gt; &gt;=C2=A0 8,0=C2=A0 =C2=A0 1=C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 =C2=
=A0 81.117915858=C2=A0 =C2=A0 =C2=A00=C2=A0 m=C2=A0 =C2=A0N cfq767A=C2=A0 /=
 sl_used=3D1 disp=3D0 charge=3D0 iops=3D1 sect=3D0<br>
&gt; &gt;<br>
&gt; &gt; where cfq767 is the xfsaild queue and cfq1618 corresponds to one =
of the ScyllaDB<br>
&gt; &gt; IO dispatchers.<br>
&gt; &gt;<br>
&gt; &gt; The requests preempting the xfsaild queue are synchronous request=
s. That&#39;s a<br>
&gt; &gt; characteristic of ScyllaDB workloads, as we only ever issue O_DIR=
ECT requests.<br>
&gt; &gt; While it can be argued that preempting ASYNC requests in favor of=
 SYNC is part<br>
&gt; &gt; of the CFQ logic, I don&#39;t believe that doing so for 15+ secon=
ds is anyone&#39;s<br>
&gt; &gt; goal.<br>
&gt; &gt;<br>
&gt; &gt; Moreover, unless I am misunderstanding something, that breaks the=
 expectation<br>
&gt; &gt; set by the &quot;fifo_expire_async&quot; tunable, which in my sys=
tem is set to the<br>
&gt; &gt; default.<br>
&gt; &gt;<br>
&gt; &gt; Looking at the code, it seems to me that the issue is that after =
we make<br>
&gt; &gt; an async queue active, there is no guarantee that it will execute=
 any request.<br>
&gt; &gt;<br>
&gt; &gt; When the queue itself tests if it cfq_may_dispatch() it can bail =
if it sees SYNC<br>
&gt; &gt; requests in flight. An incoming request from another queue can al=
so preempt it<br>
&gt; &gt; in such situation before we have the chance to execute anything (=
as seen in the<br>
&gt; &gt; trace above).<br>
&gt; &gt;<br>
&gt;<br>
&gt; The BFQ scheduler should not suffer from this issue, because it does<b=
r>
&gt; not consider this condition at all for preemption.=C2=A0 Even better, =
BFQ<br>
&gt; performs preemption as a function of just one condition, which is<br>
&gt; formally proven not to break any request-delay guarantee.<br>
&gt;<br>
&gt; Would you be willing to give it a try?=C2=A0 It might solve or at leas=
t<br>
&gt; mitigate the specific latency problem addressed by your patch, and at<=
br>
&gt; the same time provide many other benefits, in terms of low latency and=
<br>
&gt; high throughput.</p>
<p dir=3D"ltr">We are definitely interested in trying different elevators t=
hat could benefit our workload. Specially because right now we don&#39;t re=
ally have a default recommendation.</p>
<p dir=3D"ltr">But just to be clear, I saw very early on that the problem d=
idn&#39;t happen with noop or deadline, so if this was just a characteristi=
c of the CFQ I would have stopped there.</p>
<p dir=3D"ltr">I do believe however, as I have said in my commitlog message=
, that this is just a bug. And no bug shall remain unfixed in my presence.<=
br></p>
<p dir=3D"ltr">&gt;<br>
&gt; If you are willing to try it, then in [1] you can find the last BFQ<br=
>
&gt; development branch, rebased against 4.8-rc7.=C2=A0 These commits add B=
FQ as an<br>
&gt; extra scheduler.<br>
&gt;<br>
&gt; Otherwise you can find BFQ for 4.7 here [2], and BFQ for 4.6 here [3].=
<br>
&gt;<br>
&gt; If you prefer patches, then you can find them in [4] for 4.7, or in<br=
>
&gt; [5] for 4.6.<br>
&gt;<br>
&gt; Finally, if you need details about BFQ, have a look at [6], or just as=
k!<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Paolo<br>
&gt;<br>
&gt; [1] <a href=3D"https://github.com/linusw/linux-bfq/tree/bfq-v8">https:=
//github.com/linusw/linux-bfq/tree/bfq-v8</a><br>
&gt; [2] <a href=3D"https://github.com/linusw/linux-bfq/tree/bfq-v8-v4.7">h=
ttps://github.com/linusw/linux-bfq/tree/bfq-v8-v4.7</a><br>
&gt; [3] <a href=3D"https://github.com/linusw/linux-bfq/tree/bfq-v8-v4.6">h=
ttps://github.com/linusw/linux-bfq/tree/bfq-v8-v4.6</a><br>
&gt; [4] <a href=3D"http://algogroup.unimore.it/people/paolo/disk_sched/pat=
ches/4.7.0-v8r3/">http://algogroup.unimore.it/people/paolo/disk_sched/patch=
es/4.7.0-v8r3/</a><br>
&gt; [5] <a href=3D"http://algogroup.unimore.it/people/paolo/disk_sched/pat=
ches/4.6.0-v8r3/">http://algogroup.unimore.it/people/paolo/disk_sched/patch=
es/4.6.0-v8r3/</a><br>
&gt; [6] <a href=3D"http://algogroup.unimore.it/people/paolo/disk_sched/">h=
ttp://algogroup.unimore.it/people/paolo/disk_sched/</a><br>
&gt;<br>
&gt; &gt; This patch sets the must_dispatch flag if we notice that we have =
requests<br>
&gt; &gt; that are already fifo_expired. This flag is always cleared after<=
br>
&gt; &gt; cfq_dispatch_request() returns from cfq_dispatch_requests(), so i=
t won&#39;t pin<br>
&gt; &gt; the queue for subsequent requests (unless they are themselves exp=
ired)<br>
&gt; &gt;<br>
&gt; &gt; Care is taken during preempt to still allow rt requests to preemp=
t us<br>
&gt; &gt; regardless.<br>
&gt; &gt;<br>
&gt; &gt; Testing my workload with this patch applied produces much better =
results.<br>
&gt; &gt; From the application side I see no timeouts, and the open() laten=
cy histogram<br>
&gt; &gt; generated by systemtap looks much better, with the worst outlier =
at 131ms:<br>
&gt; &gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; &gt; Latency histogram of xfs_buf_lock acquisition (microseconds):<br>
&gt; &gt; value |-------------------------------------------------- count<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A00 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A011=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A01 |@@@@=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 161<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A02 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@=C2=A0 1966<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A04 |@=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 54<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A08 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A036=
<br>
&gt; &gt;=C2=A0 =C2=A0 16 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7<br>
&gt; &gt;=C2=A0 =C2=A0 32 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
&gt; &gt;=C2=A0 =C2=A0 64 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0~<br>
&gt; &gt;=C2=A0 1024 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
&gt; &gt;=C2=A0 2048 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
&gt; &gt;=C2=A0 4096 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
&gt; &gt;=C2=A0 8192 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
&gt; &gt; 16384 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2<br>
&gt; &gt; 32768 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
&gt; &gt; 65536 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
&gt; &gt; 131072 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
&gt; &gt; 262144 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
&gt; &gt; 524288 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Glauber Costa &lt;<a href=3D"mailto:glauber@scylla=
db.com">glauber@scylladb.com</a>&gt;<br>
&gt; &gt; CC: Jens Axboe &lt;<a href=3D"mailto:axboe@kernel.dk">axboe@kerne=
l.dk</a>&gt;<br>
&gt; &gt; CC: <a href=3D"mailto:linux-block@vger.kernel.org">linux-block@vg=
er.kernel.org</a><br>
&gt; &gt; CC: <a href=3D"mailto:linux-kernel@vger.kernel.org">linux-kernel@=
vger.kernel.org</a><br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Glauber Costa &lt;<a href=3D"mailto:glauber@scylla=
db.com">glauber@scylladb.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt; block/cfq-iosched.c | 13 ++++++++++---<br>
&gt; &gt; 1 file changed, 10 insertions(+), 3 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c<br>
&gt; &gt; index cc2f6db..5e24d88 100644<br>
&gt; &gt; --- a/block/cfq-iosched.c<br>
&gt; &gt; +++ b/block/cfq-iosched.c<br>
&gt; &gt; @@ -3042,7 +3042,6 @@ static struct request *cfq_check_fifo(struc=
t cfq_queue *cfqq)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ktime_get_ns() &lt; rq-&gt;fifo_tim=
e)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rq =3D NULL=
;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0cfq_log_cfqq(cfqq-&gt;cfqd, cfqq, &quot;fifo=
=3D%p&quot;, rq);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return rq;<br>
&gt; &gt; }<br>
&gt; &gt;<br>
&gt; &gt; @@ -3420,6 +3419,9 @@ static bool cfq_may_dispatch(struct cfq_dat=
a *cfqd, struct cfq_queue *cfqq)<br>
&gt; &gt; {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int max_dispatch;<br>
&gt; &gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (cfq_cfqq_must_dispatch(cfqq))<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Drain async requests before we start=
 sync IO<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; &gt; @@ -3511,15 +3513,20 @@ static bool cfq_dispatch_request(struct c=
fq_data *cfqd, struct cfq_queue *cfqq)<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0BUG_ON(RB_EMPTY_ROOT(&amp;cfqq-&gt;sort=
_list));<br>
&gt; &gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0rq =3D cfq_check_fifo(cfqq);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (rq)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cfq_mark_cfqq_mu=
st_dispatch(cfqq);<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!cfq_may_dispatch(cfqd, cfqq))<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return fals=
e;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * follow expired path, else get first =
next available<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0rq =3D cfq_check_fifo(cfqq);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rq)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rq =3D cfqq=
-&gt;next_rq;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0else<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cfq_log_cfqq(cfq=
q-&gt;cfqd, cfqq, &quot;fifo=3D%p&quot;, rq);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * insert request into driver dispatch =
list<br>
&gt; &gt; @@ -3989,7 +3996,7 @@ cfq_should_preempt(struct cfq_data *cfqd, s=
truct cfq_queue *new_cfqq,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * if the new request is sync, but the =
currently running queue is<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * not, let the sync request have prior=
ity.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0if (rq_is_sync(rq) &amp;&amp; !cfq_cfqq_sync=
(cfqq))<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (rq_is_sync(rq) &amp;&amp; !cfq_cfqq_sync=
(cfqq) &amp;&amp; !cfq_cfqq_must_dispatch(cfqq))<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true=
;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; &gt; --<br>
&gt; &gt; 2.5.5<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; To unsubscribe from this list: send the line &quot;unsubscribe li=
nux-block&quot; in<br>
&gt; &gt; the body of a message to <a href=3D"mailto:majordomo@vger.kernel.=
org">majordomo@vger.kernel.org</a><br>
&gt; &gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/ma=
jordomo-info.html">http://vger.kernel.org/majordomo-info.html</a><br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Paolo Valente<br>
&gt; Algogroup<br>
&gt; Dipartimento di Scienze Fisiche, Informatiche e Matematiche<br>
&gt; Via Campi 213/B<br>
&gt; 41125 Modena - Italy<br>
&gt; <a href=3D"http://algogroup.unimore.it/people/paolo/">http://algogroup=
.unimore.it/people/paolo/</a><br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;</p>

--94eb2c0b66f09f268b053d2b1556--
