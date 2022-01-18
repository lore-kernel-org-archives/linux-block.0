Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B78C433EF
	for <linux-block@archiver.kernel.org>; Tue, 18 Jan 2022 17:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbiARRxK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jan 2022 12:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238628AbiARRxJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jan 2022 12:53:09 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835A7C061574
        for <linux-block@vger.kernel.org>; Tue, 18 Jan 2022 09:53:09 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id n8so2753596wmk.3
        for <linux-block@vger.kernel.org>; Tue, 18 Jan 2022 09:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=M7FBzDoAriv8xQwZLoTeD6TT/AZBvb4RBjfiUlayd0k=;
        b=s9eeoFqeWryDhzZWuDTcq1vMbgdJuw61xJU6xmMrmmjzk2833fTJhClgBKm/9Buvzr
         /CJRd9eeYG1vrSUWpvusfrFg3CIQZ9w2oS6ZErGCfNXDXvMFXvZIufkgGhDve3v2ci5t
         z1IPHvF4sIXYz0uPjj/8Rq7qgyRJ4mTjJ43gn7dx+GDYDh46kSASXq/5jPJHWku4OUiK
         s7ajzbmCQG98b1myDBKC/2AN5kDUXloC7E8nrUUgPnEciKZZpt0GGYFn8BENphBjCkXQ
         BDQnGiM04AsymRvjsm3PIAOdm67ECL77HleUijs3FE6bHBj8IWLOBqKDEt8OY0I0PGV2
         gRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=M7FBzDoAriv8xQwZLoTeD6TT/AZBvb4RBjfiUlayd0k=;
        b=mPLov6jVgsrPLNjZIBO9vQ3Ct3LV3EtbudsNYbt6fSab+IsZj3iH1qiZkXhhW7POpd
         DzlesRbMkZuCcHgpORFFtZWnDFW2jGm4JoQL21WEhl+/SFk+6CW3bmJ8B/3EuRA+KV74
         DjmiMothk2jm5vzdLRvTFx8CXWgdzXggkxRfDh8cQfauqWN5f5fl1AmIWpT9IRTFLneY
         dnqoV1CxJhdLrE93bqjQlkAJujNKO65w2VhSxZM7Om4O3nEpNdeS/dGKKE9Ckb5ImuBL
         gZb2D1s83Nms/f9sXQOfv64jzuoiASmvfNeJgf028Obor6xQc66fsuSJg9IXdu81hUdK
         7f2Q==
X-Gm-Message-State: AOAM531XlU46D0bs1c3qXnSQlenbCSyOVPIcc9TCIFmnYtmr7Ku1qP36
        PjGu4yVVbkfDxl5GgBCWGCbC+w==
X-Google-Smtp-Source: ABdhPJwb+p8UB1dOVFS0odoADdrtkI114HwKAi97fv6QhAkNYi7eCqPO0rw97vJZmiAt7CiLdHGEyw==
X-Received: by 2002:a05:6000:2ad:: with SMTP id l13mr7902448wry.374.1642528388114;
        Tue, 18 Jan 2022 09:53:08 -0800 (PST)
Received: from [192.168.18.233] ([37.163.4.92])
        by smtp.gmail.com with ESMTPSA id b14sm11357994wri.62.2022.01.18.09.53.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jan 2022 09:53:07 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2 0/3] block, bfq: minor cleanup and fix
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20211231032354.793092-1-yukuai3@huawei.com>
Date:   Tue, 18 Jan 2022 18:53:01 +0100
Cc:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4E86637B-382D-4A6E-8E5C-F788589FD395@linaro.org>
References: <20211231032354.793092-1-yukuai3@huawei.com>
To:     Yu Kuai <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 31 dic 2021, alle ore 04:23, Yu Kuai <yukuai3@huawei.com> ha =
scritto:
>=20
> Chagnes in v2:
> - add comment in patch 2
> - remove patch 4, since the problem do not exist.
>=20
> Yu Kuai (3):
>  block, bfq: cleanup bfq_bfqq_to_bfqg()
>  block, bfq: avoid moving bfqq to it's parent bfqg
>  block, bfq: don't move oom_bfqq
>=20

All
Acked-by: Paolo Valente <paolo.valente@linaro.org>

Thanks,
Paolo


> block/bfq-cgroup.c  | 16 +++++++++++++++-
> block/bfq-iosched.c |  4 ++--
> block/bfq-iosched.h |  1 -
> block/bfq-wf2q.c    | 15 ---------------
> 4 files changed, 17 insertions(+), 19 deletions(-)
>=20
> --=20
> 2.31.1
>=20

