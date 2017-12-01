Return-Path: <ivan@ludios.org>
MIME-Version: 1.0
In-Reply-To: <20171201085051.GA1308@ming.t460p>
References: <87fu8v7xe2.fsf@ksca2.i-did-not-set--mail-host-address--so-tickle-me>
 <20171201085051.GA1308@ming.t460p>
From: Ivan Kozik <ivan@ludios.org>
Date: Fri, 1 Dec 2017 12:18:25 +0000
Message-ID: <CAKynti+h_-MuR7YXsiYHqTv7xCiy1QhRUyu=zCcb9brwR2ByxQ@mail.gmail.com>
Subject: Re: blk-mq + bfq IO hangs after writing partition table
To: Ming Lei <ming.lei@redhat.com>
Cc: axboe@kernel.dk, paolo.valente@linaro.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, oleksandr@natalenko.name
Content-Type: multipart/mixed; boundary="001a114c8e6a7420ac055f465f45"
List-ID: <linux-block@vger.kernel.org>

--001a114c8e6a7420ac055f465f45
Content-Type: text/plain; charset="UTF-8"

On Fri, Dec 1, 2017 at 8:50 AM, Ming Lei <ming.lei@redhat.com> wrote:
> Could you run the following script[1] and provide us the result after
> the IO hang is triggered?
>
>         #./dump-blk-info /dev/sdX       #/dev/sdX is name of your USB disk
>
> [1] http://people.redhat.com/minlei/tests/tools/dump-blk-info

Hi Ming,

Thanks for taking a look.  I have pasted and attached (in case of
gmail corruption) these files:

Samsung-128GB-before: Samsung 128GB USB 3.0 Fit plugged into HP 8460p,
before gdisk write

Samsung-128GB-after:  Samsung 128GB USB 3.0 Fit plugged into HP 8460p,
after gdisk write

Generic-4GB-after:    some awful generic but working 4GB USB flash
drive plugged into HP 8460p, after gdisk write

I have reproduced this again on the same kernel revision and blk-mq bfq with:

minimized cmdline: scsi_mod.use_blk_mq=y
gdisk writing the partition table as-is, no changes

and confirmed again that kyber never triggers this.

Thanks,

Ivan




Samsung-128GB-before
=============sdc/hctx0==================
$active
0

$busy

$/sys/kernel/debug/block/sdc//hctx0/cpu0
    $completed
    3 14
    $dispatched
    3 14
    $merged
    0
    $rq_list

$/sys/kernel/debug/block/sdc//hctx0/cpu1
    $completed
    159 76
    $dispatched
    159 76
    $merged
    0
    $rq_list

$/sys/kernel/debug/block/sdc//hctx0/cpu2
    $completed
    84 57
    $dispatched
    84 57
    $merged
    0
    $rq_list

$/sys/kernel/debug/block/sdc//hctx0/cpu3
    $completed
    154 54
    $dispatched
    155 54
    $merged
    1
    $rq_list

$ctx_map
00000000: 00

$dispatch

$dispatched
       0    8
       1    701
       2    0
       4    0
       8    0
      16    0
      32+    0

$flags
alloc_policy=FIFO SHOULD_MERGE|SG_MERGE

$io_poll
considered=0
invoked=0
success=0

$queued
602

$run
843

$sched_tags
nr_tags=2
nr_reserved_tags=0
active_queues=0

bitmap_tags:
depth=2
busy=1
bits_per_word=64
map_nr=1
alloc_hint={0, 1, 0, 0, 0, 1, 1, 0}
wake_batch=1
wake_index=0
ws={
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
}
round_robin=0

$sched_tags_bitmap
00000000: 01

$state


$tags
nr_tags=1
nr_reserved_tags=0
active_queues=0

bitmap_tags:
depth=1
busy=0
bits_per_word=64
map_nr=1
alloc_hint={0, 0, 0, 0, 0, 0, 0, 0}
wake_batch=1
wake_index=0
ws={
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
}
round_robin=0

$tags_bitmap
00000000: 00




Samsung-128GB-after
=============sdc/hctx0==================
$active
0

$busy

$/sys/kernel/debug/block/sdc//hctx0/cpu0
    $completed
    3 14
    $dispatched
    3 14
    $merged
    0
    $rq_list

