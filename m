Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E72C6FA82
	for <linux-block@archiver.kernel.org>; Tue, 20 Sep 2022 17:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiITRrc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Sep 2022 13:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiITRrK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2022 13:47:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D7971999
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 10:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663696018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LWJRD/aSyJyAYbVSyms27B8uCpwJGT87p09KfhZdwzc=;
        b=JZpLDz5aVDdCfMrt1+Ok2XWBDvWlILi1/tE+HfD/iTixOWQBy0ov1OITcqKDCNQRWAWiUB
        jBi/SG7u4IPlXthAo8xcH4M8IfTZ9y0WVwgzJptKhj3/K4m1f8iPkARtCF9wMwkocSPM9u
        0Vzv34KMz4i/4Sz0Yn3Bb+poVndXkh8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-303-KjiIUof6PsuDbSrDF7GGUw-1; Tue, 20 Sep 2022 13:46:57 -0400
X-MC-Unique: KjiIUof6PsuDbSrDF7GGUw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BDEC80280B;
        Tue, 20 Sep 2022 17:46:56 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 718662027061;
        Tue, 20 Sep 2022 17:46:56 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 28KHkuXT025484;
        Tue, 20 Sep 2022 13:46:56 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 28KHktCx025480;
        Tue, 20 Sep 2022 13:46:56 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 20 Sep 2022 13:46:55 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Christoph Hellwig <hch@infradead.org>
cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Zdenek Kabelac <zkabelac@redhat.com>
Subject: Re: [dm-devel] [PATCH 4/4] brd: implement secure erase and write
 zeroes
In-Reply-To: <Yylr9g6B7Px6xBXb@infradead.org>
Message-ID: <alpine.LRH.2.02.2209201255500.21483@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2209151604410.13231@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2209160500190.543@file01.intranet.prod.int.rdu2.redhat.com> <Yylr9g6B7Px6xBXb@infradead.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Tue, 20 Sep 2022, Christoph Hellwig wrote:

> On Fri, Sep 16, 2022 at 05:00:46AM -0400, Mikulas Patocka wrote:
> > This patch implements REQ_OP_SECURE_ERASE and REQ_OP_WRITE_ZEROES on brd.
> > Write zeroes will free the pages just like discard, but the difference is
> > that it writes zeroes to the preceding and following page if the range is
> > not aligned on page boundary. Secure erase is just like write zeroes,
> > except that it clears the page content before freeing the page.
> 
> What is the use case of this?  And just a single overwrite is not what
> storage standards would consider a secure erase, but then again we
> don't really have any documentation or standards for the Linux OP,
> which strongly suggests not actually implementing it for now.

Without support for REQ_OP_WRITE_ZEROES, "blkdiscard -z" actually 
overwrites the ramdisk with zeroes and allocates all the blocks. 
Allocating all the blocks is pointless if we want to clear them.

I implemented REQ_OP_SECURE_ERASE just because it is similar to 
REQ_OP_WRITE_ZEROES. Unlike disks, DRAM has no memory of previous content, 
so a single overwrite should be OK. We could also flush cache in 
REQ_OP_SECURE_ERASE, but I don't know if Linux has any portable function 
that does it.

Mikulas

