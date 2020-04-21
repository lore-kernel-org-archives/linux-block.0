Return-Path: <SRS0=KmMx=6F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D95DC54FC9
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 10:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D1F32068F
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 10:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMidqZVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgDUKdU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Apr 2020 06:33:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49580 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727120AbgDUKdQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Apr 2020 06:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587465195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EyLblhX5X6lhg0t/llpl5uQpyQRjyyg8CobgDx/wvC0=;
        b=bMidqZVYI7uiTwguQZBGE4M5xHCkisZSw/TgtQBENqHAKDPceQ55m3ELIfyoXpFjJH5T65
        apducSAxYZVKEVb6Fd35A9DTCd9RxdiUPA+t3iZ0Jj/gFwd6uGlHqhARcITyLjdmWf6gG5
        GYU0ZoltnzSKZUryz/GOFD8mWcoifxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-wGxjjLoBOCe4u1_JRMt9JQ-1; Tue, 21 Apr 2020 06:33:11 -0400
X-MC-Unique: wGxjjLoBOCe4u1_JRMt9JQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA27A8017FC;
        Tue, 21 Apr 2020 10:33:09 +0000 (UTC)
Received: from gondolin (ovpn-112-226.ams2.redhat.com [10.36.112.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E3FF1001B09;
        Tue, 21 Apr 2020 10:32:59 +0000 (UTC)
Date:   Tue, 21 Apr 2020 12:32:56 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: stop using ioctl_by_bdev in the s390 DASD driver
Message-ID: <20200421123256.2f5d9dbd.cohuck@redhat.com>
In-Reply-To: <b7e4a728-1f58-f304-cb5b-1aa2206a6bb4@de.ibm.com>
References: <20200421061226.33731-1-hch@lst.de>
        <b7e4a728-1f58-f304-cb5b-1aa2206a6bb4@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 21 Apr 2020 11:58:31 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 21.04.20 08:12, Christoph Hellwig wrote:
> > Hi Jens and DASD maintainers,
> > 
> > can you take a look at this series, which stops the DASD driver from
> > issuing ioctls from kernel space, in preparation of removing
> > ioctl_by_bdev.  I don't really like the new s390-only method, but short
> > of forcing the dasd driver to be built into the kernel I can't think of
> > anything better.  But maybe the s390 maintainers are fine with forcing
> > the DASD driver to be built in, in which case we could go down that
> > route?  
> 
> Hmm the defconfig results in dasd built-in anyway. But distros really like
> to keep it modular.
> 
> Hmm, we do have
> 
> obj-$(CONFIG_DASD) += dasd_mod.o
> obj-$(CONFIG_DASD_DIAG) += dasd_diag_mod.o
> obj-$(CONFIG_DASD_ECKD) += dasd_eckd_mod.o
> obj-$(CONFIG_DASD_FBA)  += dasd_fba_mod.o
> 
> Would it work to make CONFIG_DASD built-in only and keep the other 3 as modules?
> Not sure about the implications. 
> 

I don't think non-eckd dasd drivers are really useful outside of z/VM
guests, so keeping at least the disciplines modular would be good.

Also, what about special purpose environments like the zfcp dumper?
Would be good to be able to keep these small.

How big is the dasd code in the end?

