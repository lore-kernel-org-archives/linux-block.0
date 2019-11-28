Return-Path: <SRS0=c8VV=ZU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04646C432C0
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 02:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B3F215E5
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 02:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GgiZZDUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfK1CCX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Nov 2019 21:02:23 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44246 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728748AbfK1CCW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Nov 2019 21:02:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574906541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u88/f2IN9wKN0I8CImZAYplNjNAanL3f7rGr/t9lp0Y=;
        b=GgiZZDUOM/txhfC6dHjXrRI/afiD0imccOaXmj01iFX2BwWRYFPfeLbtoXQBlXLcdBVNjA
        gd8HG7NcbbOwVTTKtb2CFedr54nD/WX9lrvSRgcDpdHibwxhaD9yJeGrjBsjqki/z+lnWq
        Rh1zLcST02tBcyUSbshs/0r/qtaJRR8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-5Im0dl3PNhisgKcl7uK3hA-1; Wed, 27 Nov 2019 21:02:20 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93F91DBE6;
        Thu, 28 Nov 2019 02:02:18 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B22D360BE2;
        Thu, 28 Nov 2019 02:02:10 +0000 (UTC)
Date:   Thu, 28 Nov 2019 10:02:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V4 0/5] blk-mq: improvement on handling IO during CPU
 hotplug
Message-ID: <20191128020205.GB3277@ming.t460p>
References: <20191014015043.25029-1-ming.lei@redhat.com>
 <b3d90798-484f-09f5-a22f-f3ed3701f0d4@hisilicon.com>
MIME-Version: 1.0
In-Reply-To: <b3d90798-484f-09f5-a22f-f3ed3701f0d4@hisilicon.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 5Im0dl3PNhisgKcl7uK3hA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 28, 2019 at 09:09:13AM +0800, chenxiang (M) wrote:
> Hi,
>=20
> =E5=9C=A8 2019/10/14 9:50, Ming Lei =E5=86=99=E9=81=93:
> > Hi,
> >=20
> > Thomas mentioned:
> >      "
> >       That was the constraint of managed interrupts from the very begin=
ning:
> >        The driver/subsystem has to quiesce the interrupt line and the a=
ssociated
> >        queue _before_ it gets shutdown in CPU unplug and not fiddle wit=
h it
> >        until it's restarted by the core when the CPU is plugged in agai=
n.
> >      "
> >=20
> > But no drivers or blk-mq do that before one hctx becomes dead(all
> > CPUs for one hctx are offline), and even it is worse, blk-mq stills tri=
es
> > to run hw queue after hctx is dead, see blk_mq_hctx_notify_dead().
> >=20
> > This patchset tries to address the issue by two stages:
> >=20
> > 1) add one new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE
> >=20
> > - mark the hctx as internal stopped, and drain all in-flight requests
> > if the hctx is going to be dead.
> >=20
> > 2) re-submit IO in the state of CPUHP_BLK_MQ_DEAD after the hctx become=
s dead
> >=20
> > - steal bios from the request, and resubmit them via generic_make_reque=
st(),
> > then these IO will be mapped to other live hctx for dispatch
> >=20
> > Please comment & review, thanks!
> >=20
> > John, I don't add your tested-by tag since V3 have some changes,
> > and I appreciate if you may run your test on V3.
>=20
> I tested those patchset with John's testcase, except dump_stack() in
> function __blk_mq_run_hw_queue() sometimes occurs  which don't
> affect the function, it solves the CPU hotplug issue, so add tested-by fo=
r
> those patchset:
>=20
> Tested-by: Xiang Chen <chenxiang66@hisilicon.com>

Thanks for your test.

I plan to post a new version for 5.6 cycle, and there is still some
small race window related with requeue to be covered.

Thanks,
Ming

