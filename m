Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAEEC433F5
	for <linux-block@archiver.kernel.org>; Fri, 26 Nov 2021 09:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376273AbhKZJQD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Nov 2021 04:16:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50544 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344579AbhKZJOD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Nov 2021 04:14:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637917850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S5mwYfY0dx1F8agGukrsuuNeUtAoQ67rgE2L4EpbTTI=;
        b=e95O3RQcHh8xrWAk+t5lsdXC+ykIlQjh94SNYr448sqymAe5oLt1Rwa3GTpucN1nN3PjNM
        uiBYS8x9znCtDxtO6ry/HlLirxRDFKFSf/v8r9pH0fwtUOi2HKKcT1UuW8haWQ4qnHrA/D
        MHtQ9p0G1MJ2eRp6qD4zBItcwCms7sM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-309-4i3HPhCVOJO0Y1H9vetp_A-1; Fri, 26 Nov 2021 04:10:48 -0500
X-MC-Unique: 4i3HPhCVOJO0Y1H9vetp_A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDDD51006AA0
        for <linux-block@vger.kernel.org>; Fri, 26 Nov 2021 09:10:47 +0000 (UTC)
Received: from T590 (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D26885C22B;
        Fri, 26 Nov 2021 09:10:22 +0000 (UTC)
Date:   Fri, 26 Nov 2021 17:10:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: [bug report] WARNING at block/mq-deadline.c:600
 dd_exit_sched+0x1c6/0x260 triggered with blktests block/031
Message-ID: <YaCkd3xF75eeRTen@T590>
References: <CAHj4cs8=xDxBZF62-OekAGtHDtP6ynALKXm7fK2D2ChpNXnGAw@mail.gmail.com>
 <YaBGI7bR/9ot514F@T590>
 <CAHj4cs8L0Q0oS2RgNOr+cC55NeALKCYW_BzeFxctWvcrub-iVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs8L0Q0oS2RgNOr+cC55NeALKCYW_BzeFxctWvcrub-iVQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Yi,

On Fri, Nov 26, 2021 at 11:45:14AM +0800, Yi Zhang wrote:
> Hi MIng
> It still can be reproduced with the latest for-next[1].
> BTW, it was only reproduced when I first time run block/031, cannot be
> reproduced if I run it the second time.

Firstly can you reproduce it on v5.16-rc2?

Secondly, can you collect the bpftrace log via the attached script when
running block/031?

#!/usr/bin/bpftrace
#include <linux/blkdev.h>
#include <linux/blk-mq.h>
#include <linux/genhd.h>

kprobe:dd_insert_request
{
	$rq = (struct request *)arg1;

	if (!($rq->rq_flags & (1 << 12))) {
		printf("%lu %16s %d %d: %s rq %lx/%x %s\n", nsecs / 1000,  comm, pid, cpu,
			ksym(reg("ip")), $rq->cmd_flags, $rq->rq_flags,
			kstack);
	}
}


Thanks,
Ming

