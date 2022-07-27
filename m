Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2749C00144
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 00:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbiG0AMz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 20:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240007AbiG0AMy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 20:12:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10E7A2DA80
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 17:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658880772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kIvxI5at0N5OA/nWEqXZTe32bt4YLHL02I0WkycfBkw=;
        b=PpmFIfmfUDRH2i5vSB7wSWZI68PWPm4k2JlWsUc9KeakkvSF4j28igVZrREyge+PNoimRX
        fetlMbBbHmg6R2jgDnJWg8RxYpwkXFDwdazpOXUVT5wYaz9i+hILZX1oqIl2s1pzGdnt3w
        16c+DH487yBiifSBoCNk2sHUYpIgabs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-GgNBFUQeO7qDCnhWfR37nw-1; Tue, 26 Jul 2022 20:12:46 -0400
X-MC-Unique: GgNBFUQeO7qDCnhWfR37nw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49C4738164C0;
        Wed, 27 Jul 2022 00:12:46 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A32102166B26;
        Wed, 27 Jul 2022 00:12:41 +0000 (UTC)
Date:   Wed, 27 Jul 2022 08:12:37 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>, ming.lei@redhat.com
Subject: Re: [PATCH 1/2] ublk_drv: store device parameters
Message-ID: <YuCC9RLhltg/DApp@T590>
References: <20220723150713.750369-1-ming.lei@redhat.com>
 <20220723150713.750369-2-ming.lei@redhat.com>
 <20220725064259.GA20796@lst.de>
 <Yt5BCtLi70Pits34@T590>
 <20220726123224.GA9435@lst.de>
 <Yt/4UBGtFDqr2SfA@T590>
 <20220726174721.GA14002@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726174721.GA14002@lst.de>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 26, 2022 at 07:47:21PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 26, 2022 at 10:21:04PM +0800, Ming Lei wrote:
> > But most of fields in ublk_params aren't required for one device,
> > sending them all isn't friendly from both userspace and kernel side.
> 
> I think it actually is easier for both.  For the kernel the benefit
> is pretty clear seen by this patch, and for userspae there also is
> a lot less boilerplate code.

If everything is put into single structure:

1) it is fragile for both userspace/driver side making/paring code
- such as, how to parse zeroed fields? With grouping parameters, if one type
parameter isn't sent via set param command, the userspace just meant we do
not care this parameter just like one real hardare, driver feels free to use
the default. But if it is sent as zero, driver may have to parse it as zero
and use zero, sometimes it can be wrong, and parsing parameter with zero for
kernel becomes hard.

With grouping parameter, if one parameter is sent from userspace, ublk
driver just parses & uses it explicitly. There isn't any burden for driver for
making such decision.

2) ublk driver has to parse every fields, and the code could be harder
to organize, since there isn't parameter group. With grouping
parameters, we just need to implement two callbacks when adding new parameter
type. So code is organized pretty well.

Wrt. cleanness, I will send V2 for review, and please feel free to let me
know where isn't clean, and I am happy to make it correct/clean from the
beginning. And userspace change will be updated too, and we can see
if userspace side has much boilerplate code.

> 
> > Especially inside kernel, a big chunk buffer is allocated for
> > the structure, but only few fields are useful for one device. There can
> > be lots of ublk device, and total wasted memory can't be ignored.
> 
> I think even right now the memory usage is less.  If a lot (and I mean

Adding segment limits & zoned limits are in my todo list.

> a lot) new paramters are added, it might be slightly higher than the
> minimal config with an xarray, but not to the point where it matters.

Alibaba said their case needs to run lots of ublk devices in one machine.
It is ABI interface, and I'd rather make it easy extending from the
beginning given there is the requirement for running lots of devices.

> 
> > If we group parameters, it is easier to extend by adding new parameter
> > type. One ublk device usually just uses several parameter types.
> > And the xarray implementation is simple enough too, which is just one
> > array, but really sparsed.
> 
> Well, it isn't exactly simple.  And the apprach of a struct that just
> grows additional members has worked perfectly fine all over the kernel.

In your patch, there isn't length field in ublk_params, not sure ublk
driver can copy back correct parameter. If userspace is old, on new
kernel with bigger structure size userspace buffer could be corrupted
by copying back kernel's structure. So here one length field is really
a must.

With grouping parameters, each type has fixed length which can't be
changed since it is added, we can verify it easily in both set/get param
command, meantime the parameter type can be verified reliably in driver side,
so grouping parameter is more reliable.


Thanks,
Ming

