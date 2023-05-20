Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E430BC7EE2A
	for <linux-block@archiver.kernel.org>; Sat, 20 May 2023 09:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjETJjg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 May 2023 05:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjETJjf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 May 2023 05:39:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2B51BD;
        Sat, 20 May 2023 02:39:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77A0860A6C;
        Sat, 20 May 2023 09:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E075C433D2;
        Sat, 20 May 2023 09:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684575573;
        bh=u+XokJXJqqWsxP3R/qKZwNbpDIsXwkbgPE+7cCEi5+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C5yabXkEj7EhC8yxQ6eikd9gU/GWKBSoj3yVXwPE1+J05/0n9c4I6o9AbLMfSm7gR
         StV/f5oSbkM3NwtWKHs0m5OIPj66YN1Cb2n2oT/k6ZOweNyp2Dqil3WY7TJeQ9fCxR
         RqY0YpXNOz8AmGF26SQZvTmoWT3YgxaJ9UkETKjQH33BpCHmagWzpbPMCbY76M8RNd
         I4oXSpz+kG8vAdoBC8oARR1nMu3c4q2zVFj4iMV+9VEZfvbJPfbDTIwG61Oc71Rg/v
         pzdPTE4ikoxokxMYS81mUEsCJ5BCGOy83EpomcJ7jtZGQhNc8jlP4sJ+fV+kjYXoXE
         7jCzJRFUNurBQ==
Date:   Sat, 20 May 2023 11:39:27 +0200
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
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v21 07/30] splice: Make splice from an O_DIRECT fd use
 copy_splice_read()
Message-ID: <20230520-ethisch-wahlabend-1b7d9cf4dd13@brauner>
References: <20230520000049.2226926-1-dhowells@redhat.com>
 <20230520000049.2226926-8-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230520000049.2226926-8-dhowells@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 20, 2023 at 01:00:26AM +0100, David Howells wrote:
> Make a read splice from a file descriptor that's open O_DIRECT use
> copy_splice_read() to do the reading as filemap_splice_read() is unlikely
> to find any pagecache to splice.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-mm@kvack.org
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>
