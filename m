Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B05C2D0E4
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 01:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C2F3206B5
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 01:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzSVP6Hw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgKMBLn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Nov 2020 20:11:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45055 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726055AbgKMBLm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Nov 2020 20:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605229900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TFC6GmXGxNLsCv2kR+1bEWk/RI1lu80rZMe/SAoeXfs=;
        b=GzSVP6Hwbma+lAQPkQxuIx8wHd5vient8/Iq8/RRTMqrInw2bXGiUYZevTT0p8O2l0qjmr
        JWhtudUpNZjm1c7p/zWE4Cp/7DIrN7Hbg+JUiFA50Pz0IhqVKFlRxXcOxIC8qxZctGyVBc
        ZJvkna0p7Wb1v//bAEdDNUaSmCS/+bs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-Bd9YajE4McO-GneWj1aO_Q-1; Thu, 12 Nov 2020 20:11:37 -0500
X-MC-Unique: Bd9YajE4McO-GneWj1aO_Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FB3210066FB;
        Fri, 13 Nov 2020 01:11:35 +0000 (UTC)
Received: from T590 (ovpn-12-25.pek2.redhat.com [10.72.12.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A12CC5D9D5;
        Fri, 13 Nov 2020 01:11:23 +0000 (UTC)
Date:   Fri, 13 Nov 2020 09:11:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Qian Cai <cai@redhat.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        John Garry <john.garry@huawei.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 3/3] Revert "block: Fix a lockdep complaint triggered by
 request queue flushing"
Message-ID: <20201113011118.GC1012796@T590>
References: <20201112075526.947079-1-ming.lei@redhat.com>
 <20201112075526.947079-4-ming.lei@redhat.com>
 <43bd8381-487b-098d-8e62-3946c75bcd8a@acm.org>
 <e0392f5e-1de2-d56b-027b-4bb4d041fdcc@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0392f5e-1de2-d56b-027b-4bb4d041fdcc@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 12, 2020 at 07:29:13AM -0800, Bart Van Assche wrote:
> On 11/12/20 7:12 AM, Bart Van Assche wrote:
> > On 11/11/20 11:55 PM, Ming Lei wrote:
> >> This reverts commit b3c6a59975415bde29cfd76ff1ab008edbf614a9.
> >>
> >> Now we can avoid nvme-loop lockdep warning of 'lockdep possible recursive
> >> locking' by nvme-loop's lock class, no need to apply dynamically
> >> allocated lock class key, so revert commit b3c6a5997541("block: Fix a
> >> lockdep complaint triggered by request queue flushing").
> >>
> >> This way fixes horrible SCSI probe delay issue on megaraid_sas, and it
> >> is reported the whole probe may take more than half an hour.
> > 
> > The code touched by this patch is compiled out with locked disabled so
> > it is not clear to me how this patch could affect a probe delay for
> > megaraid_sas? Has the megaraid_sas probe issue perhaps not been root
> > caused correctly?
> 
> (replying to my own email)
> 
> I found the answer in the descriptions of the previous patches of this
> series. I think this patch would benefit from a more complete patch
> description.

Hello Bart,

OK, I can add more words to this commit log.

Thanks,
Ming

