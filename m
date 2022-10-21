Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0415EC433FE
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 15:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiJUPI1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Oct 2022 11:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJUPI0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 11:08:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F038F6B
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 08:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666364905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0v8fCov6JT023F59mHS307YwGTnGWhQRNzV/UnBn+lg=;
        b=E4B3ZXNnNaHctXMzWywMx1aCPSX6Gz5QNN9+E57aQjyyyrBUwEooAOZZbcJ4IbN91wtQ8b
        MOxq4uBV+0VTB4RANyDX3fiq3EyiQyMaJwT8rwPMDD50bs2Jwal0xT5/tKbKeDpcPvp49p
        XQ95edAvzTvUIl7Rzi/LSTD4HqkJmwo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-RSR-Zy2fMXCAv38dKQUiEw-1; Fri, 21 Oct 2022 11:08:23 -0400
X-MC-Unique: RSR-Zy2fMXCAv38dKQUiEw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 344B81C004F3;
        Fri, 21 Oct 2022 15:08:23 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 83FAB40E42E3;
        Fri, 21 Oct 2022 15:08:15 +0000 (UTC)
Date:   Fri, 21 Oct 2022 23:08:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/8] blk-mq: skip non-mq queues in blk_mq_quiesce_queue
Message-ID: <Y1K12u3C7Bnz91Xl@T590>
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-3-hch@lst.de>
 <Y1HyOS9A72GZIQWT@T590>
 <20221021131932.GA22327@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021131932.GA22327@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 21, 2022 at 03:19:32PM +0200, Christoph Hellwig wrote:
> On Fri, Oct 21, 2022 at 09:13:29AM +0800, Ming Lei wrote:
> > > -	blk_mq_wait_quiesce_done(q);
> > > +	/* nothing to wait for non-mq queues */
> > > +	if (queue_is_mq(q))
> > > +		blk_mq_wait_quiesce_done(q);
> > 
> > This interface can't work as expected for bio drivers, the only user
> > should be del_gendisk(), but anyway the patch is fine:
> 
> Another one is the wb_lat_usec sysfs attribute.  But maybe it is better
> do just do this in the callers and WARN?

wbt is only available for blk-mq.


Thanks,
Ming

