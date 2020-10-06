Return-Path: <SRS0=/MU2=DN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9365C41604
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 07:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CA9120760
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 07:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbZ0KgXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgJFHlS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Oct 2020 03:41:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28185 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726670AbgJFHlS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Oct 2020 03:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601970077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eFC0ISn2+rWqsHgSwE4sZ0+UQ3DhHxUZGAadpsJBkLw=;
        b=HbZ0KgXg7ZHibs438bH4h/9Nri0vQlJ6f8masGM9ykU2bTGyqVgaYRILeXPy1BH8IwH68G
        kkjjQ5pSOdO63lXrnN5YyRYYK3K6urvHWeORbGQYh2pOwGX5rEigIdA22vl6e27TZn7UcE
        3G+TnKlqnMYcCd7JOT38Vk5k6clcvrM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-JKwoqOqxNom9jlTPhAa4hQ-1; Tue, 06 Oct 2020 03:41:15 -0400
X-MC-Unique: JKwoqOqxNom9jlTPhAa4hQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC3AE1868411;
        Tue,  6 Oct 2020 07:41:13 +0000 (UTC)
Received: from T590 (ovpn-12-63.pek2.redhat.com [10.72.12.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C4C5755767;
        Tue,  6 Oct 2020 07:41:04 +0000 (UTC)
Date:   Tue, 6 Oct 2020 15:41:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Veronika Kabatova <vkabatov@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V7 0/2] percpu_ref & block: reduce memory footprint of
 percpu_ref in fast path
Message-ID: <20201006074100.GA26059@T590>
References: <20201001154842.26896-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001154842.26896-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 01, 2020 at 11:48:40PM +0800, Ming Lei wrote:
> Hi,
> 
> The 1st patch removes memory footprint of percpu_ref in fast path
> from 7 words to 2 words, since it is often used in fast path and
> embedded in user struct.
> 
> The 2nd patch moves .q_usage_counter to 1st cacheline of
> 'request_queue'.
> 
> Simple test on null_blk shows ~2% IOPS boost on one 16cores(two threads
> per core) machine, dual socket/numa.
> 
> V7:
> 	- add comments about reason for struct split

Hello Jens

Can you consider to merge the patchset in block tree if you are fine?


Thanks,
Ming

