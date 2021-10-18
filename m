Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9E6C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 01:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F10F960F24
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 01:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344884AbhJRBIT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Oct 2021 21:08:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40540 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344765AbhJRBIS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Oct 2021 21:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634519167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u15r5tlHLh9xwXhsGNstMaHBECmABDxMYwpF099tn14=;
        b=KDAMbw02eU9cNGchvhRQfsZ2WRSeSKqk4A1RtWVgU5EnVh3NvuisZ92QhKDbyg6IpLz8rz
        gQZqag0myymDgV1jH+u4CY4CWxcTsqj2E92KY1u8sNr8VNyvPsU/JByVG8eqoj8C/K3ONY
        Uw1OdUM1U2d7hN7fa65lPVyBi06xeXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-HM5rmnasMbWnXW9itrfqWg-1; Sun, 17 Oct 2021 21:06:02 -0400
X-MC-Unique: HM5rmnasMbWnXW9itrfqWg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B019579EDC;
        Mon, 18 Oct 2021 01:06:00 +0000 (UTC)
Received: from T590 (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D57945C232;
        Mon, 18 Oct 2021 01:05:52 +0000 (UTC)
Date:   Mon, 18 Oct 2021 09:05:47 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH V4 0/6] blk-mq: support concurrent queue quiescing
Message-ID: <YWzIazr+VjY9MNCv@T590>
References: <20211014081710.1871747-1-ming.lei@redhat.com>
 <20211014121145.GB15198@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014121145.GB15198@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 14, 2021 at 02:11:45PM +0200, Christoph Hellwig wrote:
> Except for the nitpick just noted this looks fine to me:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> I plan to apply at least 1-5 to the nvme tree with that nitpick fixed
> up locally.
> 
> Jens: do you want me to take the last patch through the nvme tree as
> well?

Hello Jens & Christoph,

Any chance to make it in v5.16?


Thanks,
Ming

