Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92446C10F11
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 00:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D1F2175B
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 00:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbfDYApd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 20:45:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54521 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbfDYApd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 20:45:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A6983C0AF786;
        Thu, 25 Apr 2019 00:45:33 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EED125D9C5;
        Thu, 25 Apr 2019 00:45:26 +0000 (UTC)
Date:   Thu, 25 Apr 2019 08:45:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 2/2] scsi: core: avoid to pre-allocate big chunk for sg
 list
Message-ID: <20190425004520.GA22636@ming.t460p>
References: <20190423103240.29864-1-ming.lei@redhat.com>
 <20190423103240.29864-3-ming.lei@redhat.com>
 <20190424055317.GF12136@lst.de>
 <20190424084145.GB32345@ming.t460p>
 <20190424143833.GD21209@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424143833.GD21209@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 25 Apr 2019 00:45:33 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 24, 2019 at 04:38:33PM +0200, Christoph Hellwig wrote:
> On Wed, Apr 24, 2019 at 04:41:46PM +0800, Ming Lei wrote:
> > > This removes the last use of the first_chunk paramter to
> > > sg_free_table_chained, please remove the paramter in an additional
> > > patch.
> > 
> > NVMe FC/RDMA still uses first_chunk.
> 
> Looks like they need a similar treatment then :)

Yeah, I agree.

But the issue could be less serious for NVMe FC/RDMA because the queue
depth is often much small.

thanks,
Ming
