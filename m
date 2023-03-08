Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94055C64EC4
	for <linux-block@archiver.kernel.org>; Wed,  8 Mar 2023 12:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjCHM2J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Mar 2023 07:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCHM2C (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Mar 2023 07:28:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C545BA862
        for <linux-block@vger.kernel.org>; Wed,  8 Mar 2023 04:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678278442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ey6Rl2HCA74zGmU3aTWR3e3XVAE5LW7iMcw1O37Wzag=;
        b=eAR1Ym+tzYdXiVvXRX1+GQCU3Y38Tx5/fGqVpzTppwUnR16JaIzNkRkYM/HH+z3SKhco2x
        Fs7A/axaZbw8xm9d1pbrCzyGCcYbKZzipjTyyXNCGx+zdqXa8X2y+cWr/vMETKMwoestaM
        ydwholG6/htUWuj5fA9eU2K9gmwD3/U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-3s2fu0jyMkGeEYktfq1Vnw-1; Wed, 08 Mar 2023 07:27:19 -0500
X-MC-Unique: 3s2fu0jyMkGeEYktfq1Vnw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FD79101A521;
        Wed,  8 Mar 2023 12:27:18 +0000 (UTC)
Received: from ovpn-8-17.pek2.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A576D2166B26;
        Wed,  8 Mar 2023 12:27:11 +0000 (UTC)
Date:   Wed, 8 Mar 2023 20:27:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hans Holmberg <hans@owltronix.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Jim Harris <james.r.harris@intel.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        "hch@lst.de" <hch@lst.de>, Stefan Hajnoczi <stefanha@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>, ming.lei@redhat.com
Subject: Re: [LSF/MM/BPF BoF]: extend UBLK to cover real storage hardware
Message-ID: <ZAh/Gk/jc4fneJ/e@ovpn-8-17.pek2.redhat.com>
References: <Y+EWCwqSisu3l0Sz@T590>
 <889dfe23-2e9e-c787-8c20-32f2c40509b5@suse.de>
 <CANr-nt2S2KWuhDtaK6QAjDK2njGB+rcVjPvHjK1MB9_m+z9Wrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANr-nt2S2KWuhDtaK6QAjDK2njGB+rcVjPvHjK1MB9_m+z9Wrg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 08, 2023 at 09:50:53AM +0100, Hans Holmberg wrote:
> This is a great topic, so I'd like to be part of it as well.
> 
> It would be great to figure out what latency overhead we could expect
> of ublk in the future, clarifying what use cases ublk could cater for.
> This will help a lot in making decisions on what to implement
> in-kernel vs user space.

If the zero copy patchset[1] can be accepted, the main overhead should be
in io_uring command communication.

I just run one quick test on my laptop between ublk/null(2 queues, depth 64, with
zero copy) and null_blk(2 queues, depth 64), and run single job fio
(128 qd, batch 16, libaio, 4k randread). IOPS on ublk is less than ~13% than
null_blk.

So looks the difference isn't bad, cause IOPS level has been reached
Million level(1.29M vs. 1.46M). This basically shows the communication
overhead. However, ublk userspace can handle io in lockless way, and
minimize context switch & maximize io parallel by coroutine, that is
ublk's advantage, and hard or impossible to do in kernel.

In the ublksrv[2] project, we implemented loop, nbd & qcow2, so far, in
my previous IOPS test result:

1) kernel loop(dio) vs. ublk/loop: the two are close

2) kernel nbd vs. ublk/nbd:  ublk/nbd is a bit better than kernel nbd

3) qmeu-nbd based qcow2 vs. ublk/qcow2: ublk/qcow2 is much better

All the three just works, not run further optimization yet.

Also ublk may perform bad if io isn't handled in batch, such as, single
queue depth io submission.

But ublk is still very young, and there can be lots of optimization in
future, such as:

1) applying polling for reducing communication overhead for both
io command and io handle, and this way should improve latency for low QD
workload

2) apply kind of ML model for predicating IO completion, and improve 
io polling, meantime reducing cpu utilization.

3) improve io_uring command for reducing communication overhead

IMO, ublk is one generic userspace block device approach, especially good at:

1) handle complicated io logic, such as, btree is applied in io mapping,
cause userspace has more weapons for this stuff

2) virtual device, such as all network based storage, or logical volume
management

3) quick prototype development

4) flexible storage simulation for test purpose

[1] https://lore.kernel.org/linux-block/ZAff9usDuyXxIPt9@ovpn-8-16.pek2.redhat.com/T/#t
[2] https://github.com/ming1/ubdsrv


Thanks, 
Ming

