Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF26DC00144
	for <linux-block@archiver.kernel.org>; Fri, 29 Jul 2022 14:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiG2O7l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Jul 2022 10:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiG2O7l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jul 2022 10:59:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 696147FE53
        for <linux-block@vger.kernel.org>; Fri, 29 Jul 2022 07:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659106779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TssSDp1EQrn0WI9HpRSe2/aP2pujgIH8GfchOkYDB24=;
        b=Y1Lswcba2hJEt6IZcCn5mNk0EQSNtxR/Q3TsX+M/+gbq/p951PKMR+nyq3ytJvNTW8gn3h
        VGW/qFfSoDpNBQyUuVlo01in1pdhprbdkhvGzbfWb+ufaKCfKcQ25S07LOgJ+9qC7cTZiU
        hpcYlZo2kY16it1FcVqNcg9ps8skQFg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-GXd7iVNlOiOrWfOQL5afTQ-1; Fri, 29 Jul 2022 10:59:36 -0400
X-MC-Unique: GXd7iVNlOiOrWfOQL5afTQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1DE2185A7B2;
        Fri, 29 Jul 2022 14:59:35 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E528B2166B26;
        Fri, 29 Jul 2022 14:59:32 +0000 (UTC)
Date:   Fri, 29 Jul 2022 22:59:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH V3 3/5] ublk_drv: add SET_PARAM/GET_PARAM control command
Message-ID: <YuP1zz965Ljud/XA@T590>
References: <20220729072954.1070514-1-ming.lei@redhat.com>
 <20220729072954.1070514-4-ming.lei@redhat.com>
 <20220729142226.GC32321@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729142226.GC32321@lst.de>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 29, 2022 at 04:22:26PM +0200, Christoph Hellwig wrote:
> On Fri, Jul 29, 2022 at 03:29:52PM +0800, Ming Lei wrote:
> > The parameter passed from userspace is added to one array, and the type is
> > used as index of the array. The following patch will add two parameter
> > types: basic(covers basic queue setting and misc settings which can't be grouped
> 
> A bunch of overly long lines here.
> 
> But I still think this is the wrong design.  The number of potential
> parameter is very limited, so splitting them over multiple ioctls

So far, at least the following 6 parameters are to be added:

- basic
- discard
- segment
- zoned
- user space crash recovery parameter
- userspace backing buffer parameter

And each one is basically not related with others.

And ublk is really one generic userspace driver framework, it is very
likely to have more parameters added in future.

> and data structure for no good reason is really a de-optimization
> that makes the code more complex and slower.

Fine, I don't have time to argue which one is better.

For the timing's reason, I switch to the single parameter way. If turns
outs single parameter can't work well enough in future, I will restart
to add set/get parameter command.


Thanks,
Ming

