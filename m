Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ED9C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 07:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiGUHNY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 03:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiGUHNY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 03:13:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AEE527B1DA
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 00:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658387602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pFCazA2HOZV1LZqm4NlD+oLAMZfkc305Jyma3uM8sRM=;
        b=WsXodgumulBsLvPRijDrXbwZQmR2f6Gpt85PJTrjFgqX+d54UySw6lC4lWLZiYAUdflnQo
        BAjLeQbH/PF1AMd6Yn0odSQ4WufbRmUIS5ZvH59q9TPjKaS1UsVyTRtIw46Sj9iQVf0Gsg
        hOX4Sfo0rUAfRodUEONm1Af1fmOKgr8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-0s7babJcP3ynwCUFyEfulg-1; Thu, 21 Jul 2022 03:13:19 -0400
X-MC-Unique: 0s7babJcP3ynwCUFyEfulg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F22FB101A588;
        Thu, 21 Jul 2022 07:13:18 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 83F52492C3B;
        Thu, 21 Jul 2022 07:13:16 +0000 (UTC)
Date:   Thu, 21 Jul 2022 15:13:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/8] ublk: remove UBLK_IO_F_PREFLUSH
Message-ID: <Ytj8hw6YhNFTVJd7@T590>
References: <20220721051632.1676890-1-hch@lst.de>
 <20220721051632.1676890-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721051632.1676890-3-hch@lst.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 21, 2022 at 07:16:26AM +0200, Christoph Hellwig wrote:
> REQ_PREFLUSH is turned into REQ_OP_FLUSH by the flush state machine
> and thus never seen by a blk-mq based driver.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

