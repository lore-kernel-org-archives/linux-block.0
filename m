Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FC6C433EF
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 00:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiCVA1P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Mar 2022 20:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbiCVA1O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Mar 2022 20:27:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCF3018BCC9
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 17:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647908745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bKVPs3C95JxXwH2wQrzESpUuhVKrrAfY7go1pNl5we0=;
        b=CdohAcojDJMsATbeSXoc80mP9BsU8MrBPSD97ht9V6NBcldEVF1J87BDnyhfKEX6iSUkJs
        KqX3XnorHc2JAr5LXG+8pE4VWRoTp3yFL13QqZM4Y8lY4VnvcS3uHZc+PuVZ3L0Di2hH0M
        HWqGsgWeAG51F8Vsbi/LJ9SLzMFpZ/k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-220-9bHONmkxP4yI4qPIgcKBEA-1; Mon, 21 Mar 2022 20:25:43 -0400
X-MC-Unique: 9bHONmkxP4yI4qPIgcKBEA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DF2C185A79C;
        Tue, 22 Mar 2022 00:25:43 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D5D5C76C2;
        Tue, 22 Mar 2022 00:25:36 +0000 (UTC)
Date:   Tue, 22 Mar 2022 08:25:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, "Ewan D . Milne" <emilne@redhat.com>
Subject: Re: [PATCH] lib/sbitmap: allocate sb->map via kvzalloc_node
Message-ID: <YjkXenfaI7iSewSC@T590>
References: <20220316012708.354668-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316012708.354668-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Wed, Mar 16, 2022 at 09:27:08AM +0800, Ming Lei wrote:
> sbitmap has been used in scsi for replacing atomic operations on
> sdev->device_busy, so IOPS on some fast scsi storage can be improved.
> 
> However, sdev->device_busy can be changed in fast path, so we have to
> allocate the sb->map statically. sdev->device_busy has been capped to 1024,
> but some drivers may configure the default depth as < 8, then
> cause each sbitmap word to hold only one bit. Finally 1024 * 128(
> sizeof(sbitmap_word)) bytes is needed for sb->map, given it is order 5
> allocation, sometimes it may fail.
> 
> Avoid the issue by using kvzalloc_node() for allocating sb->map.
> 
> Cc: Ewan D. Milne <emilne@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Ping...


thanks,
Ming

