Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EFBC433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 12:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237426AbiBOMCs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 07:02:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237403AbiBOMCs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 07:02:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88E0583014
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 04:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644926557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UMkRcz9upB0HqBHyBKswpJ6G8wVdrAoq15IZve/3J9s=;
        b=MGhvWOqc8pK/TyPsKE6trkzX4MZciHyDVs0+tL82mU4MgNxTBPE/R9hFGx9LvrwXLCjkdF
        SzfEaOZzCNJaJ2aLLaBN2IwWZgSrPyeCIJM+LgowtIHQixwpJOD14Fty55xIOsuzZ29LPf
        EOKLloyJTZbodBtTKKIvvnAq/03iy+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-Zfx8CeLZMYiWmvLTgo1JDA-1; Tue, 15 Feb 2022 07:02:34 -0500
X-MC-Unique: Zfx8CeLZMYiWmvLTgo1JDA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8D5C801B1C;
        Tue, 15 Feb 2022 12:02:32 +0000 (UTC)
Received: from T590 (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 00F0A6E217;
        Tue, 15 Feb 2022 12:02:21 +0000 (UTC)
Date:   Tue, 15 Feb 2022 20:02:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        damien.lemoal@wdc.com, jiangguoqing@kylinos.cn,
        shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH V2 1/1] blk-lib: don't check bdev_get_queue() NULL check
Message-ID: <YguWSd90b3Sb2Ptv@T590>
References: <20220215115247.11717-1-kch@nvidia.com>
 <20220215115247.11717-2-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215115247.11717-2-kch@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 15, 2022 at 03:52:47AM -0800, Chaitanya Kulkarni wrote:
> Based on the comment present in the bdev_get_queue()
> bdev->bd_queue can never be NULL. Remove the NULL check for the local
> variable q that is set from bdev_get_queue() for discard, write_same,
> and write_zeroes.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

