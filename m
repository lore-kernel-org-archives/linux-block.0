Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34C0C07E9D
	for <linux-block@archiver.kernel.org>; Tue, 27 Sep 2022 17:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbiI0RsG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Sep 2022 13:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiI0Rrp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2022 13:47:45 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94B17C74E
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 10:44:42 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id v10-20020a17090a634a00b00205e48cf845so1048543pjs.4
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 10:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=fO6VbT9u5yxNWbC9F+jffZYe3aDhWXCo2ocA7Qq2Gpc=;
        b=Mk5ffh7dj/yLHfoJt/+EF5kvYgDv6mZBskMhI7lag50pKxBk+CrK3z8nTS4OJe0mdM
         q21cVp+ZFOKzxq21cPgC55vVV8ThS2ay2wxz9e3PmlnLD9jk7+5jEPPglHvN8E+4BEjF
         qar26cwhQ6/QTw8NG90od45ouMvhK031x97vRnTne67lPRs5uGUkEsn8YZ7rEM5KlJAC
         eOkL0+CofOaQH7XldXeHyjG6YYTAUiZOnVhzIoyW0ivzkPlvZbe0X3nP6ndGuI6hHJws
         5qYzPc6PvRMsAY3kxFcE+CYdbx+4rE64CabtNkInJGWFTdNTJTjS7ZKUMvXtMEAktF9Y
         h+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fO6VbT9u5yxNWbC9F+jffZYe3aDhWXCo2ocA7Qq2Gpc=;
        b=U5w4gbLD8G0CYUWjf4b7250wXZW4fQ0WFzpY7R0fXJ93St7t276Vxuhp5ucLBi3awM
         pyTeYDLLZ/4Im9yhXHOX+yxQ1MvqrkaXZbZj4tSM2vAWVUdEpCP3yL2hmwNyfW4l+qMk
         LudFD7d9IRhXLzm5/DbYnrLuLgubSkOGqGWj2nV2NrlculrCMKC7DL2olMGclVsKhGf2
         7LDMeBCos75ypYGIguzX/oIOmljLal6MZ6kWjsbj+MvPr0ptwydzYUskoo9C+H/ewNqP
         UKKONS0UpdTDDP8B/LIBS68kYf55HmJ2LzhnHbZPfAJbbGVCgUbsMlgRPLUBUqlcw/GB
         Bd0A==
X-Gm-Message-State: ACrzQf3wcwWTLtGzfoXZ8lCCw7UFBapQ4sEzycgFNqoTD4mTJ3YrD1ng
        z+gsAtU1EkfLRA/eKIwwju0=
X-Google-Smtp-Source: AMsMyM6HM7T7hRErSa7Ye7fQc11bsYxYR0w8YLX36zoqM7YK8INQxEE9WscyeLXDAAflJ9HZI+hz3Q==
X-Received: by 2002:a17:90a:cc04:b0:200:b869:5ba4 with SMTP id b4-20020a17090acc0400b00200b8695ba4mr5884524pju.234.1664300643730;
        Tue, 27 Sep 2022 10:44:03 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id w16-20020a63d750000000b00439dfe09770sm1778707pgi.12.2022.09.27.10.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 10:44:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 27 Sep 2022 07:44:01 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-cgroup: don't update the blkg lookup hint in
 blkg_conf_prep
Message-ID: <YzM2YQ6IVIQEyl+U@slm.duckdns.org>
References: <20220927065425.257876-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927065425.257876-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 27, 2022 at 08:54:25AM +0200, Christoph Hellwig wrote:
> blkg_conf_prep just creates a new blkg structure, there is no real
> need to update the lookup hint which should only be done on a
> successful lookup in the I/O path.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
