Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB6EECAAD4
	for <linux-block@archiver.kernel.org>; Sat,  3 Sep 2022 09:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiICJiz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 3 Sep 2022 05:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiICJiz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 3 Sep 2022 05:38:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1289FB517F
        for <linux-block@vger.kernel.org>; Sat,  3 Sep 2022 02:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662197933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v1+14Jg5peWtfUOT27A8aZpElfnNxxD0uvy3KZ4DOK4=;
        b=Cm2+I1sumAFAYGJwm8MGTtEYcwT8gZTy1iTNu79xN5wl5O5a5rJcAgI3PYWSw3dyumTaJM
        aSxOMtA5jdm+KYNXrVjPWZqaSp+uHH5FHmwAJd6OIJV+1TJvi6Dc9eOJjk0VGdAQg0+z8d
        dRciQNQmnlm4Pq3k/WV2GbaJS0GW8Zs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-222-Jr5Au8kjMrqyHYAku2jPag-1; Sat, 03 Sep 2022 05:38:49 -0400
X-MC-Unique: Jr5Au8kjMrqyHYAku2jPag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66935801231;
        Sat,  3 Sep 2022 09:38:49 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A158A2026D4C;
        Sat,  3 Sep 2022 09:38:46 +0000 (UTC)
Date:   Sat, 3 Sep 2022 17:38:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: don't add partitions if GD_SUPPRESS_PART_SCAN is
 set
Message-ID: <YxMgpZ+gy7e8ItkQ@T590>
References: <20220823103819.395776-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823103819.395776-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 23, 2022 at 06:38:19PM +0800, Ming Lei wrote:
> Commit b9684a71fca7 ("block, loop: support partitions without scanning")
> adds GD_SUPPRESS_PART_SCAN for replacing part function of
> GENHD_FL_NO_PART. But looks blk_add_partitions() is missed, since
> loop doesn't want to add partitions if GENHD_FL_NO_PART was set.
> And it causes regression on libblockdev (as called from udisks) which
> operates with the LO_FLAGS_PARTSCAN.
> 
> Fixes the issue by not adding partitions if GD_SUPPRESS_PART_SCAN is
> set.
> 
> Fixes: b9684a71fca7 ("block, loop: support partitions without scanning")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Hello Jens,

Any chance to merge this patch to v6.0?

Thanks,
Ming

