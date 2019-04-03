Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0D3C4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 17:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2D820657
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 17:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfDCR74 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:59:56 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34471 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfDCR74 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 13:59:56 -0400
Received: by mail-qk1-f193.google.com with SMTP id n68so10743193qka.1
        for <linux-block@vger.kernel.org>; Wed, 03 Apr 2019 10:59:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=idNNn2auLOCsa+03fh9anl9RFgYqN/V9B05DyYw+qhk=;
        b=uXJ//5w+fubdL3Tvzb///+YtEuJ69NdlTh2sHDQxfDp14Q67SGc9IkerjJwJieoaf5
         7ELzyHHzfAalBBP79aWi90jJfEbgeKEX783BnzCdCHtTl9yOUSmXHki5WaUk7A3o2pok
         1YHxMBvEQTz3RLev0OP9vT4TkUDpBOaRPtgWZeivzThO+OcmdW3/z0NasiXU/ouEqvYD
         uqNsoGttXzQ+xVb5xmRX3ScFRPU6nH2iAr/kM/IpNBLyhJqMDeIoc3/IuF8t0Gh355ro
         /LWkXWx6p1ZWtwsmn0Hv1pK/9fMBsK3kT8GFZ3bInmELW27MvQHmRPlmbeoEEnZ3qM/6
         AaOg==
X-Gm-Message-State: APjAAAVpIQze9R6gV4zy/vTa8fXlNiE0wrPtFKtZGLJ+R2ULsFg9kUgP
        ouWvOTf9fxRhGgm5OHuCV7qJog==
X-Google-Smtp-Source: APXvYqz5hKauQKtZL/rvRNE3bghavFm5pCfnh0v2ngqfrsw+4588sfE451CYxICGeq6o18Tr/nZ9eQ==
X-Received: by 2002:a37:ef19:: with SMTP id j25mr1298662qkk.176.1554314394989;
        Wed, 03 Apr 2019 10:59:54 -0700 (PDT)
Received: from dhcp-49-37.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id p62sm2618292qkd.27.2019.04.03.10.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 10:59:54 -0700 (PDT)
Message-ID: <fc0899f9c46af3d5f22c93ea4fb93acce4fcefe3.camel@redhat.com>
Subject: Re: Panic when rebooting target server testing srp on 5.0.0-rc2
From:   Laurence Oberman <loberman@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <tom.leiming@gmail.com>, jianchao.w.wang@oracle.com
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
Date:   Wed, 03 Apr 2019 13:59:53 -0400
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

Thanks Bart
About to build and test

