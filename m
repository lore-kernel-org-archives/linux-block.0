Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC674C11F65
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 13:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FDAA6144C
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 13:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbhF3NtL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 09:49:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:21064 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234982AbhF3NtG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 09:49:06 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15UDgO9n003226;
        Wed, 30 Jun 2021 13:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=gD3vG3yht6aVXK1oFedmgep2Wcb6/NMGQWJkyX80738=;
 b=TjpkPxXloMhXeVwxD2+mQ7cAbFlXsKceV2wfMYbT6TKsiG9z/ovakRubdggHV69UouqA
 eWwzZ8LpMg9zmefI91fMr3V/JoAMyHbMoIzm4kyNt+QR0exMlaAx7P7BYsdDI5nueZCE
 TVIMMdjtJIa/vtYuJN7ZNx5JxrWDEbE2x697X0mp2y8t0YNad5bVmLFS4T8TOYd2drn/
 3CkHhm2YtCiVlQnEeTLksyzjnbPwlJyg0Tddea1qQLhrJtt9Un391PzYgIvNq6grXp1A
 IhZyB4YVgXhKaRbPY9bUwAnPbTTiufUlsYI2j/dnclNRpg6VGhIzs0WccZOqCOWyj+gC pw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39gb2t1g9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 13:46:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15UDdvOW049140;
        Wed, 30 Jun 2021 13:46:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 39dv280een-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 13:46:34 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15UDkX0k075415;
        Wed, 30 Jun 2021 13:46:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 39dv280edp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 13:46:33 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15UDkTnh005188;
        Wed, 30 Jun 2021 13:46:31 GMT
Received: from mwanda (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Jun 2021 13:46:29 +0000
Date:   Wed, 30 Jun 2021 16:46:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, He Zhe <zhe.he@windriver.com>
Subject: [bug report] aoe: convert aoeblk to blk-mq
Message-ID: <YNx1r8Jr3+t4bch/@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-GUID: gmz_hHCZqwBaKYR04sYmPA04wXCwf7-Y
X-Proofpoint-ORIG-GUID: gmz_hHCZqwBaKYR04sYmPA04wXCwf7-Y
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Jens Axboe,

The patch 3582dd291788: "aoe: convert aoeblk to blk-mq" from Oct 12,
2018, leads to the following static checker warning:

	block/blk-mq.c:151 blk_mq_freeze_queue_wait()
	warn: sleeping in atomic context

The problem is that aoedev_downdev() can sleep now.

There are two callers of aoedev_downdev() and originally they were both
called under spinlock.  One was fixed in commit 430380b4637a
("block: aoe: Fix kernel crash due to atomic sleep when exiting") but
the other is still buggy.

drivers/block/aoe/aoecmd.c
   726  static void
   727  rexmit_timer(struct timer_list *timer)
   728  {
   729          struct aoedev *d;
   730          struct aoetgt *t;
   731          struct aoeif *ifp;
   732          struct frame *f;
   733          struct list_head *head, *pos, *nx;
   734          LIST_HEAD(flist);
   735          register long timeout;
   736          ulong flags, n;
   737          int i;
   738          int utgts;      /* number of aoetgt descriptors (not slots) */
   739          int since;
   740  
   741          d = from_timer(d, timer, timer);
   742  
   743          spin_lock_irqsave(&d->lock, flags);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
spin lock held.

   744  
   745          /* timeout based on observed timings and variations */
   746          timeout = rto(d);
   747  
   748          utgts = count_targets(d, NULL);
   749  
   750          if (d->flags & DEVFL_TKILL) {
   751                  spin_unlock_irqrestore(&d->lock, flags);
   752                  return;
   753          }
   754  
   755          /* collect all frames to rexmit into flist */
   756          for (i = 0; i < NFACTIVE; i++) {
   757                  head = &d->factive[i];
   758                  list_for_each_safe(pos, nx, head) {
   759                          f = list_entry(pos, struct frame, head);
   760                          if (tsince_hr(f) < timeout)
   761                                  break;  /* end of expired frames */
   762                          /* move to flist for later processing */
   763                          list_move_tail(pos, &flist);
   764                  }
   765          }
   766  
   767          /* process expired frames */
   768          while (!list_empty(&flist)) {
   769                  pos = flist.next;
   770                  f = list_entry(pos, struct frame, head);
   771                  since = tsince_hr(f);
   772                  n = f->waited_total + since;
   773                  n /= USEC_PER_SEC;
   774                  if (aoe_deadsecs
   775                  && n > aoe_deadsecs
   776                  && !(f->flags & FFL_PROBE)) {
   777                          /* Waited too long.  Device failure.
   778                           * Hang all frames on first hash bucket for downdev
   779                           * to clean up.
   780                           */
   781                          list_splice(&flist, &d->factive[0]);
   782                          aoedev_downdev(d);
                                ^^^^^^^^^^^^^^^^^
Sleeps in atomic if we call blk_mq_freeze_queue().

   783                          goto out;
   784                  }
   785  
   786                  t = f->t;
   787                  n = f->waited + since;
   788                  n /= USEC_PER_SEC;
   789                  if (aoe_deadsecs && utgts > 0
   790                  && (n > aoe_deadsecs / utgts || n > HARD_SCORN_SECS))
   791                          scorn(t); /* avoid this target */
   792

regards,
dan carpenter
