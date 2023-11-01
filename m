Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E39C4332F
	for <linux-block@archiver.kernel.org>; Wed,  1 Nov 2023 18:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjKAS26 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Nov 2023 14:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbjKAS24 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Nov 2023 14:28:56 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BED2102
        for <linux-block@vger.kernel.org>; Wed,  1 Nov 2023 11:28:11 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-66d0ea3e5b8so925496d6.0
        for <linux-block@vger.kernel.org>; Wed, 01 Nov 2023 11:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698863290; x=1699468090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbraHScpAjzoS0M8nDOOEKlaOP4qg6lROvG1DxdhQQU=;
        b=rTLPltALxuBeyPRcNVAWWOkYjq8FdiL4OzPjIsjNuQlpvzMVk8z5wyWmbYPeydgzmK
         ExIzaPdv0pm5MMAT2X27ekWJfeDIia8zDAtSn/ip7r0jAsiMxIPfZBpS5evTxVawBEeu
         MoH0N3Tg3ycg/zrXBpT0WphgEzmm2pNjWAv7N4N0vOrUmGXlhqeUZSCw3QG/ZvcRHqfp
         gp2igPKcFBTikyWGht/mmWbyRYTIh7XGzadRO4Cu/wPApH9T0zfzkh4g/cpC/i9iYHq5
         7V7rW772wJL6mTkeTSyLhy6h9wZL9bRUf2BwfUqHk3swYeMUjfpqMYC78m2ML8oP7lo4
         oNjg==
X-Gm-Message-State: AOJu0YyBk3aNYGkiPblwpv1UOflLt5Mbh2cnch2JGtAqB/Kd96FMX/O0
        U6ZzIOD7UUvNLUHmz2dsWaGB
X-Google-Smtp-Source: AGHT+IFuYhqolGh05xqnNdfZAmwuJH7T5XnlR7OKwXvDKM+T8xuftXsfTTR03//wtu+lZk4QjEuEJw==
X-Received: by 2002:a05:6214:dc7:b0:66d:2ae0:44cc with SMTP id 7-20020a0562140dc700b0066d2ae044ccmr24754552qvt.21.1698863290336;
        Wed, 01 Nov 2023 11:28:10 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id c5-20020a05620a134500b0076f1d8b1c2dsm1663939qkl.12.2023.11.01.11.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 11:28:09 -0700 (PDT)
Date:   Wed, 1 Nov 2023 14:28:08 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Matthew Sakai <msakai@redhat.com>
Cc:     dm-devel@lists.linux.dev, linux-block@vger.kernel.org
Subject: Re: [PATCH v4 00/39] dm vdo: add the dm-vdo deduplication and
 compression DM target
Message-ID: <ZUKYuHcLu3syvvYG@redhat.com>
References: <20231026214136.1067410-1-msakai@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026214136.1067410-1-msakai@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 26 2023 at  5:40P -0400,
Matthew Sakai <msakai@redhat.com> wrote:

> The dm-vdo target provides inline deduplication, compression, zero-block
> elimination, and thin provisioning. A dm-vdo target can be backed by up to
> 256TB of storage, and can present a logical size of up to 4PB. This target
> was originally developed at Permabit Technology Corp. starting in 2009. It
> was first released in 2013 and has been used in production environments
> ever since. It was made open-source in 2017 after Permabit was acquired by
> Red Hat.
> 
> Because deduplication rates fall drastically as the block size increases, a
> vdo target has a maximum block size of 4KB. However, it can achieve
> deduplication rates of 254:1, i.e. up to 254 copies of a given 4KB block
> can reference a single 4KB of actual storage. It can achieve compression
> rates of 14:1. All zero blocks consume no storage at all.
> 
> https://github.com/dm-vdo/dm-linux contains the most recent dm-vdo updates.

I've rebased linux-dm.git's dm-vdo branch to reflect this v4 baseline
(rebased on dm-6.7).

And the dm-vdo-wip branch was rebased accordingly ontop of the dm-vdo
branch.

Mike
