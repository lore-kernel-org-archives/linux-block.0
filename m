Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F5CC433E9
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 07:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F9864E2E
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 07:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhBAHT5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Feb 2021 02:19:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23045 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231487AbhBAHTq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Feb 2021 02:19:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612163883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qVx5KBLz9JmEIvZV9RVslBW3WV7EfoFeqLOHwA4c8uU=;
        b=ES16tDNRx8NWeTQNNxk9nIZUfpOSPsPwQRLKBJ8ZCP8T+nehV7RgN0/jD0cDvGwP1H/MYX
        Zb5EbL0lhF/6giZtYP4tJd/kgNubbpwN+6a58Q2KE+BaMHUhF/4fkLxpCrOcXwI4WOOmQI
        MxoPb98R8LrsjHiuwHLQYMTPliC5U+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-QMUi9qZENbqEp4HT8S57fQ-1; Mon, 01 Feb 2021 02:14:30 -0500
X-MC-Unique: QMUi9qZENbqEp4HT8S57fQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25894801A9D;
        Mon,  1 Feb 2021 07:14:28 +0000 (UTC)
Received: from T590 (ovpn-13-140.pek2.redhat.com [10.72.13.140])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 98C603828;
        Mon,  1 Feb 2021 07:14:17 +0000 (UTC)
Date:   Mon, 1 Feb 2021 15:14:13 +0800
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
Message-ID: <20210201071413.GC9481@T590>
References: <20210129034909.18785-1-nanich.lee@samsung.com>
 <CGME20210201030830epcas1p402e8a088fb16af9fbbb130b152e097f1@epcas1p4.samsung.com>
 <20210201025248.17679-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201025248.17679-1-nanich.lee@samsung.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 01, 2021 at 11:52:48AM +0900, Changheun Lee wrote:
> > On Fri, Jan 29, 2021 at 12:49:08PM +0900, Changheun Lee wrote:
> > > bio size can grow up to 4GB when muli-page bvec is enabled.
> > > but sometimes it would lead to inefficient behaviors.
> > > in case of large chunk direct I/O, - 32MB chunk read in user space -
> > > all pages for 32MB would be merged to a bio structure if the pages
> > > physical addresses are contiguous. it makes some delay to submit
> > > until merge complete. bio max size should be limited to a proper size.
> > > 
> > > When 32MB chunk read with direct I/O option is coming from userspace,
> > > kernel behavior is below now. it's timeline.
> > > 
> > >  | bio merge for 32MB. total 8,192 pages are merged.
> > >  | total elapsed time is over 2ms.
> > >  |------------------ ... ----------------------->|
> > >                                                  | 8,192 pages merged a bio.
> > >                                                  | at this time, first bio submit is done.
> > >                                                  | 1 bio is split to 32 read request and issue.
> > >                                                  |--------------->
> > >                                                   |--------------->
> > >                                                    |--------------->
> > >                                                               ......
> > >                                                                    |--------------->
> > >                                                                     |--------------->|
> > >                           total 19ms elapsed to complete 32MB read done from device. |
> > > 
> > > If bio max size is limited with 1MB, behavior is changed below.
> > > 
bio_iov_iter_get_pages> > >  | bio merge for 1MB. 256 pages are merged for each bio.
> > >  | total 32 bio will be made.
> > >  | total elapsed time is over 2ms. it's same.
> > >  | but, first bio submit timing is fast. about 100us.
> > >  |--->|--->|--->|---> ... -->|--->|--->|--->|--->|
> > >       | 256 pages merged a bio.
> > >       | at this time, first bio submit is done.
> > >       | and 1 read request is issued for 1 bio.
> > >       |--------------->
> > >            |--------------->
> > >                 |--------------->
> > >                                       ......
> > >                                                  |--------------->
> > >                                                   |--------------->|
> > >         total 17ms elapsed to complete 32MB read done from device. |
> > 
> > Can you share us if enabling THP in your application can avoid this issue? BTW, you
> > need to make the 32MB buffer aligned with huge page size. IMO, THP perfectly fits
> > your case.
> > 
> 
> THP is enabled already like as below in my environment. It has no effect.
> 
> cat /sys/kernel/mm/transparent_hugepage/enabled
> [always] madvise never

The 32MB user buffer needs to be huge page size aligned. If your system
supports bcc/bpftrace, it is quite easy to check if the buffer is
aligned.

> 
> This issue was reported from performance benchmark application in open market.
> I can't control application's working in open market.
> It's not only my own case. This issue might be occured in many mobile environment.
> At least, I checked this problem in exynos, and qualcomm chipset.

You just said it takes 2ms for building 32MB bio, but you never investigate the
reason. I guess it is from get_user_pages_fast(), but maybe others. Can you dig
further for the reason? Maybe it is one arm64 specific issue.

BTW, bio_iov_iter_get_pages() just takes ~200us on one x86_64 VM with THP, which is
observed via bcc/funclatency when running the following workload:

[root@ktest-01 test]# cat fio.job
[global]
bs=32768k
rw=randread
iodepth=1
ioengine=psync
direct=1
runtime=20
time_based

group_reporting=0
ramp_time=5

[diotest]
filename=/dev/sde


[root@ktest-01 func]# /usr/share/bcc/tools/funclatency bio_iov_iter_get_pages
Tracing 1 functions for "bio_iov_iter_get_pages"... Hit Ctrl-C to end.
^C
     nsecs               : count     distribution
         0 -> 1          : 0        |                                        |
         2 -> 3          : 0        |                                        |
         4 -> 7          : 0        |                                        |
         8 -> 15         : 0        |                                        |
        16 -> 31         : 0        |                                        |
        32 -> 63         : 0        |                                        |
        64 -> 127        : 0        |                                        |
       128 -> 255        : 0        |                                        |
       256 -> 511        : 0        |                                        |
       512 -> 1023       : 0        |                                        |
      1024 -> 2047       : 0        |                                        |
      2048 -> 4095       : 0        |                                        |
      4096 -> 8191       : 0        |                                        |
      8192 -> 16383      : 0        |                                        |
     16384 -> 32767      : 0        |                                        |
     32768 -> 65535      : 0        |                                        |
     65536 -> 131071     : 0        |                                        |
    131072 -> 262143     : 1842     |****************************************|
    262144 -> 524287     : 125      |**                                      |
    524288 -> 1048575    : 6        |                                        |
   1048576 -> 2097151    : 0        |                                        |
   2097152 -> 4194303    : 1        |                                        |
   4194304 -> 8388607    : 0        |                                        |
   8388608 -> 16777215   : 1        |                                        |
Detaching...



-- 
Ming

