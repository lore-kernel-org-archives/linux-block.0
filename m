Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81BAC0015E
	for <linux-block@archiver.kernel.org>; Tue, 15 Aug 2023 15:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237187AbjHOPHK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Aug 2023 11:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237383AbjHOPGx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Aug 2023 11:06:53 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E69138
        for <linux-block@vger.kernel.org>; Tue, 15 Aug 2023 08:06:53 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bb91c20602so9737595ad.0
        for <linux-block@vger.kernel.org>; Tue, 15 Aug 2023 08:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692112012; x=1692716812;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gNBiuYmPP/CPRleGouxvrvKl9BhoSBRBp4snnqKeuc=;
        b=1G2UkYk7f1Fl3Hx9pXhbPTDEFsxawmWoFLLhldzAfzw42D/af9XD+abf0ogufTM0KF
         UE6E78+ZaxCi1o8RjXIq3XSVU6+ih8lmKVFgk9LhUvimJQjdZo1o72my1xrginy5nrsD
         C3ROZrmdJnJA+RyeBgkG94pFNAy+uqFFFc9L3sI10J6msQQ6/RydQoPat6KsK37ZVBjp
         TjiRxOcTddCr3CDnV2XNtY7RXlpH45nfVI7hFOcZqEUDD83ztjgdVfd2tY6WyHgeQ7uk
         jyNeEyNLPhaG5++LbW6Vc4nWxj4aacYpwdLFzshalFjDHdIAp84dYPUQTbfkK856tUEj
         spqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692112012; x=1692716812;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gNBiuYmPP/CPRleGouxvrvKl9BhoSBRBp4snnqKeuc=;
        b=SOlIrThwR3nSR46ZFqrNCWtDWnopLaH0fUYiAFOy2cXq48iM4VY0KoCqMhJ5tCr7KQ
         27IuIhXSyoZJVJkcRyjlz2IJm3sV6kiUHHkYXnO3WmxF9weTEebUTIvjAlQLSDIiUOzJ
         6oCM9Td32MMjctILcb5mAXnyvqn4oeqSF2rdAAq2XEeTbSGysfRrd+sMVwIk2J5brAL8
         Oeb5+PwvfrlsyU6l/RM9h7V6SKyRAmSJhAocSgtsRILnpZSnK94C0GVkYmVu80pf6NtP
         vzbBpxJgrIFIc7J4jhueRfLJu3QrWHtFIxKZaxWAj3fFdy3hR+bOVstiFY6F7zNy4CiF
         VmbQ==
X-Gm-Message-State: AOJu0YxaPcYefxjc2P6fSOs9NeMxAVAy/tsFjDlUvf+yFcGs+m2uWxV6
        XLV8t13PWOR7Y6zwkGuDh6v5ew==
X-Google-Smtp-Source: AGHT+IHwe0jlShP56MobJv+dBrZK7ARzi9c2zKj0IRO45ZlXfcd0KwA5pyVcc0EBBy17q0hVxx4vZw==
X-Received: by 2002:a17:902:e5c8:b0:1bb:83ec:832 with SMTP id u8-20020a170902e5c800b001bb83ec0832mr14830924plf.2.1692112012590;
        Tue, 15 Aug 2023 08:06:52 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f2-20020a170902ce8200b001bbfa86ca3bsm11222620plg.78.2023.08.15.08.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 08:06:52 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230815114815.1551171-1-ruanjinjie@huawei.com>
References: <20230815114815.1551171-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH -next] ublk: Switch to memdup_user_nul() helper
Message-Id: <169211201169.433025.9292584498879248061.b4-ty@kernel.dk>
Date:   Tue, 15 Aug 2023 09:06:51 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 15 Aug 2023 19:48:14 +0800, Ruan Jinjie wrote:
> Use memdup_user_nul() helper instead of open-coding
> to simplify the code.
> 
> 

Applied, thanks!

[1/1] ublk: Switch to memdup_user_nul() helper
      commit: 306d74055754976f6bbe67aef60fe1022c6b76e0

Best regards,
-- 
Jens Axboe



