Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBBBEB64DD
	for <linux-block@archiver.kernel.org>; Mon,  7 Aug 2023 04:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjHGEoz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Aug 2023 00:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjHGEox (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Aug 2023 00:44:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A02E8
        for <linux-block@vger.kernel.org>; Sun,  6 Aug 2023 21:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691383449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E+2EbnFZV7yJtZskjh+cWG4NxmXWzvfmJSRPX0ne/hU=;
        b=OlEYEIfpnSCjPVP9mcGtb1nLi/1kv7EgxA9ptvERTLbwDPaXvxjGQSqwohWwrIuSQ9bX87
        wz3uTH8sQwhVP6ny1mfVEHaJ4JGmKNBt6jtv6a54IDaRrpW2xVsFD1n1MgAuNnbArzzHE+
        0cPTkYUxS5SpoQwxtr53YskKzS+firo=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-7bXBxQuNOCOOPq0oOR1nEQ-1; Mon, 07 Aug 2023 00:44:08 -0400
X-MC-Unique: 7bXBxQuNOCOOPq0oOR1nEQ-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5635233876bso2653774a12.0
        for <linux-block@vger.kernel.org>; Sun, 06 Aug 2023 21:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691383447; x=1691988247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+2EbnFZV7yJtZskjh+cWG4NxmXWzvfmJSRPX0ne/hU=;
        b=WmGi8E+yyphoeIWBYEgDIndjrNFYKq+MHTbQFLQtmjOZoK2JrqeGmzdH4UXjAqoQ6T
         QtwCnWfKGdDcXlfREgf3MPQcyQm5WPvYjbZnxh3e9ElgRuysNs+iiaV9Gp28C4HEs64c
         278o9AWeJdLdTrgFLT30FGt6lqIwag1WOE2KSE4uQj6UrWs0s6JYBXvc2wHxuWWc3ZU0
         KI95VeR+3CW/XzIRcq7qJkRTMbA+io02I4/pG1c5SP0nltroJXwBjqLp8M7UwnU/SdPE
         dWZY6fzAp+IC2R5oT2o7lOlb5O5jxcOj7KpMf3kRD4YW5AY/oXNFX+N8VSXiHXtvwtT5
         gz1A==
X-Gm-Message-State: AOJu0YzbqtWBP9E/3Api4WG5Sxiv2RlxBtxJC8AXkeVcW1uu7AVeAgr7
        jzLWYQ747NlkF/e8sCYvt/vcK3q9sBMufmNpFM33Kky0+cAKBVqkVPrLeeupcSVoiHXdBMR6vMz
        0sgaP9ewhmR5en5mfCJn5IKzuK3AsNXr+DA==
X-Received: by 2002:a05:6a20:1006:b0:125:f3d8:e65b with SMTP id gs6-20020a056a20100600b00125f3d8e65bmr7292038pzc.18.1691383447541;
        Sun, 06 Aug 2023 21:44:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDShi2vAdRaNGp+RB4NdbaHvukAeLo4WlRfe0u382qDdlhARlZSEovvdd8LQZl2heUKcBudQ==
X-Received: by 2002:a05:6a20:1006:b0:125:f3d8:e65b with SMTP id gs6-20020a056a20100600b00125f3d8e65bmr7292025pzc.18.1691383447235;
        Sun, 06 Aug 2023 21:44:07 -0700 (PDT)
Received: from fedora19.localdomain ([2401:d002:2d05:b10a:c9ac:2dd7:6463:bb84])
        by smtp.gmail.com with ESMTPSA id iz7-20020a170902ef8700b001b895a17429sm5697860plb.280.2023.08.06.21.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 21:44:06 -0700 (PDT)
Date:   Mon, 7 Aug 2023 14:44:00 +1000
From:   Ian Wienand <iwienand@redhat.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Martin Doucha <mdoucha@suse.cz>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: Re: [PATCH 0/1] Possible bug in zram on ppc64le on vfat
Message-ID: <ZNB2kORYiKdl3vSq@fedora19.localdomain>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com>
 <ZMycl7xKyJoQNpcu@fedora19.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMycl7xKyJoQNpcu@fedora19.localdomain>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

After thinking it through, I think I might have a explanation...

On Fri, Aug 04, 2023 at 04:37:11PM +1000, Ian Wienand wrote:
> To recap; this test [1] creates a zram device, makes a filesystem on
> it, and fills it with sequential 1k writes from /dev/zero via dd.  The
> problem is that it sees the mem_used_total for the zram device as zero
> in the sysfs stats after the writes; this causes a divide by zero
> error in the script calculation.
> 
> An annoted extract:
> 
>  zram01 3 TINFO: /sys/block/zram1/disksize = '26214400'
>  zram01 3 TPASS: test succeeded
>  zram01 4 TINFO: set memory limit to zram device(s)
>  zram01 4 TINFO: /sys/block/zram1/mem_limit = '25M'
>  zram01 4 TPASS: test succeeded
>  zram01 5 TINFO: make vfat filesystem on /dev/zram1
> 
>  >> at this point a cat of /sys/block/zram1/mm_stat shows
>  >>   65536      527    65536 26214400    65536        0        0        0
> 
>  zram01 5 TPASS: zram_makefs succeeded

So I think the thing to note is that mem_used_total is the current
number of pages (reported * PAGE_SIZE) used by the zsmalloc allocator
to store compressed data.

So we have made the file system, which is now quiescent and just has
basic vfat data; this is compressed and stored and there's one page
allocated for this (arm64, 64k pages).

>  zram01 6 TINFO: mount /dev/zram1
>  zram01 6 TPASS: mount of zram device(s) succeeded
>  zram01 7 TINFO: filling zram1 (it can take long time)
>  zram01 7 TPASS: zram1 was filled with '25568' KB
>
>  >> however, /sys/block/zram1/mm_stat shows
>  >>   9502720        0        0 26214400   196608      145        0        0
>  >> the script reads this zero value and tries to calculate the
>  >> compression ratio
> 
>  ./zram01.sh: line 145: 100 * 1024 * 25568 / 0: division by 0 (error token is "0")

At this point, because this test fills from /dev/zero, the zsmalloc
pool doesn't actually have anything in it.  The filesystem metadata is
in-use from the writes, and is not written out as compressed data.
The zram page de-duplication has kicked in, and instead of handles to
zsmalloc areas for data we just have "this is a page of zeros"
recorded.  So this is correctly reflecting that fact that we don't
actually have anything compressed stored at this time.

>  >> If we do a "sync" then redisply the mm_stat after, we get
>  >>   26214400     2842    65536 26214400   196608      399        0        0

Now we've finished writing all our zeros and have synced, we would
have finished updating vfat allocations, etc.  So this gets compressed
and written, and we're back to have some small FS metadata compressed
in our 1 page of zsmalloc allocations.

I think what is probably "special" about this reproducer system is
that it is slow enough to allow the zero allocation to persist between
the end of the test writes and examining the stats.

I'd be happy for any thoughts on the likelyhood of this!

If we think this is right; then the point of the end of this test [1]
is ensure a high reported compression ratio on the device, presumably
to ensure the compression is working.  Filling it with urandom would
be unreliable in this regard.  I think what we want to do is something
highly compressable like alternate lengths of 0x00 and 0xFF.  This
will avoid the same-page detection and ensure we actually have
compressed data, and we can continue to assert on the high compression
ratio reliably.  I'm happy to propose this if we generally agree.

Thanks,

-i

> [1] https://github.com/linux-test-project/ltp/blob/8c201e55f684965df2ae5a13ff439b28278dec0d/testcases/kernel/device-drivers/zram/zram01.sh

