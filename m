Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFFAC433DF
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 12:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8054A20884
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 12:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRkfqXzR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbgFRMzA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:55:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26612 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728215AbgFRMy5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 08:54:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592484895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v9FbjWBdAd7q99k+gAtkUvgrScXCggI31g4H1SHIHlE=;
        b=VRkfqXzR4cNpGPbQ+BgdnIMNjR9HzFvCG/E5CRTTtS10q2gcVR19OWGRRgBTg1WKa5zuXq
        CplvuwyAa4tZXyi0claAlkkg2T0H23GN5UytDsYhRb7UTEpIhgXhEQFfagvjW7we7apaqi
        nAUhEUR861mvZoqWqFQFw5H48ji6aQk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-ozpWvtOxPhqpPeYZMlbwrw-1; Thu, 18 Jun 2020 08:54:51 -0400
X-MC-Unique: ozpWvtOxPhqpPeYZMlbwrw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDE5A835B42;
        Thu, 18 Jun 2020 12:54:49 +0000 (UTC)
Received: from T590 (ovpn-13-98.pek2.redhat.com [10.72.13.98])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D11585D9E5;
        Thu, 18 Jun 2020 12:54:42 +0000 (UTC)
Date:   Thu, 18 Jun 2020 20:54:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: kprobe: __blkdev_put probe is missed
Message-ID: <20200618125438.GA191266@T590>
References: <CACVXFVO5saamQXs0naLamTKJfXZMW+p446weeqJK=9+V34UM0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACVXFVO5saamQXs0naLamTKJfXZMW+p446weeqJK=9+V34UM0g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 17, 2020 at 06:30:39PM +0800, Ming Lei wrote:
> Hello Guys,
> 
> I found probe on __blkdev_put is missed, which can be observed
> via bcc/perf reliably:
> 
> 1) start trace
> - perf probe __blkdev_put
> - perf trace -a  -e probe:__blkdev_put
> 
> or
> 
> /usr/share/bcc/tools/stackcount __blkdev_put
> 
> 2) run the following command:
> blockdev --getbsz /dev/sda1
> 
> 3) 'perf trace'  or stackcount just  dumps one trace event, and it
> should have been two
> __blkdev_put() traces, since one __blkdev_put() is called for
> partition(/dev/sda1),
> and another is for disk(/dev/sda). If trace_printk() is added in __blkdev_put(),
> two events will be captured from ftrace.
> 

The issue can be shown by loading a kprobe module which registers on
__blkdev_put(), just by replacing _do_fork with __blkdev_put on
samples/kprobes/kprobe_example.c.

So the issue is really in kprobe code.

Thanks,
Ming

