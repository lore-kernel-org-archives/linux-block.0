Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AF7C433B4
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 02:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60E9A61464
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 02:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhEKC7A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 May 2021 22:59:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50494 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229637AbhEKC7A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 May 2021 22:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620701873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HGTw574Zdl38Dm2r00fjJlfZvUmTvOBB3ISzyiZ0v14=;
        b=HMMTzjeoDDhPvirbICtymRBcu6RX2lcNcHAl94LhrmlEaxNrX5OnDKq07z2LMlXCs/W1Su
        YAb3XkbL2WU01+l/rOg3UX48Aoeo4fbWuKLPVxrE3Z/12WL+EhazgzuxkksQD3puu6nin8
        8WfU7DyjQyXzv3HoYthS9OqyBtekwB0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-LEeC4-9OM2CkJTfhjHhQ5Q-1; Mon, 10 May 2021 22:57:51 -0400
X-MC-Unique: LEeC4-9OM2CkJTfhjHhQ5Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92F70800FF0;
        Tue, 11 May 2021 02:57:50 +0000 (UTC)
Received: from T590 (ovpn-12-106.pek2.redhat.com [10.72.12.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 335FF5D705;
        Tue, 11 May 2021 02:57:42 +0000 (UTC)
Date:   Tue, 11 May 2021 10:57:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Josh Hunt <johunt@akamai.com>
Subject: Re: [LSF/MM/BPF TOPIC] Block device congestion
Message-ID: <YJnyojvYN5PUc97A@T590>
References: <YJlx9+FQUBu5HmcI@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJlx9+FQUBu5HmcI@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 10, 2021 at 06:48:39PM +0100, Matthew Wilcox wrote:
> 
> I wish to re-nominate this topic from last year:
> 
> https://lore.kernel.org/linux-mm/20191231125908.GD6788@bombadil.infradead.org/
> 
> I don't think we've made any progress on it, and likely won't until
> everybody is forced into a room and the doors are locked.
> 

> >> Jens, is something supposed to be calling clear_bdi_congested() in the
> >> block layer?  blk_clear_congested() used to exist until October 29th
> >> last year.  Or is something else supposed to be waking up tasks that
> >> are sleeping on congestion?
> 
> Congestion isn't there anymore. It was always broken as a concept imho,
> since it was inherently racy. We used the old batching mechanism in the
> legacy stack to signal it, and it only worked for some devices.

The old batching and congestion was helpful for some slow devices, since
batching can avoid to submit IOs from different tasks concurrently to
same queue when queue is busy, so IO order in same task is maintained.

I believe Josh is struggling with this issue, and we had one offline
talk about this issue.

And there was another such old discussion too:

https://lore.kernel.org/linux-scsi/20191203022337.GE25002@ming.t460p/



Thanks,
Ming

