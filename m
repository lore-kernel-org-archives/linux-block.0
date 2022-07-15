Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E925BC43334
	for <linux-block@archiver.kernel.org>; Fri, 15 Jul 2022 09:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiGOJ0w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jul 2022 05:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiGOJ0v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jul 2022 05:26:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A82027A519
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 02:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657877209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r6hBNMDGyc62DE2qGBbYP5Gz3YVgkT8ZR1sceLIav0w=;
        b=dH865EKY4uaa7LA8upQe84v+iUkjXiqipS+Ufd3xZNj6zVdzBAHI7JICiWS8lUCIo3W6ep
        LN/F5J7LhSRRhYvJjoLTCV6C9Bl5KVla5OjlNO01rsCLTjnfT6+i0vjcfUWQeIFzvEnESl
        0QpLFVC5Cz277RvJi33ERI8P6tLUjBY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-601-3Qg_kTx-P1qWcU_lDWZPHQ-1; Fri, 15 Jul 2022 05:26:46 -0400
X-MC-Unique: 3Qg_kTx-P1qWcU_lDWZPHQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A06D1801755;
        Fri, 15 Jul 2022 09:26:45 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 79128C04482;
        Fri, 15 Jul 2022 09:26:37 +0000 (UTC)
Date:   Fri, 15 Jul 2022 17:26:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Vincent Fu <vincent.fu@samsung.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] null_blk: prevent NULL dereference in
 null_init_tag_set()
Message-ID: <YtEyxAU0JSGVWqKd@T590>
References: <YtEhCjDq2oe2SIkS@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtEhCjDq2oe2SIkS@kili>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Dan,

On Fri, Jul 15, 2022 at 11:10:50AM +0300, Dan Carpenter wrote:
> The "nullb" pointer can be NULL.  Smatch prints a warning about this:
> 
>     drivers/block/null_blk/main.c:1914 null_init_tag_set()
>     error: we previously assumed 'nullb' could be null (see line 1911)
> 
> Fixes: 37ae152c7a0d ("null_blk: add configfs variables for 2 options")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

FYI,

I have posted another fix/cleanup for this issue:

https://lore.kernel.org/linux-block/20220715031916.151469-1-ming.lei@redhat.com/T/#u


Thanks,
Ming