$/sys/kernel/debug/block/sdc//hctx0/cpu1
    $completed
    159 95
    $dispatched
    159 96
    $merged
    0
    $rq_list

$/sys/kernel/debug/block/sdc//hctx0/cpu2
    $completed
    84 58
    $dispatched
    84 58
    $merged
    0
    $rq_list

$/sys/kernel/debug/block/sdc//hctx0/cpu3
    $completed
    154 54
    $dispatched
    155 54
    $merged
    1
    $rq_list

$ctx_map
00000000: 00

$dispatch

$dispatched
       0    8
       1    721
       2    0
       4    0
       8    0
      16    0
      32+    0

$flags
alloc_policy=FIFO SHOULD_MERGE|SG_MERGE

$io_poll
considered=0
invoked=0
success=0

$queued
623

$run
887

$sched_tags
nr_tags=2
nr_reserved_tags=0
active_queues=0

bitmap_tags:
depth=2
busy=2
bits_per_word=64
map_nr=1
alloc_hint={0, 0, 0, 0, 0, 1, 1, 0}
wake_batch=1
wake_index=0
ws={
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=active},
    {.wait_cnt=1, .wait=active},
    {.wait_cnt=1, .wait=active},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
}
round_robin=0

$sched_tags_bitmap
00000000: 03

$state


$tags
nr_tags=1
nr_reserved_tags=0
active_queues=0

bitmap_tags:
depth=1
busy=0
bits_per_word=64
map_nr=1
alloc_hint={0, 0, 0, 0, 0, 0, 0, 0}
wake_batch=1
wake_index=0
ws={
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
}
round_robin=0

$tags_bitmap
00000000: 00




Generic-4GB-after
=============sdc/hctx0==================
$active
0

$busy

$/sys/kernel/debug/block/sdc//hctx0/cpu0
    $completed
    94 32
    $dispatched
    94 33
    $merged
    0
    $rq_list

$/sys/kernel/debug/block/sdc//hctx0/cpu1
    $completed
    561 113
    $dispatched
    562 113
    $merged
    0
    $rq_list

$/sys/kernel/debug/block/sdc//hctx0/cpu2
    $completed
    251 179
    $dispatched
    251 179
    $merged
    4
    $rq_list

$/sys/kernel/debug/block/sdc//hctx0/cpu3
    $completed
    228 63
    $dispatched
    228 63
    $merged
    0
    $rq_list

$ctx_map
00000000: 00

$dispatch

$dispatched
       0    21
       1    1707
       2    0
       4    0
       8    0
      16    0
      32+    0

$flags
alloc_policy=FIFO SHOULD_MERGE|SG_MERGE

$io_poll
considered=0
invoked=0
success=0

$queued
1523

$run
2000

$sched_tags
nr_tags=2
nr_reserved_tags=0
active_queues=0

bitmap_tags:
depth=2
busy=2
bits_per_word=64
map_nr=1
alloc_hint={0, 0, 0, 0, 1, 1, 0, 0}
wake_batch=1
wake_index=0
ws={
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=active},
    {.wait_cnt=1, .wait=active},
    {.wait_cnt=1, .wait=active},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
}
round_robin=0

$sched_tags_bitmap
00000000: 03

$state


$tags
nr_tags=1
nr_reserved_tags=0
active_queues=0

bitmap_tags:
depth=1
busy=0
bits_per_word=64
map_nr=1
alloc_hint={0, 0, 0, 0, 0, 0, 0, 0}
wake_batch=1
wake_index=0
ws={
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
    {.wait_cnt=1, .wait=inactive},
}
round_robin=0

$tags_bitmap
00000000: 00

--001a114c8e6a7420ac055f465f45
Content-Type: application/octet-stream; name=Generic-4GB-after
Content-Disposition: attachment; filename=Generic-4GB-after
Content-Transfer-Encoding: base64
X-Attachment-Id: f_janvchfw0

