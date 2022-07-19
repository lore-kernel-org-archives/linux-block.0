Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6454C43334
	for <linux-block@archiver.kernel.org>; Tue, 19 Jul 2022 13:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbiGSNVu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jul 2022 09:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239655AbiGSNV2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jul 2022 09:21:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6057DCBD25
        for <linux-block@vger.kernel.org>; Tue, 19 Jul 2022 05:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658234262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qvqB2ULTeD0f2GX9QuVLUrCzayp94gM6HQvsFtp7g0Y=;
        b=YeZVLofE3Ma1D+84yqjuOi5EkwcSPQ2toKyGMMxGVwl9kxtJ5UL1DeIXLgWSXJTOD3Upbf
        4+uykOSYboM7Muk/jhJTuxJlM6ThUQl1HziqMR/6UNgDuA8L6A7SKn8jdfMm2d5lLdo1f3
        7tFxqP3NaGbE3thZfXybYGf+uInWGtE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-ND3EB5wzOqynH1WRPi1hVw-1; Tue, 19 Jul 2022 08:37:33 -0400
X-MC-Unique: ND3EB5wzOqynH1WRPi1hVw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB0031C068F5;
        Tue, 19 Jul 2022 12:37:32 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D5098141511F;
        Tue, 19 Jul 2022 12:37:29 +0000 (UTC)
Date:   Tue, 19 Jul 2022 20:37:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH 2/2] Revert "ublk_drv: fix request queue leak"
Message-ID: <YtalgzqC/q3JpYCR@T590>
References: <20220718062928.335399-1-hch@lst.de>
 <20220718062928.335399-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718062928.335399-2-hch@lst.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

On Mon, Jul 18, 2022 at 08:29:28AM +0200, Christoph Hellwig wrote:
> This was just a rather broken way to paper over a core block layer bug
> that is now fixed.
> 
> This reverts commit cebbe577cb17ed9b04b50d9e6802a8bacffbadca.

This change will break START_DEV/STOP_DEV, which is supposed to run
multiple cycles after the device is added, especially this way can
help to implement error recovery from userside, such as one ubq_daemon
is crashed/hang, the device can be recovered by sending STOP_DEV/START_DEV
commands again after new ubq_daemon is setup.

So here we do need separated request_queue/disk, and the model is
similar with scsi's, in which disk rebind needs to be supported
and GD_OWNS_QUEUE can't be set.


Thanks,
Ming

