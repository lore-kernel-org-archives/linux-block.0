Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87563EE49A4
	for <linux-block@archiver.kernel.org>; Mon, 21 Aug 2023 02:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjHUCRU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Aug 2023 22:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjHUCRT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Aug 2023 22:17:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1F19C
        for <linux-block@vger.kernel.org>; Sun, 20 Aug 2023 19:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692584191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZgxLdtFO5t4RaYO0u/a/Nr0ZBkZ3ROxYuZOf+k3RdXY=;
        b=XGWJQQgkEqWSMiMhjx8WNACTZXJKHnKJv2Dc+f9kjGmb931q3MMtv3id40s4zWjJ4W1hHH
        RGUWjNkXFue9c06v18B83r9jtUc+kRGXtyqdqKdoQH367Fi+nbJq9UreBUGajIdMNIchTF
        xIVuNI4teCNBFXBoj6x6yorBkbwT0n4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-77-ClDchx78PCu2pUO3GI2VfA-1; Sun, 20 Aug 2023 22:16:27 -0400
X-MC-Unique: ClDchx78PCu2pUO3GI2VfA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6ADD6800C78;
        Mon, 21 Aug 2023 02:16:27 +0000 (UTC)
Received: from fedora (unknown [10.72.120.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 64312492C13;
        Mon, 21 Aug 2023 02:16:22 +0000 (UTC)
Date:   Mon, 21 Aug 2023 10:16:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Niklas Cassel <Niklas.Cassel@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH V2] ublk: zoned: support REQ_OP_ZONE_RESET_ALL
Message-ID: <ZOLI8b5YvqN1PNHi@fedora>
References: <20230810124326.321472-1-ming.lei@redhat.com>
 <ZNmK9RYa4NMTCfGC@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNmK9RYa4NMTCfGC@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 14, 2023 at 10:01:25AM +0800, Ming Lei wrote:
> On Thu, Aug 10, 2023 at 08:43:26PM +0800, Ming Lei wrote:
> > There isn't any reason to not support REQ_OP_ZONE_RESET_ALL given everything
> > is actually handled in userspace, not mention it is pretty easy to support
> > RESET_ALL.
> > 
> > So enable REQ_OP_ZONE_RESET_ALL and let userspace handle it.
> > 
> > Verified by 'tools/zbc_reset_zone -all /dev/ublkb0' in libzbc[1] with
> > libublk-rs based ublk-zoned target prototype[2], follows command line
> > for creating ublk-zoned:
> > 
> > 	cargo run --example zoned -- add -1 1024	# add $dev_id $DEV_SIZE
> > 
> > [1] https://github.com/westerndigitalcorporation/libzbc
> > [2] https://github.com/ming1/libublk-rs/tree/zoned.v2
> > 
> > Cc: Niklas Cassel <Niklas.Cassel@wdc.com>
> > Cc: Damien Le Moal <dlemoal@kernel.org>
> > Cc: Andreas Hindborg <a.hindborg@samsung.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> > V2:
> > 	- update comment as reported by Niklas
> 
> Hello Jens,
> 
> Can you merge this one since V2 addresses Niklas's concern.

Ping...

Thanks,
Ming

