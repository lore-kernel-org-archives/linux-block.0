Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846FDC43334
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 07:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiGUHPs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 03:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiGUHPr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 03:15:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FDAC7B7A2
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 00:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658387745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lOZQPbTsHpKcgMEDvwjgRpFPYjZdmaKijWN1c98XWsc=;
        b=cxDV8XGVl5S1lrKQRrkPfoJZIHOEl89pXivqLbxzbepdYSvd4u1xuA5q/3TUNgM2c3mpRl
        LGndndGu6C9foj2jL23SEkf2fZf2k0J15g8zYNczSjQ2HiG8b1BC5iXKYD85L7ehID0jEA
        r6EWXwm9j/kVGKPvkJ20Puu2gbKYhTQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-5j7A35EROZW7LC56vCSj0g-1; Thu, 21 Jul 2022 03:15:38 -0400
X-MC-Unique: 5j7A35EROZW7LC56vCSj0g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B50A2381A084;
        Thu, 21 Jul 2022 07:15:37 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A391140EBE3;
        Thu, 21 Jul 2022 07:15:34 +0000 (UTC)
Date:   Thu, 21 Jul 2022 15:15:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 4/8] ublk: simplify ublk_ch_open and ublk_ch_release
Message-ID: <Ytj9EnJA6MpgVPK8@T590>
References: <20220721051632.1676890-1-hch@lst.de>
 <20220721051632.1676890-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721051632.1676890-5-hch@lst.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 21, 2022 at 07:16:28AM +0200, Christoph Hellwig wrote:
> fops->open and fops->release are always paired.  Use simple atomic bit
> ops ot indicate if the device is opened instead of a count that can
> only be 0 and 1 and a useless cmpxchg loop in ublk_ch_release.
> 
> Also don't bother clearing file->private_data is the file is about to
> be freed anyway.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

