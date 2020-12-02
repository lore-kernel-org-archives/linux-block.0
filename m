Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C46C64E7C
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 19:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 241152224B
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 19:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgLBT5y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 14:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbgLBT5y (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 14:57:54 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA684C0613CF;
        Wed,  2 Dec 2020 11:57:12 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id z188so2475374qke.9;
        Wed, 02 Dec 2020 11:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u6s/okbvK6jJk9cmcgsi9vG5/CPHK1WemBjjVyLml1M=;
        b=GSOtXjrOfrvRUcd8lhvAkaBmQH/5hk4Xnjvbyd/vhvjxPztGCs1v353mo5bO21+4nB
         ZWRakJscF/4drIOspJWqzAFSlfhibAtDgZpC8KJGmxJN+7un8QJJD7XeFCmbVLeybbg/
         e5EEh0k2Pj/6w6S7Lg+OFrXD4PLUz9YAsCZS4ZD1k8a7v0QWbK/MsBVJu5fRDD2FCYVU
         h4CjqLz9l8k1x6iXyGQHh3KnBd0d2ZyGS2ZD+wmfFB0KGjvSQM7MCO86nMRlOo2HfR3W
         SCGnYPn6gtgBI6IS2uNyOhc7vUybE/R2Hd74lnDFhRHUmVTO93lWiCJYtv5LK2fbwXUS
         m2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=u6s/okbvK6jJk9cmcgsi9vG5/CPHK1WemBjjVyLml1M=;
        b=o+N+Y0G1EuB7z+KD8eg1boiIiUnhIxWybnPOOC3fpCYGXhUe6g+xBb4XPrzFwWsioo
         2NbOBeN3fMZOMp1lGJPL4TCG71ZBTNAe6qJvyGuJYWpZAeYB6cbOPbvKFaOz/vEd91Jh
         +cFqYKb/gQWBycJGfrczUscK9ad5r1yizPrBsw014TTBBoPudiaBBwmGitzUmtepLf2u
         FciZG7n7s3xOTb81YIMjbwwvMAmT7L255JVsXiH0vmPSxMCGBlSbrP5JTBFPA+LzGad3
         q+EfxsOBITNtRx5LO2hpD2cpQo75X8yRcxq06IDxy7FaTz1JgXfosxcll57HKo2T5XaY
         F9EQ==
X-Gm-Message-State: AOAM531Pbfp8qmzAJhZ5PxMsM+W+dDsxpkVev/aNoVFmYG9zfOEo5FcN
        5yNsmVMkLCOmmZPcUJESST8=
X-Google-Smtp-Source: ABdhPJz9hgaOkdMqJJDrljz8z11Q5tZ/HrlwWf9wO39mbdlci2QHGSiUhi5iMiBrZOwx/EgDkJgKbg==
X-Received: by 2002:a05:620a:15ce:: with SMTP id o14mr4399107qkm.231.1606939031780;
        Wed, 02 Dec 2020 11:57:11 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:8dbd])
        by smtp.gmail.com with ESMTPSA id j13sm2938619qki.5.2020.12.02.11.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:57:10 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 2 Dec 2020 14:56:43 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] blk-iocost: Move the usage ratio calculation to
 the correct place
Message-ID: <X8fxexrw/QLoqq7I@mtj.duckdns.org>
References: <cover.1606378475.git.baolin.wang@linux.alibaba.com>
 <a4e6af93419250de5372ff681d3395cf36676037.1606378475.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4e6af93419250de5372ff681d3395cf36676037.1606378475.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 26, 2020 at 04:16:13PM +0800, Baolin Wang wrote:
> We only use the hweight based usage ratio to calculate the new
> hweight_inuse of the iocg to decide if this iocg can donate some
> surplus vtime.
> 
> Thus move the usage ratio calculation to the correct place to
> avoid unnecessary calculation for some vtime shortage iocgs.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
