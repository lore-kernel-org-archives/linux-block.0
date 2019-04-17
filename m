Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5EEC282DA
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 21:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CA32186A
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 21:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="H979Z0A0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfDQVkZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:40:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44127 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQVkZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Apr 2019 17:40:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id y13so64115pfm.11
        for <linux-block@vger.kernel.org>; Wed, 17 Apr 2019 14:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wDaJRhkBAXEhybk4i42gb/avmEZoj5yUWgW0zAY3o1A=;
        b=H979Z0A07HUx/VAlZJ7jiiO7iOsDWml2EPLjeyPaSD03ZPIppPub0PCAbJPOcFfW6N
         F/5EZ5nGXpKns8qsctQrSbgGfeEUjxIHQNeRriTD1r57VkkZIH2U+cFESHF690zCyhzQ
         GzIuCJ6B69YgYtz9Y+kcCdte8oJ6YbSDRUEvZxPSIBCaoGif+P+QOI326JbZr+27utJu
         F64PBABtfGmYeM1ML7wYki5oqwX0jpXef89RgaG3nAdQrENo1fewKl5o/VPArapRnSuE
         n+dogkbhKz1maxpn12x8jIjCf7Jnn/rd55UHZ9SaNtdb7bZacQHbOMLhVkO69eJ5Pi+x
         U+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wDaJRhkBAXEhybk4i42gb/avmEZoj5yUWgW0zAY3o1A=;
        b=TolUMRemuGErvpqqm2MtHmJiny2GErdlpdc73bmR/uqIP0gDdUyXdrsB9uEyPCdjgI
         aLmDTu3uJ94jbYGiprdJ9yMyaEspzoCobfamX5xoTSqZBJEAeCH3yKiItbIpxmIZfV6N
         8rD4mdylkWPj5B++//+vC0oKqySjFdXxLKm+4fpsBsdX/yY6tXorYgnbaxix4UTk1mqu
         sUblAvu15Px/1WKbRMiQwBAeYER57mrRpw+RBUCT0ju6NTGvMuwZksqAcLz6jg7Gq6R5
         /QeSTexCH3NEwYJYHJaORf7jPkWy461kOkozyMfLpTLlQnR8aBi8zj91tizDRK3C4rrd
         wXzw==
X-Gm-Message-State: APjAAAUh0nQ37M+5BqY+PoUgrmvm9a3wutXWNmGKqt8ntpLZDanJTBFv
        5EqzTnDvr2tntk6FY5VzJaGngw==
X-Google-Smtp-Source: APXvYqx25BpsEVB4RHJWZ38KLKauivVg0qFA/vbZjXDVfprdxIMCV+gUj0/nB4sS90JuZbiN7Zo5SQ==
X-Received: by 2002:aa7:8494:: with SMTP id u20mr64421720pfn.76.1555537224315;
        Wed, 17 Apr 2019 14:40:24 -0700 (PDT)
Received: from vader ([2620:10d:c090:180::8abe])
        by smtp.gmail.com with ESMTPSA id i129sm164974pfc.163.2019.04.17.14.40.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 14:40:23 -0700 (PDT)
Date:   Wed, 17 Apr 2019 14:40:23 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH] nvme/012 & 013: avoid extremely slow xfs IO
Message-ID: <20190417214023.GA18727@vader>
References: <20190415012229.20689-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415012229.20689-1-ming.lei@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 15, 2019 at 09:22:29AM +0800, Ming Lei wrote:
> It is observed that nvme/012 may take ~17 minutes to complete on aarch64,
> even worse it may trigger IO timeout on nvme-loop.
> 
> Eric and Dave replied that it is because of too small log size on small
> disk.
> 
> So pass '-l size=32m' to avoid the issue.
> 
> With this patch, nvme/012 can be completed in one minute.

Nice:

nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  402.605s  ...  27.431s

Thanks, Ming, applied.
