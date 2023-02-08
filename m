Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49527C05027
	for <linux-block@archiver.kernel.org>; Wed,  8 Feb 2023 07:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjBHHc0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Feb 2023 02:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjBHHcZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Feb 2023 02:32:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D141C323
        for <linux-block@vger.kernel.org>; Tue,  7 Feb 2023 23:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675841502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f0fUJ08bbCxo3RchIQfKerKdri6w+mNP3VgVPzj103Q=;
        b=ejwYgOHz/Vj7t5v6Syf5lM7nqB2MVJfkJqkFlqvMboVtxel6y5KD5cjdASdYhw1TYVGtJy
        Nc1w3R24YXoF6tnrUiqnvoPzcS9Knz+haLepugAFXvlDhgIoFEvwCnwkzE2hb2MJrc3+uS
        33a1wF/ktaqRqqCk/r6uetPAGaC0fWc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103-PdnUgqfaOvi5yNlLhDuG0w-1; Wed, 08 Feb 2023 02:31:38 -0500
X-MC-Unique: PdnUgqfaOvi5yNlLhDuG0w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 652413806739;
        Wed,  8 Feb 2023 07:31:38 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 555BD40C83B6;
        Wed,  8 Feb 2023 07:31:34 +0000 (UTC)
Date:   Wed, 8 Feb 2023 15:31:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: ublk: improve handling device deletion
Message-ID: <Y+NP0ZGsSnGDeGT1@T590>
References: <20230207150700.545530-1-ming.lei@redhat.com>
 <fcd7fec3-d8f0-f04b-f7eb-10e2d583bfe6@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcd7fec3-d8f0-f04b-f7eb-10e2d583bfe6@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 08, 2023 at 01:57:42PM +0800, Ziyang Zhang wrote:
> On 2023/2/7 23:07, Ming Lei wrote:
> > Inside ublk_ctrl_del_dev(), when the device is removed, we wait
> > until the device number is freed with holding global lock of
> > ublk_ctl_mutex, this way isn't friendly from user viewpoint:
> > 
> > 1) if device is in-use, the current delete command hangs in
> > ublk_ctrl_del_dev(), and user can't break from the handling
> > because wait_event() is used
> > 
> > 2) global lock is held, so any new device can't be added and
> > other old devices can't be removed.
> > 
> > Improve the deleting handling by the following way, suggested by
> > Nadav:
> > 
> > 1) wait without holding the global lock
> > 
> > 2) replace wait_event() with wait_event_interruptible()
> > 
> > Reported-by: Nadav Amit <nadav.amit@gmail.com>
> > Suggested-by: Nadav Amit <nadav.amit@gmail.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> Hi Ming,
> 
> I tried this patch. And the folloing NPE bug was trigged by:
> 
> (0) dd if=/dev/zero of=/root/img bs=4096 count=1024768
> (1) ublk add -t loop -f /root/img
> (2) mkdir -p /root/ublk
> (3) mount /dev/ublkb0 /root/ublk
> (4) echo "hello" > /root/ublk
> (5) ./ublk del -n 0
> 
> So I delete the ublk device while it is mounting as
> an ext4 filesystem. I think ublk should handle this
> by (1) returning -EBUSY or (2) blocking incoming IO.

That isn't ublk unique, and is one recent block layer regression,
see the following report:

https://lore.kernel.org/linux-block/20230208063552.GA15030@lst.de/T/#u

Thanks,
Ming

