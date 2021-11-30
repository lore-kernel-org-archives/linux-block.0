Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0316C433EF
	for <linux-block@archiver.kernel.org>; Tue, 30 Nov 2021 12:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhK3NCf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Nov 2021 08:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbhK3NCe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Nov 2021 08:02:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14564C06174A
        for <linux-block@vger.kernel.org>; Tue, 30 Nov 2021 04:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S4VA4ySJ90n0DUiSF0kpsAQkDhrJExTLW8RLP14M7Y4=; b=2TnKrOcnqyIdLD7sJNMRZt0eCa
        7SVukTVTWmS7qlm3NxRm2mM64J4B9YMxwGgzZWKvpNPTF1gF/UqlsYBeFKKT+5oO88XFy6ZXFnY4h
        C7XuCnshST6+PEl3NeUT8Ayk+V3oyG0bLzjRYwjZMwnjmqLJ3r7roM6Kn6BdbKaDuCRRzp2gvCtku
        4Ai+1EqrcXCTTFhR0K1vDY2aXQ5kHhAraq1ckDZPc5BG75by2zCpbZYWT6wJzSIh7R1lG2igCxHT7
        YJJXPsnMzbHM5QDCkJCNX1hKJ1FiFqK/a/ObOQRtTspE0PMJehh5gudj151t9Uu/c19o+z4T/hB7p
        n9neWa2A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ms2j4-005CKb-NY; Tue, 30 Nov 2021 12:59:14 +0000
Date:   Tue, 30 Nov 2021 04:59:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] loop: replace loop_validate_mutex with
 loop_validate_spinlock
Message-ID: <YaYgIrQYhLXQUgii@infradead.org>
References: <84a861dc-6d50-81c0-8e8b-461ef59f4c01@i-love.sakura.ne.jp>
 <fffda32f-848a-712b-f50e-8a6d7d086039@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fffda32f-848a-712b-f50e-8a6d7d086039@i-love.sakura.ne.jp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Please post new versions of a patch in a separate thread from the
original one.

> +static bool loop_try_update_state_locked(struct loop_device *lo, const int old, const int new)

Pleae avoid the overly long line.

Also passing arguments as const is a little weird.

>  {
> +	bool ret = false;
>  
> +	lockdep_assert_held(&lo->lo_mutex);
> +	spin_lock(&loop_validate_spinlock);
> +	if (lo->lo_state == old) {
> +		lo->lo_state = new;
> +		ret = true;
>  	}
> +	spin_unlock(&loop_validate_spinlock);
> +	return ret;

But I really wonder what the point of this helper is.  IMHO it would be
much easier to follow if it was open coded in the functions that update
the state (that is without the loop_try_update_state helper as well).

But going one step further:  What is protected by loop_validate_spinlock
and what is protected by lo->lo_mutex now?  Or in other words, if we
decided the lo_state is protected by loop_validate_spinlock why do we
even need lo_mutex here now?
