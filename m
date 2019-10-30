Return-Path: <SRS0=yN0i=YX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83739CA9EC5
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 20:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510822080F
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 20:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="bKIVKPmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfJ3UpP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Oct 2019 16:45:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39218 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfJ3UpP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Oct 2019 16:45:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id p12so2284386pgn.6
        for <linux-block@vger.kernel.org>; Wed, 30 Oct 2019 13:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QSev49IyyyqhCaxWg6gIUEtoUNjdkCbrIKmlSFe3ZSE=;
        b=bKIVKPmJClYoFbYjoi6+wNLTgbeJohXFEeChBb9798qjsbTUHH8Jw6xta5YImUhgsX
         l4GO8mxwU7hle/3ViuP1veWRT+cuNOKGUdR/NqLPpQc1mo0d2FHsrhRa/MFBV9Mlqe0H
         opAevbppluRUjcd8S9GVcuYsAUJOSf5MGJqXYeetdfAMggAlg9O8hAxmsdG4f5hAK6Ll
         Lp7ilFZ174fnRo4tQxZGVyFYTbOVkbiaaMgyoDiDos4q2o2hSUo6z1GHk65fra5yLpt0
         dgD8iQkQh6VhddflDHqWbtX31nSJOr6MIn/MtbwxCXFQleVGLy3DWS9Z2BLkpAxjgnu5
         wJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QSev49IyyyqhCaxWg6gIUEtoUNjdkCbrIKmlSFe3ZSE=;
        b=dSUeHP+BYncij0cP/S0dGpnBohwkLVp7KrvH4oJypRrwDVH/2wcea69HE81uUUA/Np
         1NMK/TqZeaM+gkh7Zmyh1NGLAPmAGYfgjbmpmbEKoRxrWlVB/w2QXQbOUfWVouyP2fu2
         ZVEhiWbYsNK2DdHdm6OoTmvZCumBO/p/LnDQelJMxqcKKLgxj3CK42kI+Pv1X4Iod8qE
         Cm3026So3hk6TKxpEZ+uD/EXYXRYCexd5pHNSbIv8Pqdsq7baRg8eH5cqvVUSDaDnfAc
         VNOI83nYdeO+RyCCmPctjGxb7NFE/GUvePBgPx5Iu4sjY3osxzbmMfT2LUb4xWf4xfLz
         ykvg==
X-Gm-Message-State: APjAAAWVjaIyBfR1d3XuqTd1MAEElwwDEdo26RRYi3ZFK1jsTqIwcgnQ
        8E/nEdu4J+Y58PPZw2h1QZ4c4g==
X-Google-Smtp-Source: APXvYqzPH047nQHQW9jDF70+RWhnM81zotTD9CS9g7edHR7AZpvHG5wDbI+h1NE20+sVonPXvagRBA==
X-Received: by 2002:a17:90a:1f4b:: with SMTP id y11mr1458689pjy.123.1572468314663;
        Wed, 30 Oct 2019 13:45:14 -0700 (PDT)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id o123sm836532pfg.161.2019.10.30.13.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 13:45:14 -0700 (PDT)
Date:   Wed, 30 Oct 2019 13:45:15 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH blktests v2 0/2] Add a test that triggers
 blk_mq_update_nr_hw_queues()
Message-ID: <20191030204515.GA326591@vader>
References: <20191024210352.71080-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024210352.71080-1-bvanassche@acm.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 24, 2019 at 02:03:50PM -0700, Bart Van Assche wrote:
> Hi Omar,
> 
> This patch series includes the test that I used to verify my recently posted
> blk_mq_update_nr_hw_queues() patches. Please consider these patches for
> inclusion in the blktests repository.
> 
> Thanks,
> 
> Bart.
> 
> Changes compared to v1:
> - _uptime_s() now uses awk to read /proc/uptime.
> - Removed subshells from tests/block/029.
> - Changed find ... | wc -l into nproc.
> - Skip kernel versions that do not support modifying the null_blk submit_queues
>   attribute.
> 
> Bart Van Assche (2):
>   Move and rename uptime_s()
>   Add a test that triggers blk_mq_update_nr_hw_queues()

Thanks, Bart, applied and pushed.
