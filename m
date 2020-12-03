Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B39BC64E7C
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 03:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9078221FB
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 03:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbgLCD16 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 22:27:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42343 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726201AbgLCD16 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Dec 2020 22:27:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606965991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GSCMWeunoUkckNWAVsBNgrPayok2tfQ8SIhYBHX0vuA=;
        b=TX3p09kXZEKjnoiB1V71t1z4C+8ScJggX3iqHF11DvOpkkcSfg4u/S4XLihPlsW0NROyg1
        Tc8SLX3Zwv5TcV/qm4OLCnktANs4WKculp1MspxO7T+n6rQwUZJn4yGo4gLST8U87Mu7S5
        HiTm+8CnxXr0y6nVFqlxEsMnmTjf/VI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-7W3sj6-_PwSKdBRWx9zGDQ-1; Wed, 02 Dec 2020 22:26:30 -0500
X-MC-Unique: 7W3sj6-_PwSKdBRWx9zGDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37B5EC280;
        Thu,  3 Dec 2020 03:26:29 +0000 (UTC)
Received: from T590 (ovpn-12-87.pek2.redhat.com [10.72.12.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BD8C5C1B4;
        Thu,  3 Dec 2020 03:26:13 +0000 (UTC)
Date:   Thu, 3 Dec 2020 11:26:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     axboe@kernel.dk, martin.petersen@oracle.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        jdorminy@redhat.com, bjohnsto@redhat.com
Subject: Re: [PATCH v2] block: use gcd() to fix chunk_sectors limit stacking
Message-ID: <20201203032608.GD540033@T590>
References: <20201130171805.77712-1-snitzer@redhat.com>
 <20201201160709.31748-1-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201160709.31748-1-snitzer@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 01, 2020 at 11:07:09AM -0500, Mike Snitzer wrote:
> commit 22ada802ede8 ("block: use lcm_not_zero() when stacking
> chunk_sectors") broke chunk_sectors limit stacking. chunk_sectors must
> reflect the most limited of all devices in the IO stack.
> 
> Otherwise malformed IO may result. E.g.: prior to this fix,
> ->chunk_sectors = lcm_not_zero(8, 128) would result in
> blk_max_size_offset() splitting IO at 128 sectors rather than the
> required more restrictive 8 sectors.

What is the user-visible result of splitting IO at 128 sectors?

I understand it isn't related with correctness, because the underlying
queue can split by its own chunk_sectors limit further. So is the issue
too many further-splitting on queue with chunk_sectors 8? then CPU
utilization is increased? Or other issue?

> 
> And since commit 07d098e6bbad ("block: allow 'chunk_sectors' to be
> non-power-of-2") care must be taken to properly stack chunk_sectors to
> be compatible with the possibility that a non-power-of-2 chunk_sectors
> may be stacked. This is why gcd() is used instead of reverting back
> to using min_not_zero().

I guess gcd() won't be better because gcd(a,b) is <= max(a, b), so bio
size is decreased much with gcd(a, b), and IO performance should be affected.
Maybe worse than min_not_zero(a, b) which is often > gcd(a, b).


Thanks,
Ming

