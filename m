Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F003FC004D4
	for <linux-block@archiver.kernel.org>; Thu, 19 Jan 2023 18:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjASSsE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Jan 2023 13:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjASSsC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Jan 2023 13:48:02 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D3B4DE12
        for <linux-block@vger.kernel.org>; Thu, 19 Jan 2023 10:48:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A2076CE2597
        for <linux-block@vger.kernel.org>; Thu, 19 Jan 2023 18:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20228C433EF;
        Thu, 19 Jan 2023 18:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674154076;
        bh=wgshnKR0AqwF8kQes6szRtL7Sefx/jJD0auYcw7aCyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AvfETIhZsQfBj3rJJaGgdS42GlRCKWRrAKcnF6zwUCmE2hI82V3XoiQNSF3WetJsB
         q1xLfZtvad3QWR++gOltXUjo6bw/rNxJKQoQ4Zz8eUlNcmAld9w1LIz+I/03EN3nEY
         ASExaxoAEOZFssJdSczpvxOxzE6M0VXQ/AotgpwFOtH8fonEQZREQTmCj5UN5aRy+k
         4iRcdfRrMZ9sbjVXgSicojDurk3s0FKAoDWopOsuZq/0qRUYrcNO92C8VcSB9W0lTw
         M/EIDM+vekQ6mu49ixwGXbBqYDVwG6CaTHa7SZTKOjLvmO7D3iIqEQtHXZyxWdWM57
         DQEUjJhSZT5uA==
Date:   Thu, 19 Jan 2023 11:47:53 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ed Tsai <ed.tsai@mediatek.com>
Subject: Re: [PATCH v2] block: Improve shared tag set performance
Message-ID: <Y8mQWTRze+SXD7Oz@kbusch-mbp>
References: <20230103195337.158625-1-bvanassche@acm.org>
 <Y8hvNmyR3U1ge3H3@kbusch-mbp>
 <4be69fc0-af32-b552-6a36-f75eb798ca95@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4be69fc0-af32-b552-6a36-f75eb798ca95@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 18, 2023 at 02:46:38PM -0800, Bart Van Assche wrote:
> - The code removed by this patch negatively impacts performance of all
>   SCSI hosts with two or more data LUNs and also of all NVMe controllers
>   that export two or more namespaces if there are significant
>   differences in the number of I/O operations per second for different
>   LUNs/namespaces. This is why I think that this should be solved in the
>   block layer instead of modifying each block driver individually.

I think the potential performance sacrifice was done on purpose in order
to guarantee all tagset subscribers can have at least one unblocked
access to the pool, otherwise one LUN could starve all the others by
tying up all the tags in long-running operations. Is anyone actually
benefiting from the current sharing, though? I really do not know, so
I'm having trouble weighing in on removing it.
