Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3C5C04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 23:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A323A20989
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 23:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="R7tfg4F+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A323A20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeLEXjm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:39:42 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40190 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeLEXjl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 18:39:41 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so10780368pfo.7
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 15:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QyMv6k47mxC4QXsLZAWLAwhvbbAwz6JqUNys0Z+UDg8=;
        b=R7tfg4F+GB2UzaNa0k9i4ts6iQLowNobti5AOKKKr1IbytvWfw7ApBqHDu86ChNIsF
         BMN3WKGQcDBH1wj8toI0ibxFPr6vXw48h/+dK53CIz2nL96KbA+8ESHyJBALo9EjhEHJ
         E53Juqreq5IUEk6gjo/cbOf6BV+gAfMKyzbmxm3oWrh3tdnMwJMzwI85VcFQ2yHE3uug
         RowfHSXHoGEtZA0zUupz1FDLk7Z0JU3/I85Ek7mbkKmXRTV7Vy/H0Eg8X1mmNMasN1PH
         V9c7bqNbHs9+mHw14VmUO23LrdbE/4Uhjr2Ha/Ye/f+7BKSofy4193WMB3iCw8EOmSxm
         Gz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QyMv6k47mxC4QXsLZAWLAwhvbbAwz6JqUNys0Z+UDg8=;
        b=hfSNk+1nKojargLBkK5pux3hqwaLCPK+/9c+VLmxdzhhjh4ljKBktd2bXSBLA0RCDk
         vEAFHvyrzZSMx+Vlwhb5giphikCu1NGLyahlBD4dKeV2NvWS3lojpZrzwBqHa7Odewv4
         7w1tVFjWh1Ig5FQt7nCc7oNjjXYYvY2hmkfaQgKBHyPZY0kcRxrwWam1srH4gpMwfIzM
         o15y7hkOg+43E3i0PLet8O1hOTYyjrRmC2FFY01JE4i0AU2pjhwCTpYPBuuNAeVQuTva
         kJcjDfhClehZCwckHgJpMtu4GiKAkLuSZs46sb5w/4fnXM3NVgbyiGdAo41sErd6N/Dl
         5tWg==
X-Gm-Message-State: AA+aEWadGsjZTlqyajMAJzf5rComSPc3oqUdh4qDEN+WWu/oSsPo0Txk
        +GOiBOA5nt7iQW7u3VTcjUKo4HXFpHo=
X-Google-Smtp-Source: AFSGD/WGIGieVfZE5xNORZSvLF8dToGJc/NMP0E5umLzjMf1ul0YiqcWu9+lTb/GqkcNBTs6O10RpQ==
X-Received: by 2002:a63:5b48:: with SMTP id l8mr22369832pgm.80.1544053180626;
        Wed, 05 Dec 2018 15:39:40 -0800 (PST)
Received: from vader ([2601:602:8b00:55d3:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id c13sm29502033pfo.121.2018.12.05.15.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 15:39:40 -0800 (PST)
Date:   Wed, 5 Dec 2018 15:39:38 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block/025: test discard sector alignement and sector
 size overflow
Message-ID: <20181205233938.GE11220@vader>
References: <20181115040017.4920-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115040017.4920-1-ming.lei@redhat.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 15, 2018 at 12:00:17PM +0800, Ming Lei wrote:
> This test covers the following two issues:
> 
> 1) discard sector need to be aligned with logical block size
> 
> 2) make sure 'sector_t' instead of 'unsigned int' is used when comparing
> with discard sector size
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  tests/block/025     | 37 +++++++++++++++++++++++++++++++++++++
>  tests/block/025.out |  2 ++
>  2 files changed, 39 insertions(+)
>  create mode 100755 tests/block/025
>  create mode 100644 tests/block/025.out

Applied, thanks Ming.
