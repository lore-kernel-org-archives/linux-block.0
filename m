Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEABC433EF
	for <linux-block@archiver.kernel.org>; Fri, 10 Dec 2021 09:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbhLJJYJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Dec 2021 04:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239188AbhLJJYI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Dec 2021 04:24:08 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36D4C061746
        for <linux-block@vger.kernel.org>; Fri, 10 Dec 2021 01:20:33 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id g14so27154489edb.8
        for <linux-block@vger.kernel.org>; Fri, 10 Dec 2021 01:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SX+FfU5mZDxCoswRXg/krQoh/mf5XisDnoDBVGtWZvI=;
        b=fa2LOUoLxWv4XALz/wTI0VNk09ZivC+oOpTGEYFmFJQf65kvfkThGd8C0Tunk1nPCF
         zr+ehwd5gQ7hkPz7TvP32O9oNaZ+SWaichsnJbwlAjkrIZl3xbVi3hO/LIvr6BNuOQhx
         nA1e31nbAymHHtphxOYLlTzudumNyCS0SOyeG/x56jcrfxisLXkUiOJrnyh64fJ9L4lL
         5jzumWamcoK8rPC3Eerm1S0JuIyBmd9UbjhYBRBsEL5cEXN/AgzKnGbS3bvmF9qL46ZU
         Pb10cYUUzk+dKF+1vVfK3LRkPVbSs1/0A18UCloFMsfc3P4bczuLKEK32WPiNZq31EYw
         I3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SX+FfU5mZDxCoswRXg/krQoh/mf5XisDnoDBVGtWZvI=;
        b=mZwkbJeUo3Dl/6IQXS3zGaSBtufUYYDD3mIKaOr7EIp6/WYSfrJ/vOQCUE8+Ftmti/
         bCE62OVKB/QUCUx2aRMkjSXKXuYtEowtYAsFq6mnH83kj4kohAdTihZWMxi00HWenhQF
         W858GwNjLqL4qRRSlfKka2QKLiasZwaX4cowUFe2QTzU0vI9L2wff8M9RAZaV+neNYfM
         owJvMag1xcgXXwa7as8Oq/+0cLVFYurOuQicgXhhFEzYvYXrDUx0lgkN7bupFZOrtMDo
         5og311ejuc2KJbkgwB0baD3HJeW2Jwx5t7x6IW6dAtp3Ho3ouYaF7ASaKbTO6D19ND2S
         sZVg==
X-Gm-Message-State: AOAM533UMvD0u5zqecElAoufi0HacibJAkrXPE/i3IhocRLqr99ucHPw
        FfXX9B49fk5vTsYLBEsB6eHxBw==
X-Google-Smtp-Source: ABdhPJyjRZ85fHSpYIyUt66EHBM4ZpNNk7nXOnCt7DkA0r0LV+HPLXhCEHNQ8Ga6GAUR1sgAm7qHPQ==
X-Received: by 2002:aa7:cdd9:: with SMTP id h25mr36869911edw.130.1639128032409;
        Fri, 10 Dec 2021 01:20:32 -0800 (PST)
Received: from [192.168.1.8] (net-93-70-85-65.cust.vodafonedsl.it. [93.70.85.65])
        by smtp.gmail.com with ESMTPSA id h10sm1107199edr.95.2021.12.10.01.20.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Dec 2021 01:20:31 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH RFC 0/9] support concurrent sync io for bfq on a specail
 occasion
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20211127101132.486806-1-yukuai3@huawei.com>
Date:   Fri, 10 Dec 2021 10:20:29 +0100
Cc:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D3FF0820-6A51-46A1-A363-8FFA8CCD2851@linaro.org>
References: <20211127101132.486806-1-yukuai3@huawei.com>
To:     Yu Kuai <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 27 nov 2021, alle ore 11:11, Yu Kuai <yukuai3@huawei.com> ha =
scritto:
>=20
> Bfq can't handle sync io concurrently as long as the io are not issued
> from root group currently.
>=20
> Previous patch set:
> =
https://lore.kernel.org/lkml/20211014014556.3597008-2-yukuai3@huawei.com/t=
/
>=20
> During implemting the method mentioned by the above patch set, I found
> more problems that will block implemting concurrent sync io. The
> modifications of this patch set are as follows:
>=20
> 1) count root group into 'num_groups_with_pending_reqs';
> 2) don't idle if 'num_groups_with_pending_reqs' is 1;
> 3) If the group doesn't have pending requests while it's child groups
> have pending requests, don't count the group.

Why don't yo count the parent group? It seems to me that we should count =
it.

> 4) Once the group doesn't have pending requests, decrease
> 'num_groups_with_pending_reqs' immediately. Don't delay to when all
> it's child groups don't have pending requests.
>=20

I guess this action is related to 3).

Thanks,
Paolo

> Noted that I just tested basic functionality of this patchset, and I
> think it's better to see if anyone have suggestions or better
> solutions.
>=20
> Yu Kuai (9):
>  block, bfq: add new apis to iterate bfq entities
>  block, bfq: apply news apis where root group is not expected
>  block, bfq: handle the case when for_each_entity() access root group
>  block, bfq: count root group into 'num_groups_with_pending_reqs'
>  block, bfq: do not idle if only one cgroup is activated
>  block, bfq: only count group that the bfq_queue belongs to
>  block, bfq: record how many queues have pending requests in bfq_group
>  block, bfq: move forward __bfq_weights_tree_remove()
>  block, bfq: decrease 'num_groups_with_pending_reqs' earlier
>=20
> block/bfq-cgroup.c  |  3 +-
> block/bfq-iosched.c | 92 +++++++++++++++++++++++----------------------
> block/bfq-iosched.h | 41 +++++++++++++-------
> block/bfq-wf2q.c    | 44 +++++++++++++++-------
> 4 files changed, 106 insertions(+), 74 deletions(-)
>=20
> --=20
> 2.31.1
>=20

