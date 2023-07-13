Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357D7C0015E
	for <linux-block@archiver.kernel.org>; Thu, 13 Jul 2023 20:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbjGMUiE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jul 2023 16:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbjGMUiD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jul 2023 16:38:03 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D682D54
        for <linux-block@vger.kernel.org>; Thu, 13 Jul 2023 13:38:01 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b89b0c73d7so1495205ad.1
        for <linux-block@vger.kernel.org>; Thu, 13 Jul 2023 13:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689280680; x=1689885480;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1Q3QVXuA3e+9GjXcm3jtTXFaZS47K/0EuW+3XlNfNc=;
        b=Su8Wda2t8a9fyq+mKQcL/x7F/nORxih5QNN3QcI8gU6tafMcFTpXJ/JwTC+hoKIAet
         UZMsZJb96148P+d+aPws2YjRiYEf/edVpyjk4+wpEJ9M1XzqIucAg9yImocZFmYK9wJK
         xaE29kKpjDeCOxxq0rQ+6whCvhArs3pZ84vH3p/ZLNWFeACVq7oihBFPE5g9PWRpVt62
         m/+T4BW1NQTA7qrHOcSd4KuKrl9Spcm6bLiz8E7RZ/f+rVQrLrv9scU9gZNQlE9kebGZ
         0RGTY3HPcbhwteIksfVKa0OxCoVWRm5KTkbDlcno5Uv52JGfmdZij+dF0jwVK882tSpc
         Hovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689280680; x=1689885480;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1Q3QVXuA3e+9GjXcm3jtTXFaZS47K/0EuW+3XlNfNc=;
        b=W5D4DGTMN6u1TeD1xIiLTJ6M5jfOySQP7MubTQGzAePbtm5KfaOSbP7s5bpTNUMibl
         g1DhbgknBNKp9GBqasy0e+PJ++jI3CCfUF6ygZDooQqPurVAFQl6j4GzToSwFRRwiwuo
         Q9e3w3JZ2vUbamwYUtwxjOHnKAeowgqoDkBifhYcXVNpDm7juEFG5LoOEunt9wV8JAO8
         TGCvtHmpDwCMblKICGwaKkt7E+VYC+xB/zh5+8sv/AzL/uJvXNUbK9ilW8n9BFnfpNV0
         WoCJp8+jMEPsjahvIq+SmrtZb8C5vO6jVIFmVakNFaWPHR88GFPd6+5V9qm9zzbApCJw
         JHUQ==
X-Gm-Message-State: ABy/qLYp6l1pm2kgtcBFOUqhgOTSRfDqivm8Y4iOvlBXkoCXhOpKU51z
        FD+qyVcHlQrvLr7ksA6MpApMfISYKbkHp3LR5IY=
X-Google-Smtp-Source: APBJJlFtDbDfCH1QZYudWC+aygAHdxLHIdPeg2AQ0LHcswNN+FtzghG6W1WdomahIOIyN5rpCIt89g==
X-Received: by 2002:a17:902:e549:b0:1b8:a8e5:e8bc with SMTP id n9-20020a170902e54900b001b8a8e5e8bcmr3342583plf.6.1689280680481;
        Thu, 13 Jul 2023 13:38:00 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902988a00b001b89045ff03sm6258074plp.233.2023.07.13.13.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 13:37:59 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Josef Bacik <josef@toxicpanda.com>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20230713-b4-nbd-genl-v3-1-226cbddba04b@weissschuh.net>
References: <20230713-b4-nbd-genl-v3-1-226cbddba04b@weissschuh.net>
Subject: Re: [PATCH v3] nbd: automatically load module on genl access
Message-Id: <168928067935.580122.1235240259614744275.b4-ty@kernel.dk>
Date:   Thu, 13 Jul 2023 14:37:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 13 Jul 2023 21:29:35 +0200, Thomas Weißschuh wrote:
> Add a module alias to nbd.ko that allows the generic netlink core to
> automatically load the module when netlink messages for nbd are
> received.
> 
> This frees the user from manually having to load the module before using
> nbd functionality via netlink.
> If the system policy allows it this can even be used to load the nbd
> module from containers which would otherwise not have access to the
> necessary module files to do a normal "modprobe nbd".
> 
> [...]

Applied, thanks!

[1/1] nbd: automatically load module on genl access
      commit: 82e37f43c37845b69955a0dfa5e0d1a2a830bdb7

Best regards,
-- 
Jens Axboe



