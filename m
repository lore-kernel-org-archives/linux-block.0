Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D73C6FD1D
	for <linux-block@archiver.kernel.org>; Tue, 21 Mar 2023 08:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCUIBg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Mar 2023 04:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjCUIBf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Mar 2023 04:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7563CE22
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 01:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679385638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wC+rTCOjrmsOWw1/sDNUTIpxGUuz5xE5OzDWOizUsjY=;
        b=LOlOblxdNx9g8M7bmo+jndSnzFhbYBcdgd8VnV2ti2A0f1ChswUCcAfnfprtfef5MMAk0o
        4HjNiEC2rDX+ts4phcpmUWfHd7S9KW+7rU3DhFJSFjV1gtSsoStxn3QG2K0NEuCYdGsYbc
        mdDyd5uv6UjLYdYY29Rfz+JnOBH3qAs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-wjM_uNQWPROc-2vbFIdH9A-1; Tue, 21 Mar 2023 04:00:34 -0400
X-MC-Unique: wjM_uNQWPROc-2vbFIdH9A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62BCB29ABA0C;
        Tue, 21 Mar 2023 08:00:34 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ACF0A42C827;
        Tue, 21 Mar 2023 08:00:28 +0000 (UTC)
Date:   Tue, 21 Mar 2023 16:00:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        ming.lei@redhat.com
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
Message-ID: <ZBlkF7zjQyahk5gv@ovpn-8-18.pek2.redhat.com>
References: <20230317195938.1745318-1-bvanassche@acm.org>
 <20230317195938.1745318-3-bvanassche@acm.org>
 <ZBT6EmhEfJmgRXU1@ovpn-8-18.pek2.redhat.com>
 <580e712c-5e43-e1a5-277b-c4e8c50485f0@acm.org>
 <ZBjsDy2pfPk9t6qB@ovpn-8-29.pek2.redhat.com>
 <50dfa89c-19fa-b655-f6b8-b8853b066c75@acm.org>
 <ZBj99Oy5FPDI+Gdn@ovpn-8-18.pek2.redhat.com>
 <a9347617-70b3-3cc1-ea5e-c6bd78c29acd@opensource.wdc.com>
 <ZBkTwV7UC5QDtRyj@ovpn-8-18.pek2.redhat.com>
 <9c74df25-aa99-afc2-4f40-3201dd67368e@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c74df25-aa99-afc2-4f40-3201dd67368e@opensource.wdc.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 21, 2023 at 12:24:51PM +0900, Damien Le Moal wrote:
> On 3/21/23 11:17, Ming Lei wrote:
> > On Tue, Mar 21, 2023 at 10:46:30AM +0900, Damien Le Moal wrote:
> >> On 3/21/23 09:44, Ming Lei wrote:
> >>> On Mon, Mar 20, 2023 at 04:32:57PM -0700, Bart Van Assche wrote:
> >>>> On 3/20/23 16:28, Ming Lei wrote:
> >>>>> On Fri, Mar 17, 2023 at 04:45:46PM -0700, Bart Van Assche wrote:
> >>>>>> Thanks for having taken a look. This patch series is intended for
> >>>>>> REQ_OP_WRITE requests and not for REQ_OP_ZONE_APPEND requests.
> >>>>>
> >>>>> But you are talking about host-managed zoned device, and the write
> >>>>> should have to be zone append, right?
> >>>>
> >>>> Hi Ming,
> >>>>
> >>>> The use case I'm looking at is Android devices with UFS storage. UFS is
> >>>> based on SCSI and hence only REQ_OP_WRITE is supported natively. There is a
> >>>> REQ_OP_ZONE_APPEND emulation in drivers/scsi/sd_zbc.c but it restricts the
> >>>> queue depth to one.
> >>>
> >>> But is this UFS one host-managed zoned device? If yes, this "REQ_OP_WRITE"
> >>> still should have been handled as REQ_OP_ZONE_APPEND? Otherwise, I don't
> >>> think it is host-managed, and your patch isn't needed too.
> >>
> >> Ming,
> >>
> >> Both regular writes and zone append writes are supported by host managed
> >> devices. For ZNS, zone append write is natively supported as a different
> >> command. For SCSI & ATA (and UFS) devices, zone append write is emulated in the
> >> sd driver using the regular write command because the SCSI and ATA standards do
> >> not define a zone append write command.
> > 
> > Thanks for the clarification.
> > 
> >>
> >> For BIO splitting, splitting a regular write is fine as the resulting fragments
> >> are sequential writes, so all fine. But zone append splitting is not allowed as
> > 
> > The current bio split code may not make sequential write requests, and
> > looks Bart is trying to address it. Then looks scsi zdc emulation still
> > requires sequential writes aiming to same zone.
> 
> Split does create sequential writes, always, but the processing order may not be
> sequential in case of plugging. However, writes to sequential zones are never
> plugs so reordering due to plugging does not affect zoned devices.

If it is true, I am wondering why Bart sent the patch of 'block: Split and submit
bios in LBA order'?

> 
> > 
> > But I guess it is hard to maintain bio order, especially md/dm is
> > involved.
> 
> It is not that hard once you get rid of plugging, which we did. So far, with
> everything we support, we are not detecting any issues and we test weekly, every rc.

I see, but I meant current->bio_list, see the following bio order issue:

https://lore.kernel.org/linux-block/1609233522-25837-1-git-send-email-dannyshih@synology.com/


Thanks,
Ming

