Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027F4C433ED
	for <linux-block@archiver.kernel.org>; Mon, 17 May 2021 07:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCAC1611C2
	for <linux-block@archiver.kernel.org>; Mon, 17 May 2021 07:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbhEQHQ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 May 2021 03:16:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40708 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235153AbhEQHPt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 May 2021 03:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621235631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bLpYPqby8RHSHW0nrMHtogamAr59ozHF8RqtPLRMm6I=;
        b=htfysKtgVDyQc8Lf23DmTWE0KhdyiGCho7J/yfGg3jlkNI3MRncYwIzeYIg6TAd5WQeZNl
        2uUX4mwP9HTjl9TwPnZDrGQ70lFLc3QZHG24TCCi4KIYK625jnF0HDNW/BzTpqRAdZ/9vX
        Yjn1xKNsccyregmb/l3+dSqjFgDtcTo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-GwUdUN8NNF6TAbZjTQ4imw-1; Mon, 17 May 2021 03:13:49 -0400
X-MC-Unique: GwUdUN8NNF6TAbZjTQ4imw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A5641007476;
        Mon, 17 May 2021 07:13:48 +0000 (UTC)
Received: from T590 (ovpn-13-194.pek2.redhat.com [10.72.13.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C917970591;
        Mon, 17 May 2021 07:13:34 +0000 (UTC)
Date:   Mon, 17 May 2021 15:13:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V6 00/12] block: support bio based io polling
Message-ID: <YKIXmRTmLlAgO3AK@T590>
References: <20210422122038.2192933-1-ming.lei@redhat.com>
 <630a63ef-f9e0-6ad6-d6be-ec7a46e5ec45@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <630a63ef-f9e0-6ad6-d6be-ec7a46e5ec45@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi JeffleXu,

On Mon, May 17, 2021 at 02:16:39PM +0800, JeffleXu wrote:
> Hi all,
> 
> What's the latest progress of this bio-based polling feature?
> 
> I've noticed that hch has also sent a patch set on this [1]. But as far
> as I know, hch's patch set only refactors the interface of polling in
> the block layer. It indeed helps bio-based polling for some kind of
> bio-based driver, but for DM/MD where one bio could be mapped to several
> split bios, more work is obviously needed, just like Lei Ming's
> io_context related code in this patch set.
> 
> hch may have better idea, after all [1] is just a preparation patch set.

Yeah, we have to rebase V6 against Christoph's patchset anyway.

Looks there is at least two approaches left for us:

1) keep the generic approach in V6, just rebase after Christoph's patch
is finalized

2) support io polling simply in bio driver, since bio->bi_cookie is
assigned for underlying bio, and it shouldn't be very difficult to
support that in DM/MD. I have been thinking of it a while, but not
coding it yet. BTW, all underlying bios can be linked to DM
bio->bi_next, and we can add one new callback of .io_poll for polling
DM/MD's bio.


Thanks,
Ming

