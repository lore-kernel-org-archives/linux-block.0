Return-Path: <SRS0=VsgY=DB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDE2C4363D
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 00:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5970523119
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 00:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJ7+7aWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgIXA50 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Sep 2020 20:57:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43245 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726537AbgIXA50 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Sep 2020 20:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600909045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rikegsLFUdwOOfXAubnEnzl9Ex6jmfKrccMFmkXnxKY=;
        b=XJ7+7aWJ3owN3PNe3rgOh563bQAnFmqAGYerqeu0/QUDZxGuH53RXgyATXe0PEu0PasGIP
        2C5XPZv+I59ABiroVXtO5/WT8HygefWx+M7Khw0dfl83WBJIPqEBx1fz61BpG/Od5VqpS7
        SMFHXlhbPxR3xFG0MsQDgaMoIIUwU+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-HxzyZ2VBMvSuCciobYGnAw-1; Wed, 23 Sep 2020 20:57:23 -0400
X-MC-Unique: HxzyZ2VBMvSuCciobYGnAw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37AC410059A8;
        Thu, 24 Sep 2020 00:57:22 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EF71C7368E;
        Thu, 24 Sep 2020 00:57:18 +0000 (UTC)
Date:   Wed, 23 Sep 2020 20:57:18 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Miaohe Lin <linmiaohe@huawei.com>, dm-devel@redhat.com,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v2 2/3] block: make blk_crypto_rq_bio_prep() able to fail
Message-ID: <20200924005717.GC10500@redhat.com>
References: <20200916035315.34046-1-ebiggers@kernel.org>
 <20200916035315.34046-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916035315.34046-3-ebiggers@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 15 2020 at 11:53pm -0400,
Eric Biggers <ebiggers@kernel.org> wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> blk_crypto_rq_bio_prep() assumes its gfp_mask argument always includes
> __GFP_DIRECT_RECLAIM, so that the mempool_alloc() will always succeed.
> 
> However, blk_crypto_rq_bio_prep() might be called with GFP_ATOMIC via
> setup_clone() in drivers/md/dm-rq.c.
> 
> This case isn't currently reachable with a bio that actually has an
> encryption context.  However, it's fragile to rely on this.  Just make
> blk_crypto_rq_bio_prep() able to fail.
> 
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Suggested-by: Satya Tangirala <satyat@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

