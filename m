Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0EFC678D4
	for <linux-block@archiver.kernel.org>; Fri,  3 Mar 2023 03:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjCCDAH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Mar 2023 22:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCCDAG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2023 22:00:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FC317CD8
        for <linux-block@vger.kernel.org>; Thu,  2 Mar 2023 18:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677812362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ml1Mi4USLtb96dzjtzwKcD2jz6nSxexHok5ovftQxq8=;
        b=ClckraTjqg7kMczhoucmU4ZnIHNBCPcTkOibgwwa00fbz34VM86SNxapdQiVtbj9/B39j8
        +T3DIkMitNC6EbmWF1kkE3mzYTWmbXyfMsGf3Z/HJ7hzdnNFBCECDUJvov+zrAaix7z42C
        Tyhbymdf5eb/2UlsU+VFYPBUci9qrpo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-aL_l_Ez1OIy6a5h4oBYbWg-1; Thu, 02 Mar 2023 21:59:17 -0500
X-MC-Unique: aL_l_Ez1OIy6a5h4oBYbWg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB817800B23;
        Fri,  3 Mar 2023 02:59:16 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE9932026D4B;
        Fri,  3 Mar 2023 02:59:10 +0000 (UTC)
Date:   Fri, 3 Mar 2023 10:59:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     linux-block@vger.kernel.org, Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        kernel test robot <lkp@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v2] block: ublk: enable zoned storage support
Message-ID: <ZAFieW9PZ2LNQYHa@T590>
References: <20230224200502.391570-1-nmi@metaspace.dk>
 <ZAAPBFfqP671N4ue@T590>
 <87o7pblhi1.fsf@metaspace.dk>
 <ZABfFW+28Jlxq+Ew@T590>
 <ZABmAR6Du1tUVEa7@T590>
 <CAFj5m9+o4yNA5rNDA+EXWZthMtB+dOLOW0O788i77=Qn1eJ0qQ@mail.gmail.com>
 <87h6v3l9up.fsf@metaspace.dk>
 <ZAChttVoCHsnXmvF@T590>
 <875ybjl1r0.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875ybjl1r0.fsf@metaspace.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 02, 2023 at 02:28:33PM +0100, Andreas Hindborg wrote:
> 
> Ming Lei <ming.lei@redhat.com> writes:
> 
> > On Thu, Mar 02, 2023 at 11:07:15AM +0100, Andreas Hindborg wrote:
> >> 
> >> Ming Lei <ming.lei@redhat.com> writes:
> >> 
> >> > On Thu, Mar 2, 2023 at 5:02 PM Ming Lei <ming.lei@redhat.com> wrote:
> >> >>
> >> >> On Thu, Mar 02, 2023 at 04:32:21PM +0800, Ming Lei wrote:
> >> >> > On Thu, Mar 02, 2023 at 08:31:07AM +0100, Andreas Hindborg wrote:
> >> >> > >
> >> >>
> >> >> ...
> >> >>
> >> >> > >
> >> >> > > I agree about fetching more zones. However, it is no good to fetch up to
> >> >> > > a max, since the requested zone report may less than max. I was
> >> >> >
> >> >> > Short read should always be supported, so the interface may need to
> >> >> > return how many zones in single command, please refer to nvme_ns_report_zones().
> >> >>
> >> >> blk_zone is part of uapi, maybe the short read can be figured out by
> >> >> one all-zeroed 'blk_zone'?  then no extra uapi data is needed for
> >> >> reporting zones.
> >> >
> >> > oops, we have blk_zone_report data for reporting zones to userspace already,
> >> > see blkdev_report_zones_ioctl(), then this way can be re-used for getting zone
> >> > report from ublk server too, right?
> >> 
> >> Yes that would be nice. But I did the report_zone command like a read
> >> operation, so we are not currently copying any buffers to user space
> >> when issuing the command, we just rely on the iod.
> >
> > What I meant is to reuse the format of blk_zone_report for returning
> > multiple 'blk_zone' info in single command.
> >
> > The only change is that you need to allocate one bigger kernel buffer
> > to hold more 'blk_zone' in single report zone request.
> >
> >> I think it would be
> >> better to use the start_sectors and nr_sectors of the iod instead. Then
> >> we don't have to copy the blk_zone_report. What do you think?
> >
> > For IN parameter of report zone command, you still can reuse
> > blk_zone_report:
> >
> > struct blk_zone_report {
> >         __u64           sector;
> >         __u32           nr_zones;
> >         __u32           flags;
> > };
> >
> > Just by using the 1st two 64b words of iod for holding 'blk_zone_report', and
> > keep the iod->addr field not touched.
> 
> I see. Would you make the first part of `struct ublksrv_io_desc` a union
> for this, or would you just cast it at the use site?

oops, you still need iod->op_flags for recognizing the io op, so just
start_sector and nr_sectors can be used.

However, this way isn't good too, cause UBLK_IO_OP_DRV_IN is just mapped
to 'report zone' command in your implementation, what if new pt request
is required in future?

We need to think about how to support ublk pt request in generic way.

Thanks,
Ming

