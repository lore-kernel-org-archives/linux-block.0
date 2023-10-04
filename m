Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7034E8FDC1
	for <linux-block@archiver.kernel.org>; Wed,  4 Oct 2023 00:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238883AbjJDAXf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Oct 2023 20:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238655AbjJDAXe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2023 20:23:34 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5018A7
        for <linux-block@vger.kernel.org>; Tue,  3 Oct 2023 17:23:30 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1dd22266f51so259120fac.0
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2023 17:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1696379010; x=1696983810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ez26gy9c2AmSrsb9lxv7cbyOXUyAR+EWcPzvcDK4+/Q=;
        b=k6Hk7RYRluehQ/L1AGA5Owg/2NyTDLgpuKvzty9uPFr1C9nBE6zs7QoQsgXHVjCrp6
         Phi9BbG/IVeGs6hPWqJePPk0fEKhhIVpPj+Fq3N2r9nHk28/7vRpTCeoncRVevp3YB80
         nutPpuDZIt2g/oWmpWnbqDE3P6fsUQ4n0T9WC77v6pAI7e8SUW7BhAjjYV1aBlgsvAjU
         yKOhWA6gJBL0bLS09jpOAyqVEnr0j+sMhZsOiVHhTT+ixmfzfbgw+pKiILJ/ZQvy+RpJ
         8l1ZtwmiV7goNTVQ/wiFsBWdaUHKP8W0C+fUwV0PS8v/TogX5TPWlAR1gwfuFHdgR+YS
         6hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696379010; x=1696983810;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ez26gy9c2AmSrsb9lxv7cbyOXUyAR+EWcPzvcDK4+/Q=;
        b=qhpcG1K+n3UgdOieO3L4+kqXy9dzfDf4LhM74wQl+xDtAmSB4swzz50Z9N+kEqYokI
         vkGjFgMejeYqzZuaYiiHWrcY4hX1pEsxijl5dz8Mdp/CE/uj6LXsMbHw7c9yym49re1O
         NGjK/QiNgC1QqwooJn3d/FqkK9pk3ASAfGokXdNgMksmPPCDeZ0a3+fyzAZIRTyU8j95
         ctML58ft6wSh9OOo+pPYMlkAR1Q83tsHcWhNuiHJ4LDjn3U/Pj7rFEWpY+CxxF7+iIQ0
         2x+bwM8yjCTsI9EhClfDbyPrixfru7LPL4f7s8lxvnQwc4ND1tcwGpDfz8s6zgZTSES2
         f64g==
X-Gm-Message-State: AOJu0Yx4lF/aX/B0fEBUP6dRyL40Z1p9noLkvxERJuPlzcKH1TfgmZZA
        Uek2+6m+umTr/7RuvdUGexJMLw==
X-Google-Smtp-Source: AGHT+IEDW1m23bvF/k1OZ9I6cWgVW5H46waJxGasAHFfhJcL1Wwh8860VLpbRJWvqimsjoNJe/QKjw==
X-Received: by 2002:a05:6358:830d:b0:15e:5391:f1e7 with SMTP id i13-20020a056358830d00b0015e5391f1e7mr522434rwk.3.1696379010016;
        Tue, 03 Oct 2023 17:23:30 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id z11-20020a6552cb000000b00578afd8e012sm1721966pgp.92.2023.10.03.17.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 17:23:29 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Justin Stitt <justinstitt@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
In-Reply-To: <20230919-strncpy-drivers-block-null_blk-main-c-v3-1-10cf0a87a2c3@google.com>
References: <20230919-strncpy-drivers-block-null_blk-main-c-v3-1-10cf0a87a2c3@google.com>
Subject: Re: [PATCH v3] null_blk: replace strncpy with strscpy
Message-Id: <169637900876.2061762.14731877442734988774.b4-ty@kernel.dk>
Date:   Tue, 03 Oct 2023 18:23:28 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 19 Sep 2023 05:30:35 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should favor a more robust and less ambiguous interface.
> 
> We expect that both `nullb->disk_name` and `disk->disk_name` be
> NUL-terminated:
> |     snprintf(nullb->disk_name, sizeof(nullb->disk_name),
> |              "%s", config_item_name(&dev->group.cg_item));
> ...
> |       pr_info("disk %s created\n", nullb->disk_name);
> 
> [...]

Applied, thanks!

[1/1] null_blk: replace strncpy with strscpy
      commit: e1f2760ba3478fa3f8c48db8e91fbe3df8bea2f8

Best regards,
-- 
Jens Axboe



