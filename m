Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7868EC43334
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 07:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiGUHNs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 03:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiGUHNr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 03:13:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 954EF7B7A3
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 00:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658387625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O7elfKrOIcGxrCxM8wkQ2ZyVrzsHZYQ2B4sCeypaLC8=;
        b=DAIhPpuFToKzKoOkVdOF+75ymhqanYbrzZLsAX/Rq3Qp2naCwJU3x0wGATnSVP7fIZOe/f
        4vt5h3ljDx7qPRDcQ1IJPUTA5mmtGmtlmgAUVjeP5jj6bFL9e7ix1P8PuhCYuq4ow6LXq4
        Ga548fLJYxwfUC4CRlItmFqEd/oH5M8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-DweenHFEOU-jQ-2HdfeaeQ-1; Thu, 21 Jul 2022 03:13:44 -0400
X-MC-Unique: DweenHFEOU-jQ-2HdfeaeQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04EAA85A584;
        Thu, 21 Jul 2022 07:13:44 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FD0E40C1288;
        Thu, 21 Jul 2022 07:13:41 +0000 (UTC)
Date:   Thu, 21 Jul 2022 15:13:36 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/8] ublk: remove the empty open and release block device
 operations
Message-ID: <Ytj8oMe5w2nyEIox@T590>
References: <20220721051632.1676890-1-hch@lst.de>
 <20220721051632.1676890-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721051632.1676890-4-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 21, 2022 at 07:16:27AM +0200, Christoph Hellwig wrote:
> No need to define empty versions, they can just be left out.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

