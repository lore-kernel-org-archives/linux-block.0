Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F167C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 18:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F7521871
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 18:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hYdoj3HS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbeLRSFB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:05:01 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:50418 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeLRSFA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 13:05:00 -0500
Received: by mail-wm1-f52.google.com with SMTP id n190so3602379wmd.0
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 10:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Nvz66GtPUuxYN3vxMK8IUzN/4X43NSnR4yHHkj6VSrs=;
        b=hYdoj3HS7rdihIYDpxPx8YqjVnOHkLhoMuLXOfxbrWq5sM3hjJDc79+6UIHy7hp33d
         pa/CFYAElkR9cBSJu3rQBzZNRhMPtQaQme48bh3mrJWr8M/M8HKl9tqtdnmREIRP1ImS
         bK09PSlllnC4FgUDPoCqBZlmqVyAHyx6O7Ux4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Nvz66GtPUuxYN3vxMK8IUzN/4X43NSnR4yHHkj6VSrs=;
        b=Ax91YYX+PoTbavQQmyXcfPEkLnHItMpKimpoq7MosWII0nlP/4t/uP+xInbY+JLBwb
         eIPAQqlyvAPuD7JIWpei2XJGxTKyrTlQF4icBi2ypmh4rXzjltKAXLPJylm7O+5KswaY
         LAc1QAROIio6XjxdJrkmjCxueKJLtKC6tCleI2jELs1xWt6jCFEngLoTFgJj123gWxz5
         +WfIKzv0zF1YC0yJRTgEV/cYlpJ7WX+tdJzJSpS1j5uP67zip85NlXiM4zLyEUUZEvfH
         sErnQRWccytxeP138OzaKssAfEw8k0iDFVoYHdFTY6h6DRkqOLoSZ3+zAp4AZ/ZoStM0
         JCeg==
X-Gm-Message-State: AA+aEWb/z+QnF9mhsl2FYCPlqY/fjCAkaAM9FuyHUPGt/GfZTFG7pSWL
        HYDqti2Zbl+KUSmGubGuz4AlPQ==
X-Google-Smtp-Source: AFSGD/XCHNll1T+WmXWwVJ2/cJyRk4IoFWCh5u36Y5IYSF3VBU2dXhJqxMlYduB88yp6hkTaXcWE9A==
X-Received: by 2002:a1c:8851:: with SMTP id k78mr4225895wmd.51.1545156297003;
        Tue, 18 Dec 2018 10:04:57 -0800 (PST)
Received: from [192.168.0.100] ([84.33.66.6])
        by smtp.gmail.com with ESMTPSA id y185sm1943751wmg.34.2018.12.18.10.04.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 10:04:55 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <255AD47C-65DD-4F22-9E64-8DF9DD81B83B@linaro.org>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_B52409CE-065A-4B14-AC0A-36522C86359B"
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: Unintuitive scheduling results using BFQ
Date:   Tue, 18 Dec 2018 19:04:54 +0100
In-Reply-To: <CA+XCsb8eiq7w-W5ecPNdnqvrv1dU4Vkq=HfKCG=MoQi_CekPBg@mail.gmail.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
To:     Madhav Ancha <mancha@tower-research.com>
References: <CA+XCsb-0M8PXB30zd22c_nmww5OvMs4mKEcsFahMR7jV+9+01g@mail.gmail.com>
 <8FCED0AE-6BE7-42EE-92ED-58E2B622A165@linaro.org>
 <CA+XCsb-0vY+x1+jSSRYcLdYz+U_T77QefQVWEoikSS5bfevjpg@mail.gmail.com>
 <C8B5F877-6F4B-46AD-9AC9-BAE91C754A5F@linaro.org>
 <CA+XCsb8eiq7w-W5ecPNdnqvrv1dU4Vkq=HfKCG=MoQi_CekPBg@mail.gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_B52409CE-065A-4B14-AC0A-36522C86359B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 14 dic 2018, alle ore 19:25, Madhav Ancha =
