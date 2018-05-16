Return-Path: <hhtracer@gmail.com>
MIME-Version: 1.0
From: =?UTF-8?B?6IOh5rW3?= <hhtracer@gmail.com>
Date: Wed, 16 May 2018 11:24:48 +0800
Message-ID: <CAAq-RfRiymojD_Bf69VEo-8qquXo+LbckH1B_DmCigLt-CgCng@mail.gmail.com>
Subject: blk-mq: for sync case, whether it is mq or sq make_request instances,
 we should send the request directly
To: axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000e71339056c4a42bf"
List-ID: <linux-block@vger.kernel.org>

--000000000000e71339056c4a42bf
Content-Type: text/plain; charset="UTF-8"

Author: huhai <huhai@kylinos.cn>
Date:   Wed May 16 10:34:22 2018 +0800

    blk-mq: for sync case, whether it is mq or sq make_request instances,
we should send the request directly

    For sq make_request instances, we should issue sync request directly
too,
    otherwise it will break down the semantics of sync request,
    the current code logic is to send synchronous requests asynchronously.

    Signed-off-by: huhai <huhai@kylinos.cn>

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5629f18..fcf2f16 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1771,7 +1771,7 @@ static blk_qc_t blk_mq_make_request(struct
request_queue *q, struct bio *bio)
                        blk_mq_try_issue_directly(data.hctx, same_queue_rq,
                                        &cookie);
                }
-       } else if (q->nr_hw_queues > 1 && is_sync) {
+       } else if (is_sync) {
                blk_mq_put_ctx(data.ctx);
                blk_mq_bio_to_request(rq, bio);
                blk_mq_try_issue_directly(data.hctx, rq, &cookie);

--000000000000e71339056c4a42bf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Author: huhai &lt;<a href=3D"mailto:huhai@kylinos.cn">huha=
i@kylinos.cn</a>&gt;<br>Date: =C2=A0 Wed May 16 10:34:22 2018 +0800<br><br>=
=C2=A0 =C2=A0 blk-mq: for sync case, whether it is mq or sq make_request in=
stances, we should send the request directly<br>=C2=A0 <br>=C2=A0 =C2=A0 Fo=
r sq make_request instances, we should issue sync request directly too,<br>=
=C2=A0 =C2=A0 otherwise it will break down the semantics of sync request,<b=
r>=C2=A0 =C2=A0 the current code logic is to send synchronous requests asyn=
chronously.<br>=C2=A0 <br>=C2=A0 =C2=A0 Signed-off-by: huhai &lt;<a href=3D=
"mailto:huhai@kylinos.cn">huhai@kylinos.cn</a>&gt;<br><br>diff --git a/bloc=
k/blk-mq.c b/block/blk-mq.c<br>index 5629f18..fcf2f16 100644<br>--- a/block=
/blk-mq.c<br>+++ b/block/blk-mq.c<br>@@ -1771,7 +1771,7 @@ static blk_qc_t =
blk_mq_make_request(struct request_queue *q, struct bio *bio)<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b=
lk_mq_try_issue_directly(data.hctx, same_queue_rq,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;cookie);<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>- =C2=A0 =C2=A0 =C2=A0 }=
 else if (q-&gt;nr_hw_queues &gt; 1 &amp;&amp; is_sync) {<br>+ =C2=A0 =C2=
=A0 =C2=A0 } else if (is_sync) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 blk_mq_put_ctx(data.ctx);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 blk_mq_bio_to_request(rq, bio);<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 blk_mq_try_issue_directly(dat=
a.hctx, rq, &amp;cookie);<br></div>

--000000000000e71339056c4a42bf--
