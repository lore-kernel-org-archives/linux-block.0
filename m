Return-Path: <SRS0=SOzO=D5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822BBC388F9
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 22:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2437324630
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 22:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="af2WcgEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372621AbgJVWET (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Oct 2020 18:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372592AbgJVWEQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Oct 2020 18:04:16 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C4AC0613CE
        for <linux-block@vger.kernel.org>; Thu, 22 Oct 2020 15:04:16 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 10so2126058pfp.5
        for <linux-block@vger.kernel.org>; Thu, 22 Oct 2020 15:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dUyWZKQk6Jd509JR1HWnGlhG34ZF3RzE+ItR8/csEOI=;
        b=af2WcgEUhMVdVEHg2sk74MHZXBT5DxoLwOBS00xAz5EohLXoViwwSmaU24AWRLzOZ6
         zYMUuBSqeYJ/qwD4xXLIAGGh58KA7lRlWvv/+eYhcdQ+erGUd2LKD0srl8w55Y7XV0F4
         j+qGHjaPGeR6vtPbmiQllPHVBLr0CpNir9LOJGXQK3w0qJsIYHFCJoDC3ws7MrB/IQ+G
         1IYlCLL0TFT2TvDhogL7kls8VQDccjVT+uV0djRG3tplfsjuK4UQYIre67O2aN5RgTJC
         YtjdV6iMnesCyRXjZ+RVKmg95xHsNCS2fZMH6eaO/S05rWYT61QMtwSjaqAQDS9YMtI9
         50TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dUyWZKQk6Jd509JR1HWnGlhG34ZF3RzE+ItR8/csEOI=;
        b=XIC8ofld8b4LqWwhcI9p9FQZQ1T7VfdKQmkzBYKSfpvKmdJ54nmIW9ulKVD9R8pUEB
         ycjooejCf68fMoZeafHpRb/20WACVA3Cm+m5CAx8yOu/m9W+nLmqY+SaAmebIZbjGAFq
         kjiwRS0Vh7fKgn4hzg7EXDl3lPyWKXrEvxFjDSwBK4qggskvV8lnawutC4VRX7XyTabj
         a7GHawwqaUp0zQUnOtGnDgXYMg0dTuG5fRmNvLYZRv0S8uaO4q7H721cKyjqVsXRkRf4
         e0i109Xw9554JKbpQ4KsfYe4MikUGMrBs/CSGbwFu3rrx+4/vVpYk8oReL1X+LN9Z1Ha
         Rqaw==
X-Gm-Message-State: AOAM533Jaq1hEME6YNZOA903YlG3PR3/I+tnfvHQt7AVCC6HjiCeO5Vf
        umJ/oyPePlkfzknV4QkVUa29ic6aPVzPDg==
X-Google-Smtp-Source: ABdhPJwcEQ3YeUH8ovZald8QJXaj4Ky438QGFKsn+C8K/zktkNFvlI8EP4KTVhCTcviIo4d9WpYQ7g==
X-Received: by 2002:a63:4c6:: with SMTP id 189mr3900717pge.233.1603404256042;
        Thu, 22 Oct 2020 15:04:16 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::4:f799])
        by smtp.gmail.com with ESMTPSA id y10sm3329203pff.119.2020.10.22.15.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 15:04:14 -0700 (PDT)
Date:   Thu, 22 Oct 2020 15:04:12 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH blktests v3 00/11] NVMe Target Passthru Block Tests
Message-ID: <20201022220412.GB1006674@relinquished.localdomain>
References: <20201008164024.12546-1-logang@deltatee.com>
 <29f3dc94-50c3-1548-034e-09c5394ef781@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29f3dc94-50c3-1548-034e-09c5394ef781@deltatee.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 22, 2020 at 12:45:25PM -0600, Logan Gunthorpe wrote:
> 
> On 2020-10-08 10:40 a.m., Logan Gunthorpe wrote:
> > Hi,
> > 
> > This series adds blktests for the nvmet passthru feature that was merged
> > for 5.9. It's been reconciled with Sagi's blktest series that Omar
> > recently merged.
> 
> Bump. This has been around for a while now. Omar, can you please
> consider picking this up?

There were a couple of shellcheck errors:

tests/nvme/rc:77:8: warning: Declare and assign separately to avoid masking return values. [SC2155]
tests/nvme/rc:278:7: note: Useless echo? Instead of 'echo $(cmd)', just use 'cmd'. [SC2005]

I fixed those up and applied, thanks.
