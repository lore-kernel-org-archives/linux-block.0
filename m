Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED572C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Apr 2022 01:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiDMB7a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Apr 2022 21:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiDMB73 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Apr 2022 21:59:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81D2B19C3D
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 18:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649815029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qbm1txEKKlVaSmPNDnFXUVHfbYBf6SguxzwN2wpoygs=;
        b=hosRl3yIzBM4j4GQgCvWBLVi3DtFXhr64e8etBvRtenCotgrh1nGdrxXkZdxPLnRHcsyxp
        J6Lgs0HubOP2NLIcVpw4xYjo1I6kta9MXOoM4tZBsRe8/YMj+f7gmYE5O2j0Q9XYOdJ0Mh
        S5X7ksrcwbNhPE4Nmic+O51GAZ1igOk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-pHp6ULcKNDelERNlIA-5_Q-1; Tue, 12 Apr 2022 21:57:06 -0400
X-MC-Unique: pHp6ULcKNDelERNlIA-5_Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1CE22999B20;
        Wed, 13 Apr 2022 01:57:05 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB6B72166BA4;
        Wed, 13 Apr 2022 01:56:48 +0000 (UTC)
Date:   Wed, 13 Apr 2022 09:56:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 5/8] dm: always setup ->orig_bio in alloc_io
Message-ID: <YlYt2rzM0NBPARVp@T590>
References: <20220412085616.1409626-1-ming.lei@redhat.com>
 <20220412085616.1409626-6-ming.lei@redhat.com>
 <YlXmmB6IO7usz2c1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlXmmB6IO7usz2c1@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 12, 2022 at 04:52:40PM -0400, Mike Snitzer wrote:
> On Tue, Apr 12 2022 at  4:56P -0400,
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > The current DM codes setup ->orig_bio after __map_bio() returns,
> > and not only cause kernel panic for dm zone, but also a bit ugly
> > and tricky, especially the waiting until ->orig_bio is set in
> > dm_submit_bio_remap().
> > 
> > The reason is that one new bio is cloned from original FS bio to
> > represent the mapped part, which just serves io accounting.
> > 
> > Now we have switched to bdev based io accounting interface, and we
> > can retrieve sectors/bio_op from both the real original bio and the
> > added fields of .sector_offset & .sectors easily, so the new cloned
> > bio isn't necessary any more.
> > 
> > Not only fixes dm-zone's kernel panic, but also cleans up dm io
> > accounting & split a bit.
> 
> You're conflating quite a few things here.  DM zone really has no
> business accessing io->orig_bio (dm-zone.c can just as easily inspect
> the tio->clone, because it hasn't been remapped yet it reflects the
> io->origin_bio, so there is no need to look at io->orig_bio) -- but
> yes I clearly broke things during the 5.18 merge and it needs fixing
> ASAP.

You can just consider the cleanup part of this patches, :-)

1) no late assignment of ->orig_bio, and always set it in alloc_io()

2) no waiting on on ->origi_bio, especially the waiting is done in
fast path of dm_submit_bio_remap().

3) no split for io accounting


Thanks,
Ming

