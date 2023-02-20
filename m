Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3EFC636D6
	for <linux-block@archiver.kernel.org>; Mon, 20 Feb 2023 22:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjBTWVh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Feb 2023 17:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjBTWVg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Feb 2023 17:21:36 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724481C329
        for <linux-block@vger.kernel.org>; Mon, 20 Feb 2023 14:20:49 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id w42so2964630qtc.2
        for <linux-block@vger.kernel.org>; Mon, 20 Feb 2023 14:20:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/GkL4roSHCjRncSIk+Dw09K8EUHNxrM4m4i32VKjbs=;
        b=XDyoxKf5CkcWF5VtaFMG3kq1cMpRcYbLfhscCBw43JHr/vnW2HtXVdX3C12efAql22
         4aqLjwUGcsVRZXZNpq9htJqWX6bD0pLr6EaPTwe5FEoSD66LOSK4LYjvNVAkKtOy10HI
         /o3iPrJJwF6EDmSYzviHwjlcaXDkqCgiUqHtw6XQuSj2K+kwiZIctIhr12RfrZmfBN4w
         7biUELEzWWhOn5T4gmQ//xFRUTk4Bi1wg5Hjh1N6hNLnGOyJzGoRqDwr/93vGhWYrnC3
         0iDzgSLCHkDRNwZSa6vOGwGUsU3jdPRUTkCZxI7QuBkA66fsG175uw1CI0r1KmDPU6qD
         OSqg==
X-Gm-Message-State: AO0yUKXw1L2mk12JoZ03qiRbMpHkg/lYxyfTLnM06bYqWV/gapnr4m9I
        dluwk8RZ80pg/fMDyRnTjAUH
X-Google-Smtp-Source: AK7set+evaFySCYbSrwieLb6flOyB5fBQlkRJ9eCz3NiKxnOc+WOsFmrkfzVrqv1kjmp1x00Glq8Uw==
X-Received: by 2002:a05:622a:1456:b0:3b9:c0e8:610c with SMTP id v22-20020a05622a145600b003b9c0e8610cmr4839450qtx.60.1676931648593;
        Mon, 20 Feb 2023 14:20:48 -0800 (PST)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id b18-20020ac87fd2000000b003b80a69d353sm917343qtk.49.2023.02.20.14.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 14:20:48 -0800 (PST)
Date:   Mon, 20 Feb 2023 17:20:46 -0500
From:   Mike Snitzer <snitzer@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Benjamin Marzinski <bmarzins@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Hou Tao <houtao1@huawei.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Joe Thornber <ejt@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Pingfan Liu <piliu@redhat.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        XU pengfei <xupengfei@nfschina.com>,
        Yu Zhe <yuzhe@nfschina.com>
Subject: Re: [git pull] device mapper changes for 6.3
Message-ID: <Y/PyPrY39QLTHtW4@redhat.com>
References: <Y/OueIbrfUBZRw5J@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/OueIbrfUBZRw5J@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 20 2023 at 12:31P -0500,
Mike Snitzer <snitzer@kernel.org> wrote:

> Hi Linus,
> 
> The following changes since commit 4a6a7bc21d4726c5772e47525e6039852555b391:
> 
>   block: Default to use cgroup support for BFQ (2023-01-30 09:42:42 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.3/dm-changes
> 
> for you to fetch changes up to d695e44157c8da8d298295d1905428fb2495bc8b:
> 
>   dm: remove unnecessary (void*) conversion in event_callback() (2023-02-20 11:52:49 -0500)
> 
> Please pull, thanks.
> Mike

I should have mentioned: these DM changes are based on the "Block
updates for 6.3" from Jens.
