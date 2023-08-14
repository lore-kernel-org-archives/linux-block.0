Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9D3C04A6A
	for <linux-block@archiver.kernel.org>; Mon, 14 Aug 2023 02:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjHNCDi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Aug 2023 22:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbjHNCC2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Aug 2023 22:02:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD5F1BCA
        for <linux-block@vger.kernel.org>; Sun, 13 Aug 2023 19:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691978495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hL9JlSYqQ5o10U6VYsdiSQcTkv6K40D0t0xGAUBu8HY=;
        b=WEYMf4ydTkltxxllQSdsWCmgEQfiuywfudmUw/tQxBpxFJ/rJr1NedLbIb1aVXYV5WUT7e
        miLsesMHItlw5+RKE6QllQEv+cAgpcoIotlT608LCTAJ+pQnzflr5BETTYI3Xjzt+VegFO
        Fc1SE0f8ZEwoPTcxUTK8S3l0BKvRbxo=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-Etm8L7gVOryC1UcHfUzMmw-1; Sun, 13 Aug 2023 22:01:34 -0400
X-MC-Unique: Etm8L7gVOryC1UcHfUzMmw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE8683C0256C;
        Mon, 14 Aug 2023 02:01:33 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D6611121314;
        Mon, 14 Aug 2023 02:01:30 +0000 (UTC)
Date:   Mon, 14 Aug 2023 10:01:25 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Niklas Cassel <Niklas.Cassel@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH V2] ublk: zoned: support REQ_OP_ZONE_RESET_ALL
Message-ID: <ZNmK9RYa4NMTCfGC@fedora>
References: <20230810124326.321472-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810124326.321472-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 10, 2023 at 08:43:26PM +0800, Ming Lei wrote:
> There isn't any reason to not support REQ_OP_ZONE_RESET_ALL given everything
> is actually handled in userspace, not mention it is pretty easy to support
> RESET_ALL.
> 
> So enable REQ_OP_ZONE_RESET_ALL and let userspace handle it.
> 
> Verified by 'tools/zbc_reset_zone -all /dev/ublkb0' in libzbc[1] with
> libublk-rs based ublk-zoned target prototype[2], follows command line
> for creating ublk-zoned:
> 
> 	cargo run --example zoned -- add -1 1024	# add $dev_id $DEV_SIZE
> 
> [1] https://github.com/westerndigitalcorporation/libzbc
> [2] https://github.com/ming1/libublk-rs/tree/zoned.v2
> 
> Cc: Niklas Cassel <Niklas.Cassel@wdc.com>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Andreas Hindborg <a.hindborg@samsung.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- update comment as reported by Niklas

Hello Jens,

Can you merge this one since V2 addresses Niklas's concern.

Thanks,
Ming

