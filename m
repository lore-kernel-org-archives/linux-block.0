Return-Path: <SRS0=KbiG=A7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A295C433F1
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 12:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 090FF22B4D
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 12:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="WGDxLeap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgGTMTp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 08:19:45 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:55510 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728532AbgGTMTp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 08:19:45 -0400
Received: from iva8-d077482f1536.qloud-c.yandex.net (iva8-d077482f1536.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:2f26:0:640:d077:482f])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 0814C2E162A;
        Mon, 20 Jul 2020 15:19:40 +0300 (MSK)
Received: from iva8-88b7aa9dc799.qloud-c.yandex.net (iva8-88b7aa9dc799.qloud-c.yandex.net [2a02:6b8:c0c:77a0:0:640:88b7:aa9d])
        by iva8-d077482f1536.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id xJBw567LDK-Jat8OKM7;
        Mon, 20 Jul 2020 15:19:39 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1595247579; bh=n7ex4YljjUEmP9kvd56elLJcLM01f3QwSMI1g4OIT4s=;
        h=Message-ID:Subject:Date:References:To:From:In-Reply-To:Cc;
        b=WGDxLeap5zR3kpIWYajS3Av+8d+0dATpQ7gqmy5gWzVT8pfMIwRXcO9Wxtl73gtFD
         04CCV8EZCJAVDEPLUPwiIZun6emy5asS6ljlwrbYVXivyxeM0N1CIjfh+fF6ck5ZPm
         DFsiPLmzLgr+8L/jiSmKWvmiZgPQHI/OUEdi11VU=
Authentication-Results: iva8-d077482f1536.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 95.108.174.193-red.dhcp.yndx.net (95.108.174.193-red.dhcp.yndx.net [95.108.174.193])
        by iva8-88b7aa9dc799.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id UP5F2zyCql-JaiSViDa;
        Mon, 20 Jul 2020 15:19:36 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Monakhov <dmonakhov@gmail.com>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        axboe@kernel.dk
Subject: Re: [PATCH] bfq: fix blkio cgroup leakage
In-Reply-To: <22087F19-BC93-447E-848A-109392E0622D@linaro.org>
References: <20200702105751.20482-1-dmonakhov@gmail.com> <429E50C6-83BA-4A3F-BE9C-06C7C762AF33@linaro.org> <87k0zdrj7s.fsf@dmws.yandex.net> <545F1ABF-B2B2-4523-9259-D3F93A9BB330@linaro.org> <87h7uhqewn.fsf@dmws.yandex.net> <22087F19-BC93-447E-848A-109392E0622D@linaro.org>
Date:   Mon, 20 Jul 2020 15:19:36 +0300
Message-ID: <87tuy2ml9j.fsf@dmws.yandex.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--=-=-=
Content-Type: text/plain

Paolo Valente <paolo.valente@linaro.org> writes:

>> Il giorno 9 lug 2020, alle ore 10:19, Dmitry Monakhov <dmonakhov@gmail.com> ha scritto:
>> 
>> Paolo Valente <paolo.valente@linaro.org> writes:
>> 
>>>> Il giorno 8 lug 2020, alle ore 19:48, Dmitry Monakhov <dmonakhov@gmail.com> ha scritto:
>>>> 
>>>> Paolo Valente <paolo.valente@linaro.org> writes:
>>>> 
>>>>> Hi,
>>>>> sorry for the delay.  The commit you propose to drop fix the issues
>>>>> reported in [1].
>>>>> 
>>>>> Such a commit does introduce the leak that you report (thank you for
>>>>> spotting it).  Yet, according to the threads mentioned in [1],
>>>>> dropping that commit would take us back to those issues.
>>>>> 
>>>>> Maybe the solution is to fix the unbalance that you spotted?
>>>> I'm not quite shure that do I understand which bug was addressed for commit db37a34c563b.
>>>> AFAIU both bugs mentioned in original patchset was fixed by:
>>>> 478de3380 ("block, bfq: deschedule empty bfq_queues not referred by any proces")
>>>> f718b0932 ( block, bfq: do not plug I/O for bfq_queues with no proc refs)"
>>>> 
>>>> So I review commit db37a34c563b as independent one.
>>>> It introduces extra reference for bfq_groups via bfqg_and_blkg_get(),
>>>> but do we actually need it here?
>>>> 
>>>> #IF CONFIG_BFQ_GROUP_IOSCHED is enabled:
>>>> bfqd->root_group is holded by bfqd from bfq_init_queue()
>>>> other bfq_queue objects are owned by corresponding blkcg from bfq_pd_alloc()
>>>> So bfq_queue can not disappear under us.
>>>> 
>>> 
>>> You are right, but incomplete.  No extra ref is needed for an entity
>>> that represents a bfq_queue.  And this consideration mistook me before
>>> I realized that that commit was needed.  The problem is that an entity
>>> may also represent a group of entities.  In that case no reference is
>>> taken through any bfq_queue.  The commit you want to remove takes this
>>> missing reference.
>> Sorry, It looks like I've mistyped sentance above, I ment to say bfq_group.
>> So here is my statement corrected:
>> #IF CONFIG_BFQ_GROUP_IOSCHED is enabled:
>> bfqd->root_group is holded by bfqd from bfq_init_queue()
>> other *bfq_group* objects are owned by corresponding blkcg, reference get from bfq_pd_alloc()
>> So *bfq_group* can not disappear under us.
>> 
>> So no extra reference is required for entity represents bfq_group. Commit is not required.
>
> No, the entity may remain alive and on some tree after bfq_pd_offline has been invoked.
Ok you right, we should drop the group reference inside __bfq_bfqd_reset_in_service() 
as we do for queue's entities. Please see updated patch version.

