Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B67AECAAA1
	for <linux-block@archiver.kernel.org>; Tue, 30 Aug 2022 14:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiH3OOP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Aug 2022 10:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiH3OOP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Aug 2022 10:14:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4D4F619A
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 07:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661868853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CsVpi3FJ2ALwOSFXBD3Ac1gdDahmthKaIOff9+SMOKM=;
        b=E6b/GDX5vzLYb0yk7DhsMALu+Ns7wpsSlQ9JBr+2Cs5FHcitQddTm/2c4BbGJJ0NB6F/7F
        e1m/DTAANZK3kBI7r9NyhLfQBGrnP0yNetVU2e6H9ziwXpL2n3drQdxoYo9cxcJ+FeTaY4
        12ckJwWnoKom7dMGw4DQUYWeXGR9LaI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-ACr46tIpP0CuZD2Ixi9pDQ-1; Tue, 30 Aug 2022 10:14:09 -0400
X-MC-Unique: ACr46tIpP0CuZD2Ixi9pDQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F82A805F38;
        Tue, 30 Aug 2022 14:14:08 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F80940357BA;
        Tue, 30 Aug 2022 14:14:00 +0000 (UTC)
Date:   Tue, 30 Aug 2022 22:13:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Richard W . M . Jones" <rjones@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: Re: [PATCH] Docs: ublk: add ublk document
Message-ID: <Yw4bJnPdWZPrVJFN@T590>
References: <20220828045003.537131-1-ming.lei@redhat.com>
 <21e0e256-c223-5395-d992-040e98ce3308@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21e0e256-c223-5395-d992-040e98ce3308@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 30, 2022 at 07:14:51PM +0700, Bagas Sanjaya wrote:
> On 8/28/22 11:50, Ming Lei wrote:
> > +- UBLK_CMD_ADD_DEV
> > +  Add one ublk char device(``/dev/ublkc*``) which is talked with ublksrv wrt.
> > +  IO command communication. Basic device info is sent together with this
> > +  command, see UAPI structure of ublksrv_ctrl_dev_info, such as nr_hw_queues,
> > +  queue_depth, and max IO request buffer size, which info is negotiated with
> > +  ublk driver and sent back to ublksrv. After this command is completed, the
> > +  basic device info can't be changed any more.
> > +
> 
> Is "see UAPI structure" means set the structure?

Yes, but some fields may be changed by driver and sent back.

thanks,
Ming

