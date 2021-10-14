Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9D0C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 15:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF9260F9E
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 15:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhJNPji (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 11:39:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20766 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230080AbhJNPji (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 11:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634225852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ghrZ0fHY/L2lVDm2zxtj2ajOfOrWxMBCP6nrtoJMjlE=;
        b=X8SMW8eF55SEvBeKo7w3pR6vQ9uJMoSPuzwVKqMpPDMKbZLCzEOaiPxseHG89yBGBrHBEY
        37wKwUOIUCJc++0DdcoT3s+SFEo3H282+5MX9tMivlkynIJfh+vQll1JRaXElo7l5SOuF9
        zBSZt2CnExnwzkkp2gnteyWPUqFyAX4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-XBNGnKW5O1elDhXz9B8b8Q-1; Thu, 14 Oct 2021 11:37:29 -0400
X-MC-Unique: XBNGnKW5O1elDhXz9B8b8Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B6CC814250;
        Thu, 14 Oct 2021 15:37:23 +0000 (UTC)
Received: from localhost (unknown [10.39.193.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A00360583;
        Thu, 14 Oct 2021 15:37:20 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Enrico Granata <egranata@google.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        virtio-dev@lists.oasis-open.org, linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org, hch@infradead.org
Subject: Re: [virtio-dev] Fwd: [PATCH v2] Provide detailed specification of
 virtio-blk lifetime metrics
In-Reply-To: <CAPR809vsz_z4ooL6dPJMDtTWtf02-jbz4FVipRjsLGczCV_XCQ@mail.gmail.com>
Organization: Red Hat GmbH
References: <20210505193655.2414268-1-egranata@google.com>
 <CAPR809ukYeThsPy4eg8A-G8b4Hwt7Prxh9P75=Vp9jnCKb6WqQ@mail.gmail.com>
 <YO6ro345FI0XE8vv@stefanha-x1.localdomain> <87pmvlck3p.fsf@redhat.com>
 <YO7zwKbH6OEW2z1o@stefanha-x1.localdomain>
 <CAPR809uuo=5kmzUs3RFp6z_4===R0hxdFiScLPouUS+qxdaVWg@mail.gmail.com>
 <87h7duz7vq.fsf@redhat.com>
 <CAPR809vsz_z4ooL6dPJMDtTWtf02-jbz4FVipRjsLGczCV_XCQ@mail.gmail.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Thu, 14 Oct 2021 17:37:18 +0200
Message-ID: <87ilxzvcr5.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 06 2021, Enrico Granata <egranata@google.com> wrote:

> I would very much favor that - thanks for bringing this thread back to attention

Merged now, thank you for your patience.

