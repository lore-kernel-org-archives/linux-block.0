Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A86C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 18:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70273218A5
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 18:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iJHrEcZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbeLRSp4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:45:56 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39144 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeLRSp4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 13:45:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id f81so3854147wmd.4
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 10:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=r0M8MYbxwP5RRobqixMdqljE/Mo1diekoS/XWFdunZ4=;
        b=iJHrEcZ7WdnjAnQuifYSL3m9aQ/3TKYYiQ3DG5xw+UEYenVNDxR0+R+/w3H7mdYooR
         TFCho0luTyGnLl2/P+lCqXjbWou6672pm21192fLVMhx0p/XSuGDeOoR5Gqx0E+EswCN
         S2gpupUms65UNtR3nFbkaay5OnC9scPR2lnlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=r0M8MYbxwP5RRobqixMdqljE/Mo1diekoS/XWFdunZ4=;
        b=EgeZlBEtFLgibcgpAHRNs5WyAAJMfE2IN9gyYmT5Z/SEhmX3NlIA9g5RQir4cqc/+p
         dKFyIiWQ/C1xbOZXK2kUgNUnzaTfvEmfap6H2U0ebwH7KSmOwHA3q+Q8V5Z94pMTGxUc
         Qi0vxn+KI2tQANbkDk2RWeNQ3JWWtK90BmDa2A/8adtvcEoRyB3nAr+Q36gTgMRpgF1L
         BlvHzDaT1PBcfdJY2tYijhfs7G7l1n7FP0+ZDj4mrlbNbstakrkqhWzM5ZEBP1Wb/aeI
         h0Ld12Y2ThCfIr81eVV6Ldm/+vgHj+DpyalcF21dBWBwkOAWYBUPdFYh3OEcS+PcQTth
         L1KA==
X-Gm-Message-State: AA+aEWbH/sOFtEqh55iyEXMi0WjFmZADa5/VyKNyISLKi3gEihZlIwU5
        b3/+S5+qg5xBWYg0jsSiWo7lrw==
X-Google-Smtp-Source: AFSGD/UhncPvceZMYLaXMIkYIR3XpmKj99tg7LG5sxnF/xYF3T08RClUDzqH9d5OONLSdyQ/kJLcZA==
X-Received: by 2002:a1c:60c3:: with SMTP id u186mr4622525wmb.66.1545158752126;
        Tue, 18 Dec 2018 10:45:52 -0800 (PST)
Received: from [192.168.0.100] ([84.33.66.6])
        by smtp.gmail.com with ESMTPSA id l6sm4747918wrv.70.2018.12.18.10.45.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 10:45:51 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <0260C4E7-0D1A-45D6-BB22-DA4D94A28831@linaro.org>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_78D1884B-2EB3-496E-8D21-64EFCF4440C6"
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: Unintuitive scheduling results using BFQ
Date:   Tue, 18 Dec 2018 19:45:49 +0100
In-Reply-To: <1589bb87-487a-4394-cbbc-6d25a21771fa@kernel.dk>
Cc:     Madhav Ancha <mancha@tower-research.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
References: <CA+XCsb-0M8PXB30zd22c_nmww5OvMs4mKEcsFahMR7jV+9+01g@mail.gmail.com>
 <8FCED0AE-6BE7-42EE-92ED-58E2B622A165@linaro.org>
 <CA+XCsb-0vY+x1+jSSRYcLdYz+U_T77QefQVWEoikSS5bfevjpg@mail.gmail.com>
 <C8B5F877-6F4B-46AD-9AC9-BAE91C754A5F@linaro.org>
 <CA+XCsb8eiq7w-W5ecPNdnqvrv1dU4Vkq=HfKCG=MoQi_CekPBg@mail.gmail.com>
 <255AD47C-65DD-4F22-9E64-8DF9DD81B83B@linaro.org>
 <eb245572-a504-37d6-dd15-d1b502816940@kernel.dk>
 <0CEF3DD1-E360-4366-A756-78274F306AE4@linaro.org>
 <1589bb87-487a-4394-cbbc-6d25a21771fa@kernel.dk>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_78D1884B-2EB3-496E-8D21-64EFCF4440C6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 18 dic 2018, alle ore 19:21, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 12/18/18 11:19 AM, Paolo Valente wrote:
>>=20
>>=20
>>> Il giorno 18 dic 2018, alle ore 19:08, Jens Axboe <axboe@kernel.dk> =
ha scritto:
>>>=20
>>> On 12/18/18 11:04 AM, Paolo Valente wrote:
>>>> static bool bfq_symmetric_scenario(struct bfq_data *bfqd)
>>>> {
>>>> -	return !bfq_varied_queue_weights_or_active_groups(bfqd);
>>>> +	/*
>>>> +	 * For queue weights to differ, queue_weights_tree must contain
>>>> +	 * at least two nodes.
>>>> +	 */
>>>> +	bool varied_queue_weights =3D =
!RB_EMPTY_ROOT(&bfqd->queue_weights_tree) &&
>>>> +		(bfqd->queue_weights_tree.rb_node->rb_left ||
>>>> +		 bfqd->queue_weights_tree.rb_node->rb_right);
>>>> +
>>>> +	bool multiple_classes_busy =3D
>>>> +		(bfqd->busy_queues[0] & bfqd->busy_queues[1]) |
>>>> +		(bfqd->busy_queues[0] & bfqd->busy_queues[2]) |
>>>> +		(bfqd->busy_queues[1] & bfqd->busy_queues[2]);
>>>=20
>>> I don't think this does what you want it to, looks like these should =
be
>>> logical AND and OR.
>>>=20
>>=20
>> Absolutely, sorry. Fortunately, the end result is still correct :)
>=20
> Is it? What if ->busy_queues[0] is 1 and ->busy_queues[1] is 2. You'd
> expect the first comparison to be true, but it'd be false. Ditto for
> the rest of them, of course.
>=20

S..t. Thank you.

New patch attached, and diffs pasted again.  Madhav, you might not see
any difference for your use case, but better if you use the new patch.

 block/bfq-iosched.c | 86 =
++++++++++++++++++++++++++++-------------------------
 block/bfq-iosched.h |  8 +++--
 block/bfq-wf2q.c    | 12 ++++++--
 3 files changed, 59 insertions(+), 47 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 97337214bec4..6c67b038ede5 100644
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
+		(bfqd->busy_queues[0] && bfqd->busy_queues[1]) ||
+		(bfqd->busy_queues[0] && bfqd->busy_queues[2]) ||
+		(bfqd->busy_queues[1] && bfqd->busy_queues[2]);
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


--Apple-Mail=_78D1884B-2EB3-496E-8D21-64EFCF4440C6
Content-Disposition: attachment;
	filename*0=0001-consider-also-ioprio-classes-for-symmetry-detection.patch.g;
	filename*1=z
Content-Type: application/x-gzip;
	x-unix-mode=0644;
	name="0001-consider-also-ioprio-classes-for-symmetry-detection.patch.gz"
Content-Transfer-Encoding: base64

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
v8hORq/rDruuYfwPhjg95iMjAAA=
--Apple-Mail=_78D1884B-2EB3-496E-8D21-64EFCF4440C6
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii




--Apple-Mail=_78D1884B-2EB3-496E-8D21-64EFCF4440C6--
