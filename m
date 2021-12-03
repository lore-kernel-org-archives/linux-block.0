Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B47AC433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 02:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350014AbhLCCka (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Dec 2021 21:40:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52889 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235868AbhLCCka (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Dec 2021 21:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638499026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cUmqcFXaJLqAnlPBUxGnNVcTZaJNix4zhFJS3I1qJQw=;
        b=aTm8+u25f+/2Po6EHUJteATbIhy69dZT27a4Tf2VQas+SO3gFkRlBw+lWHmQkFlJHW5u23
        0IsOuUIrwewoxRPkdmvUZ/WAxXiwgmpV6+XT1cLuRvE9UmDhuye3MYcKlI4Hj35FCZlmRc
        NLTjt7PIKv65zV2kQhhtKWXZAaQh71E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-QKAfUyAOMqyl-fPake4Bng-1; Thu, 02 Dec 2021 21:37:05 -0500
X-MC-Unique: QKAfUyAOMqyl-fPake4Bng-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4531801B10;
        Fri,  3 Dec 2021 02:37:03 +0000 (UTC)
Received: from T590 (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E1EA2100EBAD;
        Fri,  3 Dec 2021 02:36:06 +0000 (UTC)
Date:   Fri, 3 Dec 2021 10:36:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH 2/2] block: fix double bio queue when merging in cached
 request path
Message-ID: <YamCkkHUDluZLDxE@T590>
References: <20211202194741.810957-1-axboe@kernel.dk>
 <20211202194741.810957-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202194741.810957-3-axboe@kernel.dk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 02, 2021 at 12:47:41PM -0700, Jens Axboe wrote:
> When we attempt to merge off the cached request path, we return NULL
> if successful. This makes the caller believe that it's should allocate
> a new request, and hence we end up with the bio both merged and associated
> with a new request. This, predictably, leads to all sorts of crashes.
> 
> Pass in a pointer to the bio pointer, and clear it for the merge case.
> Then the caller knows that the bio is already queued, and no new requests
> need to get allocated.
> 
> Fixes: 5b13bc8a3fd5 ("blk-mq: cleanup request allocation")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Io hang in io_uring workload can't be triggered any more with this
patch:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


-- 
Ming