<mancha@tower-research.com> ha scritto:
>=20
> Hi Paolo,
>=20
>    Thanks a lot for your time and help.
>=20
>    I reset all the parameters for bfq and am now running with this
> one change from the defaults.
>    - low_latency is set to 0.
>=20
>    When tested with our applications, the IOPRIO_CLASS_RT (doing
> direct I/O) task has no preference over the IOPRIO_CLASS_BE task (that
> was using the kernel page cache)
>=20
>    When tested with dd, the IOPRIO_CLASS_RT task (with direct I/O)
> was getting about 1/4th the bandwidth the IOPRIO_CLASS_BE task (with
> buffered I/O) was getting.
>        - RT task with direct I/O: ionice -c1 -n2 /bin/dd if=3D/dev/zero
> of=3D/n/ssd1/ddtestRT bs=3D2M oflag=3Ddirect
>        - BE task                       : /bin/dd if=3D/dev/zero
> of=3D/n/ssd1/ddtestRT bs=3D2M
>=20
>    Please let me know if you want me to test more Paolo.
>    Will look forward to hearing from you.
>=20

Ok, doubt confirmed: bfq didn't check properly whether mixed-class
processes were doing I/O.  I've attached a tentative fix as a
compressed file (to prevent my client from corrupting it).  You can
also find the same diffs pasted below, if you want to have a look and
comment.

The patch should apply cleanly on top of current master.

Let me know if it works.

In particular, consider the following two facts about your RT process
(i.e., your process with RT I/O-priority class):
1) When served in parallel with other I/O, your RT process cannot
however reach a higher throughput than it reaches when served alone!
I'm making this silly remark because you may get confused by the fact
that modern, parallel drives usually reach a higher and higher
throughput as the number of processes doing I/O grows.
2) If your RT process does I/O greedily, then it will monopolize the
drive after this patch (if this patch works :) ).  This implies that,
even if you have many processes doing I/O in parallel with your RT
process, your drive will serve almost only your RT process while the
latter is active.  Therefore parallelism may be reduced, and the total
throughput of the drive may be lower than that reached without I/O
control (I'm working on reducing this loss too, but it is really a
non-trivial task).

Here are the changes.

 block/bfq-iosched.c | 86 =
++++++++++++++++++++++++++++-------------------------
 block/bfq-iosched.h |  8 +++--
 block/bfq-wf2q.c    | 12 ++++++--
 3 files changed, 59 insertions(+), 47 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 97337214bec4..d8d7a32ce64b 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -623,26 +623,6 @@ void bfq_pos_tree_add_move(struct bfq_data *bfqd, =
struct bfq_queue *bfqq)
 		bfqq->pos_root =3D NULL;
 }
