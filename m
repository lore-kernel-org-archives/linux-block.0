Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9F1C433DB
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 18:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24F4522B45
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 18:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389014AbhAUR7U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 12:59:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45610 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389555AbhAUR7H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 12:59:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611251860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HG4irhfn4oEG/iLaQU1q1wTcc/lkE9nC/pVSM0xYQyA=;
        b=G7kTDlxHNonwq7UiEQKa8AZRNAoU9Ag4NMpMxNWXI54fg+CC6MvIMCV0sBhiZiIcgw+qhn
        Le9znAgn2qEKUAJWrdLToMg3RXuD5B60EZJP9iG1znrhzYHsQ2l/FjCvI95NJfohzADElc
        PgoTNSPKH5r0MHLlTiv3nBpqgSSSn2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-zMzoYKuDPGK_cA4uAJ2lUQ-1; Thu, 21 Jan 2021 12:57:38 -0500
X-MC-Unique: zMzoYKuDPGK_cA4uAJ2lUQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95F5480A5C4;
        Thu, 21 Jan 2021 17:57:37 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 450F460C43;
        Thu, 21 Jan 2021 17:57:34 +0000 (UTC)
Date:   Thu, 21 Jan 2021 12:57:33 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     mwilck@suse.com, Hannes Reinecke <hare@suse.de>,
        Alasdair G Kergon <agk@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: Re: [PATCH v2] dm: avoid filesystem lookup in dm_get_dev_t()
Message-ID: <20210121175733.GB4180@redhat.com>
References: <20210121175056.20078-1-mwilck@suse.com>
 <20210121175339.GA828@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121175339.GA828@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 21 2021 at 12:53pm -0500,
Christoph Hellwig <hch@lst.de> wrote:

> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Mike, Jens - can we make sure this goes in before branching off the
> block branch for 5.12?  I have some work pending that would otherwise
> conflict.

Sure, I'll do my part to get this fix staged now and sent to Linus
(likely tomorrow) for 5.11-rc5.

Thanks,
Mike

