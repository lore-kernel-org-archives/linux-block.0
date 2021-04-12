Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF15C433ED
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 11:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35B6261244
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 11:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237829AbhDLLiN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:38:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237792AbhDLLiM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 07:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618227474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w2hnPn4HUXfElyza3VitfbH0dkgzl9q6e/H7BJzZDiU=;
        b=OatX+abjdn/CWNcZG0rmROdzNMIpcGpdyNMbsXXK2if1VBlIf0jJbBYJUjKtaR8nksRqoJ
        VdgRkPhZC5KyGPtc6873HxmCHKmMOzENBYc9zIsX0+PFHExj+TgDZ/p3alWgtAxPsCrfEy
        TZHR1zXSsvCLavtenh+f+wYp468uW7M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-hC1J342ANrSFd-oeeZcDBw-1; Mon, 12 Apr 2021 07:37:51 -0400
X-MC-Unique: hC1J342ANrSFd-oeeZcDBw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9BA264157;
        Mon, 12 Apr 2021 11:37:49 +0000 (UTC)
Received: from T590 (ovpn-12-111.pek2.redhat.com [10.72.12.111])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ABF7B5D6DC;
        Mon, 12 Apr 2021 11:37:35 +0000 (UTC)
Date:   Mon, 12 Apr 2021 19:37:31 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V5 07/12] block: prepare for supporting bio_list via
 other link
Message-ID: <YHQw+3Sp7HqmTCng@T590>
References: <20210401021927.343727-1-ming.lei@redhat.com>
 <20210401021927.343727-8-ming.lei@redhat.com>
 <20210412101805.GB993044@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412101805.GB993044@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 12, 2021 at 11:18:05AM +0100, Christoph Hellwig wrote:
> I'd so something s/prepare for supporting/support using/ for the title.
> Can't say I like spreading the bio_list even more.
> 
> Btw, what uses bi_next for the bios that are being polled?

.bi_next is used for io merge after the bio is submitted to request
queue, so we can't reuse it.

-- 
Ming

