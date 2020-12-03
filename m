Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B26C6369E
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 01:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF1D221FB
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 01:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgLCBZj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 20:25:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26894 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725959AbgLCBZj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Dec 2020 20:25:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606958652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BnB6KEGreP4BJbO64pikkiDEYWis3mZbnxN7CY98rMw=;
        b=AL/caAwr9EGuHGXM8H8sPstox2edtWGM62uGHfVCL3oPvOcf05b6giBI6w1UirOGvnboVa
        on9hikbmnGX62qQJ3KxedNSwiAN5r0Ai5mRPWRL3NFSA3eN/NaAxFyDhv4iz7Oyh5kVlVe
        gLX4odNnncwBQ+gd4olKZQiL8X0HvHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-Dtml8vCjOzaToCuTRuXPMw-1; Wed, 02 Dec 2020 20:24:08 -0500
X-MC-Unique: Dtml8vCjOzaToCuTRuXPMw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D932805BF1;
        Thu,  3 Dec 2020 01:24:06 +0000 (UTC)
Received: from ovpn-66-132.rdu2.redhat.com (unknown [10.10.67.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 123AC60BFA;
        Thu,  3 Dec 2020 01:23:59 +0000 (UTC)
Message-ID: <c34804b3a4db1701fab9e03078ce75a69d9b446e.camel@redhat.com>
Subject: Re: [PATCH 0/3] blk-mq/nvme-loop: use nvme-loop's lock class for
 addressing lockdep false positive warning
From:   Qian Cai <qcai@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        John Garry <john.garry@huawei.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Date:   Wed, 02 Dec 2020 20:23:58 -0500
In-Reply-To: <20201203005035.GA540033@T590>
References: <20201112075526.947079-1-ming.lei@redhat.com>
         <20201130023606.GC230145@T590>
         <b70f46b855858a28b0e77ee7efbb2dbffbb56490.camel@redhat.com>
         <20201203005035.GA540033@T590>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2020-12-03 at 08:50 +0800, Ming Lei wrote:
> On Wed, Dec 02, 2020 at 02:07:08PM -0500, Qian Cai wrote:
> > On Mon, 2020-11-30 at 10:36 +0800, Ming Lei wrote:
> > > Any chance to take a look? And this issue has been reported several
> > > times in RH internal test.
> > 
> > I suppose that you will need to rebase as it does not apply cleanly on
> > today's
> > linux-next.
> > 
> 
> I just apply the three patches against for-5.11/block, and they can be
> done cleanly.

Ah, sorry. It was a bit whitespace damages on my end. This did really fix the
megasas_raid boot hang here. Since 103fbf8e4020 ("scsi: megaraid_sas: Added
support for shared host tagset for cpuhotplug") is now in the mainline, it
probably makes sense to merge this patchset for v5.10 as well to avoid breakage.
Anyway,

Tested-by: Qian Cai <qcai@redhat.com>

