Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811CEEB64DD
	for <linux-block@archiver.kernel.org>; Tue, 11 Jul 2023 03:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjGKDyP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jul 2023 23:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjGKDyM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2023 23:54:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1931A2
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 20:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689047607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=np4ZI6Y9u+osACrZKJ15QQ6k0qV43pdokF3OlXrj8ck=;
        b=M3xE9L8my4jJpIIbTJ/kWl0BGlDEr8FRqa2spvVHK6FSwowfbuYaoLhMgZuzL7lF/ThdeR
        NsS/4pKaTGnS5hUIOcivELP3IMdDlglVXbKoo516BmCoVgEwns0+Zn6mauYjJBpxM+B0yX
        ihgYU5IrKpmby+68N5nR38a9FUKFgeE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-5JME2jPnPjy37hQuhsn9ag-1; Mon, 10 Jul 2023 23:53:21 -0400
X-MC-Unique: 5JME2jPnPjy37hQuhsn9ag-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A109D80006E;
        Tue, 11 Jul 2023 03:53:20 +0000 (UTC)
Received: from ovpn-8-26.pek2.redhat.com (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 132EDC09A09;
        Tue, 11 Jul 2023 03:53:05 +0000 (UTC)
Date:   Tue, 11 Jul 2023 11:53:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Wen Xiong <wenxiong@linux.ibm.com>,
        Keith Busch <kbusch@kernel.org>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        Thomas Gleixner <tglx@linutronix.de>, ming.lei@redhat.com
Subject: Re: [PATCH 2/2] nvme-pci: use blk_mq_max_nr_hw_queues() to calculate
 io queues
Message-ID: <ZKzSHDPR7Jfoz/G8@ovpn-8-26.pek2.redhat.com>
References: <20230708020259.1343736-1-ming.lei@redhat.com>
 <20230708020259.1343736-3-ming.lei@redhat.com>
 <20230710064109.GB24519@lst.de>
 <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
 <ZKzOFkokjTVwd4Ry@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKzOFkokjTVwd4Ry@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Baoquan,

On Tue, Jul 11, 2023 at 11:35:50AM +0800, Baoquan He wrote:
> On 07/10/23 at 05:14pm, Ming Lei wrote:
> > On Mon, Jul 10, 2023 at 08:41:09AM +0200, Christoph Hellwig wrote:
> > > On Sat, Jul 08, 2023 at 10:02:59AM +0800, Ming Lei wrote:
> > > > Take blk-mq's knowledge into account for calculating io queues.
> > > > 
> > > > Fix wrong queue mapping in case of kdump kernel.
> > > > 
> > > > On arm and ppc64, 'maxcpus=1' is passed to kdump command line, see
> > > > `Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
> > > > still returns all CPUs.
> > > 
> > > That's simply broken.  Please fix the arch code to make sure
> > > it does not return a bogus num_possible_cpus value for these
> > 
> > That is documented in Documentation/admin-guide/kdump/kdump.rst.
> > 
> > On arm and ppc64, 'maxcpus=1' is passed for kdump kernel, and "maxcpu=1"
> > simply keep one of CPU cores as online, and others as offline.
> 
> I don't know maxcpus on arm and ppc64 well. But maxcpus=1 or nr_cpus=1
> are suggested parameter. Because usually nr_cpus=1 is enough to make
> kdump kernel work well to capture vmcore. However, user is allowed to
> specify nr_cpus=n (n>1) if they think multiple cpus are needed in kdump
> kernel. Your hard coding of cpu number in kdump kernel may be not so
> reasonable.

As I mentioned, for arm/ppc64, passing 'maxcpus=1' actually follows
Documentation/admin-guide/kdump/kdump.rst.

'nr_cpus=N' just works fine, so not related with this topic.

After 'maxcpus=1' is passed, kernel only brings up one of cpu cores as
online during booting, and others still can be put into online by
userspace. Now this way causes IO timeout on some storage device which
uses managed irq and supports multiple io queues.

Here the focus is if passing 'maxcpus=1' is valid for kdump
kernel, that is we want to hear from our arch/kdump guys.

If yes, something needs to be fixed, such as, what this patchset is
doing.

> 
> Please cc kexec mailing list when posting so that people can view the
> whole thread of discussion.

Already Cc kexe & arm/powerpc & irq list.


Thanks,
Ming