--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0001-block-bfq-fix-blkio-cgroup-leakage-v2.patch

From d708067cfa570f80b43c5716adf81d2a29b3d523 Mon Sep 17 00:00:00 2001
From: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Date: Mon, 20 Jul 2020 15:10:34 +0300
Subject: [PATCH] block: bfq fix blkio cgroup leakage v2

commit db37a34c563b ("block, bfq: get a ref to a group when adding it to a service tree")
introduce leak forbfq_group and blkcg_gq objects because of get/put
imbalance. See trace balow:
-> blkg_alloc
   -> bfq_pq_alloc
     -> bfqg_get (+1)
->bfq_activate_bfqq
  ->bfq_activate_requeue_entity
    -> __bfq_activate_entity
       ->bfq_get_entity
         ->bfqg_and_blkg_get (+1)  <==== : Note1
->bfq_del_bfqq_busy
  ->bfq_deactivate_entity+0x53/0xc0 [bfq]
    ->__bfq_deactivate_entity+0x1b8/0x210 [bfq]
      -> bfq_forget_entity(is_in_service = true)
	 entity->on_st_or_in_serv = false   <=== :Note2
	 if (is_in_service)
	     return;  ==> do not touch reference
-> blkcg_css_offline
 -> blkcg_destroy_blkgs
  -> blkg_destroy
   -> bfq_pd_offline
    -> __bfq_deactivate_entity
         if (!entity->on_st_or_in_serv) /* true, because (Note2)
		return false;
 -> bfq_pd_free
    -> bfqg_put() (-1, byt bfqg->ref == 2) because of (Note2)
So bfq_group and blkcg_gq  will leak forever, see test-case below.

We should drop group reference once it finaly removed from service
inside __bfq_bfqd_reset_in_service, as we do with queue entities.

##TESTCASE_BEGIN:
#!/bin/bash

max_iters=${1:-100}
#prep cgroup mounts
mount -t tmpfs cgroup_root /sys/fs/cgroup
mkdir /sys/fs/cgroup/blkio
mount -t cgroup -o blkio none /sys/fs/cgroup/blkio

# Prepare blkdev
grep blkio /proc/cgroups
truncate -s 1M img
losetup /dev/loop0 img
echo bfq > /sys/block/loop0/queue/scheduler

grep blkio /proc/cgroups
for ((i=0;i<max_iters;i++))
do
    mkdir -p /sys/fs/cgroup/blkio/a
    echo 0 > /sys/fs/cgroup/blkio/a/cgroup.procs
    dd if=/dev/loop0 bs=4k count=1 of=/dev/null iflag=direct 2> /dev/null
    echo 0 > /sys/fs/cgroup/blkio/cgroup.procs
    rmdir /sys/fs/cgroup/blkio/a
    grep blkio /proc/cgroups
done
##TESTCASE_END:

Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
---
 block/bfq-wf2q.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 8113138..93b236c 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -635,14 +635,10 @@ static void bfq_idle_insert(struct bfq_service_tree *st,
  * @entity: the entity being removed.
  * @is_in_service: true if entity is currently the in-service entity.
  *
- * Forget everything about @entity. In addition, if entity represents
- * a queue, and the latter is not in service, then release the service
- * reference to the queue (the one taken through bfq_get_entity). In
- * fact, in this case, there is really no more service reference to
- * the queue, as the latter is also outside any service tree. If,
- * instead, the queue is in service, then __bfq_bfqd_reset_in_service
- * will take care of putting the reference when the queue finally
- * stops being served.
+ * Forget everything about @entity. If entity is not in service, then release
+ * the service reference to the entity (the one taken through  bfq_get_entity).
+ * If the entity is in service, then __bfq_bfqd_reset_in_service will take care
+ * of putting the reference when the entity finally stops being served.
  */
 static void bfq_forget_entity(struct bfq_service_tree *st,
 			      struct bfq_entity *entity,
@@ -1626,9 +1622,16 @@ bool __bfq_bfqd_reset_in_service(struct bfq_data *bfqd)
 	 * execute the final step: reset in_service_entity along the
 	 * path from entity to the root.
 	 */
-	for_each_entity(entity)
+	for_each_entity(entity) {
 		entity->sched_data->in_service_entity = NULL;
-
+		/*
+		 * Release bfq_groups reference if it was not released in
+		 * bfq_forget_entity, which was taken in bfq_get_entity.
+		 */
+		if (!bfq_entity_to_bfqq(entity) && !entity->on_st_or_in_serv)
+			bfqg_and_blkg_put(container_of(entity, struct bfq_group,
+						       entity));
+	}
 	/*
 	 * in_serv_entity is no longer in service, so, if it is in no
 	 * service tree either, then release the service reference to
-- 
2.7.4


--=-=-=--
