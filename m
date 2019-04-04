Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375F8C10F0E
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 15:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129BC206DD
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 15:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfDDPJ5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:09:57 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36281 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729003AbfDDPJ5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Apr 2019 11:09:57 -0400
Received: by mail-qt1-f193.google.com with SMTP id s15so3646712qtn.3
        for <linux-block@vger.kernel.org>; Thu, 04 Apr 2019 08:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iSZT22f8QwqE8csxCSH9k05icX+cK2bjq0qyLbSQcYs=;
        b=dNCMjDYjy6ybyybPPpU0r3/HuVFsM6e57Xen0OE5n0+i7eqXvmd0WXgvM3mn8mhOOW
         2HS7mOLc7HB+DXZh+SRLNxuj2TulA4zjgmWqjEBifQklvvhWCba0KyEnMECnQhxlmVGv
         fD66pXv0Pl110y39tA1g+pBu5a706SUHUbWByCTGHbk5YaFbORIUrelaqQ5X7t1YFeeP
         8Ka1/gANTsI+uL/qDVjtmgjWS6Jfc5R2lZZSm2g3w82pvmm6fr3WSHs2x3VYczXh4GbU
         ArR7LwTk466Si3rAcA++8Kucs92IzALm86wurIoXlPSGhJJAFQzQ7d/4IoorAH43++62
         ZP3w==
X-Gm-Message-State: APjAAAXHGAdjsN2q0gwIIdV0vOjbmns0Jpzg83fPfK2F452VzXaOJqXM
        F1iWoP6cUFI4PyXsfg6j/P5jCQ==
X-Google-Smtp-Source: APXvYqxfoybxYJdrUko50Xk1b1WUZLjlW635y052SPFwOo5+ON0AdBd4rKQkcQ9CNJmFfm64c1JobA==
X-Received: by 2002:a0c:b8a8:: with SMTP id y40mr5251030qvf.27.1554390595789;
        Thu, 04 Apr 2019 08:09:55 -0700 (PDT)
Received: from 2600-6c64-4e80-00f1-422c-9885-0a6c-81b2.dhcp6.chtrptr.net (2600-6c64-4e80-00f1-422c-9885-0a6c-81b2.dhcp6.chtrptr.net. [2600:6c64:4e80:f1:422c:9885:a6c:81b2])
        by smtp.gmail.com with ESMTPSA id d41sm13957678qtd.90.2019.04.04.08.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 08:09:54 -0700 (PDT)
Message-ID: <2b049ffa57ccac27b876c674bc1fa06faca5d3b6.camel@redhat.com>
Subject: Re: [PATCH] block: Fix blk_mq_try_issue_directly()
From:   Laurence Oberman <loberman@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongli Zhang <dongli.zhang@oracle.com>, stable@vger.kernel.org
Date:   Thu, 04 Apr 2019 11:09:53 -0400
In-Reply-To: <1554389983.118779.237.camel@acm.org>
References: <20190403201126.22819-1-bvanassche@acm.org>
         <20190404070849.GD5004@ming.t460p> <1554389983.118779.237.camel@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2019-04-04 at 07:59 -0700, Bart Van Assche wrote:
> On Thu, 2019-04-04 at 15:08 +0800, Ming Lei wrote:
> > On Wed, Apr 03, 2019 at 01:11:26PM -0700, Bart Van Assche wrote:
> > > If blk_mq_try_issue_directly() returns BLK_STS*_RESOURCE that
> > > means that
> > > the request has not been queued and that the caller should retry
> > > to submit
> > > the request. Both blk_mq_request_bypass_insert() and
> > > blk_mq_sched_insert_request() guarantee that a request will be
> > > processed.
> > > Hence return BLK_STS_OK if one of these functions is called. This
> > > patch
> > > avoids that blk_mq_dispatch_rq_list() crashes when using dm-
> > > mpath.
> > > 
> > > Cc: Christoph Hellwig <hch@infradead.org>
> > > Cc: Hannes Reinecke <hare@suse.com>
> > > Cc: James Smart <james.smart@broadcom.com>
> > > Cc: Ming Lei <ming.lei@redhat.com>
> > > Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
> > > Cc: Keith Busch <keith.busch@intel.com>
> > > Cc: Dongli Zhang <dongli.zhang@oracle.com>
> > > Cc: Laurence Oberman <loberman@redhat.com>
> > > Tested-by: Laurence Oberman <loberman@redhat.com>
> > > Reviewed-by: Laurence Oberman <loberman@redhat.com>
> > > Reported-by: Laurence Oberman <loberman@redhat.com>
> > > Fixes: 7f556a44e61d ("blk-mq: refactor the code of issue request
> > > directly") # v5.0.
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> > > ---
> > >  block/blk-mq.c | 9 ++-------
> > >  1 file changed, 2 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > index 652d0c6d5945..b2c20dce8a30 100644
> > > --- a/block/blk-mq.c
> > > +++ b/block/blk-mq.c
> > > @@ -1859,16 +1859,11 @@ blk_status_t
> > > blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
> > >  	case BLK_STS_RESOURCE:
> > >  		if (force) {
> > >  			blk_mq_request_bypass_insert(rq, run_queue);
> > > -			/*
> > > -			 * We have to return BLK_STS_OK for the DM
> > > -			 * to avoid livelock. Otherwise, we return
> > > -			 * the real result to indicate whether the
> > > -			 * request is direct-issued successfully.
> > > -			 */
> > > -			ret = bypass ? BLK_STS_OK : ret;
> > > +			ret = BLK_STS_OK;
> > >  		} else if (!bypass) {
> > >  			blk_mq_sched_insert_request(rq, false,
> > >  						    run_queue, false);
> > > +			ret = BLK_STS_OK;
> > >  		}
> > 
> > This change itself is correct.
> > 
> > However, there is other issue introduced by 7f556a44e61d.
> > 
> > We need blk_insert_cloned_request() to pass back
> > BLK_STS_RESOURCE/BLK_STS_RESOURCE
> > to caller, so that dm-rq driver may see the underlying queue is
> > busy, then tell
> > blk-mq to deal with the busy condition from dm-rq queue, so that IO
> > merge can get improved.
> > 
> > That is exactly what 396eaf21ee17c476e8f6 ("blk-mq: improve DM's
> > blk-mq IO merging
> > via blk_insert_cloned_request feedback") did.
> > 
> > There must be performance regression with 7f556a44e61d by cut the
> > feedback.
> > 
> > So could you fix them all in one patch?
> 
> Since commit 7f556a44e61d introduced multiple problems and since
> fixing
> these is nontrivial, how about reverting that commit?
> 
> Thanks,
> 
> Bart.

When I bisected and got to that commit I was unable to revert it to
test without it.
I showed that in an earlier update, had merge issues.

loberman@lobewsrhel linux_torvalds]$ git revert 7f556a44e61d
error: could not revert 7f556a4... blk-mq: refactor the code of issue
request directly
hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'
hint: and commit the result with 'git commit'

