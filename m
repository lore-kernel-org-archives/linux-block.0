Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13852C433DB
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 03:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA17A64F5F
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 03:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhBCDmU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:42:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42157 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232024AbhBCDmU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Feb 2021 22:42:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612323653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PX75dj9ZmFBP9MwY96oGVlklfRZT76KvBwv9rEk0H1k=;
        b=b3Seps+UEWH8ZC8dgG0DftO7g865BiW0uAiZ21+SRfuxDRk79jF68gtXRpd48K3gzjqYhu
        t9xfWAS3zOIFYhagK7zdSz8lnDCBks8g5K1FLS9sqwNC/KmmauIJhlDOki2AHSZ8SrkDCM
        pTEgQkaebWqT6TiKVWgqA3Szz6VSup8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-W0WwxChnP4iP16wCHWQN_g-1; Tue, 02 Feb 2021 22:40:49 -0500
X-MC-Unique: W0WwxChnP4iP16wCHWQN_g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B184E801817;
        Wed,  3 Feb 2021 03:40:46 +0000 (UTC)
Received: from T590 (ovpn-13-198.pek2.redhat.com [10.72.13.198])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AC107100164C;
        Wed,  3 Feb 2021 03:40:35 +0000 (UTC)
Date:   Wed, 3 Feb 2021 11:40:31 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Changheun Lee <nanich.lee@samsung.com>
Cc:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, damien.lemoal@wdc.com, hch@infradead.org,
        jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mj0123.lee@samsung.com, osandov@fb.com, patchwork-bot@kernel.org,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        tj@kernel.org, tom.leiming@gmail.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com
Subject: Re: [PATCH v4 1/2] bio: limit bio max size
Message-ID: <20210203034031.GC948998@T590>
References: <20210201071413.GC9481@T590>
 <CGME20210202042747epcas1p2054df120098b3130cb104cf8e4731797@epcas1p2.samsung.com>
 <20210202041204.28995-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202041204.28995-1-nanich.lee@samsung.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 02, 2021 at 01:12:04PM +0900, Changheun Lee wrote:
> > On Mon, Feb 01, 2021 at 11:52:48AM +0900, Changheun Lee wrote:
> > > > On Fri, Jan 29, 2021 at 12:49:08PM +0900, Changheun Lee wrote:
> > > > > bio size can grow up to 4GB when muli-page bvec is enabled.
> > > > > but sometimes it would lead to inefficient behaviors.
> > > > > in case of large chunk direct I/O, - 32MB chunk read in user space -
> > > > > all pages for 32MB would be merged to a bio structure if the pages
> > > > > physical addresses are contiguous. it makes some delay to submit
> > > > > until merge complete. bio max size should be limited to a proper size.
> > > > > 
> > > > > When 32MB chunk read with direct I/O option is coming from userspace,
> > > > > kernel behavior is below now. it's timeline.
> > > > > 
> > > > >  | bio merge for 32MB. total 8,192 pages are merged.
> > > > >  | total elapsed time is over 2ms.
> > > > >  |------------------ ... ----------------------->|
> > > > >                                                  | 8,192 pages merged a bio.
> > > > >                                                  | at this time, first bio submit is done.
> > > > >                                                  | 1 bio is split to 32 read request and issue.
> > > > >                                                  |--------------->
> > > > >                                                   |--------------->
> > > > >                                                    |--------------->
> > > > >                                                               ......
> > > > >                                                                    |--------------->
> > > > >                                                                     |--------------->|
> > > > >                           total 19ms elapsed to complete 32MB read done from device. |
> > > > > 
> > > > > If bio max size is limited with 1MB, behavior is changed below.
> > > > > 
> > bio_iov_iter_get_pages> > >  | bio merge for 1MB. 256 pages are merged for each bio.
> > > > >  | total 32 bio will be made.
> > > > >  | total elapsed time is over 2ms. it's same.
> > > > >  | but, first bio submit timing is fast. about 100us.
> > > > >  |--->|--->|--->|---> ... -->|--->|--->|--->|--->|
> > > > >       | 256 pages merged a bio.
> > > > >       | at this time, first bio submit is done.
> > > > >       | and 1 read request is issued for 1 bio.
> > > > >       |--------------->
> > > > >            |--------------->
> > > > >                 |--------------->
> > > > >                                       ......
> > > > >                                                  |--------------->
> > > > >                                                   |--------------->|
> > > > >         total 17ms elapsed to complete 32MB read done from device. |
> > > > 
> > > > Can you share us if enabling THP in your application can avoid this issue? BTW, you
> > > > need to make the 32MB buffer aligned with huge page size. IMO, THP perfectly fits
> > > > your case.
> > > > 
> > > 
> > > THP is enabled already like as below in my environment. It has no effect.
> > > 
> > > cat /sys/kernel/mm/transparent_hugepage/enabled
> > > [always] madvise never
> > 
> > The 32MB user buffer needs to be huge page size aligned. If your system
> > supports bcc/bpftrace, it is quite easy to check if the buffer is
> > aligned.
> > 
> > > 
> > > This issue was reported from performance benchmark application in open market.
> > > I can't control application's working in open market.
> > > It's not only my own case. This issue might be occured in many mobile environment.
> > > At least, I checked this problem in exynos, and qualcomm chipset.
> > 
> > You just said it takes 2ms for building 32MB bio, but you never investigate the
> > reason. I guess it is from get_user_pages_fast(), but maybe others. Can you dig
> > further for the reason? Maybe it is one arm64 specific issue.
> > 
> > BTW, bio_iov_iter_get_pages() just takes ~200us on one x86_64 VM with THP, which is
> > observed via bcc/funclatency when running the following workload:
> > 
> 
> I think you focused on bio_iov_iter_get_pages() because I just commented page
> merge delay only. Sorry about that. I missed details of this issue.
> Actually there are many operations during while-loop in do_direct_IO().
> Page merge operation is just one among them. Page merge operation is called
> by dio_send_cur_page() in while-loop. Below is call stack.
> 
> __bio_try_merge_page+0x4c/0x614
> bio_add_page+0x40/0x12c
> dio_send_cur_page+0x13c/0x374
> submit_page_section+0xb4/0x304
> do_direct_IO+0x3d4/0x854
> do_blockdev_direct_IO+0x488/0xa18
> __blockdev_direct_IO+0x30/0x3c
> f2fs_direct_IO+0x6d0/0xb80
> generic_file_read_iter+0x284/0x45c
> f2fs_file_read_iter+0x3c/0xac
> __vfs_read+0x19c/0x204
> vfs_read+0xa4/0x144
> 
> 2ms delay is not only caused by page merge operation. it inculdes many the
> other operations too. But those many operations included page merge should
> be executed more if bio size is grow up.

OK, got it.

Then I think you can just limit bio size in dio_bio_add_page() instead of
doing it for all.

-- 
Ming

