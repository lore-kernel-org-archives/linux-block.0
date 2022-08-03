Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481F9C3F6B0
	for <linux-block@archiver.kernel.org>; Wed,  3 Aug 2022 12:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbiHCMB6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Aug 2022 08:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236032AbiHCMB5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Aug 2022 08:01:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D2031A072
        for <linux-block@vger.kernel.org>; Wed,  3 Aug 2022 05:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659528114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FMDN7fOMV8Y6OoacuE2thTOHytfQ5CIZ31aPWlwXRno=;
        b=i0ls67FJ98OpFowEZYs51qJ0j2obSjellS/MMksRRAxUJ9DK2wJ9OobEaoOr+D23SYOolR
        ppYF9DUQgUT9IUz0wv39AVdKJ2+wZyBpqMKS/XujcqkzoVTZjWgaKnPJjIG2Gqe3nE3XyT
        v40Y7CuW14bBVkXxRaVYlROXdvxvfE0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-_bYiyWcFPVeBfpOaFv7Wxw-1; Wed, 03 Aug 2022 08:01:49 -0400
X-MC-Unique: _bYiyWcFPVeBfpOaFv7Wxw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1449B1019C93;
        Wed,  3 Aug 2022 12:01:49 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CFD1AC28100;
        Wed,  3 Aug 2022 12:01:45 +0000 (UTC)
Date:   Wed, 3 Aug 2022 20:01:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [bug report] ublk_drv: hang while removing ublk character device
Message-ID: <YupjpIAQYxbuaOR6@T590>
References: <99bc953a-22d4-2bb2-e2b9-f0a92e787c1b@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99bc953a-22d4-2bb2-e2b9-f0a92e787c1b@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ziyang,

On Wed, Aug 03, 2022 at 07:45:24PM +0800, Ziyang Zhang wrote:
> Hi all,
> 
> Now ublk_drv has been pushed into master branch and I am running tests on it.
> With newest(master) kernel and newest(master) ublksrv[1], a test case(generic/001) of ublksrv failed(hanged):
> 

Please see the fix:

https://lore.kernel.org/io-uring/48b58f2b-014c-cbc6-36c3-29be42040fa0@gmail.com/T/#t


Thanks,
Ming

