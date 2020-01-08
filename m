Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CD1C33C99
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 02:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EDB20880
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 02:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pv4pVn97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbgAHCrd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 21:47:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29309 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725812AbgAHCrc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 21:47:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578451651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J5qXSOMEDncovNcR0PQ80T3zAoiJ7y/MPXaWvwFzR1c=;
        b=Pv4pVn97pDAthAz8wFVVrV75ykaEAl1L6FodWjrwnUTu9FNDEBxNMXROtvAzM6RJb+2pke
        c5M1nPDl9IzT+ehg/H6kS8i5PVXdBgQQTa7B4DUhGoVNkKiRZVJmBU8yuKqt/4v5MTwaoO
        P8VpzI9ahekj8Zmua7El4hT6mQZDKb8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-Dityh_QbM2WbtjzqvUnzPQ-1; Tue, 07 Jan 2020 21:47:28 -0500
X-MC-Unique: Dityh_QbM2WbtjzqvUnzPQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E41249B69F;
        Wed,  8 Jan 2020 02:47:26 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C2B17C351;
        Wed,  8 Jan 2020 02:47:21 +0000 (UTC)
Date:   Wed, 8 Jan 2020 10:47:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] block: fix get_max_segment_size() overflow on 32bit arch
Message-ID: <20200108024717.GC28075@ming.t460p>
References: <20200108012526.26731-1-ming.lei@redhat.com>
 <BYAPR04MB581614236B3088415240723AE73E0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <a5fa8b59-6685-d914-6163-1d515777300b@kernel.dk>
 <BYAPR04MB5816C3DA0641956670F2B323E73E0@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB5816C3DA0641956670F2B323E73E0@BYAPR04MB5816.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 08, 2020 at 02:38:02AM +0000, Damien Le Moal wrote:
> On 2020/01/08 11:34, Jens Axboe wrote:
> > On 1/7/20 7:06 PM, Damien Le Moal wrote:
> >> On 2020/01/08 10:25, Ming Lei wrote:
> >>> Commit 429120f3df2d starts to take account of segment's start dma address
> >>> when computing max segment size, and data type of 'unsigned long'
> >>> is used to do that. However, the segment mask may be 0xffffffff, so
> >>> the figured out segment size may be overflowed because DMA address can
> >>> be 64bit on 32bit arch.
> >>>
> >>> Fixes the issue by using 'unsigned long long' to compute max segment
> >>> size.
> >>>
> >>> Fixes: 429120f3df2d ("block: fix splitting segments on boundary masks")
> >>> Reported-by: Guenter Roeck <linux@roeck-us.net>
> >>> Tested-by: Guenter Roeck <linux@roeck-us.net>
> >>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >>> ---
> >>>  block/blk-merge.c | 4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/block/blk-merge.c b/block/blk-merge.c
> >>> index 347782a24a35..b0fcc72594cb 100644
> >>> --- a/block/blk-merge.c
> >>> +++ b/block/blk-merge.c
> >>> @@ -159,12 +159,12 @@ static inline unsigned get_max_io_size(struct request_queue *q,
> >>>  
> >>>  static inline unsigned get_max_segment_size(const struct request_queue *q,
> >>>  					    struct page *start_page,
> >>> -					    unsigned long offset)
> >>> +					    unsigned long long offset)
> >>>  {
> >>>  	unsigned long mask = queue_segment_boundary(q);
> >>>  
> >>>  	offset = mask & (page_to_phys(start_page) + offset);
> >>
> >> Shouldn't mask be an unsigned long long too for this to give the
> >> expected correct result ?
> > 
> > Don't think so, and the seg boundary is a ulong to begin with as well.
> > 
> 
> I was referring to 32bits arch were ulong is 32bits. So we would have
> 
> offset = 32bits & 64bits;
> 
> with the patch applied. But I am not sure how gcc handles that and if
> this can be a problem.

Both are 'unsigned', so C compiler will do zero extension for 32bits.


Thanks,
Ming

