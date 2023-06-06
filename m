Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810CAC7EE24
	for <linux-block@archiver.kernel.org>; Tue,  6 Jun 2023 16:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjFFQLx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Jun 2023 12:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237337AbjFFQLv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Jun 2023 12:11:51 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C63E40
        for <linux-block@vger.kernel.org>; Tue,  6 Jun 2023 09:11:03 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-3f9b1f43bd0so8522481cf.0
        for <linux-block@vger.kernel.org>; Tue, 06 Jun 2023 09:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686067862; x=1688659862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c77FQ3Gb2vrcGihgJEF093Ohpu3iXSY3aGqHmmdBFIM=;
        b=KbXO3npZ0zhhA0Mrdm7GqFMpMV5EuliEaZYu3yAacJ46bF5hrYy7iId0ovER78gCGO
         EK8zlCBoaMGiOqPnSpCeorTqrSJLb2gW0K29c9BxKpC07bXaBpFxWHBX3vHn95cMsIKB
         RXxccbXNjLzqmvP2d+GAXFM7plgBOYxf4GtGBFmOmrAGOwdcalmCtROHfl5gUEd1j7Hq
         0seTyNxomp2bEmipnbQ+ngIT+7GgyPkMBAWSn6CIlSfdIPvXZpzgZ55eL/LrG+1TRAJI
         uRGcAjBCgmGQvUjPQ5ltqLF94LhB4uXFY9di1Opg98WgGMdhlB1R2U0iQY8+fElDf40A
         V/SA==
X-Gm-Message-State: AC+VfDwDXPPQAMCjs9VoZTMNljF5cGt3gIg8Cr4DbuPhV+WR6mzRRXo3
        4PIKTvEm8SyqpEUCXcHigj3tu8g2uNJ40ycpTA==
X-Google-Smtp-Source: ACHHUZ5i75dZP6S4D/vN4PsonNhq015+FVRez3l0K1i/H5iefxLOdjHeanpRg/gCpFGqtrMsWtSrvA==
X-Received: by 2002:a05:622a:19a9:b0:3f8:6cf6:a412 with SMTP id u41-20020a05622a19a900b003f86cf6a412mr69476qtc.43.1686067862062;
        Tue, 06 Jun 2023 09:11:02 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id g1-20020ac87d01000000b003f27719c179sm5620008qtb.69.2023.06.06.09.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 09:11:01 -0700 (PDT)
Date:   Tue, 6 Jun 2023 12:11:00 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: enforce read-only state at the block layer
Message-ID: <ZH9alEbuNxHNwYYe@redhat.com>
References: <20230601072829.1258286-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601072829.1258286-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 01 2023 at  3:28P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Hi all,
> 
> I've recently got a report where a file system can write to a read-only
> block device, and while I've not found the root cause yet, it is very
> clear that we should not prevents writes to read-only at all.
> 
> This did in fact get fixed 5 years ago, but Linus reverted it as older
> lvm2 tools relying on this broken behavior.  This series tries to
> restore it, although I'm still worried about thee older lvm2 tools
> to be honest.  Question to the device mapper maintainers:  is the
> any good way to work around that behavior in device mapper if needed
> instead of leaving the core block layer and drivers exposed?

Given the block core change (in patch 3) _and_ old lvm2 code: it'll
obviously fail.

Not sure of a crafty hack to workaround. Hopefully 5 year old lvm2
remains tightly coupled to kernels of the same vintage and we get
lucky moving forward.

So I agree with Linus, worth trying this simple change again and
seeing if there is fallout. Revert/worry about it again as needed.

Mike
