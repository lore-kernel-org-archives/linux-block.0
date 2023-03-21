Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A138C6FD1D
	for <linux-block@archiver.kernel.org>; Tue, 21 Mar 2023 02:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjCUCSl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Mar 2023 22:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjCUCSk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Mar 2023 22:18:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE2C37B6A
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 19:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679365074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uI0e7uL1Zm5Jx3tMIuS19R4iopD1YS+O35N2Q4q29J4=;
        b=BNj2Cv28dXcDGCyXrgSQFjXG+lvofGDAzrSeLSwv8ejSFbKzfXL8xEtG2kKwYPAYzX08FM
        3upRVT3+zKwJ/HXyKf3ANCwQPSPTZ5Hi8UxmYQDdcJQfHreij+1fIDwTU8dT//IpSXn9z9
        lRZD26NFl1mXfqDwqjKDLog5LG6o17s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-vV5R_3QlPNSNYUXqqOlWeQ-1; Mon, 20 Mar 2023 22:17:49 -0400
X-MC-Unique: vV5R_3QlPNSNYUXqqOlWeQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EC181C04324;
        Tue, 21 Mar 2023 02:17:48 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AEFFD483EC4;
        Tue, 21 Mar 2023 02:17:42 +0000 (UTC)
Date:   Tue, 21 Mar 2023 10:17:37 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        ming.lei@redhat.com
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
Message-ID: <ZBkTwV7UC5QDtRyj@ovpn-8-18.pek2.redhat.com>
References: <20230317195938.1745318-1-bvanassche@acm.org>
 <20230317195938.1745318-3-bvanassche@acm.org>
 <ZBT6EmhEfJmgRXU1@ovpn-8-18.pek2.redhat.com>
 <580e712c-5e43-e1a5-277b-c4e8c50485f0@acm.org>
 <ZBjsDy2pfPk9t6qB@ovpn-8-29.pek2.redhat.com>
 <50dfa89c-19fa-b655-f6b8-b8853b066c75@acm.org>
 <ZBj99Oy5FPDI+Gdn@ovpn-8-18.pek2.redhat.com>
 <a9347617-70b3-3cc1-ea5e-c6bd78c29acd@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9347617-70b3-3cc1-ea5e-c6bd78c29acd@opensource.wdc.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 21, 2023 at 10:46:30AM +0900, Damien Le Moal wrote:
> On 3/21/23 09:44, Ming Lei wrote:
> > On Mon, Mar 20, 2023 at 04:32:57PM -0700, Bart Van Assche wrote:
> >> On 3/20/23 16:28, Ming Lei wrote:
> >>> On Fri, Mar 17, 2023 at 04:45:46PM -0700, Bart Van Assche wrote:
> >>>> Thanks for having taken a look. This patch series is intended for
> >>>> REQ_OP_WRITE requests and not for REQ_OP_ZONE_APPEND requests.
> >>>
> >>> But you are talking about host-managed zoned device, and the write
> >>> should have to be zone append, right?
> >>
> >> Hi Ming,
> >>
> >> The use case I'm looking at is Android devices with UFS storage. UFS is
> >> based on SCSI and hence only REQ_OP_WRITE is supported natively. There is a
> >> REQ_OP_ZONE_APPEND emulation in drivers/scsi/sd_zbc.c but it restricts the
> >> queue depth to one.
> > 
> > But is this UFS one host-managed zoned device? If yes, this "REQ_OP_WRITE"
> > still should have been handled as REQ_OP_ZONE_APPEND? Otherwise, I don't
> > think it is host-managed, and your patch isn't needed too.
> 
> Ming,
> 
> Both regular writes and zone append writes are supported by host managed
> devices. For ZNS, zone append write is natively supported as a different
> command. For SCSI & ATA (and UFS) devices, zone append write is emulated in the
> sd driver using the regular write command because the SCSI and ATA standards do
> not define a zone append write command.

Thanks for the clarification.

> 
> For BIO splitting, splitting a regular write is fine as the resulting fragments
> are sequential writes, so all fine. But zone append splitting is not allowed as

The current bio split code may not make sequential write requests, and
looks Bart is trying to address it. Then looks scsi zdc emulation still
requires sequential writes aiming to same zone.

But I guess it is hard to maintain bio order, especially md/dm is
involved.

Thanks, 
Ming

