Return-Path: <bruschi.chiara@outlook.it>
From: Chiara Bruschi <bruschi.chiara@outlook.it>
To: Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"paolo.valente@linaro.org" <paolo.valente@linaro.org>, "federico@willer.it"
	<federico@willer.it>
Subject: Re: [PATCH] block, bfq: fix occurrences of request finish method's
 old name
Date: Wed, 10 Jan 2018 14:24:18 +0000
Message-ID: <DB5PR09MB0263734788385F2E4C8163E5EA110@DB5PR09MB0263.eurprd09.prod.outlook.com>
References: <DB5PR09MB0263012F008A9B927BF94FFAEA0E0@DB5PR09MB0263.eurprd09.prod.outlook.com>
In-Reply-To: <DB5PR09MB0263012F008A9B927BF94FFAEA0E0@DB5PR09MB0263.eurprd09.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Hi Jens,
have you had time to look into this?

Thank you,
Chiara Bruschi


On 12/18/17 5:21 PM, Chiara Bruschi wrote:

Commit '7b9e93616399' ("blk-mq-sched: unify request finished methods")
changed the old name of current bfq_finish_request method, but left it
unchanged elsewhere in the code (related comments, part of function
name bfq_put_rq_priv_body).

This commit fixes all occurrences of the old name of this method by
changing them into the current name.

Fixes: 7b9e93616399 ("blk-mq-sched: unify request finished methods")
Reviewed-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Federico Motta <federico@willer.it>
Signed-off-by: Chiara Bruschi <bruschi.chiara@outlook.it>
---
=A0block/bfq-iosched.c | 26 +++++++++++++-------------
=A01 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index bcb6d21..6da7f71 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -3630,8 +3630,8 @@ static struct request *__bfq_dispatch_request(struct =
blk_mq_hw_ctx *hctx)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * We exploit the put_rq_priv=
ate hook to decrement
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * rq_in_driver, but put_rq_p=
rivate will not be
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * We exploit the bfq_finish_=
request hook to decrement
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * rq_in_driver, but bfq_fini=
sh_request will not be
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * invoked on this reque=
st. So, to avoid unbalance,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * just start this reque=
st, without incrementing
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * rq_in_driver. As a ne=
gative consequence,
@@ -3640,14 +3640,14 @@ static struct request *__bfq_dispatch_request(struc=
t blk_mq_hw_ctx *hctx)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * bfq_schedule_dispatch=
 to be invoked uselessly.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * As for implementing a=
n exact solution, the
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * put_request hook, if defin=
ed, is probably invoked
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * also on this request. So, =
by exploiting this hook,
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * we could 1) increment rq_i=
n_driver here, and 2)
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * decrement it in put_reques=
t. Such a solution would
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * let the value of the count=
er be always accurate,
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * but it would entail using =
an extra interface
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * function. This cost seems =
higher than the benefit,
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * being the frequency of non=
-elevator-private
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * bfq_finish_request hook, i=
f defined, is probably
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * invoked also on this reque=
st. So, by exploiting
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * this hook, we could 1) inc=
rement rq_in_driver here,
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * and 2) decrement it in bfq=
_finish_request. Such a
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * solution would let the val=
ue of the counter be
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * always accurate, but it wo=
uld entail using an extra
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * interface function. This c=
ost seems higher than the
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * benefit, being the frequen=
cy of non-elevator-private
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * requests very low.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto start_rq;
@@ -4482,7 +4482,7 @@ static void bfq_completed_request(struct bfq_queue *b=
fqq, struct bfq_data *bfqd)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bfq_schedule_dispatch(bfqd=
);
=A0}
=A0
-static void bfq_put_rq_priv_body(struct bfq_queue *bfqq)
+static void bfq_finish_request_body(struct bfq_queue *bfqq)
=A0{
=A0=A0=A0=A0=A0=A0=A0=A0 bfqq->allocated--;
=A0
@@ -4512,7 +4512,7 @@ static void bfq_finish_request(struct request *rq)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spin_lock_irqsave(&bfqd->l=
ock, flags);
=A0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bfq_completed_request(bfqq=
, bfqd);
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bfq_put_rq_priv_body(bfqq);
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bfq_finish_request_body(bfqq);
=A0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spin_unlock_irqrestore(&bf=
qd->lock, flags);
=A0=A0=A0=A0=A0=A0=A0=A0 } else {
@@ -4533,7 +4533,7 @@ static void bfq_finish_request(struct request *rq)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bf=
qg_stats_update_io_remove(bfqq_group(bfqq),
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 rq->cmd_flags);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bfq_put_rq_priv_body(bfqq);
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bfq_finish_request_body(bfqq);
=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0
=A0=A0=A0=A0=A0=A0=A0=A0 rq->elv.priv[0] =3D NULL;
--=20
2.1.4
