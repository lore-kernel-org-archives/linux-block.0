Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55468C76188
	for <linux-block@archiver.kernel.org>; Wed,  5 Apr 2023 13:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237898AbjDENqr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 09:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237909AbjDENqr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 09:46:47 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F254EE8
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 06:46:46 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-325f7b5cbacso56545ab.0
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 06:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680702405; x=1683294405;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Nj7IgmSBUiC0hYx7nk2RNMr/mkttF5HRcLAPZJytTk=;
        b=Msm6oyQrkP0OLXxXLuybVTtYYzPmTdaYOlkey5ZfCB8MoLi1eEzz5FgJTHGSWLsaiI
         tnEeijvHFJB70pOL5Ng9MoJF3iT6nH9YwSj3YK4ZAzWWxyezzaU2YU1Dl9PAu8NEm2nr
         2OxE8vAwlPbsV8bbrvCla7RNXHisLK8kfw5FTZngOdgHbQA8aJiTQOrOm9/G0hUjjRiG
         8NExLXL1b3HC+G+i/LCJ4gBUzZClbAn2xUoh6dBX/OAlDgLIsyo0bF0Rz6lgZzk5Cwle
         WEMFjynPuUxpQwfbkfuH7jZFXZ18GI/o9O8xKmPBzWKv7QT80ZGLDZtJc/xBts2ZQDir
         KEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680702405; x=1683294405;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Nj7IgmSBUiC0hYx7nk2RNMr/mkttF5HRcLAPZJytTk=;
        b=nvV7AglYXqESWM207POaNLp1wn8jWjeo4zIrHWgSV3BkBGQAfbZdSTVnzPjyzUL4qh
         5uq1FBOk16nqn34dHDWlvlxetg8lT79Or3Fcehb/5dL4/A0+d8pJnJYvmXtwjcHzEU8C
         cUHbVp8alYRKj2gAujbiMURfk5gBtfLyukbCphRFvhwnmprw5gMqUJA1AOArevj3Ic/g
         6VUSamVrqf7Qvafe2HojybGunA59R60Ok01nZVc3tTSxW31G3h/nx5XzZKtLg3R4TQLa
         0yjwEqDs2T3A6tJkxxqo+3KIGzgeBpu4FMwvAuNqB/i6yZfheiwOkKBQ9j3KPHSZWH0x
         CRDw==
X-Gm-Message-State: AAQBX9e3opxY63prqWvs3XDwQAWdKbc0ptvhDgR8BpYXK/3Aor+oSbA8
        gpiUlNCH6fxL6EKwO596+ayMFA==
X-Google-Smtp-Source: AKy350ZRKXD2E/DtsMklZljmzReTdEVce/oANE+LoU0x207xto8e1Ap1hOGXOMCodP0MxydFQyXhdg==
X-Received: by 2002:a05:6e02:492:b0:325:e46f:a028 with SMTP id b18-20020a056e02049200b00325e46fa028mr992433ils.3.1680702405540;
        Wed, 05 Apr 2023 06:46:45 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x13-20020a927c0d000000b00327392e5504sm385881ilc.68.2023.04.05.06.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 06:46:45 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Ondrej Kozina <okozina@redhat.com>
Cc:     bluca@debian.org, gmazyland@gmail.com, hch@infradead.org,
        brauner@kernel.org, jonathan.derrick@linux.dev
In-Reply-To: <20230405111223.272816-1-okozina@redhat.com>
References: <20230322151604.401680-1-okozina@redhat.com>
 <20230405111223.272816-1-okozina@redhat.com>
Subject: Re: [PATCH v2 0/5] sed-opal: add command to read locking range
 attributes
Message-Id: <168070240482.180333.16490902438199779587.b4-ty@kernel.dk>
Date:   Wed, 05 Apr 2023 07:46:44 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, 05 Apr 2023 13:12:18 +0200, Ondrej Kozina wrote:
> This patch set aims to add ability to user authorities to read locking
> range attributes.
> 
> It's achieved in two steps (except SUM enabled drives):
> 
> 1) Patch IOC_OPAL_ADD_USR_TO_LR command so that user authority (together with
> OPAL_ADMIN1) is added in ACE that allows getting locking range attributes.
> 
> [...]

Applied, thanks!

[1/5] sed-opal: do not add same authority twice in boolean ace.
      commit: 2fce95b196d34a17ac3f531933d156a8550d5b82
[2/5] sed-opal: add helper for adding user authorities in ACE.
      commit: 175b654402a11b01870e823f4eaa913b27ed8a63
[3/5] sed-opal: allow user authority to get locking range attributes.
      commit: 8be19a02f1e373d406b3d9e0c17a90c786c51c1f
[4/5] sed-opal: add helper to get multiple columns at once.
      commit: baf82b679cb2c76eb6f4b2881a60380e328ccc79
[5/5] sed-opal: Add command to read locking range parameters.
      commit: 4c4dd04e75e8177311d17387326253674cb0558b

Best regards,
-- 
Jens Axboe



