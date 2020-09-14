Return-Path: <SRS0=j3P0=CX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BC3C43461
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 22:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DAA421BE5
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 22:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="Ayatqx5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgINWZ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Sep 2020 18:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgINWZ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Sep 2020 18:25:26 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268E4C06174A
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2020 15:25:26 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id o68so762382pfg.2
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2020 15:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M5wCt+OTi//+UZPp9lZ8x8LVzh9kAqqfuVLoBP95ssI=;
        b=Ayatqx5Icdv+ngirXvBkjllsk0TymRJmCqS9POPC53lvVQhrS5rW8CCHiktSpIdB+a
         7i9fQEod319jFREivSoV19vw0dVcrFa3uQjV+omBpdFBPCe4Iu9mOS/o8GBJjfK3iq46
         IOcPTUC//gqrCDAatB40TBK76dRxxqgXfkN+g4PlAbAGebxeS/9eY15cm8l+wfxjcx2i
         uqrXsUcgA2Oe4oFnDfjzT64BmVyv7yfep5/7KidEt4o4AW5tMnzm3h772Z/9fWYZ7TgC
         ab+Wy8L4SSXgLuSN78p6uVHAlsoLktgdHU9mBm7blpS/EpgpeYNLF+aBGedp4vlmUz4W
         kWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M5wCt+OTi//+UZPp9lZ8x8LVzh9kAqqfuVLoBP95ssI=;
        b=LlrnOBJIUVw4GHaJDBbTUCFtjkreVgDpBA/nZly/zzzrIggA9/wTCvPPOQDJxuwwCI
         5TiOnY+RHFx9znExkKO6MA9K0lmaVYoSVVxErzPd2vBTNCynr2+GFmQMJRrakJ9RL8TQ
         j38TdjDxE1f+Jbe0GLgCE8KSoqu6/hB+9bMriyAZAqQHCkHlRZrnozc7F8V8cwl5++2s
         I6E6oxAiXSbJgMyolNUnUwSGT6KFbHCZ0xO0StDkNf3Axd/lDb0YJ0TYWGtC0X/2o31i
         W8ea4QbbGzMtCpqXNOiVcHYETelqCaKUbM9x+Gh0UGQ/eVvGc7GnJ2CouJ0ySg9LVCyV
         eQ7Q==
X-Gm-Message-State: AOAM533i1EecgXts2Dkhw9+KDnIk3Rr1lRN5DgJggITReIghDE515LnD
        4v51vsupVZh/qL5D3xfSt+wNcA==
X-Google-Smtp-Source: ABdhPJxpCUBJQSOBCgvrIM+eniOd9SoxU5v/FHgayO67f4pbpUJzSw78y+czPTHbuP0zioBtVGjTqA==
X-Received: by 2002:a62:1b86:0:b029:13e:d13d:a05b with SMTP id b128-20020a621b860000b029013ed13da05bmr14835611pfb.33.1600122325527;
        Mon, 14 Sep 2020 15:25:25 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:1687])
        by smtp.gmail.com with ESMTPSA id d128sm5157784pfc.8.2020.09.14.15.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 15:25:24 -0700 (PDT)
Date:   Mon, 14 Sep 2020 15:25:23 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 1/7] nvme: consolidate nvme requirements based on
 transport type
Message-ID: <20200914222523.GE148663@relinquished.localdomain>
References: <20200903235337.527880-1-sagi@grimberg.me>
 <20200903235337.527880-2-sagi@grimberg.me>
 <20200914215145.GA148663@relinquished.localdomain>
 <1c502865-5ac1-9952-1b79-fef0f61749c6@deltatee.com>
 <20200914220951.GD148663@relinquished.localdomain>
 <92478e6f-622a-a1ae-6189-4009f9a307bc@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92478e6f-622a-a1ae-6189-4009f9a307bc@deltatee.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 14, 2020 at 04:23:32PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2020-09-14 4:09 p.m., Omar Sandoval wrote:
> >> I noticed this too during my review, but based on my read of the current
> >> blktest code, the return value of the requires() function is not
> >> actually used. It seems to only check if SKIP_REASON is set.
> >>
> >> If we want to ensure the return value of requires() is correct, perhaps
> >> we should check it after we call it and then consult SKIP_REASON? And
> >> WARN or fail if SKIP_REASON is set when requires() didn't return 1.
> 
> > Oops, you're right, I actually changed this a few months ago in
> > 4824ac3f5c4a ("Skip tests based on SKIP_REASON, not return value").
> > Totally forgot about that :) IMO it's still cleaner to chain them
> > together.
> 
> In my opinion, this creates a bit of confusion when reading the code.
> The &&s make it look like the return value is important when, in fact,
> it is not.
> 
> It is also easy to make the assumption that adding any bash command to
> the && list will skip the test -- however that is not the case and
> people may introduce subtle bugs that look correct, but go unnoticed.
> 
> Logan

Fair enough. Sagi, don't worry about changing this, I'll queue this up
once I try it out.
