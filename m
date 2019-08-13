Return-Path: <SRS0=l92v=WJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6612AC32750
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 13:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA772067D
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 13:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="uQsdf2Cn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbfHMNLJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:11:09 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37628 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbfHMNLJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Aug 2019 09:11:09 -0400
Received: by mail-qt1-f194.google.com with SMTP id y26so106259006qto.4
        for <linux-block@vger.kernel.org>; Tue, 13 Aug 2019 06:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yh1cBCnGWHW42bcZi59aCRRuKFxMuylyUVUfd/jEGFo=;
        b=uQsdf2CnkKD+6y4WU6oXEDlY4s4fWjbFuCyWXiV8HMTze4+iTL/y2iSmHN9bFtSSGR
         0ouqxgDPSLj9UTctFirJ2DA4L16ydirnZZBHRd7yz2AjQ9WFx50IWreCvCQCaLGbP1up
         6HHtgNvEH2qDHDd7EJg2U02atLEMY5FxqA6WzKCAdeZBnHVShjXvy6sAiIPBI3xaczTj
         d+/XiwUHHjMzywnsfBJq1GGUpQn5xvyuQ6AMUENrvvzNZpBNDTtbR/CnZzmcfCGZ01Wm
         m2IJWIdIS+6982bXR1fSryT55tJnBjXsjmHXBDoqt4iDU2oPC7mnB5aGx+CXYEw4x5Bh
         URaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yh1cBCnGWHW42bcZi59aCRRuKFxMuylyUVUfd/jEGFo=;
        b=p3TVVAhOzxWEURB/XXkxVLlMBnqNNqhh5eT1/+dqsVWlRLfIWywKyps9RnLpd9VaxC
         exvjcSs63mrINj1NUvXnLaRAU0BFu52OwOZxNtrPtwsRjSWMrpbHwLvXwGnyTxZ2OulS
         RnDDTPmskFnkF+qTkQiVHnwq2uBE12rT1MKTOM/ll71VDddhPnSJuKJ2LKcl3on7laUd
         2JPRE++rI51MdTGLIdGu8Zo7eVHUrpzVn/SadwwaP2OXQryhcOkjg6mpeP+Jkk5v6e9S
         hJxQDpcuNOGgkWGrVvHIbq6eBPSEVBIB/JSnLZ4twBqt6dUTfWpUT795RjdirNfEyTJD
         3ibg==
X-Gm-Message-State: APjAAAVQhvGXyA5GQbJQqM2iSDe3UIEs170KC8bxpA2f3O3g/XyLT5ZQ
        x4oJcbncljnye52fA7YQsHl/qA==
X-Google-Smtp-Source: APXvYqz6qNCtsgNIhevjGm5klAf5x5iFiCJkOZFDRyh1Ns5dWJhhzxlN1Ghn1OEQNyGulzE/U/YBIw==
X-Received: by 2002:a0c:b0ef:: with SMTP id p44mr33453247qvc.27.1565701868265;
        Tue, 13 Aug 2019 06:11:08 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z186sm8277443qkb.2.2019.08.13.06.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 06:11:07 -0700 (PDT)
Date:   Tue, 13 Aug 2019 09:11:06 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Mike Christie <mchristi@redhat.com>
Cc:     josef@toxicpanda.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/4] nbd: add set cmd timeout helper
Message-ID: <20190813131105.nmesmsdjhda3ehyd@MacBook-Pro-91.local>
References: <20190809212610.19412-1-mchristi@redhat.com>
 <20190809212610.19412-2-mchristi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809212610.19412-2-mchristi@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 09, 2019 at 04:26:07PM -0500, Mike Christie wrote:
> Add a helper to set the cmd timeout. It does not really do a lot now,
> but will be more useful in the next patches.
> 
> Signed-off-by: Mike Christie <mchristi@redhat.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
