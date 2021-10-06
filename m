Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEB2C433F5
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 11:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03F196113A
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 11:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbhJFL4P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Oct 2021 07:56:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39258 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238117AbhJFL4O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Oct 2021 07:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633521262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z3n781SEL+Kn3UomjzzL/ye4PJxJ0/lysVbmtVZ+Dws=;
        b=CFHuDJeZCeDqujHsZEJmmLnL4mGZinKrVe01LSBLMvXYSqyxZj8Gmo4VV5F812IEhEm/A2
        L9GcmcbTovs+LadtCy2nZkQUN/b2ESbI5Kt4u3oDfdMAvrZhb+jHBjjy5pSQxl6ImOnjaU
        3WsH8QQgmJ0qat3yE16G0WXv9/D+P10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-aEExm3fYO5iHeDGh_1t3yw-1; Wed, 06 Oct 2021 07:54:19 -0400
X-MC-Unique: aEExm3fYO5iHeDGh_1t3yw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B952BBEE5;
        Wed,  6 Oct 2021 11:54:18 +0000 (UTC)
Received: from localhost (unknown [10.39.193.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 49FCE60BE5;
        Wed,  6 Oct 2021 11:54:03 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Enrico Granata <egranata@google.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtio-dev@lists.oasis-open.org, linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org, hch@infradead.org
Subject: Re: [virtio-dev] Fwd: [PATCH v2] Provide detailed specification of
 virtio-blk lifetime metrics
In-Reply-To: <CAPR809uuo=5kmzUs3RFp6z_4===R0hxdFiScLPouUS+qxdaVWg@mail.gmail.com>
Organization: Red Hat GmbH
References: <20210505193655.2414268-1-egranata@google.com>
 <CAPR809ukYeThsPy4eg8A-G8b4Hwt7Prxh9P75=Vp9jnCKb6WqQ@mail.gmail.com>
 <YO6ro345FI0XE8vv@stefanha-x1.localdomain> <87pmvlck3p.fsf@redhat.com>
 <YO7zwKbH6OEW2z1o@stefanha-x1.localdomain>
 <CAPR809uuo=5kmzUs3RFp6z_4===R0hxdFiScLPouUS+qxdaVWg@mail.gmail.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Wed, 06 Oct 2021 13:54:01 +0200
Message-ID: <87h7duz7vq.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 06 2021, Enrico Granata <egranata@google.com> wrote:

> Hi folks,
> I am back from my leave of absence, so thank you everyone for your patience
>
> This proposal has been outstanding for a while and didn't seem to
> receive pushback, especially compared to the initial proposal
>
> Would it be the right time to put this modification up for a vote?

I guess no news is good news? (Or it fell through the cracks for everybody...)

I can update #106 and start voting.

