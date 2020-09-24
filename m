Return-Path: <SRS0=VsgY=DB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213CCC4727D
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 19:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D53B8239E5
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 19:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="L2Wx7FlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgIXTo6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Sep 2020 15:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgIXTo6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Sep 2020 15:44:58 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C67C0613D6
        for <linux-block@vger.kernel.org>; Thu, 24 Sep 2020 12:44:57 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id m34so315153pgl.9
        for <linux-block@vger.kernel.org>; Thu, 24 Sep 2020 12:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ADwlTn9rnJzlHv/xfLefERCgTh/zOY3+dj+IP5LMhIo=;
        b=L2Wx7FlLw8QHVp62Ne3mt4GV7+MUCO/WLUazgDqXAmYbUX1Et5GwKUZRbOhKWcg1pJ
         h3F8YG2QH8T53HlhbxkOnKDq7rYr7VYQSpBZ/SrGKbAAN0q9gjlZztvIvkLYWYD2H5p5
         D5jWhUDJxNaNV9x10hDsgdYsv3+GqUJuih92RXGRYnyEyog4jlWpFA8o+B+sqtqEeysu
         zXsVFR5QGsEI7lJZ39JHqx1JjZyubGP7QEwNsybW+JHQWulohPcvjDgNlPxNi7sQOhp+
         YLXR3ph4QhgGStegDp9ue2849D7tWES5wOYPeY73GujeWcYMaP3DsMTgcgakPfQ8C4Iw
         pmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ADwlTn9rnJzlHv/xfLefERCgTh/zOY3+dj+IP5LMhIo=;
        b=b+5gXG2+B5BNa0KuLcXEkFyhcqSyQ7l3XVdsFfM1qrZ1Qxm5125VFtfcnhu96fY/OM
         3m1JUj6IJx1lydoOscQgRxxWSajFOyj2bMn01drELhphT66CAL6J94TIZj5OTcVDU4FD
         lty+VFtHD14ZKWOGxvBxC1VdwuziCNWWf7lcmkGz9DWOBj//rddiYzxEjcpoivvhjFmr
         o+hfrqd3szPeLbf6gNss7bfzgC5IrWd6VV3kF38wgSLFa3bUyHUWiqbV3j4h+sJoK6Hc
         fEg6ZdKlg2mDyW+NfyMlJj/60y/Ep78tEXp3oLIi2/q57ZsAdjajXo6anKxLdpfWUpVI
         LESQ==
X-Gm-Message-State: AOAM531eczZCvZVBoShuDhlqe2vDdi17ZIAdBlxknABnHx2mEy2Yecw3
        6gI6ueUzYq8GQtHz3rAmbbct8A==
X-Google-Smtp-Source: ABdhPJyn7jUbiC3AGiO/dBfKmKGpcA3VV/JE4LzjEmCUjGJIbrcL8/kmgANM72e+JonEfnG9EJ77rg==
X-Received: by 2002:a17:902:854b:b029:d1:cbf4:bb43 with SMTP id d11-20020a170902854bb02900d1cbf4bb43mr778274plo.13.1600976697336;
        Thu, 24 Sep 2020 12:44:57 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21d6::1911? ([2620:10d:c090:400::5:d63d])
        by smtp.gmail.com with ESMTPSA id u10sm267612pfn.122.2020.09.24.12.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 12:44:56 -0700 (PDT)
Subject: Re: bdi cleanups v7
To:     Christoph Hellwig <hch@lst.de>
Cc:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Coly Li <colyli@suse.de>, Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Justin Sanders <justin@coraid.com>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
References: <20200924065140.726436-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a9235ba9-95a0-4251-ee7d-e4012775346e@kernel.dk>
Date:   Thu, 24 Sep 2020 13:44:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200924065140.726436-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/24/20 12:51 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series contains a bunch of different BDI cleanups.  The biggest item
> is to isolate block drivers from the BDI in preparation of changing the
> lifetime of the block device BDI in a follow up series.

Applied, thanks.

-- 
Jens Axboe

