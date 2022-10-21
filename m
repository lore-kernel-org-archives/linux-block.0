Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8146EC433FE
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 03:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJUDsA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 23:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJUDr7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 23:47:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D52B1BC16C
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 20:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666324074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TykhW5iFncUHDB5XHHRkS75FYjeeJef8QsPki9BMuDs=;
        b=N36HF9e8k0Y5CEpY572vlc6I2ejPjbcObW5pqoBILhTq4RlX/LVf6M88BYcb2UaPrt9PIP
        aImIRakEcODvpQknfLZtS8oplzmAHXyX1cV7KJeUXYYq/eaXj9Njn2WFmoy/c3fF249yzb
        UDseFmXAQELiK7KTyqFCFDC2XtKvzU8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-YyxZK8a2N0aPY4E5HTOcCA-1; Thu, 20 Oct 2022 23:47:49 -0400
X-MC-Unique: YyxZK8a2N0aPY4E5HTOcCA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 934C6185A7A8;
        Fri, 21 Oct 2022 03:47:48 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2275F2166B40;
        Fri, 21 Oct 2022 03:47:32 +0000 (UTC)
Date:   Fri, 21 Oct 2022 11:47:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, damien.lemoal@wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH -next] block: fix memory leak for elevator on add_disk
 failure
Message-ID: <Y1IWTOO1RUIOZJQN@T590>
References: <20221021033950.3913764-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021033950.3913764-1-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 21, 2022 at 11:39:50AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> The default elevator is allocated in the begining of device_add_disk(),
> however, it's not freed in the following error path.
> 
> Fixes: 737eb78e82d5 ("block: Delay default elevator initialization")

Originally elevator can be teardown in disk release, or queue release
earlier time, so the fixes tag should be:

Fixes: 50e34d78815e ("block: disable the elevator int del_gendisk")


Thanks, 
Ming

