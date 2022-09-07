Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA59C38145
	for <linux-block@archiver.kernel.org>; Wed,  7 Sep 2022 00:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiIGApJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Sep 2022 20:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiIGApI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Sep 2022 20:45:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C54772852
        for <linux-block@vger.kernel.org>; Tue,  6 Sep 2022 17:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662511506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IWbBY2Vma6qLbzeS+8YTI+hqv9KeinttN4dUddHRaGg=;
        b=Akq5HTuttA2appyMqYBM4BFjkL/XCi8G+++iy2EUszbeg05VY19tZ3SEKhts5yxbfItcXH
        rLJcp6ycaIGbv7FYwQLoc/kQcVWCfyY8zDdlVMrav551WpjBH8XFqvlxSOe84qkvk1EuXd
        4pIfu2smgXZiKjtmPfMyFJU2KOrg4Rg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-RL7OylbtP1OI7Tm1awSYIg-1; Tue, 06 Sep 2022 20:45:01 -0400
X-MC-Unique: RL7OylbtP1OI7Tm1awSYIg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E9723C0F361;
        Wed,  7 Sep 2022 00:45:01 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D32CC2026D4C;
        Wed,  7 Sep 2022 00:44:57 +0000 (UTC)
Date:   Wed, 7 Sep 2022 08:44:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] kernel: export task_work_add
Message-ID: <Yxfpg0qBVG6ojMEu@T590>
References: <20220829040013.549212-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829040013.549212-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 29, 2022 at 12:00:13PM +0800, Ming Lei wrote:
> Firstly task_work_add() is used in several drivers. In ublk driver's
> usage, request batching submission can only be applied with task_work_add,
> and usually get better IOPS.
> 
> Secondly from this API's definition, the added work is always run in
> the task context, and when task is exiting, either the work is rejected
> to be added, or drained in do_exit(). In this way, not see obvious
> disadvantage or potential issue by exporting it for module's usage.
> 
> So export it, then ublk driver can get simplified, meantime with better
> performance.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Hello Guys,

Gentle ping...


Thanks,
Ming

