Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E918C282CC
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 02:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5E920881
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 02:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tB09hQXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfA1Ckh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Jan 2019 21:40:37 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33890 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfA1Ckh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Jan 2019 21:40:37 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0S2dV59004860;
        Mon, 28 Jan 2019 02:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=CXpFgkgp0w3G59awZqfLBWrzkRk9czZ6dmZHXpY+d5M=;
 b=tB09hQXAbF/PUxbE2xGor8Ji72+PBF6nfmy8Pq5ojKDHZzEToZVMlSxrd7ySUydCixqn
 JmHaeX1bb6WMJVgrvBlNKy5kt1kvAa6oZOSSYr5fGtTFWobG7uu+6ZqdE0M+fucOsOCa
 6nrEanDWg+gxmCoGG3Bkd6ddGt96Kdr3DLIUb8ZaH6l5v7Za8Oi4BLadSHJr7iW+LGtV
 xNxH2VE/xKQXQ/D63cEUVi5Vcb7ndCjNzDYLXwyL+tfyH6ij81Rv6K7t8sS0gy0b1grZ
 QoP7WrqF6HL3Zr44fosCsUqj8SGUPZXYuRG0XbEeHRRYkXsC1zNZOgjhUWeGiaHuNe4n bw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2q8g6qukc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jan 2019 02:40:30 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0S2eSlF005582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jan 2019 02:40:29 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0S2eRFI013929;
        Mon, 28 Jan 2019 02:40:28 GMT
