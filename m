Return-Path: <SRS0=7L3l=R7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE39C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 01:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C33F206DF
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 01:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfC1Bbb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 21:31:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33018 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfC1Bbb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 21:31:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E88081E10;
        Thu, 28 Mar 2019 01:31:30 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BB6360924;
        Thu, 28 Mar 2019 01:31:22 +0000 (UTC)
Date:   Thu, 28 Mar 2019 09:31:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Laurence Oberman <loberman@redhat.com>
Cc:     Ming Lei <tom.leiming@gmail.com>, jianchao.w.wang@oracle.com,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: Panic when rebooting target server testing srp on 5.0.0-rc2
Message-ID: <20190328013116.GC19708@ming.t460p>
References: <7858e19ce3fc3ebf7845494a2209c58cd9e3086d.camel@redhat.com>
 <1553113730.65329.60.camel@acm.org>
 <3645c45e88523d4b242333d96adbb492ab100f97.camel@redhat.com>
 <d9febee1de759206bbf4d66f6570415ae64e4f33.camel@redhat.com>
 <8a6807100283a0c1256410f4f0381979b18398fe.camel@redhat.com>
 <CACVXFVOfZvnDo_ccVm1+cFRo_oSoiexgLfe_pyXp84v=0eQ7rQ@mail.gmail.com>
 <38a35a9c6a74371ebaea6cdf210184b8dee4dbeb.camel@redhat.com>
 <5d79ef69efecba45718c87110e8a37a37f973bea.camel@redhat.com>
 <74e767afc0e10054f87fc821fa15966449d3dd2a.camel@redhat.com>
 <d8c921e8df338e789b0a5bbe5e5e6944556ff2b8.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8c921e8df338e789b0a5bbe5e5e6944556ff2b8.camel@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 28 Mar 2019 01:31:30 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 27, 2019 at 07:34:37PM -0400, Laurence Oberman wrote:
