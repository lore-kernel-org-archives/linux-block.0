Return-Path: <SRS0=SzsG=WD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC241C32751
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 17:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C150621993
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 17:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aVGu/UBm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbfHGRV0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Aug 2019 13:21:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45475 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730010AbfHGRVZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Aug 2019 13:21:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id q12so1888647wrj.12
        for <linux-block@vger.kernel.org>; Wed, 07 Aug 2019 10:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vuolA915AcWvE5yagNyuds+oSo4r9HGACr7hD1WRCQE=;
        b=aVGu/UBmLHA3dykO7e+4EmsQhRJOA0iTHk9Hv8b1/TkhzjY2XnXdPVGN5sh9fbFjiS
         Bbyqfc7wyg+5ijHYZ0MTMDxhuPymR44xiG5WiLbRa4O130QapZvSJEJlA1eu9N6hQzjH
         Tpt8YbpS/RjiP+FV+83WVVugq7v18Ra0kXQwUFqJeaSw4/gOhhS4qWkzncLMHJQPxDFZ
         OrfoL9ElwkluaiYnL8hoxCB87+xPKQgQu8kBiSkGhTojnAeuNnpddmCret/l28K9sLIg
         37e8/nR8RH3+Df6QbB7Kqpm22JerKCGAB+gm8EY1VCW1SK2f5xM5cK3KY5zoYfhU1FpF
         xOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vuolA915AcWvE5yagNyuds+oSo4r9HGACr7hD1WRCQE=;
        b=E4LjAtGn1QIT+bngZpK4P8A/56eJEIPFMtweZl5/R9rSlOL527+z+qzDepBond6gvb
         Votf6vb38cankkAnJuImI9zSlxhlg56okgy0+wQMghm8wQwIu19T9NXS0QIk9oSv0UZc
         slsdrIkwTrYSJxJIq2k7bFZHR+1C2hMeJgqh4eIRShhOjzl8LAD0H1Ngi5wenDObqRv+
         Zc2T7wWXFS547tGgkWTnpKorUG9XPg9tF7pzBULrn4joho+tyCpEMKM8V1q4zX0zvDlr
         7vxKfq8Ia5vB80Z5oxd2Nkxr0LyqBXgAalwk2FhHMYrkQDcFCdfg3rMt8GLCWrpPsymk
         7JUA==
X-Gm-Message-State: APjAAAVcV8p64zO6kIB3haBVcQ2fBCLJIxJXnxCbEvU39+giBxfEuKBl
        fW618RDH4YqwQ9D037kcoNKOug==
X-Google-Smtp-Source: APXvYqyzz1HmlUtRP/Bh8rrN0mY5HRxqSiSfvLupSZHWT8aG4tT1Ffd0nky4DLmmqD6ZHXnJtRAwSw==
X-Received: by 2002:a5d:6911:: with SMTP id t17mr11676892wru.268.1565198483442;
        Wed, 07 Aug 2019 10:21:23 -0700 (PDT)
Received: from localhost.localdomain (88-147-66-140.dyn.eolo.it. [88.147.66.140])
        by smtp.gmail.com with ESMTPSA id q193sm586773wme.8.2019.08.07.10.21.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 10:21:22 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>, linux@roeck-us.net
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [BUGFIX 0/1] handle NULL return value by bfq_init_rq()
Date:   Wed,  7 Aug 2019 19:21:10 +0200
Message-Id: <20190807172111.4718-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,
this is a hopefully complete version of the fix proposed by Guenter [1].

Thanks,
Paolo

[1] https://lkml.org/lkml/2019/7/22/824

Paolo Valente (1):
  block, bfq: handle NULL return value by bfq_init_rq()

 block/bfq-iosched.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--
2.20.1
