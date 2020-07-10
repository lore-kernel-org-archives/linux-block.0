Return-Path: <SRS0=lEwc=AV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D8CC433E0
	for <linux-block@archiver.kernel.org>; Fri, 10 Jul 2020 10:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E36DC20786
	for <linux-block@archiver.kernel.org>; Fri, 10 Jul 2020 10:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YF4TlBMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgGJKBJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jul 2020 06:01:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48246 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726560AbgGJKBI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jul 2020 06:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594375267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4MRfwMostZf2A6RtzGc8xPWOk6+MFSGocp74s19claY=;
        b=YF4TlBMIy2oYgXGmryUuY8slbQub6tAI22TFhH9R0cY5TF3edhTYACHehnZU0G3jvk7Ccc
        nUOQ6QwuV/IRLlxM7X+ePRj1TdYaNEyMmWl01Yf2MS5vK2mSW4SZ1XzuJP4DTOdwVAXeLq
        TDhqH7TuLmfp6YJ+YvwX1fav/VSnNdY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-QTEJ_5WeM1eSmi45Fd1nsA-1; Fri, 10 Jul 2020 06:01:03 -0400
X-MC-Unique: QTEJ_5WeM1eSmi45Fd1nsA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 067C18027E6;
        Fri, 10 Jul 2020 10:01:02 +0000 (UTC)
Received: from T590 (ovpn-12-41.pek2.redhat.com [10.72.12.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4179678A4C;
        Fri, 10 Jul 2020 10:00:55 +0000 (UTC)
Date:   Fri, 10 Jul 2020 18:00:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Florian-Ewald Mueller <florian-ewald.mueller@cloud.ionos.com>
Subject: Re: [PATCH RFC 4/5] block: add a statistic table for io latency
Message-ID: <20200710100051.GA3418163@T590>
References: <20200708075819.4531-1-guoqing.jiang@cloud.ionos.com>
 <20200708075819.4531-5-guoqing.jiang@cloud.ionos.com>
 <20200708132958.GC3340386@T590>
 <eb2cf4d0-4260-8f10-0ba9-3cbf4ff85449@cloud.ionos.com>
 <b37dd9cd-aebc-88ee-2b09-ac4eb36ca0f7@cloud.ionos.com>
 <cc04e449-3d41-3ef7-10c2-c257512d7650@cloud.ionos.com>
 <20200710005354.GA3395574@T590>
 <f1243a13-8773-f943-a6c3-021cde0eb661@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1243a13-8773-f943-a6c3-021cde0eb661@cloud.ionos.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 10, 2020 at 10:55:24AM +0200, Guoqing Jiang wrote:
> Hi Ming,
> 
> On 7/10/20 2:53 AM, Ming Lei wrote:
> > Hi Guoqing,
> > 
> > On Thu, Jul 09, 2020 at 08:48:08PM +0200, Guoqing Jiang wrote:
> > > Hi Ming,
> > > 
> > > On 7/8/20 4:06 PM, Guoqing Jiang wrote:
> > > > On 7/8/20 4:02 PM, Guoqing Jiang wrote:
> > > > > > Hi Guoqing,
> > > > > > 
> > > > > > I believe it isn't hard to write a ebpf based script(bcc or
> > > > > > bpftrace) to
> > > > > > collect this kind of performance data, so looks not necessary to do it
> > > > > > in kernel.
> > > > > Hi Ming,
> > > > > 
> > > > > Sorry, I don't know well about bcc or bpftrace, but I assume they
> > > > > need to
> > > > > read the latency value from somewhere inside kernel. Could you point
> > > > > how can I get the latency value? Thanks in advance!
> > > > Hmm, I suppose biolatency is suitable for track latency, will look into
> > > > it.
> > > I think biolatency can't trace data if it is not running,
> > Yeah, the ebpf prog is only injected when the trace is started.
> > 
> > > also seems no
> > > place
> > > inside kernel have recorded such information for ebpf to read, correct me
> > > if my understanding is wrong.
> > Just record the info by starting the bcc script in case you need that, is there
> > anything wrong with this usage? Always doing such stuff in kernel isn't fair for
> > users which don't care or need this info.
> 
> That is why we add a Kconfig option and set it to N by default. And I
> suppose
> with modern cpu, the cost with several more instructions would not be that
> expensive even the option is enabled, just my $0.02.
> 
> > > And as cloud provider,we would like to know data when necessary instead
> > > of collect data by keep script running because it is expensive than just
> > > read
> > > node IMHO.
> > It shouldn't be expensive. It might be a bit slow to inject the ebpf prog because
> > the code has to be verified, however once it is put inside kernel, it should have
> > been efficient enough. The kernel side prog only updates & stores the latency
> > summery data into bpf map, and the stored summery data can be read out anytime
> > by userspace.
> > 
> > Could you explain a bit why it is expensive? such as biolatency
> 
> I thought I am compare read a sys node + extra instructions in kernel with
> launch a specific process for monitoring which need to occupy more
> resources (memory) and context switch. And for biolatency, it calls the
> bpf_ktime_get_ns to calculate latency for each IO which I assume the
> ktime_get_ns will be triggered finally, and it is not cheap as you said.

You can replace one read of timestamp with rq->start_time_ns too, just
like what this patch does. You can write your bcc/bfptrace script,
which is quite easy to start. Once you learn its power, maybe you will love
it.


Thanks,
Ming

