Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F04AC433F5
	for <linux-block@archiver.kernel.org>; Tue, 24 May 2022 11:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236567AbiEXLrX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 May 2022 07:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbiEXLrT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 May 2022 07:47:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 016B02AC57
        for <linux-block@vger.kernel.org>; Tue, 24 May 2022 04:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653392838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sGMVpibRIlNAjHxwoYd+XhOfhbPAbDd/looSsIjvotA=;
        b=SlVYKfgDiKQ+Fg+aP2JVoBaAmOwfHY038CrL5SnKrGYzmYRCsHGrgn2mxC2gOmWKCHMdyG
        BLNHgKfP5pIY/mmya0D0z+hus5XhvBoXvMXBCPChzU+2nq76ydouLQbY0eRRIoOoFSttU6
        +XH7l8oJlMvWfIbgpnuGRxsmBDYO2Bc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-FZGXZKJ0Me6V5Rf0u_pHXg-1; Tue, 24 May 2022 07:47:15 -0400
X-MC-Unique: FZGXZKJ0Me6V5Rf0u_pHXg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E13A101AA45;
        Tue, 24 May 2022 11:47:14 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 120E7401E9D;
        Tue, 24 May 2022 11:47:08 +0000 (UTC)
Date:   Tue, 24 May 2022 19:47:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, shinichiro.kawasaki@wdc.com,
        dan.j.williams@intel.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH] block: remove per-disk debugfs files in
 blk_unregister_queue
Message-ID: <YozFt0qFCvZVt67m@T590>
References: <20220524083325.833981-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524083325.833981-1-hch@lst.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 24, 2022 at 10:33:25AM +0200, Christoph Hellwig wrote:
> The block debugfs files are created in blk_register_queue, which is
> called by add_disk and use a naming scheme based on the disk_name.
> After del_gendisk returns that name can be reused and thus we must not
> leave these debugfs files around, otherwise the kernel is unhappy
> and spews messages like:
> 
> 	Directory XXXXX with parent 'block' already present!
> 
> and the newly created devices will not have working debugfs files.
> 
> Move the unregistration to blk_unregister_queue instead (which matches
> the sysfs unregistration) to make sure the debugfs life time rules match
> those of the disk name.

Not look into details yet, but as one blk-mq debugfs user, I don't like
the idea, since I often see io hang issue when calling
blk_mq_freeze_queue_wait(), and blk-mq debugfs is very helpful for
investigating this kind of issue.

But now blk-mq debugfs is gone with this patch __before__ draining IO in
del_gendisk, and it becomes not useful as before.


Thanks,
Ming

