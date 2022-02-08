Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A70C433EF
	for <linux-block@archiver.kernel.org>; Tue,  8 Feb 2022 16:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382382AbiBHQH6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Feb 2022 11:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381969AbiBHQHx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Feb 2022 11:07:53 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEB0C061579
        for <linux-block@vger.kernel.org>; Tue,  8 Feb 2022 08:07:52 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id d10so53727705eje.10
        for <linux-block@vger.kernel.org>; Tue, 08 Feb 2022 08:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pxjwicyhltOLuF32btZSo9eR1Q86Q6QmMx6SaA/q3DI=;
        b=OB5f9v0kZYyeHeXgReydEaPOiq979JGQ7lVGZlZ6oerO1iBCCY1iWxu20iUkDgyoNe
         c1t/aUQ01QC+znccPD/jcIC+wwAm6hnUmmiy2z7kDF3cLJUMMmMFFRmeet/e3nBKQyEt
         Xk/CRe2LQ/RZ49l0q1BZsmQYAq4gFiek0EEZ+Z1ABV2rNhdhkyA1+kns7YAk3M7b+Lk8
         RLcZE0Sb0VvlEU2SZHdq0wbgunrryPSxZFiTgUDpR/sQS4gmOfV+oPD8RzV7YCzjALNT
         VMwocI/yT5E0Q0Vus3FHvHbYZ/1eK/o29ut25C0BmXinqyLPrMuZIx3hvWhJCDKkhxn2
         MAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pxjwicyhltOLuF32btZSo9eR1Q86Q6QmMx6SaA/q3DI=;
        b=B2CorBnSANVN8nnmCpeyqGWpJFla8hvtkfEdYJrng5DQ7z6Vpx855AaoFq849y8gGj
         TF9kOmhUNBQbcOwYUsRrhv3F0aevshYFDMHPnIVFl93jv+8WCk6yyWFimeRYdikVbQJ5
         dCt+LCzJ0GVrUsI8Hn3Lxegvye7VfNZL7Jcx8rhE+yFBlFhFLZNahpMMG11WxFiFLhoM
         9B9WkgbOCFaJFzEUgtHjvNpPMCJ7oNn41/925smKjuqPVNL3gyDXLcRmIVshmWrAhfNA
         5MSZFSF9UiNe8LWKC/3i1SPuZLu56FnJWpN0x7inohpmST85T8Fex11VaXoGjMakMWGW
         2d3w==
X-Gm-Message-State: AOAM530QsTCIyRltq7aKkXDuYczn2ZNpWoTos8QSrbeWx828cD3mjUFP
        OzCahciXgiuL25iN2Ql4ds/5Uw==
X-Google-Smtp-Source: ABdhPJz4RnNuj5YY8xlIrK2+luOydjfdY6530XHJpbvHISffDI7nftfnB9s3FoY7gS9qnJyGCpXHFw==
X-Received: by 2002:a17:906:dc90:: with SMTP id cs16mr2272590ejc.295.1644336471256;
        Tue, 08 Feb 2022 08:07:51 -0800 (PST)
Received: from mbp-di-paolo.station (net-2-37-165-88.cust.vodafonedsl.it. [2.37.165.88])
        by smtp.gmail.com with ESMTPSA id a21sm4794976eds.5.2022.02.08.08.07.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Feb 2022 08:07:50 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3 2/3] block, bfq: avoid moving bfqq to it's parent bfqg
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <c85b10ce-fb41-9e0a-772a-63c226227207@huawei.com>
Date:   Tue, 8 Feb 2022 17:07:49 +0100
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <36E597B3-AC41-48CC-BF3D-C35FAA7CCDD6@linaro.org>
References: <20220129015924.3958918-1-yukuai3@huawei.com>
 <20220129015924.3958918-3-yukuai3@huawei.com>
 <c85b10ce-fb41-9e0a-772a-63c226227207@huawei.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 8 feb 2022, alle ore 04:53, yukuai (C) <yukuai3@huawei.com> =
ha scritto:
>=20
> =E5=9C=A8 2022/01/29 9:59, Yu Kuai =E5=86=99=E9=81=93:
>> Moving bfqq to it's parent bfqg is pointless.
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>  block/bfq-cgroup.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> Hi, Paolo
>=20
> I make a clerical error in last version of this patch:
>=20
> bfq_group should be bfqq_group
>=20
> Can you please take a look of this patch? I do compile and
> test the patch this time...
>=20

Haven't I acked this patch series already?

Thanks,
Paolo

> Thanks,
> Kuai

