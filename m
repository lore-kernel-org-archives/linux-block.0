Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F907EB64DA
	for <linux-block@archiver.kernel.org>; Thu, 20 Jul 2023 19:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjGTT3n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jul 2023 15:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjGTT3n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2023 15:29:43 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5180E1724
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 12:29:41 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-785d3a53ed6so15034639f.1
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 12:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689881380; x=1690486180;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6EPe9CKzSess5IGZS9/zarMFMwQLlIFSDbX+RR9h8I=;
        b=aWwdjxzLe8UQTuinjOdE/RaORTrgWSS+tJUStZMWSCuTGUocGzJfPMDFggwMrMAyup
         PmpG9WzHPLE71dd1sqEDRVtR0wTeS6qXtA7HNY77JSM9aKIWAdbimeldoKWH3T9gUphZ
         T9RfqNwp7KF5i4X7muppFm/bSsfXvlkwcVgkZj33/+Zg68haFkini3v0Wx6p/HaOtXUf
         HweVRFOeiWlQrxa4orkyepH+lU7fO9O5hBpeV5ErsUD6NqJrmAD1xUpsH12HjzdSQ6aV
         72y9NNGonZXMjaxPUf50DxyRh29f3GuP74ybPdXa6YNrDhrR3Ou3Mvv6zSQOJgRJFxs3
         5bZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689881380; x=1690486180;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6EPe9CKzSess5IGZS9/zarMFMwQLlIFSDbX+RR9h8I=;
        b=F5GX8ScArkIpxprOB5KCiTDWCE14WQ5AgW98SMIoC6aSOkseheo/0nNlb8a7DrI8rV
         37vhik00WrVokVKbnj8qYx2XlfdCr3FoZv+/RUSdOVobH3Lswc4ysOBWl/3dRCQ9RElw
         LY6vhmDs/uetIEA1cd6rMyTGrBLRc7ntHgDDX1jnliAh2PftaaRZEreFqtFjAJrC0Dox
         B0VAr0IAxqZcLm2C9mvqDQ0v6oHQBlOGJOPOVMc5M5bbYco2WnkmFCVwW1Aq4CNM1yuD
         jA+39K45u7iouFogd+Rr92SNCP629ShlXDFtBQVbjf+jcvW7bvBNb5YxTuvWCDsen9W4
         byAg==
X-Gm-Message-State: ABy/qLZVvbGCBkEFpzusphTboAwUsLbnvOOpbXuO/oX3w9djV9c4jglS
        iBS1dZiraxWfbOvKh/0+HfIh8g==
X-Google-Smtp-Source: APBJJlGA7R3/equ2bBUMJ8Kkqg8rfcu4hag98cml2ZNmdagaHpgjf6OhPoxNf0YMowttsd06JFG9bQ==
X-Received: by 2002:a05:6602:3423:b0:780:d65c:d78f with SMTP id n35-20020a056602342300b00780d65cd78fmr4831718ioz.2.1689881380773;
        Thu, 20 Jul 2023 12:29:40 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m18-20020a02c892000000b0041d859c5721sm515494jao.64.2023.07.20.12.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 12:29:39 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     chengming.zhou@linux.dev
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
In-Reply-To: <20230720095512.1403123-1-chengming.zhou@linux.dev>
References: <20230720095512.1403123-1-chengming.zhou@linux.dev>
Subject: Re: [PATCH] blk-mq: delete dead struct blk_mq_hw_ctx->queued field
Message-Id: <168988137961.115425.9247701067643903062.b4-ty@kernel.dk>
Date:   Thu, 20 Jul 2023 13:29:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 20 Jul 2023 17:55:12 +0800, chengming.zhou@linux.dev wrote:
> This counter is not used anywhere, so delete it.
> 
> 

Applied, thanks!

[1/1] blk-mq: delete dead struct blk_mq_hw_ctx->queued field
      commit: 3641c90c4e369c8d0af5483e879174400a152cf8

Best regards,
-- 
Jens Axboe



