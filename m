Return-Path: <SRS0=r6We=DC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2CCC4363D
	for <linux-block@archiver.kernel.org>; Fri, 25 Sep 2020 17:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B81B21D7A
	for <linux-block@archiver.kernel.org>; Fri, 25 Sep 2020 17:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="kxdUTQL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbgIYRcl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Sep 2020 13:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbgIYRcl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Sep 2020 13:32:41 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D738C0613CE
        for <linux-block@vger.kernel.org>; Fri, 25 Sep 2020 10:32:41 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id l126so3840507pfd.5
        for <linux-block@vger.kernel.org>; Fri, 25 Sep 2020 10:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7JdZOwNajZADBhYXXebotkbVCE8Ql50yJYKIetU2JdY=;
        b=kxdUTQL9oNaNJ2afy7XPuZXlK0JNgyl3hxKSlwh9zImhE5Phr44nqY7Yr0+xQ46mLM
         DJ+YelM5S2ikDFYWEsFPmvGjdjAPCfY1eBbnZnf2U0mBptNRl63eRhtj3Xm9oe6Ry9LY
         ZmTtf6vBdxCC1p4agjkggjqc3W6pY4C1kl1VZibBuAhHRQw9xT5Zl+4HdQnM0zLYREhG
         UMfzZWQ+KlxwwlCLDgd68I+m8MSDIkR1fHvRlR8dON9T19Toe277PpKfqjIuklbk8M9x
         lkxTz5L8ImPi9/g6s+Xl01CrOn54u8h5XUBgcrwwPS2KJAY/UyUFSo+GJ6DN/rvSJvVc
         tgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7JdZOwNajZADBhYXXebotkbVCE8Ql50yJYKIetU2JdY=;
        b=uaZoFz2l5MYEQfAeKYNm2Q6wKaW5WuRyddyjDLEJ5WihWnACC7xj2xkqWaeJXl4bzQ
         tFVHGzoZATqmxBB94JjpI+8utaPEDqDrZ3ciP9DFcTwcBRYVieRhEJtmLzrCN8O8aj0Y
         K+DJ+O/QszvI6ln2JTa8XtsyAmE7hzuaYxPX0PVlzarV9pUoi50kzUl2bnN63f7/bOCQ
         FZQXclMl1AvSeF8V7/jFM6obEUXgNtb/kZyDkdBPnbhCgxMngWjCI54dFGr9zW1AdPDb
         JthjvzY1bFv9aLclFInIRU88qsOohEYdAkqGmgsvjE8IuSvPHYw2hKRCIxnW3t/zIgB6
         k0Eg==
X-Gm-Message-State: AOAM5338C4t3SmYMqhNDvJXjpYDJzHyzyNlVOBbvF5akh8aIQE9Vmc2Z
        VdPuWXBS22gcxh9yRhs8XQ+0DC2LnEX3PQ==
X-Google-Smtp-Source: ABdhPJzR7YQNVEEAc2HT8n4yCPTCkr4G67Y6chFZL1QNvJurmre0xRXB1OWT1h56sR2amsyG+tVM2g==
X-Received: by 2002:a63:2443:: with SMTP id k64mr23171pgk.259.1601055160821;
        Fri, 25 Sep 2020 10:32:40 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:77e2])
        by smtp.gmail.com with ESMTPSA id g21sm3390931pfh.30.2020.09.25.10.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 10:32:39 -0700 (PDT)
Date:   Fri, 25 Sep 2020 10:32:37 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 0/7] blktests: Add support to run nvme tests with
 tcp/rdma transports
Message-ID: <20200925173237.GA689191@relinquished.localdomain>
References: <20200903235337.527880-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903235337.527880-1-sagi@grimberg.me>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 03, 2020 at 04:53:30PM -0700, Sagi Grimberg wrote:
> We have a collection of nvme tests, but all run with nvme-loop. This
> is the easiest to run on a standalone machine. However its very much possible
> to run nvme-tcp and nvme-rdma using a loopback network. Add capability to run
> tests with a new environment variable to set the transport type $nvme_trtype.
> 
> $ nvme_trtype=[loop|tcp|rdma] ./check nvme
> 
> This buys us some nice coverage on some more transport types. We also add
> some transport type specific helpers to mark tests that are relevant only
> for a single transport.

Applied, thanks Sagi.
