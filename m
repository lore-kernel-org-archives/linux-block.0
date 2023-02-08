Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120B9C636CC
	for <linux-block@archiver.kernel.org>; Wed,  8 Feb 2023 01:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjBHBjr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Feb 2023 20:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBHBjq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Feb 2023 20:39:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371F711661
        for <linux-block@vger.kernel.org>; Tue,  7 Feb 2023 17:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675820338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Squ2yw7oUC4jgQCxA83Q2HVDOTo6jIlaNp5hDqz0R8=;
        b=eFQ7FmxGV80puLkDKngV2uuEuW3/egciW13fcrFak1W9p+px2rguRc9vnknqeUYljH/ynb
        s6MtjZAuNmMpc5+5gq9GLZAg9KEst1XHcutfPUhFJLlDqUyMe1D9JEVFNC4L/Sk1eY1M1m
        nr8azkfd6LvvVl7IMxRYpar2pPlLtRo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-LUXZvWl8NaOxe1ishqlJ8A-1; Tue, 07 Feb 2023 20:38:55 -0500
X-MC-Unique: LUXZvWl8NaOxe1ishqlJ8A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D3B32A59542;
        Wed,  8 Feb 2023 01:38:54 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD61640B42D4;
        Wed,  8 Feb 2023 01:38:47 +0000 (UTC)
Date:   Wed, 8 Feb 2023 09:38:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Jim Harris <james.r.harris@intel.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        "hch@lst.de" <hch@lst.de>, Stefan Hajnoczi <stefanha@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>, ming.lei@redhat.com
Subject: Re: [LSF/MM/BPF BoF]: extend UBLK to cover real storage hardware
Message-ID: <Y+L9Ijb5Kc3Yow5Z@T590>
References: <Y+EWCwqSisu3l0Sz@T590>
 <80aa92bc-f9b3-f76e-4e3a-76d3753717d2@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80aa92bc-f9b3-f76e-4e3a-76d3753717d2@acm.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 06, 2023 at 10:26:55AM -0800, Bart Van Assche wrote:
> On 2/6/23 07:00, Ming Lei wrote:
> > 4) DMA
> > - DMA requires physical memory address, UBLK driver actually has
> > block request pages, so can we export request SG list(each segment
> > physical address, offset, len) into userspace? If the max_segments
> > limit is not too big(<=64), the needed buffer for holding SG list
> > can be small enough.
> > 
> > - small amount of physical memory for using as DMA descriptor can be
> > pre-allocated from userspace, and ask kernel to pin pages, then still
> > return physical address to userspace for programming DMA
> > 
> > - this way is still zero copy
> 
> Would it be possible to use vfio in such a way that zero-copy
> functionality is achieved? I'm concerned about the code duplication that
> would result if a new interface similar to vfio is introduced.

Here I meant we can export physical address of request sg from
/dev/ublkb* to userspace, which can program the DMA controller
using exported physical address. With this way, the userspace driver
can submit IO without entering kernel, then with high performance.

This should how SPDK/nvme-pci[1] is implemented, but SPDK allocates
hugepage for getting its physical address.

[1] https://spdk.io/doc/memory.html

Thanks,
Ming

