Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06ABC00140
	for <linux-block@archiver.kernel.org>; Mon,  1 Aug 2022 02:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238179AbiHACQk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Jul 2022 22:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbiHACQi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Jul 2022 22:16:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A853AE53
        for <linux-block@vger.kernel.org>; Sun, 31 Jul 2022 19:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659320196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z6sqDqDtHH8wWC8cJSbLo9vb+r9yffc56CXkeXj9HQ0=;
        b=HwVTjRszRzePLwFp74ob5e+9Fzol8EXAlV5DLo4vc8BVnWKALP+ve6TozpZmHGxTNbauje
        V88t1iikYJNJQHPdA8GUddNbrYuq2enJ8I9GM/Bi+xB+GUpMYCsGEPkowG9kI+OTy+L0Gv
        9h5qQ8K90NNrC1+1cvD/QRVHTpFg0wQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-D6jVm96RNTeAk8JN8auRZQ-1; Sun, 31 Jul 2022 22:16:31 -0400
X-MC-Unique: D6jVm96RNTeAk8JN8auRZQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96F0A185A7B2;
        Mon,  1 Aug 2022 02:16:30 +0000 (UTC)
Received: from T590 (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A7D46400DEF8;
        Mon,  1 Aug 2022 02:16:27 +0000 (UTC)
Date:   Mon, 1 Aug 2022 10:16:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        xiaoguang.wang@linux.alibaba.com
Subject: Re: [PATCH V4 0/2] ublk: add support for UBLK_IO_NEED_GET_DATA
Message-ID: <Yuc3dq50YoU3CVzP@T590>
References: <cover.1659011443.git.ZiyangZhang@linux.alibaba.com>
 <4c6f7d83-183a-da98-a41a-5363db6f3297@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c6f7d83-183a-da98-a41a-5363db6f3297@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jul 31, 2022 at 04:03:30PM +0800, Ziyang Zhang wrote:
> Hi Jens,
> 
> Please queue this patchset up for the 5.20 merge window.
> 
> UBLK_IO_NEED_GET_DATA is an important feature designed for Ming Lei's
> ublk_drv. All the patches have been reviewed by Ming and all test cases
> in his ublksrv[1] have been passed.

Hi Jens,

This feature is helpful for existed projects to switch to ublk from similar
tech, so IMO the change makes sense.


thanks, 
Ming

