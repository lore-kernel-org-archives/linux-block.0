Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E66C636CC
	for <linux-block@archiver.kernel.org>; Fri, 17 Feb 2023 01:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBQBnW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 20:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjBQBnV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 20:43:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372983A85D
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 17:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676598152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mU+9SXlG5Jl91PwrW4h4Qqlm/SOd8UB56sX30xkB9vg=;
        b=E/YPdU/S8czOsy01aiJ7irQiTb+dw3AHpijLkBGRJYNVv2xgQh3WM70nKjzeDTuCZZwtP2
        QeOlIKbUbaRuwF1sUN3HIWPQ8CBJO57RoTweaRUDixnIo2vFq+YNY9npuN9gAKM9pazPTE
        7djdkg6CdNVcZLPT9HjipCBP1rBVWls=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-wHtU6MahPwOsNDBGKeyHSQ-1; Thu, 16 Feb 2023 20:42:31 -0500
X-MC-Unique: wHtU6MahPwOsNDBGKeyHSQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A09285A588;
        Fri, 17 Feb 2023 01:42:30 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 18AF3140EBF6;
        Fri, 17 Feb 2023 01:42:27 +0000 (UTC)
Date:   Fri, 17 Feb 2023 09:42:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH blktests v2 1/2] src: add mini ublk source code
Message-ID: <Y+7bfuybBEOB1qtN@T590>
References: <20230217013851.1402864-1-ming.lei@redhat.com>
 <20230217013851.1402864-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217013851.1402864-2-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 17, 2023 at 09:38:50AM +0800, Ming Lei wrote:
> Prepare for adding ublk related test:
> 
> 1) ublk delete is sync removal, this way is convenient to
>    blkg/queue/disk instance leak issue
> 
> 2) mini ublk has two builtin target(null, loop), and loop IO is
> handled by io_uring, so we can use ublk to cover part of io_uring
> workloads
> 
> 3) not like loop/nbd, ublk won't pre-allocate/add disk, and always
> add/delete disk dynamically, this way may cover disk plug & unplug
> tests
> 
> 4) ublk specific test given people starts to use it, so better to
> let blktest cover ublk related tests
> 
> Add mini ublk source for test purpose only, which is easy to use:
> 
> ./miniublk add -t {null|loop} [-q nr_queues] [-d depth] [-n dev_id]
> 	 default: nr_queues=2(max 4), depth=128(max 128), dev_id=-1(auto allocation)
> 	 -t loop -f backing_file
> 	 -t null
> ./miniublk del [-n dev_id] [--disk/-d disk_path ] -a
> 	 -a delete all devices, -d delete device by disk path,
> 	 -n delete specified device
> ./miniublk list [-n dev_id] -a
> 	 -a list all devices, -n list specified device, default -a
> 
> ublk depends on liburing 2.2, so allow to ignore ublk build failure
> in case of missing liburing, and we will check if ublk program exits
> inside test. Also v6.0 is the 1st linux kernel release with ublk.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  Makefile            |    2 +-
>  src/Makefile        |   18 +
>  src/ublk/miniublk.c | 1376 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1395 insertions(+), 1 deletion(-)
>  create mode 100644 src/ublk/miniublk.c
> 
> diff --git a/Makefile b/Makefile
> index 5a04479..b9bbade 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2,7 +2,7 @@ prefix ?= /usr/local
>  dest = $(DESTDIR)$(prefix)/blktests
>  
>  all:
> -	$(MAKE) -C src all
> +	$(MAKE) -i -C src all

oops, the above change needs to be removed.

Shin'ichiro, I will kill it in V3 if it is needed, otherwise
please drop the above change when you merge the patch.

Thanks,
Ming

