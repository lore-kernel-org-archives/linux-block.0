Return-Path: <SRS0=6DrF=3B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0493C32771
	for <linux-block@archiver.kernel.org>; Sun, 12 Jan 2020 08:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9409020848
	for <linux-block@archiver.kernel.org>; Sun, 12 Jan 2020 08:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3AwL9/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732345AbgALIAS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 Jan 2020 03:00:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39361 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732343AbgALIAS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Jan 2020 03:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578816017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hqkKKcItHU2Hb/2wu/C35EPKDZK6SaJox+9BNg8CTyI=;
        b=M3AwL9/F4Hm2jB5aqdPvnrGUtk0K3xyZQtLyzniB0XF4+zj8jdgQ6kE+KKI/UG4FDLG50/
        O1YS7c68H3j+XOSzXjSg8+QqyF+yLsnhipD4F2ucISXX8a4AmGzDTq2lUGnM/AgYpOFfVU
        TdcSc9FGzJWpa9IxRCRUmYQh08wwpX8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-uZitWqCvOBiRG3nELuB3Gg-1; Sun, 12 Jan 2020 01:59:08 -0500
X-MC-Unique: uZitWqCvOBiRG3nELuB3Gg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6D5110054E3;
        Sun, 12 Jan 2020 06:59:07 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E8D4D1001902;
        Sun, 12 Jan 2020 06:59:01 +0000 (UTC)
Date:   Sun, 12 Jan 2020 14:58:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2] block: fix get_max_segment_size() overflow on 32bit
 arch
Message-ID: <20200112065856.GA23710@ming.t460p>
References: <20200111125743.4222-1-ming.lei@redhat.com>
 <62d41f31-a50b-8416-fcf5-abcbb675176f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62d41f31-a50b-8416-fcf5-abcbb675176f@kernel.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jan 11, 2020 at 08:51:31AM -0700, Jens Axboe wrote:
> On 1/11/20 5:57 AM, Ming Lei wrote:
> > Commit 429120f3df2d starts to take account of segment's start dma address
> > when computing max segment size, and data type of 'unsigned long'
> > is used to do that. However, the segment mask may be 0xffffffff, so
> > the figured out segment size may be overflowed in case of zero physical
> > address on 32bit arch.
> > 
> > Fix the issue by returning queue_max_segment_size() directly when that
> > happens.
> 
> I still think this should use phys_addr_t, just in case the mask is
> ever not 32-bit. The current types are a bit weird, tbh.

I didn't use phys_addr_t because queue_segment_boundary() always
returns 'unsigned long', so using 'phys_addr_t' doesn't make any
difference because the following result can be held in 32bit always
no matter offset is 32bit or 64bit:

	mask & (page_to_phys(start_page) + offset)

BTW, 'seg_boundary_mask' is defined as 'unsigned long' since kernel
git tree was born. Given not see related report with 64bit phys_addr_t
on 32bit arch, I guess we may leave it alone.

However, if you think we need to convert 'seg_boundary_mask' into
phys_addr_t, the 'offset' parameter can be re-defined as phys_addr_t.


thanks,
Ming

