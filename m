Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE07C7EE43
	for <linux-block@archiver.kernel.org>; Tue, 13 Jun 2023 01:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjFMBir (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jun 2023 21:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjFMBir (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2023 21:38:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25039E62
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 18:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686620274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oWX0ejnudayz4hyeUhkIUJVdFhbRR7/ZXHZP25haJFI=;
        b=P+qt8V1vbKOCKaOTZwnzmO+bR9J8MrRbhH1Utg/1eQO6m7vHKc39lMsQT59J65/cNe1j0b
        oKGyAbgi5veu1CJJKaDIOkWvOcgJeAvoYmiHEDDqOCnVQ+A0gsqSx4xNAiW+yJj5XPI/S+
        Xj1V4Q+BDY72qfAs4c20Flik766Pdc4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-HwybWfQuMXqXRKNmlAFfyw-1; Mon, 12 Jun 2023 21:37:51 -0400
X-MC-Unique: HwybWfQuMXqXRKNmlAFfyw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48431811E86;
        Tue, 13 Jun 2023 01:37:51 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA1C01415102;
        Tue, 13 Jun 2023 01:37:46 +0000 (UTC)
Date:   Tue, 13 Jun 2023 09:37:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Pittman <jpittman@redhat.com>
Cc:     axboe@kernel.dk, djeffery@redhat.com, loberman@redhat.com,
        emilne@redhat.com, minlei@redhat.com, linux-block@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH] block: set reasonable default for discard max
Message-ID: <ZIfIZWthJptVsQ6q@ovpn-8-16.pek2.redhat.com>
References: <20230609180805.736872-1-jpittman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609180805.736872-1-jpittman@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 09, 2023 at 02:08:05PM -0400, John Pittman wrote:
> Some drive manufacturers export a very large supported max discard size.

Most of devices exports very large max discard size, and it shouldn't be
just some.

> However, when the operating system sends I/O of the max size to the
> device, extreme I/O latency can often be encountered. Since hardware

It often depends on drive internal state.

> does not provide an optimal discard value in addition to the max, and
> there is no way to foreshadow how well a drive handles the large size,
> take the method from max_sectors setting, and use BLK_DEF_MAX_SECTORS to
> set a more reasonable default discard max. This should avoid the extreme
> latency while still allowing the user to increase the value for specific
> needs.

As Martin and Chaitanya mentioned, reducing max discard size to level
of BLK_DEF_MAX_SECTORS won't be one ideal approach, and shouldn't be
accepted, since discarding command is supposed to be cheap from device
viewpoint, such as, SSD FW usually just marks the LBA ranges as invalid
for handling discard.

However, how well discard performs may depend on SSD internal, such as
if GC is in-progress. And it might be one more generic issue for SSD,
and it was discussed several times, such as "Issues around discard" in
lsfmm2019:

	https://lwn.net/Articles/787272/

BTW, blk-wbt actually throttles discard, but it is just in queue depth
level. If max discard size is too big, single big discard request still may
cause device irresponsive.


Thanks,
Ming

