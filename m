Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5D4C7EE23
	for <linux-block@archiver.kernel.org>; Sat, 20 May 2023 09:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjETJij (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 May 2023 05:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjETJij (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 May 2023 05:38:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E86CE42;
        Sat, 20 May 2023 02:38:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B034260B61;
        Sat, 20 May 2023 09:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22513C433D2;
        Sat, 20 May 2023 09:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684575517;
        bh=UITJqkbSRLqe3fEc/QtOwUE1guoZf/bbfzKL1AjylCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Od+Lz2YNHLKcVu5WN/P/qKOOjTtun4t+C1+WmsiHvDKiyi/1YD4kjk8JDMk8rRSQx
         pdzF6X4a3RaH7ynOSdzubf/a1Xc6ke7xyG2nZLvFD1dHmy9N99YZ05G4Ja6y4rSt0Z
         5DMiQSN5Z/CTXeog+M63zW2PSvdYJo4WPsaFRqfdlS4ret+Hph34fjQF9Wup2qVtJe
         UPwZC2A52ZJrU06wIZCHJIEBzpdW1cD/I8UMb+qCLjd5Lk5YLyjJfIWJ+MgCXvZv5V
         3LNN8QZa7HJ+92sBouqJiE/Dh1+rRWZKw05yYnv/nV+m/PESmveuYRRJCQSBav0lRM
         XDtMHCv4eXGqg==
Date:   Sat, 20 May 2023 11:38:30 +0200
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
Subject: Re: [PATCH v21 06/30] splice: Check for zero count in
 vfs_splice_read()
Message-ID: <20230520-zweieinhalb-erfragen-f9cce7c16e0c@brauner>
References: <20230520000049.2226926-1-dhowells@redhat.com>
 <20230520000049.2226926-7-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230520000049.2226926-7-dhowells@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 20, 2023 at 01:00:25AM +0100, David Howells wrote:
> Make vfs_splice_read() return immediately if the length is 0.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>
