Return-Path: <SRS0=NSF0=DQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFE3C433DF
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 04:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29AAB22254
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 04:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602218154;
	bh=Tg3M8HcXZsuM4G3jfJiGryz0wcPcHh5f3zA/BIo1kAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L2GNIEvqDHRS28/3Hdn4I6LLlqRu5S6nmdmClJ0UQhODIZb9BPlwIv0EpMbOyJSly
	 7xdj7Jv5x1wPDKbA7p6fEdRT7oqhvZQooWCwLhRjNdIw2HXu3dXKGD+I3E3xGTEPX1
	 l1C1l5gZencD5NZczM2n9NUY8muxwar6SDQCD6cI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgJIEfx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Oct 2020 00:35:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgJIEfx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Oct 2020 00:35:53 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF7C22223C;
        Fri,  9 Oct 2020 04:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602218153;
        bh=Tg3M8HcXZsuM4G3jfJiGryz0wcPcHh5f3zA/BIo1kAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y6lgfV1fM4xbr1OD0T+LOo1v3KT/tly1Me3Sb6etSCeYwuQvbsWXcXYe0IiJbHvya
         1yNwFK6JEEUuuhMV6FAx0HZB6Zx/01cke+vCFcv5+ZsZp9fWzBAP9lXxIJa1UOwKFI
         83VrepKIadtRCtJ2zDNfuOGrQpaePqF/g1MBg1EE=
Date:   Thu, 8 Oct 2020 21:35:51 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu_ref: don't refer to ref->data if it isn't
 allocated
Message-ID: <20201009043551.GB854@sol.localdomain>
References: <20201009040356.43802-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009040356.43802-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 09, 2020 at 12:03:56PM +0800, Ming Lei wrote:
> We can't check ref->data->confirm_switch directly in __percpu_ref_exit(), since
> ref->data may not be allocated in one not-initialized refcount.
> 
> Fixes: 2b0d3d3e4fcf ("percpu_ref: reduce memory footprint of percpu_ref in fast path")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Please don't forget:

Reported-by: syzbot+fd15ff734dace9e16437@syzkaller.appspotmail.com
