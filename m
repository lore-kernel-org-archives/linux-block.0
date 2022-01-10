Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729B4C433F5
	for <linux-block@archiver.kernel.org>; Mon, 10 Jan 2022 02:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238246AbiAJCsP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Jan 2022 21:48:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41039 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232727AbiAJCsN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 9 Jan 2022 21:48:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641782892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KrglM2NWtDVe++umyUwnBpcL+XhJ2OWtddTl131Ve9U=;
        b=RzHHDDVLCYYVAEQyQZSxXdi0vEtY5exFqW+GrcBSSK8O4FqQykI1P6qbSQk3XVUTsm6NBn
        M0WUhcTxymRNdcrqCOHidsPe7qAxxEEOR0+bi783VlqCq8rnKsfnWqqJVSLEXg+qMPy8Bn
        +aLcsOdKiYW0a2gFQPIvY4XEeiAFOAk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-goC6VtdoOnumf6DBjXigcA-1; Sun, 09 Jan 2022 21:48:09 -0500
X-MC-Unique: goC6VtdoOnumf6DBjXigcA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2A0C1083F60;
        Mon, 10 Jan 2022 02:48:08 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8ABFBE709;
        Mon, 10 Jan 2022 02:48:00 +0000 (UTC)
Date:   Mon, 10 Jan 2022 10:47:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Martin Wilck <martin.wilck@suse.com>
Subject: Re: [PATCH] lib/sbitmap: kill 'depth' from sbitmap_word
Message-ID: <YdueWjYzHVP1bkU0@T590>
References: <20220110015007.326561-1-ming.lei@redhat.com>
 <020ba538-bb41-c827-1290-c2939bf8940c@kernel.dk>
 <YducMfW4vhk15CMq@T590>
 <8e24bd70-a817-ff8d-c59a-3e998e5cb869@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e24bd70-a817-ff8d-c59a-3e998e5cb869@kernel.dk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jan 09, 2022 at 07:43:26PM -0700, Jens Axboe wrote:
> On 1/9/22 7:38 PM, Ming Lei wrote:
> > On Sun, Jan 09, 2022 at 06:54:21PM -0700, Jens Axboe wrote:
> >> On 1/9/22 6:50 PM, Ming Lei wrote:
> >>> Only the last sbitmap_word can have different depth, and all the others
> >>> must have same depth of 1U << sb->shift, so not necessary to store it in
> >>> sbitmap_word, and it can be retrieved easily and efficiently by adding
> >>> one internal helper of __map_depth(sb, index).
> >>>
> >>> Not see performance effect when running iops test on null_blk.
> >>>
> >>> This way saves us one cacheline(usually 64 words) per each sbitmap_word.
> >>
> >> We probably want to kill the ____cacheline_aligned_in_smp from 'word' as
> >> well.
> > 
> > But sbitmap_deferred_clear_bit() is called in put fast path, then the
> > cacheline becomes shared with get path, and I guess this way isn't
> > expected.
> 
> Just from 'word', not from 'cleared'. They will still be in separate
> cache lines, but usually doesn't make sense to have the leading member
> marked as cacheline aligned, that's a whole struct property at that
> point.

OK, got it, it is just sort of code style thing, and not any functional
change.

Will include it in V2.


Thanks,
Ming

