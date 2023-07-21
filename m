Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F69BEB64DD
	for <linux-block@archiver.kernel.org>; Fri, 21 Jul 2023 15:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjGUPMZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jul 2023 11:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjGUPMV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2023 11:12:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0890E3A8F
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 08:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689952262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6I/TR9khe0tvgU1kgdVsTvGXvVg17ybDMF1EKA4LK4k=;
        b=gzcJV+zG8gN3gcyTDMp21LgHB7UbTgkC4hcH1tRbKKLcjKQhkxxuvfcvwk852AysU0TJCi
        iIlzoo05CIp2bBnTU8oi0fghFChe7e0BmWDfAmNRyU8XiOrqSrv6MsiWBCEdQFj/yCbbDG
        gr/pC2CEYq1uDZ8GZR5ZTdQj88MYc58=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-Bt1tuMdjN1G3JK__evfSWA-1; Fri, 21 Jul 2023 11:10:59 -0400
X-MC-Unique: Bt1tuMdjN1G3JK__evfSWA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F657936D26;
        Fri, 21 Jul 2023 15:10:58 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E15F2166B25;
        Fri, 21 Jul 2023 15:10:58 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id A75C33096A42; Fri, 21 Jul 2023 15:10:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id A635C3F7CF;
        Fri, 21 Jul 2023 17:10:56 +0200 (CEST)
Date:   Fri, 21 Jul 2023 17:10:56 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
cc:     Li Nan <linan666@huaweicloud.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH v2 0/3] brd discard patches
In-Reply-To: <6f0b9cbb-6752-6dd8-c184-10798533dfed@kernel.dk>
Message-ID: <67d28762-d41a-4f67-7e11-de7040bfb369@redhat.com>
References: <9933f5df-dd43-3447-dce3-f513368578@redhat.com> <6f0b9cbb-6752-6dd8-c184-10798533dfed@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Fri, 21 Jul 2023, Jens Axboe wrote:

> On 7/21/23 7:48?AM, Mikulas Patocka wrote:
> > This is a new version of the brd discard patches.
> 
> Can you please:
> 
> 1) Ensure that your postings thread properly, it's all separate emails
>    and the patches don't nest under the cover letter parent.

I use alpine. I was testing it - and it turns out that when I delete the 
last character in the "Subject" field, it deletes the field "In-Reply-To" 
from the header. This must be some new bug/feature - it didn't do it in 
the past.

I'll try to be more careful to not make the "Subject" field empty when 
sending patches.

> 2) Include a changelog. What changed since v1?
> 
> -- 
> Jens Axboe

ChangeLog:

* Batch discarded pages into the "free_page_batch" structure and free all 
  of them with just one "call_rcu" call. In case of allocation failure, 
  fall back to per-page "call_rcu" calls. (suggested by Christoph Hellwig)

* Make the module parameter "/sys/module/brd/parameters/discard"  
  changeable at runtime. Changing it will iterate over all ramdisk devices 
  and call brd_set_discard_limits on them to enable or disable discard.
  (suggested by Christoph Hellwig)

* Use "switch (bio_op(bio))" in brd_submit_bio, so that the code looks 
  better. (suggested by Chaitanya Kulkarni)

* do "bio->bi_status = BLK_STS_NOTSUPP" in brd_submit_bio if unknown type 
  of bio is received.

Mikulas

