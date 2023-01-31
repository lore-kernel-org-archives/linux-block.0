Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78931C636D3
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 01:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjAaBx0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Jan 2023 20:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjAaBxZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2023 20:53:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A77827D74
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 17:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675129957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J2VT+eU2grpu/3NrzMJ97GWGdrcNSw3JIMVGL0+uYxM=;
        b=g69DN5OxVIh0lwn5/b0KvLgKYEcrSAysCLZYelKxv1Z5C2o1tfZcKs1A+lzmnlIpksJ5f1
        wmfyh1w0VILloFUmYjDan9mlVbwXQZAWaFsmkAf8zQXdg7Tp/o8pEvEwhlAMr1Nc6WoA2V
        s8/k3prcUAq7hHY0XJWGNLYu4uI2irM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-BYGBruE7OASbkXXoyLmy4w-1; Mon, 30 Jan 2023 20:52:34 -0500
X-MC-Unique: BYGBruE7OASbkXXoyLmy4w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39F66101A521;
        Tue, 31 Jan 2023 01:52:34 +0000 (UTC)
Received: from T590 (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BE8862166B26;
        Tue, 31 Jan 2023 01:52:30 +0000 (UTC)
Date:   Tue, 31 Jan 2023 09:52:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, ming.lei@redhat.com
Subject: Re: [PATCH] block: Revert "let blkcg_gq grab request queue's refcnt"
Message-ID: <Y9h0WMOqNau4s0c0@T590>
References: <20230130232257.972224-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130232257.972224-1-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart,

On Mon, Jan 30, 2023 at 03:22:57PM -0800, Bart Van Assche wrote:
> Since commit 0a9a25ca7843 ("block: let blkcg_gq grab request queue's
> refcnt") for many request queues the reference count drops to 1 when
> the request queue is destroyed instead of to 0. In other words, the
> request queue is leaked. Fix this by reverting that commit.

When/where you observe that the reference count drops to 1 instead of 0?

Do you have kmem leak log?

Probably, the last drop is in blkg_free_workfn().


Thanks, 
Ming