Received: from [10.182.71.8] (/10.182.71.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 27 Jan 2019 18:40:27 -0800
Subject: Re: fsync hangs after scsi rejected a request
To:     Florian Stecker <m19@florianstecker.de>,
        Ming Lei <tom.leiming@gmail.com>
Cc:     Linux SCSI List <linux-scsi@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>
References: <70df6d90-31eb-96f4-908d-462ea58dea6e@florianstecker.de>
 <CACVXFVOSHtV7jcMwEvDKZzPnsLRzkdvAEqb+ggugkM27LJvagg@mail.gmail.com>
 <a30b5868-dd7d-d3db-b7f4-c723ac279ead@florianstecker.de>
 <CACVXFVOzwaZyJFaOJw3K-FQUHeYGWNx8sPr8kqJzCV59Rd6sqg@mail.gmail.com>
 <e18051e3-4008-e259-dee3-dd58f23642ab@oracle.com>
 <4b631218-49ee-c3ed-46be-17f9d30b663f@florianstecker.de>
 <c42631fa-3e61-e046-851e-8079906a14fb@oracle.com>
 <d9fd42a9-6105-2404-6e74-cc540da1cf16@florianstecker.de>
 <3d921990-06c4-4662-2853-7667b4e9a462@oracle.com>
 <4fe48ebc-43db-7ada-087b-5ccbdb64cc66@oracle.com>
 <00501045-a87b-27d0-6373-72dcf243b32b@florianstecker.de>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <a7a3e95e-5c66-31d6-c442-ad295f82d72c@oracle.com>
Date:   Mon, 28 Jan 2019 10:42:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <00501045-a87b-27d0-6373-72dcf243b32b@florianstecker.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9149 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901280021
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 1/26/19 11:37 PM, Florian Stecker wrote:
> 
> 
> On 1/26/19 2:25 AM, jianchao.wang wrote:
...
>>>>
>>>> dmesg: https://urldefense.proofpoint.com/v2/url?u=https-3A__florianstecker.de_dmesg-2D2019-2D01-2D25.txt&d=DwIDaQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=t_udGGsH8ivtjXHin4oQ4LxELuPoXbl_ARP7oSxiQ6k&s=DC2fhRw2g4haGhhHxOYyX4zD6FWQQ5YoERdfptVRHM4&e=
>>>> Note that no I/O scheduler is in use here, I deactivated them in a udev rule because I still want to be able to use my laptop. When I test this stuff I just reactivate mq-deadline manually.
>>>>
>>>> Config is the default in Arch Linux: https://urldefense.proofpoint.com/v2/url?u=https-3A__git.archlinux.org_svntogit_packages.git_tree_trunk_config-3Fh-3Dpackages_linux&d=DwIDaQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=t_udGGsH8ivtjXHin4oQ4LxELuPoXbl_ARP7oSxiQ6k&s=GjV_fyXaKZ8za8zdB_gqmKW7yBlbla2OHRaAT0iGZkc&e=
>>>>
>>>> The problem also appears with BFQ.
>>>>
>>>> And rq->end_io is set to mq_flush_data_end_io when this happens. The only point I see where this function could invoke blk_mq_end_request is via blk_flush_complete_seq, but it does so only if seq == REQ_FSEQ_DONE. However, seq is REQ_FSEQ_POSTFLUSH for me (i.e. it just transitioned from REQ_FSEQ_DATA to REQ_FSEQ_POSTFLUSH).
>>>
>>>
>>> Could it be this scenario ?
>>>
>>> data + post flush
>>>
>>> blk_flush_complete_seq          a flush
>>>    case REQ_FSEQ_DATA
>>>    blk_flush_queue_rq
>>>       finally issued to driver      blk_mq_dispatch_rq_list
>>>                                  try to issue a flush req
>>>                                  failed due to NON-NCQ command
>>>                                  due to RESTART is set, do nothing
>>>    req complete
>>>    req->end_io（） // doesn't check RESTART
>>>    mq_flush_data_end_io
>>> 　  blk_flush_complete_seq
>>>       case REQ_FSEQ_POSTFLUSH
>>>       blk_kick_flush
>>>         do nothing because previous flush
>>>         has not been completed, so
>>>         flush_pending_idx != flush_running_idx
>>>

This should be corrected as following,
 data + post flush
 blk_flush_complete_seq          a flush
   case REQ_FSEQ_DATA
   blk_flush_queue_rq
      finally issued to driver   blk_mq_dispatch_rq_list
                                 try to issue a flush req
                                 failed due to NON-NCQ command
                                 return BLK_STS_DEV_RESOURCE

 req complete
 req->end_io（） // doesn't check RESTART
 mq_flush_data_end_io
 case REQ_FSEQ_POSTFLUSH
    blk_kick_flush
    do nothing because previous flush
    has not been completed, so
    flush_pending_idx != flush_running_idx
 blk_mq_mq_run_hw_queue
                                 insert rq to hctx->dispatch_list
                                 due to RESTART is set, do nothing

...
> I'm not sure if I understand every detail, but your scenario sounds roughly the same as what I imagine. The patch solves the problem for me (except for the fact that hctx is not defined in that function).
> 
> Actually, it doesn't seem to me as if any of the other users of blk_mq_free_request require or even expect that it calls blk_mq_sched_restart (I could be wrong though). If that is true, how about we just call it from __blk_mq_end_request, like this (also tested successfully on my laptop)?
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 6a7566244de3..9f3d3456c4af 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -481,7 +481,6 @@ static void __blk_mq_free_request(struct request *rq)
>                 blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
>         if (sched_tag != -1)
>                 blk_mq_put_tag(hctx, hctx->sched_tags, ctx, sched_tag);
> -       blk_mq_sched_restart(hctx);
>         blk_queue_exit(q);
>  }
> 
> @@ -522,6 +521,7 @@ EXPORT_SYMBOL_GPL(blk_mq_free_request);
>  inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
>  {
>         u64 now = ktime_get_ns();
> +       struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(rq->q, rq->mq_ctx->cpu);
> 
>         if (rq->rq_flags & RQF_STATS) {
>                 blk_mq_poll_stats_start(rq->q);
> @@ -541,6 +541,8 @@ inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
>                         blk_mq_free_request(rq->next_rq);
>                 blk_mq_free_request(rq);
>         }
> +
> +       blk_mq_sched_restart(hctx);
>  }
>  EXPORT_SYMBOL(__blk_mq_end_request);

We should invoke blk_mq_sched_restart before blk_queue_exit is invoked.

How about this one ?

diff --git a/block/blk-flush.c b/block/blk-flush.c
index a3fc7191..6e0f2d9 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -335,7 +335,7 @@ static void mq_flush_data_end_io(struct request *rq, blk_status_t error)
        blk_flush_complete_seq(rq, fq, REQ_FSEQ_DATA, error);
        spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
 
-       blk_mq_run_hw_queue(hctx, true);
+       blk_mq_sched_restart(hctx);
 }

Thanks
Jianchao