=20
-/*
- * Tell whether there are active queues with different weights or
- * active groups.
- */
-static bool bfq_varied_queue_weights_or_active_groups(struct bfq_data =
*bfqd)
-{
-	/*
-	 * For queue weights to differ, queue_weights_tree must contain
-	 * at least two nodes.
-	 */
-	return (!RB_EMPTY_ROOT(&bfqd->queue_weights_tree) &&
-		(bfqd->queue_weights_tree.rb_node->rb_left ||
-		 bfqd->queue_weights_tree.rb_node->rb_right)
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-	       ) ||
-		(bfqd->num_groups_with_pending_reqs > 0
-#endif
-	       );
-}
-
 /*
  * The following function returns true if every queue must receive the
  * same share of the throughput (this condition is used when deciding
@@ -651,25 +631,48 @@ static bool =
bfq_varied_queue_weights_or_active_groups(struct bfq_data *bfqd)
  *
  * Such a scenario occurs when:
  * 1) all active queues have the same weight,
- * 2) all active groups at the same level in the groups tree have the =
same
- *    weight,
+ * 2) all active queues belong to the same I/O-priority class,
  * 3) all active groups at the same level in the groups tree have the =
same
+ *    weight,
+ * 4) all active groups at the same level in the groups tree have the =
same
  *    number of children.
  *
  * Unfortunately, keeping the necessary state for evaluating exactly
  * the last two symmetry sub-conditions above would be quite complex
- * and time consuming.  Therefore this function evaluates, instead,
- * only the following stronger two sub-conditions, for which it is
+ * and time consuming. Therefore this function evaluates, instead,
+ * only the following stronger three sub-conditions, for which it is
  * much easier to maintain the needed state:
  * 1) all active queues have the same weight,
- * 2) there are no active groups.
+ * 2) all active queues belong to the same I/O-priority class,
+ * 3) there are no active groups.
  * In particular, the last condition is always true if hierarchical
  * support or the cgroups interface are not enabled, thus no state
  * needs to be maintained in this case.
  */
 static bool bfq_symmetric_scenario(struct bfq_data *bfqd)
 {
-	return !bfq_varied_queue_weights_or_active_groups(bfqd);
+	/*
+	 * For queue weights to differ, queue_weights_tree must contain
+	 * at least two nodes.
+	 */
+	bool varied_queue_weights =3D =
!RB_EMPTY_ROOT(&bfqd->queue_weights_tree) &&
+		(bfqd->queue_weights_tree.rb_node->rb_left ||
+		 bfqd->queue_weights_tree.rb_node->rb_right);
+
+	bool multiple_classes_busy =3D
+		(bfqd->busy_queues[0] & bfqd->busy_queues[1]) |
+		(bfqd->busy_queues[0] & bfqd->busy_queues[2]) |
+		(bfqd->busy_queues[1] & bfqd->busy_queues[2]);
+
+	/*
+	 * For queue weights to differ, queue_weights_tree must contain
+	 * at least two nodes.
+	 */
+	return !(varied_queue_weights || multiple_classes_busy
+#ifdef BFQ_GROUP_IOSCHED_ENABLED
+	       || bfqd->num_groups_with_pending_reqs > 0
+#endif
+		);
 }
=20
 /*
@@ -728,15 +731,14 @@ void bfq_weights_tree_add(struct bfq_data *bfqd, =
struct bfq_queue *bfqq,
 	/*
 	 * In the unlucky event of an allocation failure, we just
 	 * exit. This will cause the weight of queue to not be
-	 * considered in bfq_varied_queue_weights_or_active_groups,
-	 * which, in its turn, causes the scenario to be deemed
-	 * wrongly symmetric in case bfqq's weight would have been
-	 * the only weight making the scenario asymmetric.  On the
-	 * bright side, no unbalance will however occur when bfqq
-	 * becomes inactive again (the invocation of this function
-	 * is triggered by an activation of queue).  In fact,
-	 * bfq_weights_tree_remove does nothing if
-	 * !bfqq->weight_counter.
+	 * considered in bfq_symmetric_scenario, which, in its turn,
+	 * causes the scenario to be deemed wrongly symmetric in case
+	 * bfqq's weight would have been the only weight making the
+	 * scenario asymmetric.  On the bright side, no unbalance will
+	 * however occur when bfqq becomes inactive again (the
+	 * invocation of this function is triggered by an activation
+	 * of queue).  In fact, bfq_weights_tree_remove does nothing
+	 * if !bfqq->weight_counter.
 	 */
 	if (unlikely(!bfqq->weight_counter))
 		return;
@@ -2217,7 +2219,7 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct =
bfq_queue *bfqq,
 		return NULL;
=20
 	/* If there is only one backlogged queue, don't search. */
-	if (bfqd->busy_queues =3D=3D 1)
+	if (bfq_tot_busy_queues(bfqd) =3D=3D 1)
 		return NULL;
=20
 	in_service_bfqq =3D bfqd->in_service_queue;
@@ -3655,7 +3657,8 @@ static bool bfq_better_to_idle(struct bfq_queue =
*bfqq)
 	 * the requests already queued in the device have been served.
 	 */
 	asymmetric_scenario =3D (bfqq->wr_coeff > 1 &&
-			       bfqd->wr_busy_queues < bfqd->busy_queues) =
||
+			       bfqd->wr_busy_queues <
+			       bfq_tot_busy_queues(bfqd)) ||
 		!bfq_symmetric_scenario(bfqd);
