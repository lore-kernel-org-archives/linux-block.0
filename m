Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3363C433EF
	for <linux-block@archiver.kernel.org>; Fri, 27 May 2022 12:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348612AbiE0Mg4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 May 2022 08:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352147AbiE0Mer (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 May 2022 08:34:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15A7315E63F
        for <linux-block@vger.kernel.org>; Fri, 27 May 2022 05:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653653749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2bGPVPvfFk4EyyzDfsuiyfWcJ9auiucrugHfToxISX8=;
        b=EhXe/8s65o8TCTcWfnP58p+x8K6S3G2m0N3cbQ6CSiJ5W3eiaVWiWojvOkrtEF6nBbRTjX
        5QdML9NwzkX16VxwKpicUhO/Pn946rBY5paUkXNjYEufj+tvK7ZAGa79BiSWXSgUEetQdc
        Zd73StJiLilWAIP6MCYuqopAUGbVZkA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520--iRcPKWJMeOptrTrH4ZeZQ-1; Fri, 27 May 2022 08:15:38 -0400
X-MC-Unique: -iRcPKWJMeOptrTrH4ZeZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0306800882;
        Fri, 27 May 2022 12:15:37 +0000 (UTC)
Received: from T590 (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1278A1678F;
        Fri, 27 May 2022 12:15:34 +0000 (UTC)
Date:   Fri, 27 May 2022 20:15:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] block, loop: support partitions without scanning
Message-ID: <YpDA4Ux6IYi5XwOZ@T590>
References: <20220527055806.1972352-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527055806.1972352-1-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 27, 2022 at 07:58:06AM +0200, Christoph Hellwig wrote:
> Historically we did distinguish between a flag that surpressed partition
> scanning, and a combinations of the minors variable and another flag if
> any partitions were supported.  This was generally confusing and doesn't
> make much sense, but some corner case uses of the loop driver actually
> do want to support manually added partitions on a device that does not
> actively scan for partitions.  To make things worsee the loop driver
> also wants to dynamically toggle the scanning for partitions on a live
> gendisk, which makes the disk->flags updates non-atomic.
> 
> Introduce a new GD_SUPPRESS_PART_SCAN bit in disk->state that disables
> just scanning for partitions, and toggle that instead of GENHD_FL_NO_PART
> in the loop driver.
> 
> Fixes: 1ebe2e5f9d68 ("block: remove GENHD_FL_EXT_DEVT")
> Reported-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

