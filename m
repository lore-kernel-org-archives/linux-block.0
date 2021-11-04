Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8739CC433EF
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 00:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 647D5611CB
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 00:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhKDAP0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Nov 2021 20:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhKDAPZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Nov 2021 20:15:25 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB228C061714
        for <linux-block@vger.kernel.org>; Wed,  3 Nov 2021 17:12:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 127so4084796pfu.1
        for <linux-block@vger.kernel.org>; Wed, 03 Nov 2021 17:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aiFlDDoPphFdax8t3+vgi2ejhvKpRDh7/No/Q/VIr2I=;
        b=BAEynWMdMRlkSSJY0srpBlBYJednmmqF1G63NosmIWMc0Q+4AJMFCNhqfAA76CdAnd
         CcNTmdL8gzyOISWADvYFLtFUQ0nGsMVl2CLvzGTVmznszFkr5aNbQy/B8JBL58X3OprP
         WxabcSYcDyX1quSThfoypWjtfjH5u0Eswijcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aiFlDDoPphFdax8t3+vgi2ejhvKpRDh7/No/Q/VIr2I=;
        b=GixIXpK4zLi5JjqsED1y76YVlM5fdwCxJDnc6mDN9+b9HbqFs5/3t5w9UXc9J7pNk3
         Jtl0AK3jWaX841yHL/jKzIBF5FDY6VJtAH6Nf1b5Cl5wUgzh1EsyeOMREmIw5FeJbdN6
         0dqlmez9grnXmXRzkwJc/N3AFXwiov6PUU8Icr8sJFXrzGdmBp0UkrfOIPz6LTSzPDqI
         +5dYqmVXLUfssFnktbuvX5Rv8Ykkx6qidrIhFsObuJKVTBuJ665oKDyPAXpHHkgl1SKM
         J5qfrQD3Q7Gntk87h3qftv8i64EyTv/dyb8X4F+R/knD1rxn7SaBqNUM5KSsOs7keuR+
         Ft8Q==
X-Gm-Message-State: AOAM531pqNsBazkGUYDAtOtdI7fRfynW5X3G2obI7SCPOj5a5rIov6aT
        jktyf9cTpoaA8HppTYQ8CBTvwAeBLDpnIQ==
X-Google-Smtp-Source: ABdhPJzBJoVbv76VuMfMN12dqt6obL+TqZohnLnrn1g1oB1WAOtxkRDgcTnQgY3Mdh8HUJU/6MlJ9A==
X-Received: by 2002:a63:8bc3:: with SMTP id j186mr23601334pge.250.1635984768491;
        Wed, 03 Nov 2021 17:12:48 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:1f56:281c:d78b:3f3a])
        by smtp.gmail.com with ESMTPSA id f11sm3831765pfc.116.2021.11.03.17.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 17:12:48 -0700 (PDT)
Date:   Thu, 4 Nov 2021 09:12:43 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: use ATTRIBUTE_GROUPS
Message-ID: <YYMle7jh+i5j+b5q@google.com>
References: <20211028203600.2157356-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028203600.2157356-1-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (21/10/28 13:36), Luis Chamberlain wrote:
> Embrace ATTRIBUTE_GROUPS to avoid boiler plate code.
> This should not introduce any functional changes.
> 

Cc-ing Andrew  (20211028203600.2157356-1-mcgrof@kernel.org)

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
