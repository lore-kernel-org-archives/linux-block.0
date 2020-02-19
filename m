Return-Path: <SRS0=ya0H=4H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5550C11D91
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 22:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D8B2468B
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 22:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dBIJo1if"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbgBSWXX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 17:23:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28322 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727163AbgBSWXX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 17:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582151001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nHypu13CZF8UBHp6BjnFh3CpnVljadFwXikdU7QeLTM=;
        b=dBIJo1ifiDhzl9lr5o/kbE6kBjhhISOnExVHOoKTb+v4qXkg36sM+IQSuXPamcsSNjRRjK
        RFU2vZt4T3c3kh9+mf0g8ek8uYm/0G65MyEplMJumDUIJQdB4AxEoSlHTU5Wi6m+FSlkx2
        doZax+QdiMsPMXyrwwvcsv6UxPUaI+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-mkJHZndZOSGRlBopAdowcQ-1; Wed, 19 Feb 2020 17:23:17 -0500
X-MC-Unique: mkJHZndZOSGRlBopAdowcQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 802A2800580;
        Wed, 19 Feb 2020 22:23:15 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F2F0D92D00;
        Wed, 19 Feb 2020 22:23:03 +0000 (UTC)
Date:   Thu, 20 Feb 2020 06:22:55 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Salman Qazi <sqazi@google.com>
Cc:     Jesse Barnes <jsbarnes@google.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Gwendal Grignou <gwendal@google.com>
Subject: Re: BLKSECDISCARD ioctl and hung tasks
Message-ID: <20200219222255.GB24522@ming.t460p>
References: <20200213082643.GB9144@ming.t460p>
 <d2c77921-fdcd-4667-d21a-60700e6a2fa5@acm.org>
 <CAKUOC8U1H8qJ+95pcF-fjeu9hag3P3Wm6XiOh26uXOkvpNngZg@mail.gmail.com>
 <de7b841c-a195-1b1e-eb60-02cbd6ba4e0a@acm.org>
 <CACVXFVP114+QBhw1bXqwgKRw_s4tBM_ZkuvjdXEU7nwkbJuH1Q@mail.gmail.com>
 <CAKUOC8Xss0YPefhKfwBiBar-7QQ=QrVh3d_8NBfidCCxUuxcgg@mail.gmail.com>
 <20200215034652.GA19867@ming.t460p>
 <CAJmaN=miqzhnZUTqaTOPp+OWY8+QYhXoE=h5apSucMkEU4nvtA@mail.gmail.com>
 <20200219025456.GD31488@ming.t460p>
 <CAKUOC8UceQ_cDQC8ckvUio0AZHhasi7Np-PQ09e-dQ3fechKoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKUOC8UceQ_cDQC8ckvUio0AZHhasi7Np-PQ09e-dQ3fechKoA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 19, 2020 at 09:54:31AM -0800, Salman Qazi wrote:
> On Tue, Feb 18, 2020 at 6:55 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Tue, Feb 18, 2020 at 08:11:53AM -0800, Jesse Barnes wrote:
> > > On Fri, Feb 14, 2020 at 7:47 PM Ming Lei <ming.lei@redhat.com> wrote:
> > > > What are the 'other operations'? Are they block IOs?
> > > >
> > > > If yes, that is why I suggest to fix submit_bio_wait(), which should cover
> > > > most of sync bio submission.
> > > >
> > > > Anyway, the fix is simple & generic enough, I'd plan to post a formal
> > > > patch if no one figures out better doable approaches.
> > >
> > > Yeah I think any block I/O operation that occurs after the
> > > BLKSECDISCARD is submitted will also potentially be affected by the
> > > hung task timeouts, and I think your patch will address that.  My only
> > > concern with it is that it might hide some other I/O "hangs" that are
> > > due to device misbehavior instead.  Yes driver and device timeouts
> > > should generally catch those, but with this in place we might miss a
> > > few bugs.
> > >
> > > Given the nature of these types of storage devices though, I think
> > > that's a minor issue and not worth blocking the patch on, given that
> > > it should prevent a lot of false positive hang reports as Salman
> > > demonstrated.
> >
> > Hello Jesse and Salman,
> >
> > One more question about this issue, do you enable BLK_WBT on your test
> > kernel?
> 
> It doesn't exist on the original 4.4-based kernel where we reproduced
> this bug.  I am curious how this interacts with this bug.

blk-wbt can throttle discard request and keep discard queue not too
deep.

However, given block erase is involved in BLKSECDISCARD, I guess blk-wbt
may not avoid this task hung issue completely.


Thanks,
Ming

