Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FE7ECAAD1
	for <linux-block@archiver.kernel.org>; Thu,  1 Sep 2022 03:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiIADMz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Aug 2022 23:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiIADMu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Aug 2022 23:12:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64233E0FDD
        for <linux-block@vger.kernel.org>; Wed, 31 Aug 2022 20:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662001968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yIgIZFBw78kIOv79sLbHF4ZmNrSCwpW9QOAJDHkgz0o=;
        b=PVwLsCN8AfnTJFrjo0nHPi39THE252k6TG/EGFilzUkejPrZGrkcktxbjKwm4m1RouFqPS
        1OXViFNMyyiP/Ac+ArnpyFMLl1XcbuhE3LxhHdHulx/135Wbha7AyiS9tqw53XtkiKxBpm
        hH8uJcb+b8NtMs0Zl7o9rwMOUxRrI7s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-RxgKDJX-P6mqncGKuUJfAg-1; Wed, 31 Aug 2022 23:12:44 -0400
X-MC-Unique: RxgKDJX-P6mqncGKuUJfAg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29603803301;
        Thu,  1 Sep 2022 03:12:44 +0000 (UTC)
Received: from T590 (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DD76492C3B;
        Thu,  1 Sep 2022 03:12:38 +0000 (UTC)
Date:   Thu, 1 Sep 2022 11:12:36 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Richard W . M . Jones" <rjones@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: Re: [PATCH V2 1/1] Docs: ublk: add ublk document
Message-ID: <YxAjJJLoU7LR4ahh@T590>
References: <20220901023008.669893-1-ming.lei@redhat.com>
 <0dc0e0ac-75cd-81e5-e54b-1b0436090f4c@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dc0e0ac-75cd-81e5-e54b-1b0436090f4c@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 01, 2022 at 11:04:24AM +0800, Ziyang Zhang wrote:
> On 2022/9/1 10:30, Ming Lei wrote:
> > +
> > +- ``UBLK_IO_NEED_GET_DATA``
> > +
> > +  ublk server pre-allocates IO buffer for each IO by default. Any new projects
> > +  should use this buffer to communicate with ublk driver. However, existing
> > +  projects may break or not able to consume the new buffer interface; that's
> > +  why this command is added for backwards compatibility so that existing
> > +  projects can still consume existing buffers.
> 
> Hi, Ming.
> 
> Could you please add more information on UBLK_IO_NEED_GET_DATA. stefanha
> found it hard to understand.
> 
> Myabe we should write like this:
> 
> With UBLK_F_NEED_GET_DATA enabled, the WRITE request will be firstly issued to
> ublksrv without data copy. Then, IO backend receives the request and it can allocate
> data buffer and embed its addr inside a new ioucmd. After the kernel driver gets the
> ioucmd, the data copy happens(from biovecs to backend's buffer). Finally,
> the backend receives the request again with data to be written and it can truly
> handle the request.
> 
> UBLK_IO_NEED_GET_DATA add one additional round-trip in ublk_drv and one
> io_uring_enter() syscall. Any user thinks that it may lower performance
> should not enable UBLK_F_NEED_GET_DATA. ublk server pre-allocates IO buffer
> for each IO by default. Any new projects should use this buffer to communicate
> with ublk driver. However, existing projects may break or not able to consume
> the new buffer interface; that's why this command is added for backwards
> compatibility so that existing projects can still consume existing buffers.

I am fine to add it if V3 is needed. If not, please send a new patch.

BTW, I guess Jens may consider it for v6.0.

Thanks,
Ming

