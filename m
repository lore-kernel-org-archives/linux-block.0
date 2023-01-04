Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2BAC4332F
	for <linux-block@archiver.kernel.org>; Wed,  4 Jan 2023 05:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjADFnL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Jan 2023 00:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjADFnJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Jan 2023 00:43:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945E93881
        for <linux-block@vger.kernel.org>; Tue,  3 Jan 2023 21:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672810940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3laPIRrhTbAZ9iBnLwBV3Prp4y2KIhGs+IoIdoLiqVY=;
        b=SkrJkZ97pCzwGX9D/r2hRVHbmKMV21bOrtXJU4JYlfIiR+JXY9PBgnUFWd6IxcYSivQ+ZR
        FvJmZBBCd4M/hqTUaavAqldq3krnEyYVLq9iLqGGxSxayqziUjRFCGou6eqnIjGoh7d6aZ
        cd5Rlt6NNmNwOZjRM0EKlpXzrQXB9H0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-52-JledLpv7MWSUgQiq9lBfHQ-1; Wed, 04 Jan 2023 00:42:19 -0500
X-MC-Unique: JledLpv7MWSUgQiq9lBfHQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB6E08030CD;
        Wed,  4 Jan 2023 05:42:18 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 92A84492C14;
        Wed,  4 Jan 2023 05:42:15 +0000 (UTC)
Date:   Wed, 4 Jan 2023 13:42:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: Potential hang on ublk_ctrl_del_dev()
Message-ID: <Y7URsuwxaAHFmn8S@T590>
References: <862272BC-C6A3-4A60-A620-4C5596972D01@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <862272BC-C6A3-4A60-A620-4C5596972D01@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 03, 2023 at 01:47:37PM -0800, Nadav Amit wrote:
> Hello Ming,
> 
> I am trying the ublk and it seems very exciting.
> 
> However, I encounter an issue when I remove a ublk device that is mounted or
> in use.
> 
> In ublk_ctrl_del_dev(), shouldn’t we *not* wait if ublk_idr_freed() is false?
> It seems to me that it is saner to return -EBUSY in such a case and let
> userspace deal with the results.
> 
> For instance, if I run the following (using ubdsrv):
> 
>  $ mkfs.ext4 /dev/ram0
>  $ ./ublk add -t loop -f /dev/ram0
>  $ sudo mount /dev/ublkb0 tmp
>  $ sudo ./ublk del -a
> 
> ublk_ctrl_del_dev() would not be done until the partition is unmounted, and you
> can get a splat that is similar to the one below.

The splat itself can be avoided easily by replace wait_event with
wait_event_timeout() plus loop, but I guess you think the sync delete
isn't good too?

> 
> What do you say? Would you agree to change the behavior to return -EBUSY?

It is designed in this way from beginning, and I believe it is just for
the sake of simplicity, and one point is that the device number needs
to be freed after 'ublk del' returns.

But if it isn't friendly from user's viewpoint, we can change to return
-EBUSY. One simple solution is to check if the ublk block device
is opened before running any deletion action, if yes, stop to delete it
and return -EBUSY; otherwise go ahead and stop & delete the pair of devices.
And the userspace part(ublk utility) needs update too.

However, -EBUSY isn't perfect too, cause user has to retry the delete
command manually.

thanks,
Ming

