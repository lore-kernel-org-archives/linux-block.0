Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4A6C04A68
	for <linux-block@archiver.kernel.org>; Thu, 28 Jul 2022 01:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbiG1B4j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 21:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbiG1B4j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 21:56:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A0F358B4C
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 18:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658973397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KHZlToQdykohOisCXclAe9uYcYddXMxV8NXPaLhSb9Q=;
        b=dAwMF73GTg1mbUfPe4PuEXAEnGTjhKhBdZPo1RlI68UuvwnVrr0Tbnj6vYsIA/E/c8znDE
        2P7iOiI5tOn9iIhar3qHIGaLfLou0cKbSVM1X48P39+k9NS1nj63yxvg0ajCVsB03xOf+Q
        kZDeajPfMHKkvNycPfrqjWDpNJNg6ew=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-7sbNobR9NUm6USzuu20eZw-1; Wed, 27 Jul 2022 21:56:36 -0400
X-MC-Unique: 7sbNobR9NUm6USzuu20eZw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1B9285A58D;
        Thu, 28 Jul 2022 01:56:35 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0433640CF8E2;
        Thu, 28 Jul 2022 01:56:31 +0000 (UTC)
Date:   Thu, 28 Jul 2022 09:56:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>, ming.lei@redhat.com
Subject: Re: [PATCH V2 3/5] ublk_drv: add SET_PARAM/GET_PARAM control command
Message-ID: <YuHsyusQZYTlUabu@T590>
References: <20220727141628.985429-1-ming.lei@redhat.com>
 <20220727141628.985429-4-ming.lei@redhat.com>
 <20220727162234.GB18969@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727162234.GB18969@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

On Wed, Jul 27, 2022 at 06:22:34PM +0200, Christoph Hellwig wrote:
> As stated in the previous discussion I think this is a very bad idea
> that leads to a lot of boiler plate code.  If you don't want to rely

But you never point out where the boiler plate code is, care to share
what/where it is?

If you don't like xarray, we can replace it with one plain array
from the beginning, this change is just in implementation level.

Given it is ABI interface, I'd suggest to consolidate it from the
beginning.

> on zeroed fields we can add a mask of valid fields, similar to how
> e.g. the statx API works.

With one mask for marking valid fields, we still need to group
fields, and one bit in mask has to represent one single group, and
it can't represent each single field.

Also one length field has to be added in the header for keeping
compatibility with old app.

With the above two change, it becomes very similar with the approach
in this patch.

IMO there are more advantages in grouping parameter explicitly:

1) avoid big chunk of memory for storing lots of unnecessary parameter
if the big params data structure is extended, and we just store whatever
the userspace cares.

2) easy to add new type by just implementing two callbacks(both optionally),
and code is actually well organized, and each callback just focuses on the
interested parameter type 

3) parameter is easier to verify, since we know each parameter's length and type.
With mask, we can only know if one parameter type exists in the big
parameters data structure or not.


Thanks,
Ming

