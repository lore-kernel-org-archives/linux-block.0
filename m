Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AABC04A68
	for <linux-block@archiver.kernel.org>; Thu, 28 Jul 2022 00:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbiG1ASs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 20:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiG1ASr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 20:18:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 299CC3CBC4
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 17:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658967525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=169n3QudRfwB4tRIfa2gs2cb6GTxYFv8fBft6/2bDnk=;
        b=Mn1GAKW28udFPSvkAvo+zaI5Iz2rBOgf9j56CaCR3e3iYJPepByDkC9f8KQsHGEC9vL5Mg
        S96U3WyJKxUe6cJnd1P9HR1IKK0sTh923c/pT24H6CUS6woGPkB6MUXXDh5BegfcxaSmyH
        fB3j81k/U8ddKRZ0ArFpp4aa1GE30fs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-vdbaxunqOceoQ-tcNltJGw-1; Wed, 27 Jul 2022 20:18:41 -0400
X-MC-Unique: vdbaxunqOceoQ-tcNltJGw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 448A08037AF;
        Thu, 28 Jul 2022 00:18:41 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CE4C52166B26;
        Thu, 28 Jul 2022 00:18:36 +0000 (UTC)
Date:   Thu, 28 Jul 2022 08:18:31 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH V2 1/5] ublk_drv: avoid to leak ublk device in case that
 add_disk fails
Message-ID: <YuHV11N1A45xwxyT@T590>
References: <20220727141628.985429-1-ming.lei@redhat.com>
 <20220727141628.985429-2-ming.lei@redhat.com>
 <20220727162132.GA18969@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727162132.GA18969@lst.de>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 27, 2022 at 06:21:32PM +0200, Christoph Hellwig wrote:
> maybe s/avoid/don't/ in the subject?

OK, will change in V3.

> 
> > -	get_device(&ub->cdev_dev);
> >  	ret = add_disk(disk);
> >  	if (ret) {
> >  		put_disk(disk);
> >  		goto out_unlock;
> 
> Maybe just add a put_device here in the error branch to keep
> things simple?

That is fine.

Another way is to add 'out_put_disk' error label which can be
reused with previous error handling.


Thanks,
Ming