PT09PT09PT09PT09PXNkYy9oY3R4MD09PT09PT09PT09PT09PT09PQokYWN0aXZlCjAKCiRidXN5
CgokL3N5cy9rZXJuZWwvZGVidWcvYmxvY2svc2RjLy9oY3R4MC9jcHUwCgkkY29tcGxldGVkCgk5
NCAzMgoJJGRpc3BhdGNoZWQKCTk0IDMzCgkkbWVyZ2VkCgkwCgkkcnFfbGlzdAoJCiQvc3lzL2tl
cm5lbC9kZWJ1Zy9ibG9jay9zZGMvL2hjdHgwL2NwdTEKCSRjb21wbGV0ZWQKCTU2MSAxMTMKCSRk
aXNwYXRjaGVkCgk1NjIgMTEzCgkkbWVyZ2VkCgkwCgkkcnFfbGlzdAoJCiQvc3lzL2tlcm5lbC9k
ZWJ1Zy9ibG9jay9zZGMvL2hjdHgwL2NwdTIKCSRjb21wbGV0ZWQKCTI1MSAxNzkKCSRkaXNwYXRj
aGVkCgkyNTEgMTc5CgkkbWVyZ2VkCgk0CgkkcnFfbGlzdAoJCiQvc3lzL2tlcm5lbC9kZWJ1Zy9i
bG9jay9zZGMvL2hjdHgwL2NwdTMKCSRjb21wbGV0ZWQKCTIyOCA2MwoJJGRpc3BhdGNoZWQKCTIy
OCA2MwoJJG1lcmdlZAoJMAoJJHJxX2xpc3QKCQokY3R4X21hcAowMDAwMDAwMDogMDAKCiRkaXNw
YXRjaAoKJGRpc3BhdGNoZWQKICAgICAgIDAJMjEKICAgICAgIDEJMTcwNwogICAgICAgMgkwCiAg
ICAgICA0CTAKICAgICAgIDgJMAogICAgICAxNgkwCiAgICAgIDMyKwkwCgokZmxhZ3MKYWxsb2Nf
cG9saWN5PUZJRk8gU0hPVUxEX01FUkdFfFNHX01FUkdFCgokaW9fcG9sbApjb25zaWRlcmVkPTAK
aW52b2tlZD0wCnN1Y2Nlc3M9MAoKJHF1ZXVlZAoxNTIzCgokcnVuCjIwMDAKCiRzY2hlZF90YWdz
Cm5yX3RhZ3M9Mgpucl9yZXNlcnZlZF90YWdzPTAKYWN0aXZlX3F1ZXVlcz0wCgpiaXRtYXBfdGFn
czoKZGVwdGg9MgpidXN5PTIKYml0c19wZXJfd29yZD02NAptYXBfbnI9MQphbGxvY19oaW50PXsw
LCAwLCAwLCAwLCAxLCAxLCAwLCAwfQp3YWtlX2JhdGNoPTEKd2FrZV9pbmRleD0wCndzPXsKCXsu
d2FpdF9jbnQ9MSwgLndhaXQ9aW5hY3RpdmV9LAoJey53YWl0X2NudD0xLCAud2FpdD1pbmFjdGl2
ZX0sCgl7LndhaXRfY250PTEsIC53YWl0PWFjdGl2ZX0sCgl7LndhaXRfY250PTEsIC53YWl0PWFj
dGl2ZX0sCgl7LndhaXRfY250PTEsIC53YWl0PWFjdGl2ZX0sCgl7LndhaXRfY250PTEsIC53YWl0
PWluYWN0aXZlfSwKCXsud2FpdF9jbnQ9MSwgLndhaXQ9aW5hY3RpdmV9LAoJey53YWl0X2NudD0x
LCAud2FpdD1pbmFjdGl2ZX0sCn0Kcm91bmRfcm9iaW49MAoKJHNjaGVkX3RhZ3NfYml0bWFwCjAw
MDAwMDAwOiAwMwoKJHN0YXRlCgoKJHRhZ3MKbnJfdGFncz0xCm5yX3Jlc2VydmVkX3RhZ3M9MAph
Y3RpdmVfcXVldWVzPTAKCmJpdG1hcF90YWdzOgpkZXB0aD0xCmJ1c3k9MApiaXRzX3Blcl93b3Jk
PTY0Cm1hcF9ucj0xCmFsbG9jX2hpbnQ9ezAsIDAsIDAsIDAsIDAsIDAsIDAsIDB9Cndha2VfYmF0
Y2g9MQp3YWtlX2luZGV4PTAKd3M9ewoJey53YWl0X2NudD0xLCAud2FpdD1pbmFjdGl2ZX0sCgl7
LndhaXRfY250PTEsIC53YWl0PWluYWN0aXZlfSwKCXsud2FpdF9jbnQ9MSwgLndhaXQ9aW5hY3Rp
dmV9LAoJey53YWl0X2NudD0xLCAud2FpdD1pbmFjdGl2ZX0sCgl7LndhaXRfY250PTEsIC53YWl0
PWluYWN0aXZlfSwKCXsud2FpdF9jbnQ9MSwgLndhaXQ9aW5hY3RpdmV9LAoJey53YWl0X2NudD0x
LCAud2FpdD1pbmFjdGl2ZX0sCgl7LndhaXRfY250PTEsIC53YWl0PWluYWN0aXZlfSwKfQpyb3Vu
ZF9yb2Jpbj0wCgokdGFnc19iaXRtYXAKMDAwMDAwMDA6IDAwCgo=
--001a114c8e6a7420ac055f465f45
Content-Type: application/octet-stream; name=Samsung-128GB-after
Content-Disposition: attachment; filename=Samsung-128GB-after
Content-Transfer-Encoding: base64
X-Attachment-Id: f_janvchgg1

