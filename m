Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7CBC43334
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 15:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiGUP1s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGUP1s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 11:27:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DFD17E834
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 08:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658417266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jt+VQaNoLWFdB5GpXhfQ0cJg2gOlU0NSFQCavaAH/6E=;
        b=SpeRTf3ag7/SUI9Rrcg+imVDCloSkHVeo5ljJ6JW7lBdnrSnOM5X8TMTX/xdZNNhSgE3gZ
        QtS62i5jDRdmxAIgBVgN/rM2n2+VSABIYchLqAiGm7+JFvsS37oFgVWWt3FkLcOaQ2cXlk
        SzSf3D2Fvu1m5ofcuLnE/Bg9LuEfAQc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-J4ktH5hQMFeTbL-97gDfHQ-1; Thu, 21 Jul 2022 11:27:36 -0400
X-MC-Unique: J4ktH5hQMFeTbL-97gDfHQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20D84280EE2B;
        Thu, 21 Jul 2022 15:27:36 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E19D492C3B;
        Thu, 21 Jul 2022 15:27:33 +0000 (UTC)
Date:   Thu, 21 Jul 2022 23:27:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: ublk vs write cache and FUA
Message-ID: <YtlwYKu8S4SV68MK@T590>
References: <20220721151458.GA4399@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721151458.GA4399@lst.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 21, 2022 at 05:14:58PM +0200, Christoph Hellwig wrote:
> Hi Ming,
> 
> ublk implements REQ_OP_FLUSH and REQ_FUA, but will never see those as
> it never calls blk_queue_write_cache.  Can we drop the code?  Or should
> there be a flag to enable write cache and fua support when setting up
> a device?

There should have been flags defined in ublksrv_ctrl_dev_info for describe
wc/fua info, since ublk_drv doesn't handle any device specific logic.

So please keep REQ_OP_FLUSH and REQ_FUA which two should be useful, and I
will add flags and related code to use them.


Thanks,
Ming