=20
 	/*
@@ -3934,7 +3937,7 @@ static struct request =
*bfq_dispatch_rq_from_bfqq(struct bfq_data *bfqd,
 	 * belongs to CLASS_IDLE and other queues are waiting for
 	 * service.
 	 */
-	if (!(bfqd->busy_queues > 1 && bfq_class_idle(bfqq)))
+	if (!(bfq_tot_busy_queues(bfqd) > 1 && bfq_class_idle(bfqq)))
 		goto return_rq;
=20
 	bfq_bfqq_expire(bfqd, bfqq, false, BFQQE_BUDGET_EXHAUSTED);
@@ -3952,7 +3955,7 @@ static bool bfq_has_work(struct blk_mq_hw_ctx =
*hctx)
 	 * most a call to dispatch for nothing
 	 */
 	return !list_empty_careful(&bfqd->dispatch) ||
-		bfqd->busy_queues > 0;
+		bfq_tot_busy_queues(bfqd) > 0;
 }
=20
 static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx =
*hctx)
@@ -4006,9 +4009,10 @@ static struct request =
*__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 		goto start_rq;
 	}
=20
-	bfq_log(bfqd, "dispatch requests: %d busy queues", =
bfqd->busy_queues);
+	bfq_log(bfqd, "dispatch requests: %d busy queues",
+		bfq_tot_busy_queues(bfqd));
=20
-	if (bfqd->busy_queues =3D=3D 0)
+	if (bfq_tot_busy_queues(bfqd) =3D=3D 0)
 		goto exit;
=20
 	/*
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 0b02bf302de0..30be669be465 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -501,10 +501,11 @@ struct bfq_data {
 	unsigned int num_groups_with_pending_reqs;
=20
 	/*
-	 * Number of bfq_queues containing requests (including the
-	 * queue in service, even if it is idling).
+	 * Per-class (RT, BE, IDLE) number of bfq_queues containing
+	 * requests (including the queue in service, even if it is
+	 * idling).
 	 */
-	int busy_queues;
+	unsigned int busy_queues[3];
 	/* number of weight-raised busy @bfq_queues */
 	int wr_busy_queues;
 	/* number of queued requests */
@@ -974,6 +975,7 @@ extern struct blkcg_policy blkcg_policy_bfq;
=20
 struct bfq_group *bfq_bfqq_to_bfqg(struct bfq_queue *bfqq);
 struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity);
+unsigned int bfq_tot_busy_queues(struct bfq_data *bfqd);
 struct bfq_service_tree *bfq_entity_service_tree(struct bfq_entity =
*entity);
 struct bfq_entity *bfq_entity_of(struct rb_node *node);
 unsigned short bfq_ioprio_to_weight(int ioprio);
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 63e0f12be7c9..7119207cae3c 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -44,6 +44,12 @@ static unsigned int bfq_class_idx(struct bfq_entity =
*entity)
 		BFQ_DEFAULT_GRP_CLASS - 1;
 }
=20
+unsigned int bfq_tot_busy_queues(struct bfq_data *bfqd)
+{
+	return bfqd->busy_queues[0] + bfqd->busy_queues[1] +
+		bfqd->busy_queues[2];
+}
+
 static struct bfq_entity *bfq_lookup_next_entity(struct bfq_sched_data =
*sd,
 						 bool expiration);
=20
@@ -1514,7 +1520,7 @@ struct bfq_queue *bfq_get_next_queue(struct =
bfq_data *bfqd)
 	struct bfq_sched_data *sd;
 	struct bfq_queue *bfqq;
=20
-	if (bfqd->busy_queues =3D=3D 0)
+	if (bfq_tot_busy_queues(bfqd) =3D=3D 0)
 		return NULL;
