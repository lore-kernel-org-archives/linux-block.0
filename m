Return-Path: <SRS0=k6TP=4V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC8BC3F2CD
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 03:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A34920838
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 03:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ll+QguwZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387566AbgCDDrA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Mar 2020 22:47:00 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51494 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387469AbgCDDrA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Mar 2020 22:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583293619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ldW0Bt53Z7jSSRCB6WQDAvf5XFQIl+N3b5ldTZ1uj50=;
        b=Ll+QguwZJG7Winuiq4CwwFlsojH2gzBPho8XtF07eMVr9uJmAFQGZfn5MSNWjXYjnmL+e8
        cCKStgEIaSR5/WFVXWtAHdAwTc/Gwy009pAyr2mKLaXg8pLwEM1YZVXMcCmTZvz7qufbiI
        +L6uFNBr4FdlfJkOINQpjiyEY0hnKvQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-BS6UuV6wNmSt7-y5ltrwow-1; Tue, 03 Mar 2020 22:46:55 -0500
X-MC-Unique: BS6UuV6wNmSt7-y5ltrwow-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 878F31088388;
        Wed,  4 Mar 2020 03:46:54 +0000 (UTC)
Received: from ming.t460p (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 25A8B5C1D4;
        Wed,  4 Mar 2020 03:46:48 +0000 (UTC)
Date:   Wed, 4 Mar 2020 11:46:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: commit 01e99aeca397 causes longer runtime of block/004
Message-ID: <20200304034644.GA23012@ming.t460p>
References: <20200304023842.gu37d4mzfbseiscw@shindev.dhcp.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304023842.gu37d4mzfbseiscw@shindev.dhcp.fujisawa.hgst.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 04, 2020 at 02:38:43AM +0000, Shinichiro Kawasaki wrote:
> I noticed that blktests block/004 takes longer runtime with 5.6-rc4 than
> 5.6-rc3, and found that the commit 01e99aeca397 ("blk-mq: insert passthrough
> request into hctx->dispatch directly") triggers it.
> 
> The longer runtime was observed with dm-linear device which maps SATA SMR HDD
> connected via AHCI. It was not observed with dm-linear on SAS/SATA SMR HDDs
> connected via SAS-HBA. Not observed with dm-linear on non-SMR HDDs either.
> 
> Before the commit, block/004 took around 130 seconds. After the commit, it takes
> around 300 seconds. I need to dig in further details to understand why the
> commit makes the test case longer.
> 
> The test case block/004 does "flush intensive workload". Is this longer runtime
> expected?

The following patch might address this issue:

https://lore.kernel.org/linux-block/20200207190416.99928-1-sqazi@google.com/#t

Please test and provide us the result.

thanks,
Ming

