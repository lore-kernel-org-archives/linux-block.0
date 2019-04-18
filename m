Return-Path: <SRS0=aY0t=SU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F181BC282DA
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 02:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB4A217F9
	for <linux-block@archiver.kernel.org>; Thu, 18 Apr 2019 02:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387811AbfDRCaV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Apr 2019 22:30:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33851 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732737AbfDRCaV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Apr 2019 22:30:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A4846C057F4C;
        Thu, 18 Apr 2019 02:30:20 +0000 (UTC)
Received: from ming.t460p (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EDFB219C58;
        Thu, 18 Apr 2019 02:30:10 +0000 (UTC)
Date:   Thu, 18 Apr 2019 10:30:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, stefanha@redhat.com,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2] block: bio_map_user_iov should not be limited to
 BIO_MAX_PAGES
Message-ID: <20190418023004.GC9520@ming.t460p>
References: <20190417115207.30202-1-pbonzini@redhat.com>
 <20190418021903.GB9520@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418021903.GB9520@ming.t460p>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 18 Apr 2019 02:30:20 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 18, 2019 at 10:19:04AM +0800, Ming Lei wrote:
> Hi Paolo,
> 
> On Wed, Apr 17, 2019 at 01:52:07PM +0200, Paolo Bonzini wrote:
> > Because bio_kmalloc uses inline iovecs, the limit on the number of entries
> > is not BIO_MAX_PAGES but rather UIO_MAXIOV, which indeed is already checked
> > in bio_kmalloc.  This could cause SG_IO requests to be truncated and the HBA
> > to report a DMA overrun.
> 
> BIO_MAX_PAGES only limits the single bio's max vector number, if one bio
> can't hold all user space request, new bio will be allocated and appended
> to the passthrough request if queue limits aren't reached.
> 
> So I understand SG_IO request shouldn't be truncated because of
> BIO_MAX_PAGES, or could you explain it in a bit detail or provide
> a reproducer?
> 
> > 
> > Note that if the argument to iov_iter_npages were changed to UIO_MAXIOV,
> > we would still truncate SG_IO requests beyond UIO_MAXIOV pages.  Changing
> > it to UIO_MAXIOV + 1 instead ensures that bio_kmalloc notices that the
> > request is too big and blocks it.
> 
> We should pass UIO_MAXIOV instead of UIO_MAXIOV + 1, otherwise bio_kmalloc()
> will fail. Otherwise, the patch looks fine, but shouldn't be a fix if my
> above analysis is correct.

Also we have enabled multipage bvec for passthough IO[1], we shouldn't
need to allocate so big max io vectors any more, and actually the reasonable
number is (PAGE_SIZE - sizeof(struct bio)) / sizeof(struct bio_vec), then we
can avoid to stress mm for high order allocation.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.2/block&id=489fbbcb51d0249569d863f9220de69cb31f1922

Thanks,
Ming
