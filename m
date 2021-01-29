Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E18C433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 07:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A35460C41
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 07:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhA2HZ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Jan 2021 02:25:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38036 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231267AbhA2HZW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jan 2021 02:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611905036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+EjsBKH8pk3a/SzzBGO3nLH8UwbPTs+BAABsbiHFzWo=;
        b=IvMn57Ep3uw+EPDhiizDOofzLyiDWx7V47XqRoreRjrdTgHOHK0wKtr5cKIkuKSGS/8Dix
        K5Q9sh3MKDIBfEXifw9VhgzrSuwklkl1aJmQgiOLVdftiAGpUgXEN15ZGhbNRF9qj31bB9
        sIrXzcfeRPO4XpvtP2DgX9pdPxGyqjI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-Xye7LETOPDGqPuHxTcvfpg-1; Fri, 29 Jan 2021 02:23:52 -0500
X-MC-Unique: Xye7LETOPDGqPuHxTcvfpg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECA2A10054FF;
        Fri, 29 Jan 2021 07:23:49 +0000 (UTC)
Received: from T590 (ovpn-12-246.pek2.redhat.com [10.72.12.246])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B1B6860C13;
        Fri, 29 Jan 2021 07:23:39 +0000 (UTC)
Date:   Fri, 29 Jan 2021 15:23:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Changheun Lee <nanich.lee@samsung.com>
Cc:     hch@infradead.org, Johannes.Thumshirn@wdc.com,
        asml.silence@gmail.com, axboe@kernel.dk, damien.lemoal@wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        osandov@fb.com, patchwork-bot@kernel.org, tj@kernel.org,
        tom.leiming@gmail.com, jisoo2146.oh@samsung.com,
        junho89.kim@samsung.com, mj0123.lee@samsung.com,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        woosung2.lee@samsung.com, yt0928.kim@samsung.com
Subject: Re: [PATCH v4 1/2] bio: limit bio max size
Message-ID: <20210129072335.GA1745608@T590>
References: <CGME20210129040447epcas1p4531f0bf1ddebf0b469af87e85199cc43@epcas1p4.samsung.com>
 <20210129034909.18785-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129034909.18785-1-nanich.lee@samsung.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 29, 2021 at 12:49:08PM +0900, Changheun Lee wrote:
> bio size can grow up to 4GB when muli-page bvec is enabled.
> but sometimes it would lead to inefficient behaviors.
> in case of large chunk direct I/O, - 32MB chunk read in user space -
> all pages for 32MB would be merged to a bio structure if the pages
> physical addresses are contiguous. it makes some delay to submit
> until merge complete. bio max size should be limited to a proper size.
> 
> When 32MB chunk read with direct I/O option is coming from userspace,
> kernel behavior is below now. it's timeline.
> 
>  | bio merge for 32MB. total 8,192 pages are merged.
>  | total elapsed time is over 2ms.
>  |------------------ ... ----------------------->|
>                                                  | 8,192 pages merged a bio.
>                                                  | at this time, first bio submit is done.
>                                                  | 1 bio is split to 32 read request and issue.
>                                                  |--------------->
>                                                   |--------------->
>                                                    |--------------->
>                                                               ......
>                                                                    |--------------->
>                                                                     |--------------->|
>                           total 19ms elapsed to complete 32MB read done from device. |
> 
> If bio max size is limited with 1MB, behavior is changed below.
> 
>  | bio merge for 1MB. 256 pages are merged for each bio.
>  | total 32 bio will be made.
>  | total elapsed time is over 2ms. it's same.
>  | but, first bio submit timing is fast. about 100us.
>  |--->|--->|--->|---> ... -->|--->|--->|--->|--->|
>       | 256 pages merged a bio.
>       | at this time, first bio submit is done.
>       | and 1 read request is issued for 1 bio.
>       |--------------->
>            |--------------->
>                 |--------------->
>                                       ......
>                                                  |--------------->
>                                                   |--------------->|
>         total 17ms elapsed to complete 32MB read done from device. |

Can you share us if enabling THP in your application can avoid this issue? BTW, you
need to make the 32MB buffer aligned with huge page size. IMO, THP perfectly fits
your case.


Thanks,
Ming

