Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0101BC6FD1D
	for <linux-block@archiver.kernel.org>; Tue, 21 Mar 2023 00:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjCUApi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Mar 2023 20:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCUApi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Mar 2023 20:45:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9535599
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 17:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679359490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=55G0EFrO+StsY6eSyecZzV4HzN4bKdUcftTKtTE4lPA=;
        b=S9Y4mqcqQBdk8fFQ243D416ytPtbhT66Kt4BVr77mSh2KUgxVX9rcsd9O87wA43Ma7hawZ
        OOk4ecG7BSpvV4iMO4vK9QKur+2OP+vTfQWEyQAHekJzqq/KvFxSN8TgK+amDNTECJWT6Z
        mXRazebvVYP27p0ky1SZG1UaOO1BUyM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-P8fCCP_1Nw-z4z2M7uJjgg-1; Mon, 20 Mar 2023 20:44:46 -0400
X-MC-Unique: P8fCCP_1Nw-z4z2M7uJjgg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29019800B23;
        Tue, 21 Mar 2023 00:44:46 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AA48492C13;
        Tue, 21 Mar 2023 00:44:40 +0000 (UTC)
Date:   Tue, 21 Mar 2023 08:44:36 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        ming.lei@redhat.com
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
Message-ID: <ZBj99Oy5FPDI+Gdn@ovpn-8-18.pek2.redhat.com>
References: <20230317195938.1745318-1-bvanassche@acm.org>
 <20230317195938.1745318-3-bvanassche@acm.org>
 <ZBT6EmhEfJmgRXU1@ovpn-8-18.pek2.redhat.com>
 <580e712c-5e43-e1a5-277b-c4e8c50485f0@acm.org>
 <ZBjsDy2pfPk9t6qB@ovpn-8-29.pek2.redhat.com>
 <50dfa89c-19fa-b655-f6b8-b8853b066c75@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50dfa89c-19fa-b655-f6b8-b8853b066c75@acm.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 20, 2023 at 04:32:57PM -0700, Bart Van Assche wrote:
> On 3/20/23 16:28, Ming Lei wrote:
> > On Fri, Mar 17, 2023 at 04:45:46PM -0700, Bart Van Assche wrote:
> > > Thanks for having taken a look. This patch series is intended for
> > > REQ_OP_WRITE requests and not for REQ_OP_ZONE_APPEND requests.
> > 
> > But you are talking about host-managed zoned device, and the write
> > should have to be zone append, right?
> 
> Hi Ming,
> 
> The use case I'm looking at is Android devices with UFS storage. UFS is
> based on SCSI and hence only REQ_OP_WRITE is supported natively. There is a
> REQ_OP_ZONE_APPEND emulation in drivers/scsi/sd_zbc.c but it restricts the
> queue depth to one.

But is this UFS one host-managed zoned device? If yes, this "REQ_OP_WRITE"
still should have been handled as REQ_OP_ZONE_APPEND? Otherwise, I don't
think it is host-managed, and your patch isn't needed too.


Thanks,
Ming

