Return-Path: <SRS0=ECsc=UF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1314EC04AB5
	for <linux-block@archiver.kernel.org>; Thu,  6 Jun 2019 14:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D940520684
	for <linux-block@archiver.kernel.org>; Thu,  6 Jun 2019 14:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfFFOrY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:47:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52980 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727309AbfFFOrY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Jun 2019 10:47:24 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56EYDGK026482
        for <linux-block@vger.kernel.org>; Thu, 6 Jun 2019 10:47:22 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sy3b4wu9d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 06 Jun 2019 10:47:22 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <bblock@linux.ibm.com>;
        Thu, 6 Jun 2019 15:47:19 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Jun 2019 15:47:16 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x56ElEnA36831304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Jun 2019 14:47:15 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C350FA4062;
        Thu,  6 Jun 2019 14:47:14 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0D16A405B;
        Thu,  6 Jun 2019 14:47:14 +0000 (GMT)
Received: from t480-pf1aa2c2 (unknown [9.152.212.151])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  6 Jun 2019 14:47:14 +0000 (GMT)
Received: from bblock by t480-pf1aa2c2 with local (Exim 4.92)
        (envelope-from <bblock@linux.ibm.com>)
        id 1hYtfe-00051W-De; Thu, 06 Jun 2019 16:47:14 +0200
Date:   Thu, 6 Jun 2019 16:47:14 +0200
From:   Benjamin Block <bblock@linux.ibm.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        kernel test robot <rong.a.chen@intel.com>,
        Jens Remus <jremus@linux.ibm.com>
Subject: Re: [PATCH] block: free sched's request pool in blk_cleanup_queue
References: <20190604130802.17076-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190604130802.17076-1-ming.lei@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-TM-AS-GCONF: 00
x-cbid: 19060614-0012-0000-0000-00000325A6D3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060614-0013-0000-0000-0000215E8EFA
Message-Id: <20190606144714.GA6549@t480-pf1aa2c2>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906060102
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 04, 2019 at 09:08:02PM +0800, Ming Lei wrote:
> In theory, IO scheduler belongs to request queue, and the request pool
> of sched tags belongs to the request queue too.
> 
> However, the current tags allocation interfaces are re-used for both
> driver tags and sched tags, and driver tags is definitely host wide,
> and doesn't belong to any request queue, same with its request pool.
> So we need tagset instance for freeing request of sched tags.
> 
> Meantime, blk_mq_free_tag_set() often follows blk_cleanup_queue() in case
> of non-BLK_MQ_F_TAG_SHARED, this way requires that request pool of sched
> tags to be freed before calling blk_mq_free_tag_set().
> 
> Commit 47cdee29ef9d94e ("block: move blk_exit_queue into __blk_release_queue")
> moves blk_exit_queue into __blk_release_queue for simplying the fast
> path in generic_make_request(), then causes oops during freeing requests
> of sched tags in __blk_release_queue().
> 
> Fix the above issue by move freeing request pool of sched tags into
> blk_cleanup_queue(), this way is safe becasue queue has been frozen and no any
> in-queue requests at that time. Freeing sched tags has to be kept in queue's
> release handler becasue there might be un-completed dispatch activity
> which might refer to sched tags.
> 
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Fixes: 47cdee29ef9d94e485eb08f962c74943023a5271 ("block: move blk_exit_queue into __blk_release_queue")
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Our CI meanwhile also crashes regularly because of this:

  run blktests block/002 at 2019-06-06 14:44:55
  Unable to handle kernel pointer dereference in virtual kernel address space, Failing address: 6b6b6b6b6b6b6000 TEID: 6b6b6b6b6b6b6803
  Fault in home space mode while using kernel ASCE.
  AS:0000000057290007 R3:0000000000000024
  Oops: 0038 ilc:3 [#1] PREEMPT SMP
  Modules linked in: ...
  CPU: 4 PID: 139 Comm: kworker/4:2 Kdump: loaded Not tainted 5.2.0-rc3-master-05489-g55f909514069 #3
  Hardware name: IBM 3906 M03 703 (LPAR)
  Workqueue: events __blk_release_queue
  Krnl PSW : 0704e00180000000 000000005657db18 (blk_mq_free_rqs+0x48/0x128)
             R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
  Krnl GPRS: 00000000a8309db5 6b6b6b6b6b6b6b6b 000000008beb3858 00000000a2befbc8
             0000000000000000 0000000000000001 0000000056bb16c8 00000000b4070aa8
             000000008beb3858 000000008bc46b38 00000000a2befbc8 0000000000000000
             00000000bafb8100 00000000568e8040 000003e0092b3c30 000003e0092b3be0
  Krnl Code: 000000005657db0a: a7f4006e            brc     15,5657dbe6
             000000005657db0e: e31020380004       lg      %r1,56(%r2)
            #000000005657db14: b9040082           lgr     %r8,%r2
            >000000005657db18: e31010500002       ltg     %r1,80(%r1)
             000000005657db1e: a784ffee           brc     8,5657dafa
             000000005657db22: e32030000012       lt      %r2,0(%r3)
             000000005657db28: a784ffe9           brc     8,5657dafa
             000000005657db2c: b9040074           lgr     %r7,%r4
  Call Trace:
  ([<000000008ff8ed00>] 0x8ff8ed00)
   [<0000000056582958>] blk_mq_sched_tags_teardown+0x68/0x98
   [<0000000056583396>] blk_mq_exit_sched+0xc6/0xd8
   [<0000000056569324>] elevator_exit+0x54/0x70
   [<0000000056570644>] __blk_release_queue+0x84/0x110
   [<0000000055f416c6>] process_one_work+0x3a6/0x6b8
   [<0000000055f41c50>] worker_thread+0x278/0x478
   [<0000000055f49e08>] kthread+0x160/0x178
   [<00000000568d83e8>] ret_from_fork+0x34/0x38
  INFO: lockdep is turned off.
  Last Breaking-Event-Address:
   [<000000005657daf6>] blk_mq_free_rqs+0x26/0x128
  Kernel panic - not syncing: Fatal exception: panic_on_oops
  run blktests block/003 at 2019-06-06 14:44:56

When I tried to reproduced this with this patch, it went away (at least all of
blktest/block ran w/o crash).

I don't feel competent enough to review this patch right now, but it would be
good if we get something upstream for this.

-- 
With Best Regards, Benjamin Block      /      Linux on IBM Z Kernel Development
IBM Systems & Technology Group   /  IBM Deutschland Research & Development GmbH
Vorsitz. AufsR.: Matthias Hartmann       /      Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: AmtsG Stuttgart, HRB 243294

