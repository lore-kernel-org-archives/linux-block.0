Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC44C433FE
	for <linux-block@archiver.kernel.org>; Wed, 12 Oct 2022 13:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiJLNHr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Oct 2022 09:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiJLNHq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Oct 2022 09:07:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDCECAE47
        for <linux-block@vger.kernel.org>; Wed, 12 Oct 2022 06:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665580064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QdSuEPO6v5Yda13eZlEGM4ZoOTT31U8VyXGaksmdMD8=;
        b=AJCRda0iXRMwmzkb0zsUPALrJ8JeDfQmm1hpNAqZlAbvOGltFNoOrIO0KGx6l8UsTtJwjT
        ihM8P3Uq2y0sj2ZT8HmT0YUWGXTeQoYi1s9wvCayRmHDYirEbJK8Q5MRb+iTExiHFqgNdG
        98ipjot+/gQblwAcRZVCq6DxQxHTQZs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-vOWCSjtKMgKO6CGvADhryw-1; Wed, 12 Oct 2022 09:07:43 -0400
X-MC-Unique: vOWCSjtKMgKO6CGvADhryw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD02438164C3;
        Wed, 12 Oct 2022 13:07:42 +0000 (UTC)
Received: from T590 (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F288B40C206B;
        Wed, 12 Oct 2022 13:07:38 +0000 (UTC)
Date:   Wed, 12 Oct 2022 21:07:33 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        Igor Raits <igor.raits@gooddata.com>,
        Daniel Secik <daniel.secik@gooddata.com>,
        David Krupicka <david.krupicka@gooddata.com>
Subject: Re: again? - Write I/O queue hangup at random on recent Linus'
 kernels
Message-ID: <Y0a8Fax+YbB0M831@T590>
References: <CAK8fFZ5w8CC7ez50dEd9nGJpc_c-ubJLk3+77d7Y5qN1pMkfRQ@mail.gmail.com>
 <206b68b7-e52c-969c-a08f-a309a86c1ba6@acm.org>
 <CAK8fFZ48N_VPSZ6SiknBtasDtUZiRn_ZsvcR4D132rj36W0KsA@mail.gmail.com>
 <acac67a6-3331-75dd-840a-40b509ada0c1@acm.org>
 <CAK8fFZ6ruxHsXuGT4qarNxdLLQtAoLsSvV0buFQhdc+TKo3Tag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8fFZ6ruxHsXuGT4qarNxdLLQtAoLsSvV0buFQhdc+TKo3Tag@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 11, 2022 at 05:15:05PM +0200, Jaroslav Pulchart wrote:
> Hello,
> 
> we disabled the wbt, issue is happening much sooner. The logs are attached
> 1/ "dmesg-20221011.log" form kernel messages
> 2/ "command.logs" from execution of
>     (cd /sys/kernel/debug/block/vdc && find . -type f -exec grep -aH . {} \;)
> 

From command.logs, looks like it is one qemu or virtio-blk issue.

Maybe you can try to revert 0e9911fa768f ("virtio-blk: support mq_ops->queue_rqs()")
and see if it makes difference.


[1] all busy tags points to in-flight IOs

grep busy temp/command.logs | grep -v -E "dispatch_busy|busy=0"

./hctx27/tags:busy=3
./hctx27/busy:00000000e4e3af26 {.op=READ, .cmd_flags=FAILFAST_DEV|FAILFAST_TRANSPORT|FAILFAST_DRIVER|RAHEAD, .rq_flags=IO_STAT|STATS, .state=in_flight, .tag=167, .internal_tag=-1}
./hctx27/busy:00000000a9d6975f {.op=READ, .cmd_flags=FAILFAST_DEV|FAILFAST_TRANSPORT|FAILFAST_DRIVER|RAHEAD, .rq_flags=IO_STAT|STATS, .state=in_flight, .tag=168, .internal_tag=-1}
./hctx27/busy:00000000474663fc {.op=READ, .cmd_flags=FAILFAST_DEV|FAILFAST_TRANSPORT|FAILFAST_DRIVER|RAHEAD, .rq_flags=IO_STAT|STATS, .state=in_flight, .tag=169, .internal_tag=-1}
./hctx26/tags:busy=2
./hctx26/busy:00000000f32dd525 {.op=WRITE, .cmd_flags=SYNC, .rq_flags=IO_STAT|STATS, .state=in_flight, .tag=107, .internal_tag=-1}
./hctx26/busy:0000000055297a93 {.op=READ, .cmd_flags=FAILFAST_DEV|FAILFAST_TRANSPORT|FAILFAST_DRIVER|RAHEAD, .rq_flags=IO_STAT|STATS, .state=in_flight, .tag=108, .internal_tag=-1}
...


Thanks,
Ming

