Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A138C77B7C
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 15:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241724AbjELPJa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 11:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241739AbjELPJ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 11:09:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F9946A5
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 08:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683904120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9elHzm14HVz/I3f2sbcn8LDOCUW/BfhAry+4IEil1CE=;
        b=C9PUlUZgYuBWg3niQfRuxTc7EQem0Zqv7eWlf0qxUbcE1OEQr2aI2P+aHiJR++4JAM8agH
        glHY/GF/+pFRCW3hl6pq/8VO7zPRprJSej5ccj3CFgnod60Rd4m9Q8lqYpjp08padWqmO5
        +CwIOx5rh+MB/o+LBjCJ964yxt2OQwQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-LNsn7ufMMl-yR9fg7erzaQ-1; Fri, 12 May 2023 11:08:39 -0400
X-MC-Unique: LNsn7ufMMl-yR9fg7erzaQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBAD329A9CB6;
        Fri, 12 May 2023 15:08:38 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C56462166B26;
        Fri, 12 May 2023 15:08:36 +0000 (UTC)
Date:   Fri, 12 May 2023 23:08:31 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH] ublk: fix command op code check
Message-ID: <ZF5Wb7L3I8YLqaaJ@ovpn-8-16.pek2.redhat.com>
References: <20230505153142.1258336-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505153142.1258336-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 05, 2023 at 11:31:42PM +0800, Ming Lei wrote:
> In case of CONFIG_BLKDEV_UBLK_LEGACY_OPCODES, type of cmd opcode could
> be 0 or 'u'; and type can only be 'u' if CONFIG_BLKDEV_UBLK_LEGACY_OPCODES
> isn't set.
> 
> So fix the wrong check.
> 
> Fixes: 2d786e66c966 ("block: ublk: switch to ioctl command encoding")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Hello Jens,

Can you queue this fix for 6.3?


Thanks,
Ming

