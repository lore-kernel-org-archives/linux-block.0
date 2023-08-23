Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC6CEE49A5
	for <linux-block@archiver.kernel.org>; Wed, 23 Aug 2023 00:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjHWAJX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Aug 2023 20:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjHWAJX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2023 20:09:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C364E60
        for <linux-block@vger.kernel.org>; Tue, 22 Aug 2023 17:09:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf1876ef69so6331945ad.1
        for <linux-block@vger.kernel.org>; Tue, 22 Aug 2023 17:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692749350; x=1693354150;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdAmFpsgAimnC/MBfbBr1LVAlYOvun6vfII/jkXCFI8=;
        b=w7VKM9wOfDqjg3owcHgb2C1pnHTB9457TIJF1v5sJBPucicGSUVcJwZhbBMXy0CApW
         gmc6pzY4ypInuel01Z/6LdlQpZBASjvNe/TpVzvbylk42+d+JWm8fDM1rWD5wmk6DqPm
         602Fh89hxbzIbZq6T/WoFLAk2obOopGYQ/Kr9awheMUn7sMyWDlAJkuFETmprLdVkHMA
         2/raoT+DuUgn/r7Qt2FJwbY7g1aoySD/PICaXxcBM5NCOSBbpwpKjGHzNgqc5VbTJmFr
         st02qp7I32ujhd0pqOjYxqQBerVFJblqrbKn9gE47dsllzXW2nqbgAhuZadpsZl6HF8j
         DprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692749350; x=1693354150;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdAmFpsgAimnC/MBfbBr1LVAlYOvun6vfII/jkXCFI8=;
        b=fVdTK4s0DSomi8xWdLt3oVF34agohw8W7CPylo0WY3jgKEGQgYOzhtkPejHOKPI8b6
         amNjlcOlPMaI51dxReDaq1iC4vClKYRM1XRaAaX1gAaJtdX8ulGZAstb8vhTaRLESyaC
         0jthCTRp/2gcZAoOAFTcWTBj3T485yY9A8AKp41qr/NvM2zOR9ApVOSc+wE0bkOM023V
         3129bJkWWuOcgCayYB0wJ0PlNxfdmboHgkYi6yax/FgFQzgwT77QvLcDFMtNHpPMOaKA
         3USFiJVasuNc0SY6AJqHZJuMyuLwlDR7I70tDNkAP+Rm1yHKkYZyhqIHtn3RJ7QzOnTy
         fxMQ==
X-Gm-Message-State: AOJu0YwWBjaeGmzNpOOVM2eSyHaFzHLIdsQHfmtEdAM1Gll9r4jslnDg
        t/bkIrHuFqzNBZZqmrpurVPTcw==
X-Google-Smtp-Source: AGHT+IEWieYgoZObLvRGZKRu3zCi2GHgsl+XF2ezTYqTa5Gs1LxrTcwz8X3gX21BbOaA5WSk2J65hw==
X-Received: by 2002:a17:902:dacd:b0:1bc:496c:8eda with SMTP id q13-20020a170902dacd00b001bc496c8edamr12479327plx.4.1692749350550;
        Tue, 22 Aug 2023 17:09:10 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j8-20020a170902690800b001bc56c1a384sm9528238plk.277.2023.08.22.17.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 17:09:09 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Justin Stitt <justinstitt@google.com>
Cc:     linux-s390@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20230822-strncpy-block-partitions-cmdline-ibm-v1-1-154dea8f755c@google.com>
References: <20230822-strncpy-block-partitions-cmdline-ibm-v1-1-154dea8f755c@google.com>
Subject: Re: [PATCH] partitions/ibm: refactor deprecated strncpy
Message-Id: <169274934932.113461.1025457818715758046.b4-ty@kernel.dk>
Date:   Tue, 22 Aug 2023 18:09:09 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 22 Aug 2023 23:59:26 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ the case for `strncpy`!
> 
> 
> [...]

Applied, thanks!

[1/1] partitions/ibm: refactor deprecated strncpy
      commit: 674576f8af1b34d7babade11082c392bcb6081b7

Best regards,
-- 
Jens Axboe



