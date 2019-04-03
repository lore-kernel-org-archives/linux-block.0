Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A877C4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 18:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193982084B
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 18:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfDCSnj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:43:39 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41629 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfDCSni (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 14:43:38 -0400
Received: by mail-qk1-f196.google.com with SMTP id o129so29796qke.8
        for <linux-block@vger.kernel.org>; Wed, 03 Apr 2019 11:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ek2PhIDisG6J66uV7qhhtwD5wdO30T5kxZXke94Glko=;
        b=msKVwW/ugUt3okwklSLvagpXriMjG/b5T1ZfKgfwqxGVhD404ZkqZtN9k44OawcxTb
         TzQ3zYN/CIvgO5UqeuDXuSwMkRm/CQ/LcKa8dRFSXn4adsh4+GaUG4ePJxhSxN6p5/yr
         ZNLrahSeeOzcWNkdHArMKSuOujdjZde/Khyaid6GTzfzPTzpehmIpRuLfB9hMJzqb7gX
         uz1wpgnQWj4TRjQgl7B3UfntpmtSUS+dZ68KYawOJB8bllsejuPCFLA/bINn3fHhqazy
         epyqfoPehaM0nMVMUMuphnVVqb/SLxXCjclnJTnwwvjlz0Qyq/qyLUi6gEk8N9K7SP/r
         2Q8w==
X-Gm-Message-State: APjAAAWQB75YLTJycG5/qR05/U8322ME6wnWlcRuYrXOL7iXSW5h30Hi
        L1VrO2r5SOThg4EkarYez3/MOA==
X-Google-Smtp-Source: APXvYqwYXayp02c+98QDMfBv5zCOno3flsgkkhICUAWnMJhZUue5xE+BP050mKTSkna6WuPjERlqTg==
X-Received: by 2002:a05:620a:1253:: with SMTP id a19mr1467369qkl.148.1554317017166;
        Wed, 03 Apr 2019 11:43:37 -0700 (PDT)
Received: from dhcp-49-37.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x2sm8323041qkj.59.2019.04.03.11.43.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 11:43:36 -0700 (PDT)
Message-ID: <799b8ceb473c6c221eb7468e5897a61576bc003a.camel@redhat.com>
Subject: Re: Panic when rebooting target server testing srp on 5.0.0-rc2
From:   Laurence Oberman <loberman@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <tom.leiming@gmail.com>, jianchao.w.wang@oracle.com
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
Date:   Wed, 03 Apr 2019 14:43:35 -0400
In-Reply-To: <1554313972.118779.233.camel@acm.org>
References: <6e19971d315f4a3ce2cc20a1c6693f4a263a280c.camel@redhat.com>
         <7858e19ce3fc3ebf7845494a2209c58cd9e3086d.camel@redhat.com>
         <1553113730.65329.60.camel@acm.org>
         <3645c45e88523d4b242333d96adbb492ab100f97.camel@redhat.com>
         <d9febee1de759206bbf4d66f6570415ae64e4f33.camel@redhat.com>
         <8a6807100283a0c1256410f4f0381979b18398fe.camel@redhat.com>
         <CACVXFVOfZvnDo_ccVm1+cFRo_oSoiexgLfe_pyXp84v=0eQ7rQ@mail.gmail.com>
         <38a35a9c6a74371ebaea6cdf210184b8dee4dbeb.camel@redhat.com>
         <5d79ef69efecba45718c87110e8a37a37f973bea.camel@redhat.com>
         <74e767afc0e10054f87fc821fa15966449d3dd2a.camel@redhat.com>
         <1554313972.118779.233.camel@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-04-03 at 10:52 -0700, Bart Van Assche wrote:
> On Wed, 2019-03-27 at 18:00 -0400, Laurence Oberman wrote:
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
> >     to dispatch list ) always inserts requests to hctx dispatch
> > list
> >     whenever get a BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE, this
> > is
> >     overkill and will harm the merging. We just need to do that for
> >     the requests that has been through .queue_rq. This patch also
> >     could fix this.
> >     
> >     Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> >     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Hi Laurence,
> 
> I have not been able to reproduce this issue. But you may want to try
> the following patch (applies on top of v5.1-rc3):
> 
> 
> Subject: [PATCH] block: Fix blk_mq_try_issue_directly()
> 
> If blk_mq_try_issue_directly() returns BLK_STS*_RESOURCE that means
> that
> the request has not been queued and that the caller should retry to
> submit
> the request. Both blk_mq_request_bypass_insert() and
> blk_mq_sched_insert_request() guarantee that a request will be
> processed.
> Hence return BLK_STS_OK if one of these functions is called. This
> patch
> avoids that blk_mq_dispatch_rq_list() crashes when using dm-mpath.
> 
> Reported-by: Laurence Oberman <loberman@redhat.com>
> Fixes: 7f556a44e61d ("blk-mq: refactor the code of issue request
> directly") # v5.0.
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 652d0c6d5945..b2c20dce8a30 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1859,16 +1859,11 @@ blk_status_t blk_mq_try_issue_directly(struct
> blk_mq_hw_ctx *hctx,
>  	case BLK_STS_RESOURCE:
>  		if (force) {
>  			blk_mq_request_bypass_insert(rq, run_queue);
> -			/*
> -			 * We have to return BLK_STS_OK for the DM
> -			 * to avoid livelock. Otherwise, we return
> -			 * the real result to indicate whether the
> -			 * request is direct-issued successfully.
> -			 */
> -			ret = bypass ? BLK_STS_OK : ret;
> +			ret = BLK_STS_OK;
>  		} else if (!bypass) {
>  			blk_mq_sched_insert_request(rq, false,
>  						    run_queue, false);
> +			ret = BLK_STS_OK;
>  		}
>  		break;
>  	default:
> 
> 
> Thanks,
> 
> Bart.

Hello Bart

For the above:

Reviewed-by: Laurence Oberman <loberman@redhat.com>
Tested-by: Laurence Oberman <loberman@redhat.com>


Thank you. Given I know this issue very well, I can confirm your patch
fixes it.
Against 5.1-rc3 the initiator no longer panics when I reboot the
ib_srpt target server. It continues to try reconnect as it should.
I would never have found this. Patch makes sense now of course so I can
review it.

[  221.285919] device-mapper: multipath: Failing path 8:176.
[  221.286182] device-mapper: multipath: Failing path 65:144.
[  221.286266] device-mapper: multipath: Failing path 65:0.
[  221.286625] device-mapper: multipath: Failing path 65:32.
[  221.286708] device-mapper: multipath: Failing path 65:96.
[  221.286965] device-mapper: multipath: Failing path 65:224.
[  221.287115] device-mapper: multipath: Failing path 66:48.
[  221.309589] sd 1:0:0:14: rejecting I/O to offline device
[  221.309595] sd 1:0:0:6: rejecting I/O to offline device
[  231.692106] scsi host2: ib_srp: Got failed path rec status -110
[  231.722521] scsi host2: ib_srp: Path record query failed: sgid
fe80:0000:0000:0000:7cfe:9003:0072:6ed3, dgid
fe80:0000:0000:0000:7cfe:9003:0072:6e4f, pkey 0xffff, service_id
0x7cfe900300726e4e
[  231.816709] scsi host2: reconnect attempt 2 failed (-110)
[  236.684030] scsi host1: ib_srp: Got failed path rec status -110
[  236.716132] scsi host1: ib_srp: Path record query failed: sgid
fe80:0000:0000:0000:7cfe:9003:0072:6ed2, dgid
fe80:0000:0000:0000:7cfe:9003:0072:6e4e, pkey 0xffff, service_id
0x7cfe900300726e4e
[  236.814095] scsi host1: reconnect attempt 2 failed (-110)




