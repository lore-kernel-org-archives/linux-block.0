Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB9AC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 18:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628552184A
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 18:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="uZ8GRGUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfB0SuQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 13:50:16 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35022 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfB0SuQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 13:50:16 -0500
Received: by mail-pf1-f196.google.com with SMTP id j5so8439124pfa.2
        for <linux-block@vger.kernel.org>; Wed, 27 Feb 2019 10:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r7OH1WE1wo+9xb7nFU6vgw+DJyXdDWLgTpZDixCSWFI=;
        b=uZ8GRGUiQn12TeaD8SQYvtRXBrIdyqwxARxO7fA535U6E4BN/16Cng9cydOyiIY7HH
         jjBXSbO/m1b+H/wiVQ8y4+Zpg3aaV07ACv0IIg8tWHUWBMR0Rkj2pGP01/h/yeW4vDkE
         qLzJMjA+jl1qU5kRw5SqDibao+dXwwn5NUgdeH7bjHILVzOxpFlg4iNfOIIcwWQpfdmu
         eddQ9GXOOxJCOFIzd2Mfm3sMBLj3XqH1paD06fI0mpU6P4erm5Bxi3qOk7djix/kA4Q3
         CxTUPXh/wrmloUEEzrbAF+6Lmaa2v1GNSUgVtj8UZZcngEfalo900BekLLryoZ8mWzUf
         ctkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r7OH1WE1wo+9xb7nFU6vgw+DJyXdDWLgTpZDixCSWFI=;
        b=O1zZg8kUb5BKfvgd40mckLLzaua7pY84IDNW+CUuzcYFBgwSCJx7Ho1KgOYuYMv9JV
         Fm0Aq/YqNGcmmsQl29VWWoixjoSyQ9vNS3MuQ9HSeuUdwND/IfieLAxRituO+5HM5sFy
         +aXLs8GHWKRmqXWzQqZ9R6/vknp1u02sj0MculvQ0X8mK1oeZUfD/UAPRrAAJopreY0q
         8fFoYzQ8gIAOOCLJDvZnDZXuNZJhjaWG30H5NfoOAD3kDzKpRfvGOy7lJSeE7cusTp8c
         3+l6pmGbC9JAu7S2mxwXkfidY3rRe1HrQQgENaksSoUWzF7rF7rHP5Bkybtdn/hUgWpP
         ggpg==
X-Gm-Message-State: AHQUAuZtiTxU9jTSUSkYPYei337G6ZG4qQMcnynitoi3pfJlL62uinwy
        XWQ8iJu/AHB09ie+1Qj3RhK0Fw==
X-Google-Smtp-Source: AHgI3IaAYPZsu5cDk1AijlzreDiN8xpapCSa6R9s5/40q2ohkigH4Vi7NJC7u+A9/wE8ybwYBnPphg==
X-Received: by 2002:a63:e752:: with SMTP id j18mr4288951pgk.313.1551293415502;
        Wed, 27 Feb 2019 10:50:15 -0800 (PST)
Received: from vader ([2601:602:8b00:55d3:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id z6sm22007436pgo.31.2019.02.27.10.50.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 10:50:14 -0800 (PST)
Date:   Wed, 27 Feb 2019 10:50:13 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH V2 0/8] nvme: misc cleanups
Message-ID: <20190227185013.GA11806@vader>
References: <20190221044248.11096-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221044248.11096-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 20, 2019 at 08:42:40PM -0800, Chaitanya Kulkarni wrote:
> Hi Omar,
> This is a small patch series which follows the blktests coding
> style format as pointed out by Bart. Also minimizes the overall
> code for the review.
> 
> -Regards,
> Chaitanya
> 
> Changes since V1:-
> 1. Add testcase specific error message on failure.

I also made these redirect to $FULL instead of /dev/null. The result is
pushed to https://github.com/osandov/blktests/commits/nvme-cleanups,
could you take a quick look?

Also, I assume I can add your signed-off-by to all of these commits?
