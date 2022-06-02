Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F4FC43334
	for <linux-block@archiver.kernel.org>; Thu,  2 Jun 2022 13:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbiFBNMM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jun 2022 09:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbiFBNMK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jun 2022 09:12:10 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9559CE13
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 06:12:08 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e29so662629wra.11
        for <linux-block@vger.kernel.org>; Thu, 02 Jun 2022 06:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:in-reply-to:references:subject:message-id:date:mime-version
         :content-transfer-encoding;
        bh=U5vSY/Se5tCRuMsr60pEuEsyusSTL3gl1RsNPtBDXgI=;
        b=f/dg/vDLrX6sQtck7kt3m6xtRfx8XXT+A9mE+7I16l1RLXFHXB+jF/YFexshTCxaZ4
         ZSmhAO9AP46xNjz4CEeRx2N0VmaoghwhovazO6SubCVgWFgCrXseUBdZvky9MQRtTV8G
         90n1ZDGzerM5rFOUljUoP+qxVIcDTmTodjCE7FtfrMBH/tAwbP7k0UoCGHo9cjV6NAPY
         sBH/87iFLDYNhte30gTAjX4upE3zN1q8sC4PoAMIuRnFHsKW2ZeO7d1JAWsBho8Qs7yJ
         BcaHZnRFpoWTHZfgmk7uCKrUu6IEhmNBxes7IFPlRR1bXNtTbJv/+ZQD5Z9+BW6RBFsa
         IiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=U5vSY/Se5tCRuMsr60pEuEsyusSTL3gl1RsNPtBDXgI=;
        b=T7DQmKFXt/tXrbMmOMqP9Oos9JuNCtuXDdejBQ0zPahfLDjIclGiSnhghCnpkpGt6G
         uOns/HxuowihtF0S5aPPZnKRm1cgXc7WYlONKGValGKhUIRAkRp1iNFpSfHLhvww0tFN
         xIZBH7B9Pvr1obz3M08vOGLdIK5YfUvzDXLmtQDgKAI7Pdz3/Bt7P5lURp/9lcQl+7kN
         Hxkd/46j/V/1i6n78nuureiooPcmZTlET1phMuRNK709OH4nwhaL/CBE02W2nYqyfr4/
         uCgz3bE9/RDSmVRLlhdHDjft3BhIlM9CYJkV3qKBJI3UVN5k38Er1wOuIpQySmrEf/XR
         +xDw==
X-Gm-Message-State: AOAM532pLya6UVItnAUiFgovwKtAUG867mRn7PffJtkJuf8QjFyQ1++P
        M01th2M8pZK2Axagltw2a7MlKMTeQQLWoXnv
X-Google-Smtp-Source: ABdhPJyzscxowSdg1vjQ6CCMxR8E0tZFcYcKAkFXPxUGfP0r1y7o7jdDxFT76Q1iaIc/P3l0biamqw==
X-Received: by 2002:a5d:650f:0:b0:20d:77b:702b with SMTP id x15-20020a5d650f000000b0020d077b702bmr3664590wru.78.1654175526748;
        Thu, 02 Jun 2022 06:12:06 -0700 (PDT)
Received: from [127.0.1.1] ([193.52.24.5])
        by smtp.gmail.com with ESMTPSA id t67-20020a1c4646000000b003942a244f33sm8599364wma.12.2022.06.02.06.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 06:12:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, damien.lemoal@opensource.wdc.com
In-Reply-To: <20220602120344.1365329-1-damien.lemoal@opensource.wdc.com>
References: <20220602120344.1365329-1-damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH] block: null_blk: Fix null_zone_write()
Message-Id: <165417552595.7731.1271657336358651866.b4-ty@kernel.dk>
Date:   Thu, 02 Jun 2022 07:12:05 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2 Jun 2022 21:03:44 +0900, Damien Le Moal wrote:
> The bio and rq fields of struct nullb_cmd are now overlapping in a
> union. So we cannot use a test on ->bio being non-NULL to detect the
> NULL_Q_BIO queue mode. null_zone_write() use such broken test to set the
> sector position of a zone append write in the command bio or request.
> When the null_blk device uses the NULL_Q_MQ queue mode,
> null_zone_write() wrongly end up setting the bio sector position,
> resulting in the command request to be broken and random crashes
> following.
> 
> [...]

Applied, thanks!

[1/1] block: null_blk: Fix null_zone_write()
      commit: aacae8c469f9ce4b303a2eb61593ff522c1420bc

Best regards,
-- 
Jens Axboe


