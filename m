Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE222EB64DA
	for <linux-block@archiver.kernel.org>; Thu, 20 Jul 2023 22:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjGTW2P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jul 2023 18:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjGTW2O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2023 18:28:14 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D6010D2
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 15:28:13 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6862d4a1376so282882b3a.0
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 15:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689892093; x=1690496893;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ER64QQYHsUjwnG72el4kyuwJDiqUwTkcoHvph6BDruY=;
        b=xvnxeikI4preGoplg4GJa2wMcpwX156LfaLr8H24NbeffloJZcxZ79aZcYtr3mITgR
         J3SBSJ4LeXPYFbhe91Z0vaDGcAyXlTZf5tXCmRzOBCpy7n3NtPOf7HIr2lzT+ShELXLd
         C3Sbk0INLRfUrb5HCB9ayySAPcoatZ2wF5LstdPXuVWobEPNOV1iHKqyw6ZJcCmmxVbs
         E0ty3dIfkDANo1MPs9ZAKju5ZQy2F1bHqVxTca5GYUMJJzQNvfLot9kZ3k1Z20R4KOVy
         LQmKKwgSfWkJU/hVi2kEoJasJvfst55olSEhnUFyOHfj7wNkqiBT+sB+OHZU3Cxks0cd
         0egA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689892093; x=1690496893;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ER64QQYHsUjwnG72el4kyuwJDiqUwTkcoHvph6BDruY=;
        b=EpSY/VkhpcpoA9mq1J39WM9w0mtjd6TIznv7QQ6OK7Q+6fbrtyE6RswrWC6TrmJx/m
         3RhoLaVXJQRI9qtRt3a2SSMxoEQIkp0krTWZ9OQhexk/VFHS1owChB1AbqBj7zeagcWu
         14NPVfWOC6a2iz38ntZXrCHeV3umzsrhjldudt/Nrnq7H8Pge+xX7ZWMcu6zbPtczsXe
         +G+wjOHg7NDY39bL8K2xHVZcR1mJua2ljrFwl6VyUxBNcI2yxc6m4d2rCWUHsoktUu+V
         FHSOEArxYVMINn9z1M++ROBAhOTrzXSGXvTBwIJ7Xj/GiNGqG/3zr0hveEHGLl7OopBI
         uarg==
X-Gm-Message-State: ABy/qLbCzsTNqMYIJIRK6VTJO7Qla49Q7iZWhckBfr7lEpbzm6my+LTK
        nJTsplHLdG89ftg4gU7AwcBkHA==
X-Google-Smtp-Source: APBJJlGb5KbDm3ra3A6zcXjXBrySFNfNSVxxeSzp8vPmQrISvsnUWmY7D8a8kPz7CxMAemHOYr+xMg==
X-Received: by 2002:a17:90a:304b:b0:262:c2a1:c01f with SMTP id q11-20020a17090a304b00b00262c2a1c01fmr30777pjl.3.1689892093322;
        Thu, 20 Jul 2023 15:28:13 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id gv20-20020a17090b11d400b0025bf1ea918asm1409443pjb.55.2023.07.20.15.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 15:28:12 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     martin.petersen@oracle.com, gost.dev@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230719121608.32105-1-nj.shetty@samsung.com>
References: <CGME20230719121928epcas5p3c2af8016b8ffd5d4cb53238a5528eec8@epcas5p3.samsung.com>
 <20230719121608.32105-1-nj.shetty@samsung.com>
Subject: Re: [PATCH] block: refactor to use helper
Message-Id: <168989209223.138604.5420894293792909192.b4-ty@kernel.dk>
Date:   Thu, 20 Jul 2023 16:28:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 19 Jul 2023 17:46:08 +0530, Nitesh Shetty wrote:
> Reduce some code by making use of bio_integrity_bytes().
> 
> 

Applied, thanks!

[1/1] block: refactor to use helper
      commit: 8f63fef5867fb5e8c29d9c14b6d739bfc1869d32

Best regards,
-- 
Jens Axboe



