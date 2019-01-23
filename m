Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7335BC282C0
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 16:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373FA21726
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 16:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dr1/qnvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfAWQOz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:14:55 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:38064 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfAWQOz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 11:14:55 -0500
Received: by mail-wm1-f45.google.com with SMTP id m22so2530526wml.3
        for <linux-block@vger.kernel.org>; Wed, 23 Jan 2019 08:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=I6DqHgwHOFfQHKeDOE1zNnfyzQ/ZeTp1zIvVf+79pGs=;
        b=dr1/qnvR+vdxcRPb4DBtnJzB4ZFPXDcRN5iAMYCLmDUmCw/Z3nGLbf2AXLsShixQMX
         7yvcYrEKDf5BvKhLuY8egCYaDADVb1aVPVXTTs6YB3W106HW146SdV42jnTRFcjtgY1L
         IYgHA2tAmudeN7xeqdymHoyEBBR8tNM8gDTKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=I6DqHgwHOFfQHKeDOE1zNnfyzQ/ZeTp1zIvVf+79pGs=;
        b=ul4NNiyk4irB1UNUWqnMht+F/py468gKtA5BVMXOlVapBkJleBo6gNqbYvobqlRIg8
         Q69D6jxuFN42vxqK0atsKwrMzq0clIvHmnZBiwhrp9DRV6zF1jHxekeXIJ3zGr0IB+Mi
         0aj50nxeB6sZhW+TqSC3DRPiLPVGfZnAVdd6xoq+skLdKec20aB73IQ/BVlM4k4D82YQ
         e3LjUjWexkJXWK4zsItzIA7H/NZr7vLSoqjVsYDJuw8RbG8S+dR4S01BqPV6fwnmEO8Q
         TpcvZ9YMTNGpmMSSO6MuFpUJl17f3ZSthe1tZPLgA7baEdgfBpJlh8YDcLdZQr5defaU
         yRFA==
X-Gm-Message-State: AJcUukfXJyaibFv7eUgkqAViitTPJuWZh1OR5URyL9qzcM7tguu32+Sr
        mnBBe/c9mBWCJlmuteDqg8qNFg==
X-Google-Smtp-Source: ALg8bN4mu3EjC6n2ske8tRyt7GGitg5NctpkvtpkVT1T6l3ZmkhazmD3TLu6cEJzoXJfRT/1QX3kjg==
X-Received: by 2002:a1c:2e0c:: with SMTP id u12mr3327208wmu.81.1548260093278;
        Wed, 23 Jan 2019 08:14:53 -0800 (PST)
Received: from [192.168.0.100] (146-241-80-237.dyn.eolo.it. [146.241.80.237])
        by smtp.gmail.com with ESMTPSA id v6sm84715527wro.57.2019.01.23.08.14.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 08:14:52 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: checking whether a device has internal queueing
Message-Id: <A65F1B2A-0A24-473F-9DB8-2A751CDB5ED8@linaro.org>
Date:   Wed, 23 Jan 2019 17:14:51 +0100
To:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,
bfq uses the old cfq's heuristic to detect whether a device performs
queueing.  Is there now a way to check that without guessing?

Thanks,
Paolo
