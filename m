Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21FAC43334
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 13:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbiFQNUP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 09:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiFQNUO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 09:20:14 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CAF5EBEE
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 06:20:13 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id u37so4177394pfg.3
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 06:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=QnI6pz57NQWdAoVhfY8g6Ic1NYrdDscUi64+n3ALCRM=;
        b=m619SZ31xH0CvhwsurSYUtRYfqObRmCKaEFrlTr0d5hyu6LhLWYD0GJh4InZ8N2tu7
         U/3kpPvpJTurxbwd5aclFW/aZ4/wx5GlR89MRolMd9fs0F5xqC4BWijF4vltoQYY/7dn
         9jC+nGK3AxdV0kPTbVZUCbcNZC00o9kUE3RLCd+Xswt0oUQtTDheR7xGxvoh5qKrjRT+
         d7Str0D9t1UplN7m9pJkMJKRDzQCXBt25X/EHUN3E7LHcQiVrEgZug7nd6eFAgxRsQOX
         9NxBzwkLDrWARvdjPuvfp/O3yG6962YDt6wwHNW00pygSLA0FcHVLuGyaNkevBMxTBh3
         +KmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=QnI6pz57NQWdAoVhfY8g6Ic1NYrdDscUi64+n3ALCRM=;
        b=Rhju8/QFYVzbRgi/MedTUquh8g3878i9Cx24XHfx4nQgSqrye33D2h6B0WaQimoA1e
         zwEjmvQzBXNjcRCeav0Vph9jZtRdE1D2M3Pb6gUOZJLCh7aALD0++kYkzSpMB//Qr/9P
         6HdYK54Cmb6rwc7D9p6LF+7W9JqhvmFoYCtOy6U80uCDxBmGENaNHgyR0nMy+qjZ4LuV
         0P7oJyr+85crMa/j34/ukQU1PXPSwcjXneJAQLPtaE8wEoMwKz6hCKOkuibxhawjfi1A
         yGagH+vZQ7CWK8WLu/g9LiSIcoy/NHi9ck7wPhy0a1ACAM0WQ3Ojl6AS9bRYlqH2xbLj
         C9UA==
X-Gm-Message-State: AJIora99c/iVhXNvQ8NnVPn0vEgMVI2gnwMuKsv8mplJtZkbN2DeFB/z
        ymQEsLl8wjWGk4wIO/uWYuicVW8JKAcjHg==
X-Google-Smtp-Source: AGRyM1tptRrsf6Q3nqHH0rD+ocB+quW8FtFhM2hGszL4JXqC8vrMxNLKiYqTBY8pWC2LEQ+ua0mxVw==
X-Received: by 2002:a63:604:0:b0:3fc:8830:a67c with SMTP id 4-20020a630604000000b003fc8830a67cmr9002146pgg.402.1655472011447;
        Fri, 17 Jun 2022 06:20:11 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jj21-20020a170903049500b001616e19537esm3500969plb.213.2022.06.17.06.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 06:20:11 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     zhenggy@chinatelecom.cn, paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org
In-Reply-To: <1655461684-19075-1-git-send-email-zhenggy@chinatelecom.cn>
References: <1655461684-19075-1-git-send-email-zhenggy@chinatelecom.cn>
Subject: Re: [PATCH] bfq: Remove useless code in bfq_lookup_next_entity
Message-Id: <165547201071.352991.1371333987869154505.b4-ty@kernel.dk>
Date:   Fri, 17 Jun 2022 07:20:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 17 Jun 2022 18:28:04 +0800, GuoYong Zheng wrote:
> It is no need to judge entity is null or not here,
> directly return entity is ok, so remove it.
> 
> 

Applied, thanks!

[1/1] bfq: Remove useless code in bfq_lookup_next_entity
      commit: 5eac37b6ef5fffd617e1befa119274f9db747569

Best regards,
-- 
Jens Axboe


