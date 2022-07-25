Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2533FCCA48E
	for <linux-block@archiver.kernel.org>; Mon, 25 Jul 2022 07:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiGYHHG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jul 2022 03:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiGYHHG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jul 2022 03:07:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E962DEC7
        for <linux-block@vger.kernel.org>; Mon, 25 Jul 2022 00:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658732823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C6HOOXAAeSpz6v29UnOUYcpMsdp1bd+OxbUAYi69omQ=;
        b=dqiUBOz7seUkokVRTLTBkm8bazAu99U5Rfh/Lv2XXlYV/b7FBbjgUefPp0fE642zsJo/KO
        Q0AGZVQwp6xzgajuKDu+WVhyg4vv3qDaEzqWLPS1/wj4ZPKmXMzoROZk3gw7yMtvEyOoLv
        xRVaS8uNYVV1dqBd2Ek0Wv60KmEOqB8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-q53ow3FRNRWcPNCzHcoOFQ-1; Mon, 25 Jul 2022 03:06:59 -0400
X-MC-Unique: q53ow3FRNRWcPNCzHcoOFQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 620743C0D84C;
        Mon, 25 Jul 2022 07:06:59 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DC102166B2C;
        Mon, 25 Jul 2022 07:06:55 +0000 (UTC)
Date:   Mon, 25 Jul 2022 15:06:50 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH 1/2] ublk_drv: store device parameters
Message-ID: <Yt5BCtLi70Pits34@T590>
References: <20220723150713.750369-1-ming.lei@redhat.com>
 <20220723150713.750369-2-ming.lei@redhat.com>
 <20220725064259.GA20796@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725064259.GA20796@lst.de>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 25, 2022 at 08:42:59AM +0200, Christoph Hellwig wrote:
> On Sat, Jul 23, 2022 at 11:07:12PM +0800, Ming Lei wrote:
> > One important goal of ublk is to provide generic framework for
> > making one block device by userspace.
> > 
> > As one generic block device, there are still lots of parameters,
> > such as max_sectors, write_cache/fua, discard related limits,
> > zoned parameters, ...., so this patch starts to store & retrieve
> > device parameters and prepares for implementing ctrl command of
> > SET/GET_DEV_PARAMETERS.
> > 
> > Device parameters have to be stored somewhere, one reason is that
> > disk/queue won't be allocated until START_DEV command is received,
> > but device parameters have to setup before starting device.
> 
> This seems rather overeingeering and really hard to read.  Any reason
> to not simply open code the parameter verification and application
> and do away with the xarray and all the boiler plate code?
 
There could be more parameters than the two types(), such as segments,
zoned, ..., also in future, feature related parameters can be added
in this way too, and most of them are optional.

So xarray is needed.

Thanks,
Ming

