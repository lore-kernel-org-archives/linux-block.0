Return-Path: <SRS0=iQ6z=7W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0016C433E0
	for <linux-block@archiver.kernel.org>; Tue,  9 Jun 2020 08:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 884CC20814
	for <linux-block@archiver.kernel.org>; Tue,  9 Jun 2020 08:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5Ero/PK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgFIIu0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Jun 2020 04:50:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38917 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726463AbgFIIuY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jun 2020 04:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591692623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Flv6S2rTMdck7MgTpJf2hUpAzcm5hp/f8jle5Kb7TVE=;
        b=B5Ero/PKGDi0//TmyroTxm8sUeTFhUFrg4fFLAKY97quZ59r/VFf8UGhwdrm038rA1C2bg
        Cjo02XI0EJJ34CZaZAzRNm1uVnobPpMYfnGrwsfRB/IdL2YUSobnDpySTPFcZdGyXRLkB4
        zkunnnWAFUu6LBzrCrR4XAsunkku4wA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-S8FIr6iGMhae9s18Vw6Juw-1; Tue, 09 Jun 2020 04:50:18 -0400
X-MC-Unique: S8FIr6iGMhae9s18Vw6Juw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2793D800053;
        Tue,  9 Jun 2020 08:50:17 +0000 (UTC)
Received: from T590 (ovpn-13-202.pek2.redhat.com [10.72.13.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 57E8560CD0;
        Tue,  9 Jun 2020 08:50:08 +0000 (UTC)
Date:   Tue, 9 Jun 2020 16:50:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Josh Snyder <joshs@netflix.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Josh Snyder <josh@code406.com>
Subject: Re: [RFC 2/2] Track io_ticks at microsecond granularity.
Message-ID: <20200609085002.GB270404@T590>
References: <20200609040724.448519-1-joshs@netflix.com>
 <20200609040724.448519-3-joshs@netflix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200609040724.448519-3-joshs@netflix.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 08, 2020 at 09:07:24PM -0700, Josh Snyder wrote:
> Previously, we performed truncation of I/O issue/completion times during
> calculation of io_ticks, counting only I/Os which cross a jiffy
> boundary. The effect is a sampling of I/Os: at every boundary between
> jiffies we ask "is there an outstanding I/O" and increment a counter if
> the answer is yes. This produces results that are accurate (they don't
> systematically over- or under-count), but not precise (there is high
> variance associated with only taking 100 samples per second).
> 
> This change modifies the sampling rate from 100Hz to 976562.5Hz (1
> sample per 1024 nanoseconds). I chose this sampling rate by simulating a
> workload in which I/Os are issued randomly (by a Poisson process), and
> processed in constant time: an M/D/∞ system (Kendall's notation). My
> goal was to produce a sampled utilization fraction which was correct to
> one part-per-thousand given one second of samples.
> 
> The tradeoff of the higher sampling rate is increased synchronization
> overhead caused by more frequent compare-and-swap operations. The
> technique of commit 5b18b5a73760 ("block: delete part_round_stats and
> switch to less precise counting") is to allow multiple I/Os to complete
> while performing only one synchronized operation. As we are increasing
> the sample rate by a factor of 10000, we will less frequently be able to
> exercise the synchronization-free code path.

Not sure if we need so precise %util, and ~1M sampling rate may cause to run
cmpxchg() 1M/sec for each partition, which overhead might be observable.

Thanks,
Ming

