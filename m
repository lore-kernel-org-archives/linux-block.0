Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF464C64EC4
	for <linux-block@archiver.kernel.org>; Thu,  9 Mar 2023 14:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjCIO06 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Mar 2023 09:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjCIO05 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Mar 2023 09:26:57 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5ED29439
        for <linux-block@vger.kernel.org>; Thu,  9 Mar 2023 06:26:56 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso3732500wmq.1
        for <linux-block@vger.kernel.org>; Thu, 09 Mar 2023 06:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678372014;
        h=content-transfer-encoding:subject:to:mime-version:from:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yf2ahHvlY2IXDyPqkpKQ3Qkug7WIJL4NOmqcaxPWKDU=;
        b=NN8fDHs3guzY9CMMaCb9h6c9yjjx29Z13ygG325eorYAWi+UwN2oV1ajb5kiKAvn8u
         Nj+PpBMnoofN/BWDQpA4lZMQNR2oTdBcEbP91vIQgUhMUVgU3FfoUBXVw9OibDBe5jNU
         D7Dhp8eZMh/Y9ixR92vhtoIe3Ba1YRcu3+FwO0Jyx/Xl3g7tLLFJb311tQh/zoXf0QrC
         h8cTHmx82nSHUBfaNiJnq56rPrPMmSf3TcWB+AjV2TPchmbM1h6+1YT3b1+SZ1rmYD/N
         KjeSFLRbTqyvyCcKobb6tN1rRQTPu5WfkJ4MEBN6iay6S2xGNQr2xzjUQdUXXdfyMuGf
         FMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678372014;
        h=content-transfer-encoding:subject:to:mime-version:from:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yf2ahHvlY2IXDyPqkpKQ3Qkug7WIJL4NOmqcaxPWKDU=;
        b=2c2dUhNVDh12LbzN6Ddh5Dd0YFvsA+vF9XTyr53y627LM1U1VeINN/pVtP6JkoJqJd
         tIiUBciF9fZhdyC6bX5o3upPJ48S1CZa4B0l40BwUOhuSRjbfW9dursMuGdDYEP1f9jn
         VFLmmiGtIMvwtUu+WDweQ2mcwBagTXS3DZsQ03O+ENmYqTeDFUQ5AEyntI2gDO2Y7m9w
         TY8LpObtbySfIIqF/ruGjrEjo+qBPr3isps3J+e0iQqRTkouWZgvCR6iv32yegCGoHsc
         e0jkQS7WzWz4BXaLJN3h+Z4TZNDcQoyLXekYmmSp6wnBHMjBEPXh2SWXnMYjfotd5OoM
         dGVQ==
X-Gm-Message-State: AO0yUKV3I1ksLwqT5b+rE6jCQvGn9xzvpuWalpkiq/qhU8dN0f/zh7NR
        mNacYRl3ESTTG8ATYQXfUQb6yigejpE=
X-Google-Smtp-Source: AK7set9csJ2XXbhJuI3e+AGHMWIMNF6AOJ9F/gWwF4QIPi72YIeHxX1mOTdgaIIzeC17uI4cr7vHxA==
X-Received: by 2002:a05:600c:1d03:b0:3ea:840c:e8ff with SMTP id l3-20020a05600c1d0300b003ea840ce8ffmr17945672wms.3.1678372014527;
        Thu, 09 Mar 2023 06:26:54 -0800 (PST)
Received: from DESKTOP-8VK398V ([125.62.90.127])
        by smtp.gmail.com with ESMTPSA id c23-20020a7bc017000000b003de2fc8214esm12655wmb.20.2023.03.09.06.26.53
        for <linux-block@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 09 Mar 2023 06:26:54 -0800 (PST)
Message-ID: <6409ecae.7b0a0220.b426e.00fd@mx.google.com>
Date:   Thu, 09 Mar 2023 06:26:54 -0800 (PST)
X-Google-Original-Date: 9 Mar 2023 19:26:53 +0500
From:   krewkaydenr843@gmail.com
X-Google-Original-From: KrewKaydenr843@gmail.com
MIME-Version: 1.0
To:     linux-block@vger.kernel.org
Subject: Estimate To Bid
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,=0D=0A=0D=0ACrown Estimation, LLC is experts in providing cost=
ing and takeoff solutions to GC's and Sub's. We are based in NJ. =
We do estimate all types of construction projects including resid=
ential, commercial, new build and federal government projects.=0D=0A=
=0D=0Aplease send me the plans if you have any job for a quote on=
 our service charges before getting started.=0D=0A=0D=0AYou may a=
sk for any type of samples.Thanks.=0D=0A=0D=0ABest Regards,=0D=0A=
Krew Kaydenr=0D=0AMarketing Manager=0D=0ACrown Estimation, LLC=0D=0A

