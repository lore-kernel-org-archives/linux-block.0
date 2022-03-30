Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F155C433EF
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 15:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347703AbiC3PER (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Mar 2022 11:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344524AbiC3PEQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Mar 2022 11:04:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00504DF5D
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 08:02:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A04531F37B;
        Wed, 30 Mar 2022 15:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648652550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hSvx/jwnDEMpOpOcIUnC5TadP/nNxMZQ+fITqf7JB+s=;
        b=hAREkiaXFkP+E2UlHxKgvvrJ1aFM5upJjTbX2UvAL82643ACtcy+jvp/Jf6yr/y3V6z/y/
        nhZ2OkdGt2fAQ+Q4yQ+kcFsyO7HPvcf/tHxHJMtrsAjpKjeI5UqUfgMxM7BiB7Isdz80zS
        ahAoLw/NsQyVBkh+4SY8j8zasM/hY1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648652550;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hSvx/jwnDEMpOpOcIUnC5TadP/nNxMZQ+fITqf7JB+s=;
        b=RIKKW3hoxJHvf0/mN+zDC2TZnoBJjL7Yi6JnSZLICp+sg2aAxKYfYkIE0PccrID6YdcKHt
        B4T7J7t8r4qG8vCQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8FF6BA3B83;
        Wed, 30 Mar 2022 15:02:30 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0A63DA0610; Wed, 30 Mar 2022 17:02:30 +0200 (CEST)
Date:   Wed, 30 Mar 2022 17:02:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 8/9] bfq: Get rid of __bio_blkcg() usage
Message-ID: <20220330150230.dzdlbu5w6cdshl5s@quack3.lan>
References: <20220330123438.32719-1-jack@suse.cz>
 <20220330124255.24581-8-jack@suse.cz>
 <YkRlasF4GzJ+iHo/@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkRlasF4GzJ+iHo/@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 30-03-22 07:12:58, Christoph Hellwig wrote:
> On Wed, Mar 30, 2022 at 02:42:51PM +0200, Jan Kara wrote:
> > Convert BFQ to the new situation where bio->bi_blkg is initialized in
> > bio_set_dev() and thus practically always valid. This allows us to save
> > blkcg_gq lookup and noticeably simplify the code.
> 
> Is there any case at all where it is not valid these days?
> I can't think of any even if we have plenty of boilerplate code trying
> to handle that case.

So I didn't find any as well but I was not 100% sure since
blkg_tryget_closest() seems like it *could* return NULL in some rare error
cases. If we either modify blkg_tryget_closest() or handle that case in
bio_associate_blkg_from_css() by using root_blkg, we can remove all the
boilerplate code I assume.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
