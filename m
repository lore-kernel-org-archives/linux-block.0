Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066F5C433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 02:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF8BD20776
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 02:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3/KjSUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgFPCko (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jun 2020 22:40:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60171 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725978AbgFPCkn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jun 2020 22:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592275242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zjYU+ictEH4BKnJDi+POKJ1qTR37DlqYFMD0YIWJexM=;
        b=E3/KjSUB/EQSVEY2AGH3nBf0G4s/sXkwnOa2hz3apXvJZADfchpwR/GmYlk2R1TmYKOGBk
        KBYv+W3sW8WNkkWf0FgZW1vB8+H+1c66NrWviYBQVvUHhcyglDjd2E3R9xMY6As93qZPH9
        vAUZszALhqnrDKLUojAOIxhjnZK/T24=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-Nz5UI5luO7mcDck6mN5dVQ-1; Mon, 15 Jun 2020 22:40:40 -0400
X-MC-Unique: Nz5UI5luO7mcDck6mN5dVQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BA67100960F;
        Tue, 16 Jun 2020 02:40:39 +0000 (UTC)
Received: from T590 (ovpn-12-136.pek2.redhat.com [10.72.12.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A23D05D9D5;
        Tue, 16 Jun 2020 02:40:33 +0000 (UTC)
Date:   Tue, 16 Jun 2020 10:40:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-block@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] block: add split_alignment for request queue
Message-ID: <20200616024028.GE27192@T590>
References: <20200616005633.172804-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616005633.172804-1-harshadshirwadkar@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 15, 2020 at 05:56:33PM -0700, Harshad Shirwadkar wrote:
> This feature allows the user to control the alignment at which request
> queue is allowed to split bios. Google CloudSQL's 16k user space
> application expects that direct io writes aligned at 16k boundary in
> the user-space are not split by kernel at non-16k boundaries. More
> details about this feature can be found in CloudSQL's Cloud Next 2018
> presentation[1]. The underlying block device is capable of performing
> 16k aligned writes atomically. Thus, this allows the user-space SQL
> application to avoid double-writes (to protect against partial
> failures) which are very costly provided that these writes are not
> split at non-16k boundary by any underlying layers.
> 
> We make use of Ext4's bigalloc feature to ensure that writes issued by
> Ext4 are 16k aligned. But, 16K aligned data writes may get merged with
> contiguous non-16k aligned Ext4 metadata writes. Such a write request
> would be broken by the kernel only guaranteeing that the individually
> split requests are physical block size aligned.
> 
> We started observing a significant increase in 16k unaligned splits in
> 5.4. Bisect points to commit 07173c3ec276cbb18dc0e0687d37d310e98a1480
> ("block: enable multipage bvecs"). This patch enables multipage bvecs
> resulting in multiple 16k aligned writes issued by the user-space to
> be merged into one big IO at first. Later, __blk_queue_split() splits
> these IOs while trying to align individual split IOs to be physical
> block size.
> 
> Newly added split_alignment parameter is the alignment at which
> requeust queue is allowed to split IO request. By default this
> alignment is turned off and current behavior is unchanged.
> 

Such alignment can be reached via q->limits.chunk_sectors, and you
just need to expose it via sysfs and make it writable.

Thanks,
Ming

