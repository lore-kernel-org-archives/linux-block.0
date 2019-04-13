Return-Path: <SRS0=i+2c=SP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2543FC10F11
	for <linux-block@archiver.kernel.org>; Sat, 13 Apr 2019 06:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51EC2084E
	for <linux-block@archiver.kernel.org>; Sat, 13 Apr 2019 06:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbfDMG4W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Apr 2019 02:56:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbfDMG4V (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Apr 2019 02:56:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9075FC0669D5;
        Sat, 13 Apr 2019 06:56:21 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 75A60600C1;
        Sat, 13 Apr 2019 06:56:14 +0000 (UTC)
Date:   Sat, 13 Apr 2019 14:56:09 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V5 9/9] SCSI: don't hold device refcount in IO path
Message-ID: <20190413065608.GA9108@ming.t460p>
References: <20190412033032.10418-1-ming.lei@redhat.com>
 <20190412033032.10418-10-ming.lei@redhat.com>
 <yq1o95akbxj.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1o95akbxj.fsf@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sat, 13 Apr 2019 06:56:21 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 12, 2019 at 08:04:40PM -0400, Martin K. Petersen wrote:
> 
> Ming,
> 
> > scsi_device's refcount is always grabbed in IO path.
> >
> > Turns out it isn't necessary, because blk_queue_cleanup() will
> > drain any in-flight IOs, then cancel timeout/requeue work, and
> > SCSI's requeue_work is canceled too in __scsi_remove_device().
> >
> > Also scsi_device won't go away until blk_cleanup_queue() is done.
> >
> > So don't hold the refcount in IO path, especially the refcount isn't
> > required in IO path since blk_queue_enter() / blk_queue_exit()
> > is introduced in the legacy block layer.
> 
> This all looks good to me. I assume it will go through Jens' tree?
> 
> Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

Hi Nartin,

This patch doesn't depend on patch 1~8, so please take it via scsi tree
if you are fine.


Thanks,
Ming
