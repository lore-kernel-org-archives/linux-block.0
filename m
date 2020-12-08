Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC38BC4361B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 01:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7770F23A50
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 01:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgLHBW5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Dec 2020 20:22:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36561 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726253AbgLHBW5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Dec 2020 20:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607390491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xOH63xXW4+sGWa4f3BUPNHTYv3qj8dsuPHdWc32K0kg=;
        b=XVwR1pNBE3ofUj1T0DfkBHktGdutmEiq72tE+lVYOzdVYtE7PG9A3/rdczPQ8xpS6I+9Ph
        nxXRwAYIxHRwtbT85J+5feNtIQWEDbg3Om1rUmKo0GDLiaQaZonskS9n41fG8WjQsFNSGJ
        L1G5y46HdZ7pBPvhfZSxLVWR+pL+GxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-w5RQKdeHP3O1GY6hs3-ARQ-1; Mon, 07 Dec 2020 20:21:29 -0500
X-MC-Unique: w5RQKdeHP3O1GY6hs3-ARQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C5B8107ACE3;
        Tue,  8 Dec 2020 01:21:28 +0000 (UTC)
Received: from T590 (ovpn-13-16.pek2.redhat.com [10.72.13.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D6FC31E5;
        Tue,  8 Dec 2020 01:21:21 +0000 (UTC)
Date:   Tue, 8 Dec 2020 09:21:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: add bio_iov_iter_nvecs for figuring out nr_vecs
Message-ID: <20201208012117.GA1059392@T590>
References: <20201201120652.487077-1-ming.lei@redhat.com>
 <3eb1020d-c336-dbe6-d75e-70c388464e6e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eb1020d-c336-dbe6-d75e-70c388464e6e@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 07, 2020 at 06:07:39PM +0000, Pavel Begunkov wrote:
> On 01/12/2020 12:06, Ming Lei wrote:
> > Pavel reported that iov_iter_npages is a bit heavy in case of bvec
> > iter.
> > 
> > Turns out it isn't necessary to iterate every page in the bvec iter,
> > and we call iov_iter_npages() just for figuring out how many bio
> > vecs need to be allocated. And we can simply map each vector in bvec iter
> > to bio's vec, so just return iter->nr_segs from bio_iov_iter_nvecs() for
> > bvec iter.
> > 
> > Also rename local variable 'nr_pages' as 'nr_vecs' which exactly matches its
> > real usage.
> > 
> > This patch is based on Mathew's post:
> 
> Tried this, the system didn't boot + discovered a filesystem blowned after
> booting with a stable kernel. That's on top of 4498a8536c816 ("block: use
> an xarray for disk->part_tbl"), which works fine. Ideas?

Is share any log to show the issue?

Can you share us the kernel .config? And what is your root disk? Not see
any issue on this kernel in my KVM test.


Thanks,
Ming

