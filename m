Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0957CC77B62
	for <linux-block@archiver.kernel.org>; Sat,  1 Apr 2023 13:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjDANYD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Apr 2023 09:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjDANYC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Apr 2023 09:24:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2FB25479
        for <linux-block@vger.kernel.org>; Sat,  1 Apr 2023 06:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680355354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WVXk13Jt7hsNQvxvVP08hy5UcBn+tBDbfgB3QoQy/aw=;
        b=cuqZ7HNruxV/YOWGXihQmobP3NhyP6HmJuDrf/Nj7pwYKLuT8u5+bFVg5ym+eeLImw+RSt
        TKey8R32YEYReDBhO30EiqSKyCpWMpvxzgUuHtjPxTHxSxv9RRnPEM6Bl9pBPIc5j4ladQ
        tXEba6T8i1oUQ8LJrhDRtzG/ynRVJto=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-W_xJP64DP8-Bw2Hu84eTPw-1; Sat, 01 Apr 2023 09:22:33 -0400
X-MC-Unique: W_xJP64DP8-Bw2Hu84eTPw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B56861C05EB5;
        Sat,  1 Apr 2023 13:22:32 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D66791121314;
        Sat,  1 Apr 2023 13:22:25 +0000 (UTC)
Date:   Sat, 1 Apr 2023 21:22:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>, ming.lei@redhat.com
Subject: Re: [PATCH V6 17/17] block: ublk_drv: apply io_uring FUSED_CMD for
 supporting zero copy
Message-ID: <ZCgwDLhyZpFSi77R@ovpn-8-18.pek2.redhat.com>
References: <20230330113630.1388860-1-ming.lei@redhat.com>
 <20230330113630.1388860-18-ming.lei@redhat.com>
 <22d9e781-4100-9d24-0ece-a008fd299ab4@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22d9e781-4100-9d24-0ece-a008fd299ab4@ddn.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 31, 2023 at 07:55:30PM +0000, Bernd Schubert wrote:
> On 3/30/23 13:36, Ming Lei wrote:

...

> > +static inline bool ublk_check_fused_buf_dir(const struct request *req,
> > +		unsigned int flags)
> > +{
> > +	flags &= IO_URING_F_FUSED_BUF;
> 
> ~IO_URING_F_FUSED_BUF ?

IO_URING_F_FUSED_BUF is buffer direction mask, and we can get direction
flags only in above way, so the above is correct.


Thanks, 
Ming

