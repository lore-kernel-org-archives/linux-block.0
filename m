Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7C6C433EF
	for <linux-block@archiver.kernel.org>; Tue, 11 Jan 2022 08:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbiAKIg1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jan 2022 03:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236083AbiAKIgZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jan 2022 03:36:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642B1C06173F
        for <linux-block@vger.kernel.org>; Tue, 11 Jan 2022 00:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oHDEhEL+vIEHUOXhbdgu94qlPv7SV51/WTi7X5zK45o=; b=sD/HN0I7GX/ypynJOsjG07nomi
        qHP+oHR1CusXf53DGCx3qGCGTTFqfDT5zxQ0hIB/l8MMKnhQFjZKBSMWvRL2lT3o0UxilwDtqQDdX
        aAp3kSJrGt34kXesYbVXVl0SoCakEN1F8YGYkTZnmXVqKNFbxumoIRRpo0TZ2pJY9WL6d8BqwV6As
        8h831fXlvHpyC/eS1yUi6LAnlOAmnrodk/6MD4kqxnM/XURuHeACt9qGor8gfGFNp7sDii/iAVk1s
        N7+TjcF/ns7nn4/zOnmJrEn+L0vaBKf/JJqN+DMyC6SQ1K6Ryox9rDFL6yS6AJk94ukuNtHjScexo
        gaySM+ww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7CdY-00FLJc-Ty; Tue, 11 Jan 2022 08:36:12 +0000
Date:   Tue, 11 Jan 2022 00:36:12 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        lining <lining2020x@163.com>, Tejun Heo <tj@kernel.org>,
        Chunguang Xu <brookxu@tencent.com>
Subject: Re: [dm-devel] [PATCH 1/2] block: add resubmit_bio_noacct()
Message-ID: <Yd1BfGXzmnXr1+Js@infradead.org>
References: <20220110075141.389532-1-ming.lei@redhat.com>
 <20220110075141.389532-2-ming.lei@redhat.com>
 <YdxuWlZAPJkPyr3h@infradead.org>
 <YdyC9KpQ7yC3l7RZ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdyC9KpQ7yC3l7RZ@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 10, 2022 at 02:03:16PM -0500, Mike Snitzer wrote:
> Ming is lifting code out of __blk_queue_split() for reuse (by DM in
> this instance, because it has its own bio_split+bio_chain).
> 
> Are you saying submit_bio_noacct() should be made to call
> blk_throtl_charge_bio_split() and blk_throtl_charge_bio_split() simply
> return if not a split bio? (not sure bio has enough context to know,
> other than looking at some side-effect change from bio_chain)

Yes.
