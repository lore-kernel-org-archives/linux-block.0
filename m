Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31526C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 07:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiFWHsx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 03:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiFWHsQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 03:48:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5516A120A5
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 00:48:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F088121D34;
        Thu, 23 Jun 2022 07:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655970491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=43nJFzKPp9lru1TVC3g9kCuDrrDoLnO4s4j3Bu4v2uA=;
        b=X9v8kdfIgw1NhcTsFzd1/eQtaK6ksNaA6gckH1hbcB3+YDBrYRobAziU30tnJWBOPzrk2t
        lyuol9GA/xXw/yt+RguhDR3OPVVyQlHjK/d8We9/SbQamfsrxQHXTjsDpac6gI5SBH9z4d
        thD/cgohi7mYUHcptCsGgxvEV7ahF0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655970491;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=43nJFzKPp9lru1TVC3g9kCuDrrDoLnO4s4j3Bu4v2uA=;
        b=kJT1wFezvdIQXoLREXjWy+i2nsQEpyNGV2qC7jcpgg8qjfDkC74BnAewoox2BVIvablcNw
        rgbziiLgbjlSkiBw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 058B92C145;
        Thu, 23 Jun 2022 07:48:06 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3FBB8A062B; Thu, 23 Jun 2022 09:48:11 +0200 (CEST)
Date:   Thu, 23 Jun 2022 09:48:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH 0/9 v4] block: Fix IO priority mess
Message-ID: <20220623074811.3yrkevoa5n3jarkz@quack3.lan>
References: <20220621102201.26337-1-jack@suse.cz>
 <217a12c7-fd02-1e3d-16cc-207e7c55551b@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <217a12c7-fd02-1e3d-16cc-207e7c55551b@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 23-06-22 09:24:56, Damien Le Moal wrote:
> On 6/21/22 19:24, Jan Kara wrote:
> > Hello,
> > 
> > This is the fourth revision of my patches fixing IO priority handling in the
> > block layer.
> 
> Hey,
> 
> I ran some tests with RT IO class on an ATA HDD with NCQ priority.
> Results look good:
> 
> randread: (groupid=0, jobs=1): err= 0: pid=1862: Thu Jun 23 09:22:42 2022
>   read: IOPS=152, BW=19.1MiB/s (20.0MB/s)(11.1GiB/592929msec)
>     slat (usec): min=37, max=3280, avg=174.96, stdev=120.90
>     clat (msec): min=7, max=918, avg=156.95, stdev=149.43
>      lat (msec): min=7, max=918, avg=157.13, stdev=149.43
>     clat prio 0/0 (msec): min=7, max=918, avg=171.68, stdev=150.48
>     clat prio 1/0 (msec): min=8, max=166, avg=24.64, stdev= 5.93
>     clat percentiles (msec):
>      |  1.00th=[   15],  5.00th=[   20], 10.00th=[   23], 20.00th=[   32],
>      | 30.00th=[   51], 40.00th=[   77], 50.00th=[  108], 60.00th=[  146],
>      | 70.00th=[  194], 80.00th=[  262], 90.00th=[  372], 95.00th=[  477],
>      | 99.00th=[  659], 99.50th=[  701], 99.90th=[  793], 99.95th=[  818],
>      | 99.99th=[  885]
>     clat prio 0/0 (89.99% of IOs) percentiles (msec):
>      |  1.00th=[   15],  5.00th=[   21], 10.00th=[   27], 20.00th=[   46],
>      | 30.00th=[   68], 40.00th=[   94], 50.00th=[  126], 60.00th=[  163],
>      | 70.00th=[  213], 80.00th=[  279], 90.00th=[  388], 95.00th=[  489],
>      | 99.00th=[  659], 99.50th=[  709], 99.90th=[  793], 99.95th=[  827],
>      | 99.99th=[  885]
>     clat prio 1/0 (10.01% of IOs) percentiles (msec):
>      |  1.00th=[   14],  5.00th=[   17], 10.00th=[   18], 20.00th=[   20],
>      | 30.00th=[   22], 40.00th=[   23], 50.00th=[   25], 60.00th=[   26],
>      | 70.00th=[   28], 80.00th=[   30], 90.00th=[   33], 95.00th=[   35],
>      | 99.00th=[   40], 99.50th=[   42], 99.90th=[   47], 99.95th=[   50],
>      | 99.99th=[  167]
> 
> Clearly significantly lower tail latencies for the 10% of IOs with class
> RT (1/0), as expected. This is with "none" scheduler at QD=24 (128K random
> read).

Nice! :)

> Feel free to add:
> 
> Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Thanks for testing! I'll post the final patch version shortly.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
