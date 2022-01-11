Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56B2C433EF
	for <linux-block@archiver.kernel.org>; Tue, 11 Jan 2022 18:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242284AbiAKSVx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jan 2022 13:21:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30442 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242057AbiAKSVw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jan 2022 13:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641925312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5BL/Z9jZkrOVYFK7HhKccychDhStBWbDZbasY7oM2OA=;
        b=PszB0HvHHMB8sAdqzzVBoIJhedXpwXWk3LumMYAT56HR/hPo/5WNBPK7joV0qvz1WleUF7
        o0ZKUsLbyUdZ5jV6GOOs6c7xheFMN0oW1FDNlYAEbWP98quc2WnIOWIJmZ/kw74rx6PByV
        IUmh7W/AxDbOx0Iq2PyWL9phinJomvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-nGqmbmKKO_uDREgOHCH5kA-1; Tue, 11 Jan 2022 13:21:49 -0500
X-MC-Unique: nGqmbmKKO_uDREgOHCH5kA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BC75100F944;
        Tue, 11 Jan 2022 18:21:48 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 053C67A3F6;
        Tue, 11 Jan 2022 18:21:22 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Mike Snitzer <snitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [dm-devel] [PATCH 0/3] blk-mq/dm-rq: support BLK_MQ_F_BLOCKING for dm-rq
References: <20211221141459.1368176-1-ming.lei@redhat.com>
        <YcH/E4JNag0QYYAa@infradead.org> <YcP4FMG9an5ReIiV@T590>
        <YcuB4K8P2d9WFb83@redhat.com> <Yd1BFpYTBlQSPReW@infradead.org>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Tue, 11 Jan 2022 13:23:53 -0500
In-Reply-To: <Yd1BFpYTBlQSPReW@infradead.org> (Christoph Hellwig's message of
        "Tue, 11 Jan 2022 00:34:30 -0800")
Message-ID: <x49ee5ejfly.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Tue, Dec 28, 2021 at 04:30:08PM -0500, Mike Snitzer wrote:
>> Yeah, people use request-based for IO scheduling and more capable path
>> selectors. Imposing bio-based would be a pretty jarring workaround for 
>> BLK_MQ_F_BLOCKING. request-based DM should properly support it.
>
> Given that nvme-tcp is the only blocking driver that has multipath
> driver that driver explicitly does not intend to support dm-multipath
> I'm absolutely against adding block layer cruft for this particular
> use case.

Maybe I have bad taste, but the patches didn't look like cruft to me.
:)

I'm not sure why we'd prevent users from using dm-mpath on nvmeof.  I
think there's agreement that the nvme native multipath implementation is
the preferred way (that's the default in rhel9, even), but I don't think
that's a reason to nack this patch set.

Or have I missed your point entirely?

Thanks!
Jeff

