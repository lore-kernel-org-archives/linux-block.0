Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C7EC433F5
	for <linux-block@archiver.kernel.org>; Tue,  8 Feb 2022 03:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345225AbiBHDYB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Feb 2022 22:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbiBHDYA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Feb 2022 22:24:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A950C043188
        for <linux-block@vger.kernel.org>; Mon,  7 Feb 2022 19:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644290639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m8MFRztUxgRkrBpUpM+qrlg49h9/BEVue4eQaEH7ZJc=;
        b=K8nLvtlCFw8+cUFekM56iZKxA5ERQ82usD7Is/WoNrKGWmpphpixPAnCbSloKc1pMVi/S4
        zxLkOuwUVZIo1++ErZGIPDa+OmusVTi/F+OWEkdbKaFeTrfO/CAB40OddR9KJpv3oxZZ7z
        R+sk9HIKn8IULSMtOP9DIWF39l7VH5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-TvQDvObAP4y1IoxvJ0qeVg-1; Mon, 07 Feb 2022 22:23:56 -0500
X-MC-Unique: TvQDvObAP4y1IoxvJ0qeVg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F9711091DA3;
        Tue,  8 Feb 2022 03:23:55 +0000 (UTC)
Received: from T590 (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A7AA46994;
        Tue,  8 Feb 2022 03:23:38 +0000 (UTC)
Date:   Tue, 8 Feb 2022 11:23:32 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Martin Wilck <martin.wilck@suse.com>
Subject: Re: [PATCH V2] lib/sbitmap: kill 'depth' from sbitmap_word
Message-ID: <YgHiNLhY/IWQY7zp@T590>
References: <20220110072945.347535-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110072945.347535-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 10, 2022 at 03:29:45PM +0800, Ming Lei wrote:
> Only the last sbitmap_word can have different depth, and all the others
> must have same depth of 1U << sb->shift, so not necessary to store it in
> sbitmap_word, and it can be retrieved easily and efficiently by adding
> one internal helper of __map_depth(sb, index).
> 
> Remove 'depth' field from sbitmap_word, then the annotation of
> ____cacheline_aligned_in_smp for 'word' isn't needed any more.
> 
> Not see performance effect when running high parallel IOPS test on
> null_blk.
> 
> This way saves us one cacheline(usually 64 words) per each sbitmap_word.
> 
> Cc: Martin Wilck <martin.wilck@suse.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Hello Guys,

Ping...

Thanks,
Ming

