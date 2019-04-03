Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDA3C4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 03:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA16920882
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 03:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfDCDYv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:24:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46560 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbfDCDYv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Apr 2019 23:24:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BDA90307D90D;
        Wed,  3 Apr 2019 03:24:50 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FB005C57E;
        Wed,  3 Apr 2019 03:24:43 +0000 (UTC)
Date:   Wed, 3 Apr 2019 11:24:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/5] blk-mq: allow to run queue if queue refcount is held
Message-ID: <20190403032437.GB9968@ming.t460p>
References: <20190401020036.GB30776@ming.t460p>
 <a64684d1-c3dc-b10a-1a03-0a8b2d01b331@acm.org>
 <20190401025237.GE30776@ming.t460p>
 <21b2000b-16b6-f5a6-692b-73143a49a4ec@oracle.com>
 <20190401032852.GG30776@ming.t460p>
 <ef192658-74cd-e193-cb40-aed546c2b309@oracle.com>
 <20190401100334.GA5493@ming.t460p>
 <ad0f8f4c-5efe-e50f-a3a7-4f7e3d368d28@oracle.com>
 <20190402025505.GB26316@ming.t460p>
 <1554228668.118779.166.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554228668.118779.166.camel@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 03 Apr 2019 03:24:50 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 02, 2019 at 11:11:08AM -0700, Bart Van Assche wrote:
> On Tue, 2019-04-02 at 10:55 +0800, Ming Lei wrote:
> > Also, isn't it the typical practice to release kobject related resources in
> > its release handler?
> 
> A typical approach is to call kobject_del() before starting to clean up a

Yes.

> resource and to defer the final kfree() call to the release handler. I think
> that's how it works today in the block layer core. That is easy to see in the
> blk_mq_hw_sysfs_release() implementation:
> 
> static void blk_mq_hw_sysfs_release(struct kobject *kobj)
> {
> 	struct blk_mq_hw_ctx *hctx = container_of(kobj, struct blk_mq_hw_ctx,
> 						  kobj);
> 	free_cpumask_var(hctx->cpumask);
> 	kfree(hctx->ctxs);
> 	kfree(hctx);
> }

Right, then we should free other hctx fields here too, it is safe
and reliable.


Thanks,
Ming
