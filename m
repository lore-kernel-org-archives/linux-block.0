Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62654C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2500C2089D
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="vjXvNkkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2500C2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeKPSxq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:53:46 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37766 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeKPSxq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 13:53:46 -0500
Received: by mail-pg1-f196.google.com with SMTP id 80so10306308pge.4
        for <linux-block@vger.kernel.org>; Fri, 16 Nov 2018 00:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SznEsT1jYqx5lDvR/269hfvn/vPewld1f2cMxpe7y0g=;
        b=vjXvNkkx/0xBJBpEPNEVICFQOWECzyU8cc1VvkekNesBylbQaQ8ukVRwkWdAfi5zmN
         Brd6YqwFW27ZJixI2aL8LKtyLgxkJrHg2Fndy6mxtZGaO+WuDOWPWwoA4FWPwDv2s6Ee
         KH7GaX82pHB+YvGgilNgwxjLDwtvbNRvtY0Ac5p2yUtSg2kdfeVj2flpUrroDOjO5vzP
         pKoUxukBSgrRouEyid7+vz5vu0R7cZgfQ58TFT2gepPWktV1fmFaLqrVXgQX7LTRV2OY
         WQ7+GLt/2r/DewLAQSSExUld2kkU4t+ONrWrlCVKtrbKpDpRC1t5DLsPcdfWn7/qWT/P
         sObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SznEsT1jYqx5lDvR/269hfvn/vPewld1f2cMxpe7y0g=;
        b=kL1WfZgOLYumjhKfCSuQ6hcHcnSYg+zrDF4hYs6RZS1Bj+Cj4p7WHFi69PWrPGHunw
         e9Rlqm0XcRDIKpad49e0UlbSoAPzS2echNV0Yw0Y5JA6RXVnt+Pg/eRs2yRDXkBpQfIk
         mZF0GzGi3mTaXGpHE3Qa57RmTkGAvDtZ6SHBg+ZLFMJsqAH2Qin5dy/r9by0vwm+tRyn
         1hF+sWc6FcQAOALYDaeFavGK/OG5hMaN8GFTu19WmZhNllAmSH5ow9AealIY1Sqz03VS
         1T606UaLW0y/ANAKwjxi29nOlt0dXbKoqdCaCDhftAVxAohnAWhMCVEnwLywpuWbwHwo
         xnHw==
X-Gm-Message-State: AGRZ1gI88y4f1kQ6GrnJtQsplDuHiwcjhdJJjLwM9jco+tAQzbbl6i7i
        etCSEZfNnqAemcCvDp+hZCYYxw==
X-Google-Smtp-Source: AJdET5dkNiU54kIZHC5HHC+x4BvGf/U0iw/MB3wIVjEX3pdrgDKPoBcIiqTX8pmU6v+iD9B1OczbAw==
X-Received: by 2002:a63:181c:: with SMTP id y28mr8838763pgl.75.1542357744347;
        Fri, 16 Nov 2018 00:42:24 -0800 (PST)
Received: from vader ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id m3sm51768487pgl.69.2018.11.16.00.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 00:42:23 -0800 (PST)
Date:   Fri, 16 Nov 2018 00:42:22 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        linux-block@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 5/6] ide: don't acquire queue_lock in ide_complete_pm_rq
Message-ID: <20181116084222.GS23828@vader>
References: <20181116081006.5083-1-hch@lst.de>
 <20181116081006.5083-6-hch@lst.de>
 <20181116083732.GR23828@vader>
 <20181116084004.GA15331@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116084004.GA15331@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 16, 2018 at 09:40:04AM +0100, Christoph Hellwig wrote:
> On Fri, Nov 16, 2018 at 12:37:32AM -0800, Omar Sandoval wrote:
> > On Fri, Nov 16, 2018 at 09:10:05AM +0100, Christoph Hellwig wrote:
> > > blk_mq_stop_hw_queues doesn't need any locking, and the ide
> > > dev_flags field isn't protected by it either.
> > 
> > Is it a bug that dev_flags is no longer protected by queue_lock after
> > the mq conversion?
> 
> Most if not all users weren't under queue_lock before.  As far as I can
> tell it generally is set in the probe path, and without any obvious
> locking.

Good enough for me, you can add

Reviewed-by: Omar Sandoval <osandov@fb.com>
