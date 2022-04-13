Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CE5C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Apr 2022 01:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiDMBpn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Apr 2022 21:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiDMBpm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Apr 2022 21:45:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C50962C117
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 18:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649814201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L025zsfDef0QFqKeTxgUC1PvCVGz3+bexIoVJ8iOkn4=;
        b=NP8FuyVWKtqxGpEYCqbiInLaY7bo2HgaLAaI0KKk0oqz0mAlBdZJ/xdN6Jh1t4vH+Uwf8n
        ROZFEmtoA1OovaNClOpciRa4KnuCtoXDbe0Gq1KplNlERqsy+Hv/OHbAW730vEJLUgqw+N
        YGlx+zI6mP0s7e/ue9DHvs3YlmefVHc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-hlw6haZ9NAW8BKMiyiP-oQ-1; Tue, 12 Apr 2022 21:43:18 -0400
X-MC-Unique: hlw6haZ9NAW8BKMiyiP-oQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A89F29AB3F0;
        Wed, 13 Apr 2022 01:43:18 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DE7AD40D2821;
        Wed, 13 Apr 2022 01:43:13 +0000 (UTC)
Date:   Wed, 13 Apr 2022 09:43:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 3/8] dm: pass 'dm_io' instance to dm_io_acct directly
Message-ID: <YlYqrC41lzT5c4gm@T590>
References: <20220412085616.1409626-1-ming.lei@redhat.com>
 <20220412085616.1409626-4-ming.lei@redhat.com>
 <YlXhC1tHYYyCQxdI@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlXhC1tHYYyCQxdI@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 12, 2022 at 04:28:59PM -0400, Mike Snitzer wrote:
> On Tue, Apr 12 2022 at  4:56P -0400,
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > All the other 4 parameters are retrieved from the 'dm_io' instance, so
> > not necessary to pass all four to dm_io_acct().
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> Yeah, commit 0ab30b4079e103 ("dm: eliminate copying of dm_io fields in
> dm_io_dec_pending") could've gone further to do what you've done here
> in this patch.
> 
> But it stopped short because of the additional "games" associated with
> the late assignment of io->orig_bio that is in the dm-5.19 branch.

OK, I will rebase on dm-5.19, but IMO the idea of late assignment of
io->orig_bio isn't good, same with splitting one bio just for
accounting, things shouldn't be so tricky.


Thanks,
Ming

