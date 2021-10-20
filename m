Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1CFC433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 00:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0920610F8
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 00:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhJTA0S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 20:26:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52337 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229657AbhJTA0S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 20:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634689444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KHu0xi8kNhwEy8umE0S0z8zYWzB1LSxz+DK8Rurzgc4=;
        b=VsbUre4ZIRE9XAKBLdhQ/gbOeUYzry7Qi1+NviNzYmtJNkFiYEFlDbHZgoFqT/Ok6qsflR
        tXQI2F0aAud8IpuvsF5tbAVxZx+iWAOUCLSpTaI6xe0Di0PvzBFrhN5/SE41zo/wKAt8J6
        yGkLNEz3oPfTlQWAxiDUbppNUIPKGVU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-AcgGz8wXPES9A5MyHxFeCA-1; Tue, 19 Oct 2021 20:24:01 -0400
X-MC-Unique: AcgGz8wXPES9A5MyHxFeCA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 269628042DF;
        Wed, 20 Oct 2021 00:23:59 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DD3B17CDB;
        Wed, 20 Oct 2021 00:23:50 +0000 (UTC)
Date:   Wed, 20 Oct 2021 08:23:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH V4 0/6] blk-mq: support concurrent queue quiescing
Message-ID: <YW9hkWyO6H5sc6vY@T590>
References: <20211014081710.1871747-1-ming.lei@redhat.com>
 <20211014121145.GB15198@lst.de>
 <YWzIazr+VjY9MNCv@T590>
 <bd75e597-ab35-2a88-c2a7-e4e5365bf0ef@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd75e597-ab35-2a88-c2a7-e4e5365bf0ef@kernel.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Oct 17, 2021 at 07:19:13PM -0600, Jens Axboe wrote:
> On 10/17/21 7:05 PM, Ming Lei wrote:
> > On Thu, Oct 14, 2021 at 02:11:45PM +0200, Christoph Hellwig wrote:
> >> Except for the nitpick just noted this looks fine to me:
> >>
> >> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >>
> >> I plan to apply at least 1-5 to the nvme tree with that nitpick fixed
> >> up locally.
> >>
> >> Jens: do you want me to take the last patch through the nvme tree as
> >> well?
> > 
> > Hello Jens & Christoph,
> > 
> > Any chance to make it in v5.16?
> 
> Yep, I'll take a look at this in the morning. Rebasing the block tree
> anyway, I'll let you know if we need any changes here.

Hello Jens,

Looks the 6 patches can still be applied cleanly against both
for-5.16/block and for-5.16/drivers today, do you need an resend?

thanks,
Ming

