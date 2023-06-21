Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC04EB64D7
	for <linux-block@archiver.kernel.org>; Wed, 21 Jun 2023 13:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjFUNqq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 09:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjFUNqp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 09:46:45 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D287819B
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 06:46:44 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b515ec39feso10993635ad.0
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 06:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687355204; x=1689947204;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLtSXPBahUMgKQVBn5Rd4J0wNhqqaJSy+CKw/Y/m6tM=;
        b=p/6bV4ypTW1kiEtExMP1Y77vqeg7zVH2t1J0zdEv4dtxUnvbN0McjCJ9aZ2vSliOJ5
         2kFNww98CbYdPpGtc71RixBZAQYE6odAVxQtGtyiW99SmFR/OGfsTEcQJCMX5Ap06/Hr
         zhcSgq/TJFysLI+bYBqFXzTqKIh+ozfgfqxaYgSnU1cuJtTXLdDbI5SSdnT2wd3QcSiG
         trj8DCd6JLkCiPH2vbLoqUAKbbYDfNSjoeNvNnjwpqZErGldwRfiapwMdwFI0QbMx9vz
         +EHP4e6v1Dh2GMcXJOAi2hc+QYSpM3kRsjjZ9I/A0C2sbuVrAA0eDAiAV231EUAY4Ofe
         boyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687355204; x=1689947204;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLtSXPBahUMgKQVBn5Rd4J0wNhqqaJSy+CKw/Y/m6tM=;
        b=TdIyqNLelCUoiosTsskGa5nvaNFxc2K2zxnOLLSVzzElwovMp7ZSWTG0fpP5LfLATV
         LSGnvLZ+53ZhXZN282+hWVvlb2TnZA/vrkmwvstKQw8SbQHHUAn8ub+YS2NOjbufa28F
         OuquD8VXWd4xHJjEZUL8e2t6EGQymw8jn37liQ/YOrzCeZsECsv/5JwD/U3/Hqet6J1L
         FY8OaCwXc+nItKTF1zjTt0fGhac71Kzjlmh2Gf0EsDCxwt/2xXO4DwlZ3rFjnQBRjoVa
         iC0LNEnA3Kmrd1vMng3gHpSaZccshwFKmkuhGPUzshHxKJ41XqegcVCfx+zfOY74v+RQ
         EKfw==
X-Gm-Message-State: AC+VfDwj+LthHQWnfxgPlAMkDZ4Vo4fB1n28/ukJMH71a9yNghs3+6bU
        1Es3NgcuYRFNkVDjmcO9gp6WBtbC3CBDHfJ2ZOY=
X-Google-Smtp-Source: ACHHUZ7OkD4wv0DkpDZydNb4IYO41VvvOdEvmserXM7+mx4U8O/fwa4iq5YczMz/UU+uyqg2Ak8uJQ==
X-Received: by 2002:a17:903:1ca:b0:1b5:32ec:df97 with SMTP id e10-20020a17090301ca00b001b532ecdf97mr18146080plh.5.1687355203847;
        Wed, 21 Jun 2023 06:46:43 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090282c200b001ac95be5081sm3503549plz.307.2023.06.21.06.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 06:46:43 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>
In-Reply-To: <20230620180129.645646-5-gregkh@linuxfoundation.org>
References: <20230620180129.645646-5-gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/4] block/rnbd: make all 'class' structures const
Message-Id: <168735520264.3922571.3510429095521254500.b4-ty@kernel.dk>
Date:   Wed, 21 Jun 2023 07:46:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 20 Jun 2023 20:01:30 +0200, Greg Kroah-Hartman wrote:
> Now that the driver core allows for struct class to be in read-only
> memory, making all 'class' structures to be declared at build time
> placing them into read-only memory, instead of having to be dynamically
> allocated at load time.
> 
> 

Applied, thanks!

[1/4] block/rnbd: make all 'class' structures const
      commit: 137380c0ec40710cbaf57c7878726c41a6da81cd
[2/4] aoe: make aoe_class a static const structure
      commit: 65d7a37d4e3e226bb4a4ddf73a827d0dbc77f530
[3/4] ublk: make ublk_chr_class a static const structure
      commit: 2eefd399d28a52739fdbeebe84775275f016171c
[4/4] bsg: make bsg_class a static const structure
      commit: 72ef02b8dfa009029fa713e8a731a92d27d14e35

Best regards,
-- 
Jens Axboe



