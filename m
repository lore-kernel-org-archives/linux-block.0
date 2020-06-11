Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C85C433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 07:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6B172075F
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 07:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1F4oTWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgFKH1m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:27:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38543 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726375AbgFKH1m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 03:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591860460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+pWTxVQR2gCgtGr/Q5zCXAYOI/vAMCDiFBOSl9htBRQ=;
        b=a1F4oTWYPMXcjnK+OywDJa0nOzRm/a3DUKysf55y+Gl1+lQlXDlFrNROMxXwQVRzVoHldr
        SBH/M1ypv6JaMO0ualFIn4Inte5g8ckC/AjchJ00yFH59C5aQEAnnI55Fq7cAnzQbJ4w0z
        UoJSNW/XddlqiGqr7DZEQtReGXk1JLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-i_Uwc6bAPYmhT_sQMuSEZw-1; Thu, 11 Jun 2020 03:27:39 -0400
X-MC-Unique: i_Uwc6bAPYmhT_sQMuSEZw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48FF3C7441;
        Thu, 11 Jun 2020 07:27:37 +0000 (UTC)
Received: from T590 (ovpn-12-163.pek2.redhat.com [10.72.12.163])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AC18E5D9D3;
        Thu, 11 Jun 2020 07:27:29 +0000 (UTC)
Date:   Thu, 11 Jun 2020 15:27:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Alan Adamson <alan.adamson@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH V2 0/3] blk-mq/nvme: improve nvme-pci reset handler
Message-ID: <20200611072724.GA473855@T590>
References: <20200530135221.1152749-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530135221.1152749-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 30, 2020 at 09:52:18PM +0800, Ming Lei wrote:
> Hi,
> 
> For nvme-pci, after controller is recovered, in-flight IOs are waited
> before updating nr hw queues. If new controller error happens during
> this period, nvme-pci driver deletes the controller and fails in-flight
> IO. This way is too violent, and not friendly from user viewpoint.
> 
> Add APIs for checking if queue is frozen, and replace nvme_wait_freeze
> in nvme-pci reset handler with checking if all ns queues are frozen &
> controller disabled. Then a fresh new reset can be scheduled for
> handling new controller error during waiting for in-flight IO completion.
> 
> So deleting controller & failing IOs can be avoided in this situation.
> 
> Without this patches, when fail io timeout injection is run, the
> controller can be removed very quickly. With this patch, no controller
> removing can be observed, and controller can recover to normal state
> after stopping to inject io timeout failure.
> 
> V2:
> 	- give up after retrying enough times
> 	- add comment on breaking because of shutdown
> 
> Ming Lei (3):
>   blk-mq: add API of blk_mq_queue_frozen
>   nvme: add nvme_frozen
>   nvme-pci: make nvme reset more reliable
> 
>  block/blk-mq.c           |  6 +++++
>  drivers/nvme/host/core.c | 17 +++++++++++++-
>  drivers/nvme/host/nvme.h |  3 +++
>  drivers/nvme/host/pci.c  | 50 +++++++++++++++++++++++++++++++++-------
>  include/linux/blk-mq.h   |  1 +
>  5 files changed, 68 insertions(+), 9 deletions(-)
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Max Gurtovoy <maxg@mellanox.com>

Hello Guys,

Ping...

Thanks,
Ming