> On Wed, 2019-03-27 at 18:00 -0400, Laurence Oberman wrote:
> > On Wed, 2019-03-27 at 08:56 -0400, Laurence Oberman wrote:
> > > Truncating email content, starting bisect again as suggested.
> > > Email was getting too long with repetition.
> > > 
> > > Crux of the issue repeated here so easy to understand topic
> > > 
> > > We got to dispatch passing rq_list and the list is corrupted/freed
> > > so
> > > we panic. Clearly a race and is in v5.x+ kernels.
> > > This new bisect will find it.
> > > 
> > > crash> bt
> > > PID: 9191   TASK: ffff9dea0a8395c0  CPU: 1   COMMAND:
> > > "kworker/1:1H"
> > >  #0 [ffffa9fe0759fab0] machine_kexec at ffffffff938606cf
> > >  #1 [ffffa9fe0759fb08] __crash_kexec at ffffffff9393a48d
> > >  #2 [ffffa9fe0759fbd0] crash_kexec at ffffffff9393b659
> > >  #3 [ffffa9fe0759fbe8] oops_end at ffffffff93831c41
> > >  #4 [ffffa9fe0759fc08] no_context at ffffffff9386ecb9
> > >  #5 [ffffa9fe0759fcb0] do_page_fault at ffffffff93870012
> > >  #6 [ffffa9fe0759fce0] page_fault at ffffffff942010ee
> > >     [exception RIP: blk_mq_dispatch_rq_list+114]
> > >     RIP: ffffffff93b9f202  RSP: ffffa9fe0759fd90  RFLAGS: 00010246
> > >     RAX: ffff9de9c4d3bbc8  RBX: ffff9de9c4d3bbc8  RCX:
> > > 0000000000000004
> > >     RDX: 0000000000000000  RSI: ffffa9fe0759fe20  RDI:
> > > ffff9dea0dad87f0
> > >     RBP: 0000000000000000   R8: 0000000000000000   R9:
> > > 8080808080808080
> > >     R10: ffff9dea33827660  R11: ffffee9d9e097a00  R12:
> > > ffffa9fe0759fe20
> > >     R13: ffff9de9c4d3bb80  R14: 0000000000000000  R15:
> > > ffff9dea0dad87f0
> > >     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> > >  #7 [ffffa9fe0759fe18] blk_mq_sched_dispatch_requests at
> > > ffffffff93ba455c
> > >  #8 [ffffa9fe0759fe60] __blk_mq_run_hw_queue at ffffffff93b9e3cf
> > >  #9 [ffffa9fe0759fe78] process_one_work at ffffffff938b0c21
> > > #10 [ffffa9fe0759feb8] worker_thread at ffffffff938b18d9
> > > #11 [ffffa9fe0759ff10] kthread at ffffffff938b6ee8
> > > #12 [ffffa9fe0759ff50] ret_from_fork at ffffffff94200215
> > > 
> > 
> > Hello Jens, Jianchao
> > Finally made it to this one.
> > I will see if I can revert and test
> > 
> > 7f556a44e61d0b62d78db9a2662a5f0daef010f2 is the first bad commit
> > commit 7f556a44e61d0b62d78db9a2662a5f0daef010f2
> > Author: Jianchao Wang <jianchao.w.wang@oracle.com>
> > Date:   Fri Dec 14 09:28:18 2018 +0800
> > 
> >     blk-mq: refactor the code of issue request directly
> >     
> >     Merge blk_mq_try_issue_directly and __blk_mq_try_issue_directly
> >     into one interface to unify the interfaces to issue requests
> >     directly. The merged interface takes over the requests totally,
> >     it could insert, end or do nothing based on the return value of
> >     .queue_rq and 'bypass' parameter. Then caller needn't any other
> >     handling any more and then code could be cleaned up.
> >     
> >     And also the commit c616cbee ( blk-mq: punt failed direct issue
> >     to dispatch list ) always inserts requests to hctx dispatch list
> >     whenever get a BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE, this is
> >     overkill and will harm the merging. We just need to do that for
> >     the requests that has been through .queue_rq. This patch also
> >     could fix this.
> >     
> >     Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> >     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > 
> > 
> > 
> 
> Cannot clean revert 
> 
> loberman@ibclient linux]$ git revert
> 7f556a44e61d0b62d78db9a2662a5f0daef010f2 
> error: could not revert 7f556a4... blk-mq: refactor the code of issue
> request directly
> hint: after resolving the conflicts, mark the corrected paths
> hint: with 'git add <paths>' or 'git rm <paths>'
> hint: and commit the result with 'git commit'
> 
> Revert "blk-mq: refactor the code of issue request directly"
> 
> This reverts commit 7f556a44e61d0b62d78db9a2662a5f0daef010f2.
> 
> Conflicts:
>         block/blk-mq.c
> 
> No clear what in this commit is breaking things and causing the race

Hi Laurence,

Could you test the following patch?

'bypass' means the caller handle the dispatch result.

Also, we might remove the handling for 'force', so we can align to
blk_mq_dispatch_rq_list(), but that shouldn't be related with this
issue.

diff --git a/block/blk-mq.c b/block/blk-mq.c
index bc3524428b96..ee4bfd9cbde5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1848,12 +1848,14 @@ blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	ret = __blk_mq_issue_directly(hctx, rq, cookie, last);
 out_unlock:
 	hctx_unlock(hctx, srcu_idx);
+	if (bypass)
+		return ret;
 	switch (ret) {
 	case BLK_STS_OK:
 		break;
 	case BLK_STS_DEV_RESOURCE:
 	case BLK_STS_RESOURCE:
-		if (force) {
+		if (force)
 			blk_mq_request_bypass_insert(rq, run_queue);
 			/*
 			 * We have to return BLK_STS_OK for the DM
@@ -1861,18 +1863,14 @@ blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 			 * the real result to indicate whether the
 			 * request is direct-issued successfully.
 			 */
-			ret = bypass ? BLK_STS_OK : ret;
-		} else if (!bypass) {
+		else
 			blk_mq_sched_insert_request(rq, false,
 						    run_queue, false);
-		}
 		break;
 	default:
-		if (!bypass)
-			blk_mq_end_request(rq, ret);
+		blk_mq_end_request(rq, ret);
 		break;
 	}
-
 	return ret;
 }
 
Thanks,
Ming