=20
 	/*
@@ -1666,7 +1672,7 @@ void bfq_del_bfqq_busy(struct bfq_data *bfqd, =
struct bfq_queue *bfqq,
=20
 	bfq_clear_bfqq_busy(bfqq);
=20
-	bfqd->busy_queues--;
+	bfqd->busy_queues[bfqq->ioprio_class - 1]--;
=20
 	if (!bfqq->dispatched)
 		bfq_weights_tree_remove(bfqd, bfqq);
@@ -1689,7 +1695,7 @@ void bfq_add_bfqq_busy(struct bfq_data *bfqd, =
struct bfq_queue *bfqq)
 	bfq_activate_bfqq(bfqd, bfqq);
=20
 	bfq_mark_bfqq_busy(bfqq);
-	bfqd->busy_queues++;
+	bfqd->busy_queues[bfqq->ioprio_class - 1]++;
=20
 	if (!bfqq->dispatched)
 		if (bfqq->wr_coeff =3D=3D 1)

Thanks,
Paolo


--Apple-Mail=_B52409CE-065A-4B14-AC0A-36522C86359B
Content-Disposition: attachment;
	filename*0=0001-consider-also-ioprio-classes-for-symmetry-detection.patch.g;
	filename*1=z
Content-Type: application/x-gzip;
	x-unix-mode=0644;
	name="0001-consider-also-ioprio-classes-for-symmetry-detection.patch.gz"
Content-Transfer-Encoding: base64

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
p46/yE5Gt+MMO45h/A+W39vKHiMAAA==
--Apple-Mail=_B52409CE-065A-4B14-AC0A-36522C86359B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Thanks,
> Madhav.
>=20
>=20
> On Fri, Dec 14, 2018 at 12:20 PM Paolo Valente =
<paolo.valente@linaro.org> wrote:
>>=20
>>=20
>>=20
>>> Il giorno 14 dic 2018, alle ore 14:55, Madhav Ancha =
<mancha@tower-research.com> ha scritto:
>>>=20
>>> Hi Paolo,
>>>=20
>>>   Thanks a lot for your work and your response to this email.
>>>=20
>>=20
>> Thank you for trying bfq!
>>=20
>>>   Following your advise, I switched my real time application to =
direct I/O.
>>>   We now have
>>>=20
>>>   Task1: Using ionice -c1, we run a RT IO/ O_DIRECT task that writes
>>> to flood the NVME drive to its capacity.
>>>   Task2: We run a normal (best-effort) IO/ asyn(page-cache buffered)
>>> task that writes to flood the NVME drive to its capacity.
>>>=20
>>>   What we now see is that Task2 still ends up getting about 3/5th or
>>> more of the NVMe bandwidth and Task1 ends up getting the rest of the
>>> NVMe disk bandwidth. Could the kernel threads/buffering be
>>> overpowering the RT priority of Task1?
>>>=20
>>>   What we desire is to loosely ensure that Task1 gets as much
>>> bandwidth as it asks for in any iteration while Task2 and the
>>> remaining tasks share the leftover bandwidth.
>>>=20
>>>   We are currently testing with these settings in BFQ.
>>>   low_latency =3D 0 (to control the bandwidth allocation)
>>=20
>> This may be a good idea.  But, after we sort this out, you could try
>> leaving low_latency enabled.  It should cause no harm (I'm trying to
>> make bfq smarter and smarter).
>>=20
>>=20
>>>   slice_idle =3D 0     (we are using a fast NVMe and if Task1 does =
not
>>> have any requests and control goes to Task2, it seems to make sense =
we
>>> get the control back to Task1 quickly)
>>=20
>> Unfortunately, this is not correct.  Setting slice_idle to 0 means
>> losing completely control on I/O.  And in you case you need ...
>> control :)
>>=20
>> So, you'd better leave slice_idle as it is.
>>=20
>> The actual problem is that, while thinking on whether it was
>> reasonable to set slice_idle =3D=3D 0, I realized that bfq is likely =
to fail
>> even with slice_idle > 0.  In fact, I have not checked the respect of
>> RT priority for probably a few years.  And I have changed lots of
>> critical operations in these years.
>>=20
>> So, I'll wait for your feedback, which I do expect to be negative.
>> Then, if it is actually negative, I'll work on the bug behind the
>> failure.
>>=20
>>>   timeout_sync =3D 1 (Task1 does application level buffering and =
sends
>>> the biggest chunk of data available (in high MB's) always)
>>>=20
>>=20
>> Also for this one, things should go well even without touching it.
>> But we will find out after discovering whether bfq is broken for your
>> use case.
>>=20
>> Looking forward to your feedback,
>> Paolo
>>=20
>>>   We are unable to make the leap to cpugroups at this time Paolo. Is
>>> there anything we can tune in BFQ or change the way we generate
>>> traffic in Task1 to ensure that Task1 gets the bandwidth it asks =
for?
>>>=20
>>>   A rough approximation to the Task1 and Task2 traffic we discussed
>>> above seem to be these instantiations of dd.
>>>   Task1: ionice -c1 -n2 /bin/dd if=3D/dev/zero of=3D/n/ssd1/ddtestRT1
>>> bs=3D2M oflag=3Ddirect
>>>   Task2: /bin/dd if=3D/dev/zero of=3D/n/ssd1/ddtestRT2   bs=3D2M
>>>=20
>>> Thanks again Paolo,
>>> Madhav.
>>>=20
>>>=20
>>>=20
>>> On Fri, Dec 14, 2018 at 1:38 AM Paolo Valente =
<paolo.valente@linaro.org> wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> Il giorno 13 dic 2018, alle ore 21:34, Madhav Ancha =
<mancha@tower-research.com> ha scritto:
>>>>>=20
>>>>> In our setup, we have a task that writes to a NVMe SSD drive using =
the
>>>>> page cache. (using ::write os calls). This task does application =
level
>>>>> buffering and sends big (large MBs) chunks of data to ::write =
call.
>>>>> Each instance of the task writes upto 10Gbps of data to the NVME =
SSD.
>>>>>=20
>>>>> We run two instances of this task as below.
>>>>> Instance 1: Using ionice -c1, we run a RT IO instance of this =
task.
>>>>> Instance 2: We run a normal (best-effort) IO instance of this =
task.
>>>>>=20
>>>>> Both the write task instances compete for NVMe bandwidth. We =
observe
>>>>> that BFQ allocates equal bandwidth to both the task instances =
starting
>>>>> a few seconds after they start up.
>>>>>=20
>>>>> What we expected is that Instance1 (IOPRIO_CLASS_RT scheduling =
class)
>>>>> will be granted all the bandwidth it asked for while Instance2 =
will be
>>>>> allowed to consume the remaining bandwidth.
>>>>>=20
>>>>> Could you please help us understand how we may be able to design =
to
>>>>> get our expected behavior.
>>>>>=20
>>>>=20
>>>> Hi,
>>>> if you do async, in-memory writes, then your task instances just =
dirty
>>>> vm pages.  Then different processes, the kworkers, will do the
>>>> writeback of dirty pages asynchronously, according to the system
>>>> writeback logic and configuration.  kworkers have their own =
priority,
>>>> which is likely to be the same for each such process.  AFAICT this
>>>> priority is not related to the priority you give to your processes.
>>>>=20
>>>> If you want to control I/O bandwidths for writes, go for direct I/O =
or
>>>> use cgroups.  In case of cgroups, consider that there is still the
>>>> oddity that bfq interface parameters are non standard.  We have
>>>> proposed and are pushing for a solution to this problem [1].
>>>>=20
>>>> Thanks,
>>>> Paolo
>>>>=20
>>>> [1] https://lkml.org/lkml/2018/11/19/366
>>>>=20
>>>>> Thanks
>>>>=20
>>=20


--Apple-Mail=_B52409CE-065A-4B14-AC0A-36522C86359B--
