Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0FAC00140
	for <linux-block@archiver.kernel.org>; Mon,  1 Aug 2022 02:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiHACNq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Jul 2022 22:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiHACNq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Jul 2022 22:13:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66DD01117D
        for <linux-block@vger.kernel.org>; Sun, 31 Jul 2022 19:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659320024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SNBLTwM16adB5UKRKQ1X3zK1SF3CcLbPbx3gf5hTRTI=;
        b=KKhPOCV2qNZ+mDSwNVpF/UTnXcoDQ25FGFdwXYmFMOz9FQJW60tpizf41X2mivCCY9NWFm
        FrPnuzuvfPwUC7OtWEvs+rM986IP8f/9pXLiOIr1pGhfs4HmsH1vFpT8RlkdMCaHmUwNWy
        yeP5XJGFZNv/IJ2fUyGyrS0oIYbK+bA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-s1FBi4s7NHS8j2QdhRdC0A-1; Sun, 31 Jul 2022 22:13:40 -0400
X-MC-Unique: s1FBi4s7NHS8j2QdhRdC0A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5706F38041D1;
        Mon,  1 Aug 2022 02:13:40 +0000 (UTC)
Received: from T590 (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 15D694010FA3;
        Mon,  1 Aug 2022 02:13:36 +0000 (UTC)
Date:   Mon, 1 Aug 2022 10:13:31 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH V4 0/4] ublk_drv: add generic mechanism to get/set
 parameters
Message-ID: <Yuc2yxnxoFVADcjX@T590>
References: <20220730092750.1118167-1-ming.lei@redhat.com>
 <1596ad46-1a21-f7ac-a335-059b7d6732f5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596ad46-1a21-f7ac-a335-059b7d6732f5@kernel.dk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jul 30, 2022 at 09:04:24AM -0600, Jens Axboe wrote:
> On 7/30/22 3:27 AM, Ming Lei wrote:
> > Hello Jens,
> > 
> > The 1st two patches fixes ublk device leak or hang issue in case of some
> > failure path, such as, failing to start device.
> > 
> > The 3rd patch adds two control commands for setting/getting device
> > parameters in generic way, and easy to extend to add new parameter
> > type.
> > 
> > The 4th patch cleans UAPI of ublksrv_ctrl_dev_info, and userspace needs
> > to be updated for this driver change, so please consider this patchset
> > for v5.20.
> > 
> > Verified by all targets in the following branch, and pass all built-in
> > tests.
> 
> This will miss the first pull request, but I've queued it up for this
> merge window.

That is great, thanks for queuing it up!

-- 
Ming

