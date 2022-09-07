Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7229C38145
	for <linux-block@archiver.kernel.org>; Wed,  7 Sep 2022 08:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiIGImF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Sep 2022 04:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIGImE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Sep 2022 04:42:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2253AF0D0
        for <linux-block@vger.kernel.org>; Wed,  7 Sep 2022 01:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662539931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v7tXqiRu6Q/ASgIKZPVujZFkCxqS9SjkhigXRzRcRk0=;
        b=ZLNvGvSo1rCnTYLeyyyqxSU2s5LhBKtOdMbXMj9snouGQ8oirzu5Vcgt5KC3jnR7J3rEHD
        RfwTnaSjCw6oFoR5JOuGy6EDBhw+JZ1PzBglz3O47Vkleci7loEHQL93IXZoEt3if4+G4N
        SVvCYTsEOeUG1n+gQqUrig5BtSrBAzo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-zdi2S9TtMO-e-EHkgYTvBg-1; Wed, 07 Sep 2022 04:38:48 -0400
X-MC-Unique: zdi2S9TtMO-e-EHkgYTvBg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80F398041BE;
        Wed,  7 Sep 2022 08:38:47 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2050C1415102;
        Wed,  7 Sep 2022 08:38:42 +0000 (UTC)
Date:   Wed, 7 Sep 2022 16:38:37 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dusty Mabe <dusty@dustymabe.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org
Subject: Re: regression caused by block: freeze the queue earlier in
 del_gendisk
Message-ID: <YxhYjaA3CrMz5njZ@T590>
References: <017845ae-fbae-70f6-5f9e-29aff2742b8c@dustymabe.com>
 <YxBZ4BBjxvAkvI2A@T590>
 <20220907073324.GB23826@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907073324.GB23826@lst.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 07, 2022 at 09:33:24AM +0200, Christoph Hellwig wrote:
> On Thu, Sep 01, 2022 at 03:06:08PM +0800, Ming Lei wrote:
> > It is a bit hard to associate the above commit with reported issue.
> 
> So the messages clearly are about something trying to open a device
> that went away at the block layer, but somehow does not get removed
> in time by udev (which seems to be a userspace bug in CoreOS).  But
> even with that we really should not hang.

The new device should be allocated from md_probe() via blk_request_module(),
and the underlying devices are virtio-blk from the fedora BZ2121791.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=2121791

Thanks,
Ming

