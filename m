Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185C7C77B7D
	for <linux-block@archiver.kernel.org>; Sat, 20 May 2023 09:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjETJOa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 May 2023 05:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjETJO3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 May 2023 05:14:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC50D1;
        Sat, 20 May 2023 02:14:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 130E160FAF;
        Sat, 20 May 2023 09:14:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FBEC433D2;
        Sat, 20 May 2023 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684574067;
        bh=VWYo/zrId8bi/ArfUMirZunxj8EOCtROc5ibvxwzPP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c+WzSc1rAfsiZoi3Jdu+ms5yzCVF8c/Dnn3bCNFBGqv/DDAGUoVUT4Tul3e1BBjP8
         SUY0x8OUvJz7+XMbCrrmAj+E5k4Fj52NA7EJP4pRJ47UDgZVWjpa29Ei9HRzj8knkn
         sLZT8isHaK8damZrH/Tgi7woimOkrwSJ7FCoYi2OXEdp+oYtvA2tqKP+pm6gqA0z5J
         Bz05Fd3c3ZcYSMnNIcD9m8dATvSE6jKH0wVmck3SPeoy5AxxTNUatmfHLs7ioJ3Mpn
         BLRrmR7u+ES70P5q8S/M6utY03FYWRaFIH1LA5HD4JbKo7LZl/tWnTNxJ0W1vAs50j
         MHWGh85L3AB5Q==
Date:   Sat, 20 May 2023 11:14:14 +0200
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
        Steve French <stfrench@microsoft.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v21 01/30] splice: Fix filemap of a blockdev
Message-ID: <20230520-bioladen-mitgift-7936402c233a@brauner>
References: <20230520000049.2226926-1-dhowells@redhat.com>
 <20230520000049.2226926-2-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230520000049.2226926-2-dhowells@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 20, 2023 at 01:00:20AM +0100, David Howells wrote:
> Fix filemap_splice_read() to use file->f_mapping->host, not file->f_inode,
> as the source of the file size because in the case of a block device,
> file->f_inode points to the block-special file (which is typically 0
> length) and not the backing store.
> 
> Fixes: 07073eb01c5f ("splice: Add a func to do a splice from a buffered file without ITER_PIPE")
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> cc: Steve French <stfrench@microsoft.com>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: David Hildenbrand <david@redhat.com>
> cc: John Hubbard <jhubbard@nvidia.com>
> cc: linux-mm@kvack.org
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>
