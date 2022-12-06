Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44E8C352A1
	for <linux-block@archiver.kernel.org>; Tue,  6 Dec 2022 17:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbiLFRTc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Dec 2022 12:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbiLFRTb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Dec 2022 12:19:31 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30F9326EB
        for <linux-block@vger.kernel.org>; Tue,  6 Dec 2022 09:19:30 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id a18so4251646ilk.9
        for <linux-block@vger.kernel.org>; Tue, 06 Dec 2022 09:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oCNEDNpGcaI2Aj5VMbDsaBAOnGUQv0gPAyadqC7Wu4=;
        b=Wz9CseKxzzVvT9R4Qxvx6tSE3Sr5Qizdya0/jSyc0v2aaoNGKrFPtw+IFZVY3CoKmR
         6wOSW4GpL+0IZ48Nfq0PE7Jd5qJu5UC+itK2LuV0h7U8q9bHNtIg+CaiMwR5UETfhy+/
         zxny0Z1nFI72vrjLVLT6YFAXqyVc+C4ckLGgcG0bp3EfdOsniL/XR8sNau1ukqPkpIvY
         UnLtGh1hqyZZWvCM8brC5Kzvnjppm0WRFkCHCDwvcxNvM7mbLSXHGjmPtq85vQyF3Hm9
         RPKc7mZuT1zRmYPRA9l9m6xztmxMpyrEyps6j/p9sOu6wmyAoLX5t0Oy5/rUPvH9pyJF
         eoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oCNEDNpGcaI2Aj5VMbDsaBAOnGUQv0gPAyadqC7Wu4=;
        b=k9x5IvwQQrKNr0tlmNNzltx2tVipxw+T4RgCCZO3YvQ13yTeOhmrxHravH8sS/NvJB
         js2C5/t5KqG9siHEcyQaQgXvxSd3MtKvbLh2qDsvtg4OMx1CU3NGOn3JvmP1LyvYYqhy
         EAqns6z57hqY/9Cqm8GyePDpHi18JnORz8qBqURJ4CHxAVEl2d176u6SBVF7/O1M2qhJ
         Juc1CSXPf/3BTC9Bt+7tY20D7BlD+zy2MRLak36I73vuWEXCZzcxkwiCGugHikFL/76c
         rvtxqRDzJnViQVQgYBXcAlKVz2kmo5uWH1cWJtXm87y6DedVeuUBN/xZbJ07MuUIp/wL
         YhUg==
X-Gm-Message-State: ANoB5plfKcSIKxc30/hoKCDbGMZJ9JItKkhVjOGa1sNh7Dyh+8ifwlwh
        E+JCx8PzuIjY6t3vg6q1JHr5gREFxDzprUlEOik=
X-Google-Smtp-Source: AA0mqf5Cidrser6tiSvWBkr4gK7QPwxmKSMGCKUsyvTmQ2yPXYL9dF7uvErDCBy8BDPyEJp/vVCC8g==
X-Received: by 2002:a05:6e02:78b:b0:303:ab9:9c93 with SMTP id q11-20020a056e02078b00b003030ab99c93mr21100756ils.111.1670347170090;
        Tue, 06 Dec 2022 09:19:30 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f3-20020a05660215c300b006dfd3599b60sm6592323iow.26.2022.12.06.09.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 09:19:29 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20221206144407.722049-1-hch@lst.de>
References: <20221206144407.722049-1-hch@lst.de>
Subject: Re: [PATCH] block: bio_copy_data_iter
Message-Id: <167034716943.332019.15368410495932137707.b4-ty@kernel.dk>
Date:   Tue, 06 Dec 2022 10:19:29 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-50ba3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 06 Dec 2022 15:44:07 +0100, Christoph Hellwig wrote:
> With the pktcdvdv removal, bio_copy_data_iter is unused now.  Fold the
> logic into bio_copy_data and remove the separate lower level function.
> 
> 

Applied, thanks!

[1/1] block: bio_copy_data_iter
      commit: db1c7d77976775483a8ef240b4c705f113e13ea1

Best regards,
-- 
Jens Axboe


