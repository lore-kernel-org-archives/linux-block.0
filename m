Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2ED9C77B7A
	for <linux-block@archiver.kernel.org>; Wed,  7 Jun 2023 13:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbjFGNwf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jun 2023 09:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjFGNwe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jun 2023 09:52:34 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F4D1BE5
        for <linux-block@vger.kernel.org>; Wed,  7 Jun 2023 06:52:32 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3f9ac889629so2988391cf.0
        for <linux-block@vger.kernel.org>; Wed, 07 Jun 2023 06:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686145952; x=1688737952;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBCy6Zr3tLUZoNRTWAl9DUYT1FQNLXNhhe11Jl7EVJw=;
        b=0C0UEcws8800wGAcfU9YjUSxWnq5/82Hz8dLip01clh8YgJqhfQAhSdQM/bRFYglqw
         BkFRmwNIC2wT1U5h0HObDAp5lkrdBVH6bKt2dwT4ugzdDyLKpZaYxWHCwiLplJdjXZRx
         aAqyVqX1sC1t6edvZlsbs52JcQ+JKet2zKf+e80GIEbtKibc0OaHtP07v7ZcMI+FxPMy
         nv0L+vWB5lVz/+HFIvc4xU1uZ0vaRRzxQqyY3fRmeuv0LYR0o1RRBOpXwfaoDKuER1vP
         QQF9wl/mb5fvfpO2cjkf69nmiPjrwww3q0SqVu/HWYAOeznBdMG/StrXRXlLPoLuRswQ
         wd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686145952; x=1688737952;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBCy6Zr3tLUZoNRTWAl9DUYT1FQNLXNhhe11Jl7EVJw=;
        b=QcPrgiCdhEF1RHbSU9AMHfywuhuCyMTa2RwasH1Id4ZgUSSs23YE539cUohe3sQc6u
         LbtUWAmjw+omMxTTi3lAhRSuos1OFOVy/2xYGzzxOhVisoXTP312DLbHvhobNUM/VEP8
         evSzuIuF1Ew8T5bVZ+RY2Crq5PEtWWKojoVacFglXRkS397AJNNOeYhfawhL8zOeUN4n
         jhzCHOkc9RXBVzC4jIIhdKN7Eua/yBU5mtUIH126MDg9P9sVRe95WL3xiHvZBz/BmVUM
         CLiSkhVfseulv10zrUfUSAeK+Xhn4nSwbNzKi9I5HMV+vxt5JdCDP44XBewtfqdhNdRn
         D6tQ==
X-Gm-Message-State: AC+VfDxljls8dZLgfVFsj9FiNIuQQKhoI1FKdrCrvgMY7Sqc//fVYOd9
        J+VGxAHRL18PiNhDWaoWo4wT3Zi1c0nK8HAxZNg=
X-Google-Smtp-Source: ACHHUZ4fQ6pIyhB3M/I8i99y9dSNcWczKJKV8fRBAt/6EkdwqWBTOtLxNvG2mG7MjkYS368wiazRpw==
X-Received: by 2002:a05:6214:d8e:b0:625:88f5:7c62 with SMTP id e14-20020a0562140d8e00b0062588f57c62mr2038353qve.2.1686145951989;
        Wed, 07 Jun 2023 06:52:31 -0700 (PDT)
Received: from [127.0.0.1] ([50.234.116.5])
        by smtp.gmail.com with ESMTPSA id s5-20020a05621412c500b0062119a7a7a3sm6141611qvv.4.2023.06.07.06.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 06:52:31 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     josef@toxicpanda.com, Zhong Jinghua <zhongjinghua@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, zhongjinghua@huawei.com,
        yi.zhang@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230605122159.2134384-1-zhongjinghua@huaweicloud.com>
References: <20230605122159.2134384-1-zhongjinghua@huaweicloud.com>
Subject: Re: [PATCH -next] nbd: Add the maximum limit of allocated index in
 nbd_dev_add
Message-Id: <168614594988.134969.5912378237473757521.b4-ty@kernel.dk>
Date:   Wed, 07 Jun 2023 07:52:29 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 05 Jun 2023 20:21:59 +0800, Zhong Jinghua wrote:
> If the index allocated by idr_alloc greater than MINORMASK >> part_shift,
> the device number will overflow, resulting in failure to create a block
> device.
> 
> Fix it by imiting the size of the max allocation.
> 
> 
> [...]

Applied, thanks!

[1/1] nbd: Add the maximum limit of allocated index in nbd_dev_add
      commit: f12bc113ce904777fd6ca003b473b427782b3dde

Best regards,
-- 
Jens Axboe



