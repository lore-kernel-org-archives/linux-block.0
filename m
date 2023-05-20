Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA14C77B7A
	for <linux-block@archiver.kernel.org>; Sat, 20 May 2023 09:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjETJ6y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 May 2023 05:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjETJ6x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 May 2023 05:58:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C7BE43;
        Sat, 20 May 2023 02:58:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B83B760F24;
        Sat, 20 May 2023 09:58:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBCCC433EF;
        Sat, 20 May 2023 09:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684576732;
        bh=VnKI4qZpFQ9iWa6k/mp6zpfQVgwf7YR8lVREgEuUKpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nnCgfXNAQMDsOlL7b/BDNfq5TwHq59PvGIgRTuMZYVDnwvjqm/YWZX0czQQ1e2z49
         /J5U1dh5au+vdE1JrKfcHwsYIqH78V6ss+32RyJ3A15wqgll/C7PpRlhKisNgjNzLZ
         ovH94Ksh8+iEac+E2ILRdGs3zdPltaMBxA600cx7j3z3lC34o9dZmsyq8bElsxewTI
         ZgnskiSOQTsDfGkqx2kxMIlZC0RJBDHVjJ5qsDqmLyJYYbMuKpzvLHnltCsx+63cJs
         bCaGf0IGoaclJtMBl2fYqF7PfsDpmpWR73r/BdkPHw3T5oEVydY1h3TiwtxBW3XtLY
         ezHTsPwziOQ8A==
Date:   Sat, 20 May 2023 11:58:45 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v21 30/30] iov_iter: Kill ITER_PIPE
Message-ID: <20230520-luftpolster-unzahl-4f257c43e2ac@brauner>
References: <20230520000049.2226926-1-dhowells@redhat.com>
 <20230520000049.2226926-31-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230520000049.2226926-31-dhowells@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 20, 2023 at 01:00:49AM +0100, David Howells wrote:
> The ITER_PIPE-type iterator was only used by generic_file_splice_read() and
> that has been replaced and removed.  This leaves ITER_PIPE unused - so
> remove it too.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: David Hildenbrand <david@redhat.com>
> cc: John Hubbard <jhubbard@nvidia.com>
> cc: linux-mm@kvack.org
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>
