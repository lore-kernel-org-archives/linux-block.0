Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AD9C433EF
	for <linux-block@archiver.kernel.org>; Tue, 24 May 2022 12:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbiEXMOg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 May 2022 08:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiEXMOe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 May 2022 08:14:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFF496F492
        for <linux-block@vger.kernel.org>; Tue, 24 May 2022 05:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653394472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9JI11b85ofkZF9fW3eAAZPAx9w5swJPzDrsDSmuEDHo=;
        b=OE34eTElvNxk9abGAhgiAmev5mXCZFcpzfyuA4760+CT2O0KqX5mHXIknBvO2LfEPRyGJq
        tVf0fcabL3gIIbz/zconwjUaqSwo/hMXFhpe1g2sBEmJACEm/GZ+hiWzvvmlrKl+JWvkSn
        WPocKtrYuUWTBvdd+ilCk2cCudIc4Kk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-510--HnNk4O4Nce-xzdg-sLThw-1; Tue, 24 May 2022 08:14:29 -0400
X-MC-Unique: -HnNk4O4Nce-xzdg-sLThw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C0D91D32362;
        Tue, 24 May 2022 12:14:29 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B27C2166B25;
        Tue, 24 May 2022 12:14:23 +0000 (UTC)
Date:   Tue, 24 May 2022 20:14:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, shinichiro.kawasaki@wdc.com,
        dan.j.williams@intel.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: remove per-disk debugfs files in
 blk_unregister_queue
Message-ID: <YozMGvN/3TJirE3N@T590>
References: <20220524083325.833981-1-hch@lst.de>
 <YozFt0qFCvZVt67m@T590>
 <20220524120134.GB17563@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524120134.GB17563@lst.de>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 24, 2022 at 02:01:34PM +0200, Christoph Hellwig wrote:
> On Tue, May 24, 2022 at 07:47:03PM +0800, Ming Lei wrote:
> > Not look into details yet, but as one blk-mq debugfs user, I don't like
> > the idea, since I often see io hang issue when calling
> > blk_mq_freeze_queue_wait(), and blk-mq debugfs is very helpful for
> > investigating this kind of issue.
> > 
> > But now blk-mq debugfs is gone with this patch __before__ draining IO in
> > del_gendisk, and it becomes not useful as before.
> 
> This is the way hot it is set up, so in doubt I want it to be torn down
> synchronously.  There might be a way to move the teardown later, but
> that will require a very careful audit.

Then please move it to disk release at least, when blk-mq debug becomes
less useful.

In theory, blk_cleanup_queue() may have similar issue, but most of
drivers release disk after blk_cleanup_queue() except for scsi disk.

So from user viewpoint, the best place to tear down blk-mq debugfs is
still in queue release handler.

Thanks,
Ming