PT09PT09PT09PT09PXNkYy9oY3R4MD09PT09PT09PT09PT09PT09PQokYWN0aXZlCjAKCiRidXN5
CgokL3N5cy9rZXJuZWwvZGVidWcvYmxvY2svc2RjLy9oY3R4MC9jcHUwCgkkY29tcGxldGVkCgkz
IDE0CgkkZGlzcGF0Y2hlZAoJMyAxNAoJJG1lcmdlZAoJMAoJJHJxX2xpc3QKCQokL3N5cy9rZXJu
ZWwvZGVidWcvYmxvY2svc2RjLy9oY3R4MC9jcHUxCgkkY29tcGxldGVkCgkxNTkgOTUKCSRkaXNw
YXRjaGVkCgkxNTkgOTYKCSRtZXJnZWQKCTAKCSRycV9saXN0CgkKJC9zeXMva2VybmVsL2RlYnVn
L2Jsb2NrL3NkYy8vaGN0eDAvY3B1MgoJJGNvbXBsZXRlZAoJODQgNTgKCSRkaXNwYXRjaGVkCgk4
NCA1OAoJJG1lcmdlZAoJMAoJJHJxX2xpc3QKCQokL3N5cy9rZXJuZWwvZGVidWcvYmxvY2svc2Rj
Ly9oY3R4MC9jcHUzCgkkY29tcGxldGVkCgkxNTQgNTQKCSRkaXNwYXRjaGVkCgkxNTUgNTQKCSRt
ZXJnZWQKCTEKCSRycV9saXN0CgkKJGN0eF9tYXAKMDAwMDAwMDA6IDAwCgokZGlzcGF0Y2gKCiRk
aXNwYXRjaGVkCiAgICAgICAwCTgKICAgICAgIDEJNzIxCiAgICAgICAyCTAKICAgICAgIDQJMAog
ICAgICAgOAkwCiAgICAgIDE2CTAKICAgICAgMzIrCTAKCiRmbGFncwphbGxvY19wb2xpY3k9RklG
TyBTSE9VTERfTUVSR0V8U0dfTUVSR0UKCiRpb19wb2xsCmNvbnNpZGVyZWQ9MAppbnZva2VkPTAK
c3VjY2Vzcz0wCgokcXVldWVkCjYyMwoKJHJ1bgo4ODcKCiRzY2hlZF90YWdzCm5yX3RhZ3M9Mgpu
cl9yZXNlcnZlZF90YWdzPTAKYWN0aXZlX3F1ZXVlcz0wCgpiaXRtYXBfdGFnczoKZGVwdGg9Mgpi
dXN5PTIKYml0c19wZXJfd29yZD02NAptYXBfbnI9MQphbGxvY19oaW50PXswLCAwLCAwLCAwLCAw
LCAxLCAxLCAwfQp3YWtlX2JhdGNoPTEKd2FrZV9pbmRleD0wCndzPXsKCXsud2FpdF9jbnQ9MSwg
LndhaXQ9aW5hY3RpdmV9LAoJey53YWl0X2NudD0xLCAud2FpdD1pbmFjdGl2ZX0sCgl7LndhaXRf
Y250PTEsIC53YWl0PWFjdGl2ZX0sCgl7LndhaXRfY250PTEsIC53YWl0PWFjdGl2ZX0sCgl7Lndh
aXRfY250PTEsIC53YWl0PWFjdGl2ZX0sCgl7LndhaXRfY250PTEsIC53YWl0PWluYWN0aXZlfSwK
CXsud2FpdF9jbnQ9MSwgLndhaXQ9aW5hY3RpdmV9LAoJey53YWl0X2NudD0xLCAud2FpdD1pbmFj
dGl2ZX0sCn0Kcm91bmRfcm9iaW49MAoKJHNjaGVkX3RhZ3NfYml0bWFwCjAwMDAwMDAwOiAwMwoK
JHN0YXRlCgoKJHRhZ3MKbnJfdGFncz0xCm5yX3Jlc2VydmVkX3RhZ3M9MAphY3RpdmVfcXVldWVz
PTAKCmJpdG1hcF90YWdzOgpkZXB0aD0xCmJ1c3k9MApiaXRzX3Blcl93b3JkPTY0Cm1hcF9ucj0x
CmFsbG9jX2hpbnQ9ezAsIDAsIDAsIDAsIDAsIDAsIDAsIDB9Cndha2VfYmF0Y2g9MQp3YWtlX2lu
ZGV4PTAKd3M9ewoJey53YWl0X2NudD0xLCAud2FpdD1pbmFjdGl2ZX0sCgl7LndhaXRfY250PTEs
IC53YWl0PWluYWN0aXZlfSwKCXsud2FpdF9jbnQ9MSwgLndhaXQ9aW5hY3RpdmV9LAoJey53YWl0
X2NudD0xLCAud2FpdD1pbmFjdGl2ZX0sCgl7LndhaXRfY250PTEsIC53YWl0PWluYWN0aXZlfSwK
CXsud2FpdF9jbnQ9MSwgLndhaXQ9aW5hY3RpdmV9LAoJey53YWl0X2NudD0xLCAud2FpdD1pbmFj
dGl2ZX0sCgl7LndhaXRfY250PTEsIC53YWl0PWluYWN0aXZlfSwKfQpyb3VuZF9yb2Jpbj0wCgok
dGFnc19iaXRtYXAKMDAwMDAwMDA6IDAwCgo=
--001a114c8e6a7420ac055f465f45
Content-Type: application/octet-stream; name=Samsung-128GB-before
Content-Disposition: attachment; filename=Samsung-128GB-before
Content-Transfer-Encoding: base64
X-Attachment-Id: f_janvchgl2

