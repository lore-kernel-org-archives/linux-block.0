Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C05CC77B61
	for <linux-block@archiver.kernel.org>; Thu, 27 Apr 2023 07:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242963AbjD0H2i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Apr 2023 03:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243195AbjD0H2b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Apr 2023 03:28:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BD440E7
        for <linux-block@vger.kernel.org>; Thu, 27 Apr 2023 00:28:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D6D9C1FDFA;
        Thu, 27 Apr 2023 07:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682580465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=gW4QUErGvAesybuMXXu5So0XZ/1kEjh78pRTMQqyBus=;
        b=TyBX65E7nepGXfxpezeZyRNtvZBrhS4QNEzwBVcz+gLfCVTyHB6v6MJ0QO20elgrRkdRFv
        NBQE8wjkHjk9zJMk6y6EqQMPtXzcbWR5vxKM/TeXxRatTl/gCWeWaz8qp2gn8hUvGG7IDd
        9eag1LST/TKpPlZyxLGdqqflP+XJs20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682580465;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=gW4QUErGvAesybuMXXu5So0XZ/1kEjh78pRTMQqyBus=;
        b=5jv60hrPOjKNcztMjbJJmpUKCgEidfdlY2Y1Sy51opTEf9G9umsGR0uDZ/ndMBLawzjbHl
        vd3+gDsXXfvOvXBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C88C513910;
        Thu, 27 Apr 2023 07:27:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 66neMPEjSmTFKAAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 27 Apr 2023 07:27:45 +0000
Date:   Thu, 27 Apr 2023 09:27:45 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [LSF/MM/BPF TOPIC] nvme state machine refactoring
Message-ID: <dkxas4hwmnzknde7csbnuxwtk6odsaptj34hj7ukz4kh54h45n@6aiz7ghuf7ej>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

I'd like to use the opportunity to align and discuss the nvme state machine
refactoring work in person. I don't think we need a lot of time for this topic,
so if we could just have the topic during a BOF it would be great.

Sagi proposed following high level API:

  ops.setup_transport(ctrl)
  ops.alloc_admin_queue(ctrl)
  ops.start_admin_queue(ctrl)
  ops.stop_admin_queue(ctrl)
  ops.free_admin_queue(ctrl)
  ops.alloc_io_queues(ctrl)
  ops.start_io_queues(ctrl)
  ops.stop_io_queues(ctrl)
  ops.free_io_queues(ctrl)

Getting the queue functions done is fairly straight forward and I didn't run
into any problems in my experiments.

The more tricky part is the slight different behavior how the transports handle
how many queues are allocated for IO and their placement. To keep it exactly as
it is right now, I had to add a couple of additional callbacks aside to
setup_transport():

 - nr_io_queues(): limit the number of queues
 - set_io_queues(): map the queues to cpu

The first one was mainly necessary for rdma but IIRC Keith has done some work
there which could make the callback unnecessary. My question is should we try
to unify this part as well?

Also I haven't really checked what pci does here.

The second callback should probably be replaced with something which is also
executed during runtime, e.g. for CPU hotplug events. I don't think it is
strictly necessary. At least it looks a bit suspicious that we only do the queue
cpu mapping when (re)connecting. But maybe I am just missing something.

There is also the question how to handle the flags set by the core and the one
set the the transports. There are generic ones like NVME_TCP_Q_LIVE. These can
be translated into generic ones, so fairly simple. Though here is one transport
specific one in rdma: NVME_RDMA_Q_TR_READY. What to do here?

In short, I don't think there are real blockers. The main question for me is, do
we want to unify all transport so far that they act exactly the same?

Required Attendees:
  - Chaitanya Kulkarni
  - Christoph Hellwig
  - Hannes Reinecke
  - James Smart
  - Keith Busch
  - Sagi Grimberg

Anyway, I think it is necessary to have tests in blktests up front. Hence my
current effort with enabling fc transport in blktests.

Thanks,
Daniel

https://lore.kernel.org/linux-nvme/20230301082737.10021-1-dwagner@suse.de/
https://lore.kernel.org/linux-nvme/20230306093244.20775-1-dwagner@suse.de/
