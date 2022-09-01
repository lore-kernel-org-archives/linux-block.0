Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BE4ECAAD4
	for <linux-block@archiver.kernel.org>; Thu,  1 Sep 2022 01:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbiIABfY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Aug 2022 21:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbiIABfX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Aug 2022 21:35:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6775B07E
        for <linux-block@vger.kernel.org>; Wed, 31 Aug 2022 18:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661996119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sgRY6AVpYxwTFhEBEfeVojP2/QykwLDt049VIzQbuBQ=;
        b=UO8TGt7Q8M6EA5LG6TlgheILDj1JVlWSk46FsodE7A2eYqdK6tfemSqGAjFI9gymkY+sFQ
        4FQL8S0NwjVGDuoOl1lqUAyQ5xJPxjQZHRF+3wG/Xa26Iu1/eVgsQO+YgU4IPc6ibKrs4a
        77VEG3igo4dkupOlrX2Qf3/CFRNgXkM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-K66Me4ORN4utVuvpyb3dhA-1; Wed, 31 Aug 2022 21:35:16 -0400
X-MC-Unique: K66Me4ORN4utVuvpyb3dhA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70C593C0E214;
        Thu,  1 Sep 2022 01:35:16 +0000 (UTC)
Received: from T590 (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 089981415125;
        Thu,  1 Sep 2022 01:35:09 +0000 (UTC)
Date:   Thu, 1 Sep 2022 09:35:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Richard W . M . Jones" <rjones@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: Re: [PATCH] Docs: ublk: add ublk document
Message-ID: <YxAMSjrs3cuj5O3o@T590>
References: <20220828045003.537131-1-ming.lei@redhat.com>
 <1a9815d4-7c99-81c0-8f9c-958fd3eef91d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a9815d4-7c99-81c0-8f9c-958fd3eef91d@kernel.dk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 31, 2022 at 07:04:33PM -0600, Jens Axboe wrote:
> On 8/27/22 10:50 PM, Ming Lei wrote:
> > ublk document is missed when merging ublk driver, so add it now.
> 
> Ming, and you send a v2 of this so we can get it queued up for
> 6.0?

OK, I will send v2 soon.


Thanks,
Ming