PT09PT09PT09PT09PXNkYy9oY3R4MD09PT09PT09PT09PT09PT09PQokYWN0aXZlCjAKCiRidXN5
CgokL3N5cy9rZXJuZWwvZGVidWcvYmxvY2svc2RjLy9oY3R4MC9jcHUwCgkkY29tcGxldGVkCgkz
IDE0CgkkZGlzcGF0Y2hlZAoJMyAxNAoJJG1lcmdlZAoJMAoJJHJxX2xpc3QKCQokL3N5cy9rZXJu
ZWwvZGVidWcvYmxvY2svc2RjLy9oY3R4MC9jcHUxCgkkY29tcGxldGVkCgkxNTkgNzYKCSRkaXNw
YXRjaGVkCgkxNTkgNzYKCSRtZXJnZWQKCTAKCSRycV9saXN0CgkKJC9zeXMva2VybmVsL2RlYnVn
L2Jsb2NrL3NkYy8vaGN0eDAvY3B1MgoJJGNvbXBsZXRlZAoJODQgNTcKCSRkaXNwYXRjaGVkCgk4
NCA1NwoJJG1lcmdlZAoJMAoJJHJxX2xpc3QKCQokL3N5cy9rZXJuZWwvZGVidWcvYmxvY2svc2Rj
Ly9oY3R4MC9jcHUzCgkkY29tcGxldGVkCgkxNTQgNTQKCSRkaXNwYXRjaGVkCgkxNTUgNTQKCSRt
ZXJnZWQKCTEKCSRycV9saXN0CgkKJGN0eF9tYXAKMDAwMDAwMDA6IDAwCgokZGlzcGF0Y2gKCiRk
aXNwYXRjaGVkCiAgICAgICAwCTgKICAgICAgIDEJNzAxCiAgICAgICAyCTAKICAgICAgIDQJMAog
ICAgICAgOAkwCiAgICAgIDE2CTAKICAgICAgMzIrCTAKCiRmbGFncwphbGxvY19wb2xpY3k9RklG
TyBTSE9VTERfTUVSR0V8U0dfTUVSR0UKCiRpb19wb2xsCmNvbnNpZGVyZWQ9MAppbnZva2VkPTAK
c3VjY2Vzcz0wCgokcXVldWVkCjYwMgoKJHJ1bgo4NDMKCiRzY2hlZF90YWdzCm5yX3RhZ3M9Mgpu
cl9yZXNlcnZlZF90YWdzPTAKYWN0aXZlX3F1ZXVlcz0wCgpiaXRtYXBfdGFnczoKZGVwdGg9Mgpi
dXN5PTEKYml0c19wZXJfd29yZD02NAptYXBfbnI9MQphbGxvY19oaW50PXswLCAxLCAwLCAwLCAw
LCAxLCAxLCAwfQp3YWtlX2JhdGNoPTEKd2FrZV9pbmRleD0wCndzPXsKCXsud2FpdF9jbnQ9MSwg
LndhaXQ9aW5hY3RpdmV9LAoJey53YWl0X2NudD0xLCAud2FpdD1pbmFjdGl2ZX0sCgl7LndhaXRf
Y250PTEsIC53YWl0PWluYWN0aXZlfSwKCXsud2FpdF9jbnQ9MSwgLndhaXQ9aW5hY3RpdmV9LAoJ
ey53YWl0X2NudD0xLCAud2FpdD1pbmFjdGl2ZX0sCgl7LndhaXRfY250PTEsIC53YWl0PWluYWN0
aXZlfSwKCXsud2FpdF9jbnQ9MSwgLndhaXQ9aW5hY3RpdmV9LAoJey53YWl0X2NudD0xLCAud2Fp
dD1pbmFjdGl2ZX0sCn0Kcm91bmRfcm9iaW49MAoKJHNjaGVkX3RhZ3NfYml0bWFwCjAwMDAwMDAw
OiAwMQoKJHN0YXRlCgoKJHRhZ3MKbnJfdGFncz0xCm5yX3Jlc2VydmVkX3RhZ3M9MAphY3RpdmVf
cXVldWVzPTAKCmJpdG1hcF90YWdzOgpkZXB0aD0xCmJ1c3k9MApiaXRzX3Blcl93b3JkPTY0Cm1h
cF9ucj0xCmFsbG9jX2hpbnQ9ezAsIDAsIDAsIDAsIDAsIDAsIDAsIDB9Cndha2VfYmF0Y2g9MQp3
YWtlX2luZGV4PTAKd3M9ewoJey53YWl0X2NudD0xLCAud2FpdD1pbmFjdGl2ZX0sCgl7LndhaXRf
Y250PTEsIC53YWl0PWluYWN0aXZlfSwKCXsud2FpdF9jbnQ9MSwgLndhaXQ9aW5hY3RpdmV9LAoJ
ey53YWl0X2NudD0xLCAud2FpdD1pbmFjdGl2ZX0sCgl7LndhaXRfY250PTEsIC53YWl0PWluYWN0
aXZlfSwKCXsud2FpdF9jbnQ9MSwgLndhaXQ9aW5hY3RpdmV9LAoJey53YWl0X2NudD0xLCAud2Fp
dD1pbmFjdGl2ZX0sCgl7LndhaXRfY250PTEsIC53YWl0PWluYWN0aXZlfSwKfQpyb3VuZF9yb2Jp
bj0wCgokdGFnc19iaXRtYXAKMDAwMDAwMDA6IDAwCgo=
--001a114c8e6a7420ac055f465f45--
