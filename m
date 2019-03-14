Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD32C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 17:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C6420811
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 17:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="F35z/Hxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfCNRzg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 13:55:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46473 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbfCNRzg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 13:55:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id s23so4334382pfe.13
        for <linux-block@vger.kernel.org>; Thu, 14 Mar 2019 10:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qglhaAbFLPN1WCZPpcTaAg3VETklku4XmF59T0uaNbw=;
        b=F35z/HxdVVhLbK4KNISVB3MLLtxofONNFWRF5EVcb3cUtpAtbalKdazS8f0UQL4OIu
         KEX8Y2iJJj0TJZhketM9TAMFgfT7rjVqAMIfTmpWDGf1vJlfMXqrxW0aAwUsK9iIGgzp
         oRXoAzP2fm96Hiwuzk818QmRfKf5ZAXFtvPxF0y95MlxbwzN1CenZTPGIbOirsaE1Lim
         dQf9a7V4HcR1kE0CMz0USQOfIaU3qd+/oNTomYOhKC0CbCxrgocNH0LC5YixDBiSdM4o
         GBnfwFkyXQKMm3IIkrGMD4XOqFjLxYQM1SBy0e3fvWLt0DEi6iPnMcQ/9fz8fTCbUX1k
         YRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qglhaAbFLPN1WCZPpcTaAg3VETklku4XmF59T0uaNbw=;
        b=QkkwA0MaKfIq6EHa7w513Hi/Wn/ypoiQgvuU5Zi3eXY7dYev8rJninbzxeR9iDho3C
         tBPdjAzUE6WYcYNduwd0e6NmLnaw11pGVVeAuIns5G8Rn4XgJ/3PP0GugS+uj8kFf8/M
         wIDHusPoiK7Rv2msk+dwfmLIdcjPO3fAZ1wdSnN592o9EspKwRvklEc23o4i/432YOj0
         RDCzGZ04mXh1TP1V8vfRiDnU4pXqxFlgTS5WOTwMJ1l3LtjXNEZyUPZPpj8aBBOMCx8l
         nwMOm1ZnVAUkLKJtYnYhr/aX7cxhfIBvPOduJZ4ragwFdsW2SByVuactEFMoF+ocCXQ4
         XKMw==
X-Gm-Message-State: APjAAAXfNLlxY8kN84m3LSLOkfDL6ZhUICR6LDQZdzLwUpqxgNhRAOS6
        q+T/JQgo08M0+QuJRCRagJ6Ss0Wzb/g=
X-Google-Smtp-Source: APXvYqxPImg4YIcTvqHsaaluUQEIG0MDVkVRd1wE13v7Fpj45/rVokcumfvtTjUg7Y/TI4SFOz10iA==
X-Received: by 2002:a63:68ca:: with SMTP id d193mr45932268pgc.53.1552586135066;
        Thu, 14 Mar 2019 10:55:35 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::3:7870])
        by smtp.gmail.com with ESMTPSA id u26sm21811663pfn.166.2019.03.14.10.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 10:55:34 -0700 (PDT)
Date:   Thu, 14 Mar 2019 10:55:33 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     linux-block@vger.kernel.org, osandov@fb.com, jack@suse.cz
Subject: Re: [PATCH blktests 2/2] loop/001: verify all partitions are removed
Message-ID: <20190314175533.GC11825@vader>
References: <1552563917-8388-1-git-send-email-dongli.zhang@oracle.com>
 <1552563917-8388-2-git-send-email-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552563917-8388-2-git-send-email-dongli.zhang@oracle.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 14, 2019 at 07:45:17PM +0800, Dongli Zhang wrote:
> loop/001 does not test whether all partitions are removed successfully
> during loop device partition scanning. As a result, the regression
> introduced by 0da03cab87e6 ("loop: Fix deadlock when calling
> blkdev_reread_part()") can not be detected.
> 
> The regression will generate below message in dmesg:
> 
> [  464.414043] __loop_clr_fd: partition scan of loop0 failed (rc=-22)
> 
> and leave orphan partitions like below:
> 
> - /dev/loop0p1
> - /sys/block/loop0/loop0p1
> 
> This patch verifies all partitions are removed by checking if there is
> /sys/block/loopX/loopXpY left. The expected number of partitions left is 0.

Thanks for the test! A couple of comments below.

> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  tests/loop/001     | 5 +++++
>  tests/loop/001.out | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/tests/loop/001 b/tests/loop/001
> index 47f760a..a0326b7 100755
> --- a/tests/loop/001
> +++ b/tests/loop/001
> @@ -4,6 +4,9 @@
>  #
>  # Test loop device partition scanning. Regression test for commit e02898b42380
>  # ("loop: fix LO_FLAGS_PARTSCAN hang").
> +#
> +# Test loop device paritition scanning. Regression test for commit 758a58d0bc67
> +# ("loop: set GENHD_FL_NO_PART_SCAN after blkdev_reread_part()").

These can just be combined to

# Test loop device partition scanning. Regression test for commits e02898b42380
# ("loop: fix LO_FLAGS_PARTSCAN hang") and 758a58d0bc67 ("loop: set
# GENHD_FL_NO_PART_SCAN after blkdev_reread_part()").

>  . tests/loop/rc
>  
> @@ -24,9 +27,11 @@ test() {
>  		mkpart primary 50% 100%
>  
>  	loop_device="$(losetup -P -f --show "$TMPDIR/img")"
> +	loop_name=${loop_device:5}
>  	lsblk -ln "$loop_device" | wc -l
>  
>  	losetup -d "$loop_device"
> +	ls /sys/block/$loop_name | grep loop | wc -l

We can just repeat the same `lsblk -ln "$loop_device" | wc -l` from
earlier, right? That's a bit cleaner than the hardcoded string slicing
and ls.

>  	rm "$TMPDIR/img"
>  	echo "Test complete"
>  }
> diff --git a/tests/loop/001.out b/tests/loop/001.out
> index 75979f0..8c4917f 100644
> --- a/tests/loop/001.out
> +++ b/tests/loop/001.out
> @@ -1,3 +1,4 @@
>  Running loop/001
>  3
> +0
>  Test complete
> -- 
> 2.7.4
> 
