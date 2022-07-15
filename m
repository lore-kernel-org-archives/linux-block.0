Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D71C43334
	for <linux-block@archiver.kernel.org>; Fri, 15 Jul 2022 01:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239183AbiGOBNP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 21:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiGOBNO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 21:13:14 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43AE60681
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 18:13:13 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26F1AvlW002826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 21:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1657847459; bh=yxhN6FuXs3hDSsDmqji0U/lzEr2L0wIS9xKwls5+VjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=KA3Nx1alW+RPtLgC7LGgm9Bf5TFeUmpCQMsCFqs8HbKiMeCOrr5p77bbNY4CKekeb
         fqvYYO3w/NvNJt9eJGRXfrzqCh0jWOUtLY2ICS/OtPpCE53j8OilCE1RTK9/SUBxiA
         m5JC8q+6n6n1iZYscbNvSlkuS2AKCLMzf+CcB1QuhsmNLPb4G6bT20odeE/zGXynIv
         r5ewk0/89337tM49yCwdTfZ0klIaenj7m88phUolr7rvm6WMYn9o9ZB6rwRrtMEcyN
         9AmPHkvI4jFQmWab9Jz/nfL+GGVoi8GAeC12XEfZZggHDxeaNYsS6S0AjMrchOBVWD
         1wXgdKWvUIPNg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9FD2915C003C; Thu, 14 Jul 2022 21:10:57 -0400 (EDT)
Date:   Thu, 14 Jul 2022 21:10:57 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH v3 56/63] fs/jbd2: Fix the documentation of the
 jbd2_write_superblock() callers
Message-ID: <YtC+oRrpbyscTHKg@mit.edu>
References: <20220714180729.1065367-1-bvanassche@acm.org>
 <20220714180729.1065367-57-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714180729.1065367-57-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 14, 2022 at 11:07:22AM -0700, Bart Van Assche wrote:
> Commit 2a222ca992c3 ("fs: have submit_bh users pass in op and flags
> separately") renamed the jbd2_write_superblock() 'write_op' argument into
> 'write_flags'. Propagate this change to the jbd2_write_superblock()
> callers. Additionally, change the type of 'write_flags' into blk_opf_t.
> 
> Cc: Mike Christie <michael.christie@oracle.com>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Acked-by: Theodore Ts'o <tytso@mit.edu>
