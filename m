Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC9DC433FE
	for <linux-block@archiver.kernel.org>; Fri, 18 Nov 2022 11:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbiKRL35 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiKRL34 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 06:29:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E1D657D5
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 03:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668770941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5a+yrIkbIMgxgMgsl7YwCu05OPMIM0lA2aPkKKcR6U0=;
        b=MSHmtQ5RpA7Khmdp3XkuJSEL4eWusMGa+1SKVcH9LSLGV3sgIluR+O21KuA75meOd6bgHf
        oemHOz1h4x7ZMsdi0GRTctrk20ooxtoF1inw5l0oDqTifstmK8nz6+EYLp2CIb1uK2eaXE
        KcboyflfwFLlJiZdGPjOu6RGIMrSnQI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-XM24GRmOMziOHxHrdzXQ6g-1; Fri, 18 Nov 2022 06:28:58 -0500
X-MC-Unique: XM24GRmOMziOHxHrdzXQ6g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE25138041C3;
        Fri, 18 Nov 2022 11:28:57 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 35C9AC15BA5;
        Fri, 18 Nov 2022 11:28:53 +0000 (UTC)
Date:   Fri, 18 Nov 2022 19:28:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Andreas Hindborg <andreas.hindborg@wdc.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: Reordering of ublk IO requests
Message-ID: <Y3dscKle5oqLjSNT@T590>
References: <Y3WZ41tKFZHkTSHL@T590>
 <87o7t67zzv.fsf@wdc.com>
 <Y3X2M3CSULigQr4f@T590>
 <87k03u7x3r.fsf@wdc.com>
 <Y3YfUjrrLJzPWc4H@T590>
 <87fseh92aa.fsf@wdc.com>
 <Y3cGM0es14vj3n3N@T590>
 <2f86eb58-148b-03ac-d2bf-d67c5756a7a6@opensource.wdc.com>
 <Y3chDDdbuN99l7v7@T590>
 <8735ag8ueg.fsf@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735ag8ueg.fsf@wdc.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 18, 2022 at 10:41:31AM +0100, Andreas Hindborg wrote:
> 
> Ming Lei <ming.lei@redhat.com> writes:
> 
> > CAUTION: This email originated from outside of Western Digital. Do not click on
> > links or open attachments unless you recognize the sender and know that the
> > content is safe.
> >
> >
> > On Fri, Nov 18, 2022 at 01:35:29PM +0900, Damien Le Moal wrote:
> >> On 11/18/22 13:12, Ming Lei wrote:
> >> [...]
> >> >>> You can only assign it to zoned write request, but you still have to check
> >> >>> the sequence inside each zone, right? Then why not just check LBAs in
> >> >>> each zone simply?
> >> >>
> >> >> We would need to know the zone map, which is not otherwise required.
> >> >> Then we would need to track the write pointer for each open zone for
> >> >> each queue, so that we can stall writes that are not issued at the write
> >> >> pointer. This is in effect all zones, because we cannot track when zones
> >> >> are implicitly closed. Then, if different queues are issuing writes to
> >> >
> >> > Can you explain "implicitly closed" state a bit?
> >> >
> >> > From https://zonedstorage.io/docs/introduction/zoned-storage, only the
> >> > following words are mentioned about closed state:
> >> >
> >> >     ```Conversely, implicitly or explicitly opened zoned can be transitioned to the
> >> >     closed state using the CLOSE ZONE command.```
> >>
> >> When a write is issued to an empty or closed zone, the drive will
> >> automatically transition the zone into the implicit open state. This is
> >> called implicit open because the host did not (explicitly) issue an open
> >> zone command.
> >>
> >> When there are too many implicitly open zones, the drive may choose to
> >> close one of the implicitly opened zone to implicitly open the zone that
> >> is a target for a write command.
> >>
> >> Simple in a nutshell. This is done so that the drive can work with a
> >> limited set of resources needed to handle open zones, that is, zones that
> >> are being written. There are some more nasty details to all this with
> >> limits on the number of open zones and active zones that a zoned drive may
> >> have.
> >
> > OK, thanks for the clarification about implicitly closed, but I
> > understand this close can't change the zone's write pointer.
> 
> You are right, it does not matter if the zone is implicitly closed, I
> was mistaken. But we still have to track the write pointer of every zone
> in open or active state, otherwise we cannot know if a write that arrive
> to a zone with no outstanding IO is actually at the write pointer, or
> whether we need to hold it.
> 
> >
> >>
> >> >
> >> > zone info can be cached in the mapping(hash table)(zone sector is the key, and zone
> >> > info is the value), which can be implemented as one LRU style. If any zone
> >> > info isn't hit in the mapping table, ioctl(BLKREPORTZONE) can be called for
> >> > obtaining the zone info.
> >> >
> >> >> the same zone, we need to sync across queues. Userspace may have
> >> >> synchronization in place to issue writes with multiple threads while
> >> >> still hitting the write pointer.
> >> >
> >> > You can trust mq-dealine, which guaranteed that write IO is sent to ->queue_rq()
> >> > in order, no matter MQ or SQ.
> >> >
> >> > Yes, it could be issue from multiple queues for ublksrv, which doesn't sync
> >> > among multiple queues.
> >> >
> >> > But per-zone re-order still can solve the issue, just need one lock
> >> > for each zone to cover the MQ re-order.
> >>
> >> That lock is already there and using it, mq-deadline will never dispatch
> >> more than one write per zone at any time. This is to avoid write
> >> reordering. So multi queue or not, for any zone, there is no possibility
> >> of having writes reordered.
> >
> > oops, I miss the single queue depth point per zone, so ublk won't break
> > zoned write at all, and I agree order of batch IOs is one problem, but
> > not hard to solve.
> 
> The current implementation _does_ break zoned write because it reverses
> batched writes. But if it is an easy fix, that is cool :)

Please look at Damien's comment:

>> That lock is already there and using it, mq-deadline will never dispatch
>> more than one write per zone at any time. This is to avoid write
>> reordering. So multi queue or not, for any zone, there is no possibility
>> of having writes reordered.

For zoned write, mq-deadline is used to limit at most one inflight write
for each zone.

So can you explain a bit how the current implementation breaks zoned
write?


Thanks, 
Ming

