Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B99E8FDBF
	for <linux-block@archiver.kernel.org>; Wed,  4 Oct 2023 00:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbjJDAYF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Oct 2023 20:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238655AbjJDAYE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2023 20:24:04 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEBAA9
        for <linux-block@vger.kernel.org>; Tue,  3 Oct 2023 17:24:01 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c746bc3bceso3289235ad.1
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2023 17:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1696379041; x=1696983841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+5Ev8JWtX66U66pqJ0cubLluMVIrf54bZdgwJ7z1Ak=;
        b=R/HoyXxxAEP3kkZLfR3iS1pHFGv8S1VtXsck6cLhsWAX7OlcWwoSfrDvIfI1dl2P8F
         d5zKFM+hasB0Qx0Uw+WhVzSR/4McPloibAnCpKdOaLDupbgY4W++f8+XdAL8918V9b6q
         0jPIXcgMaB/vyokc155iZFt/gjXZLYl96U6enQatTeLqo8QKqV3HlcW/JA5NUgHBzJRc
         lec9ILki6Ctpc0iwzro7krpbR83Nhemc3m0pmmrJG4raw34aV4glr1IuMYYreNhyr2YO
         n8hLL8gZc/bvs7nTZ058S3OitX6CBsScXg1GbKHLGbRsvytwh1DooSsiJD6bwiNXdVk+
         zy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696379041; x=1696983841;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+5Ev8JWtX66U66pqJ0cubLluMVIrf54bZdgwJ7z1Ak=;
        b=RlyDvjj50WcXjCKRtbOI2XlsMlraGC9hw72a2jsIRJubQ6u/qFbaNfkl/hE9bCXuZZ
         nNXIYcleETZcZ+b8nh3rtZ2mKB2FrKd/eWesOq5hIYC+qr+yA26076av+ySnEYaIUzGe
         9ATSV4snW/nVp0otcayWEQ/u9cs32dSc3hVHdY+bjuG+wCAEfXEzizm86gO3RGSM8NR7
         xJpHJx/2h0fCIUbOHVO1tKt4RO0184pqfyLDqKkonCdSWHXPsMjEphLTeza3ENrd7ZSz
         WkpdiBZkUJZ81V3mXFHmWZIfuWC0kpYZysKw5gwcxz7UU7y0jwLlT9i4eHOrk5+/DBRX
         l1fw==
X-Gm-Message-State: AOJu0Yw1W7+GpiSrCiIR1EN6YGkBY5Dsy/pC58BQ+VXRoM/y+y2TIuuq
        +EErzg6yuXp2WF8Y5XW75K1v4w==
X-Google-Smtp-Source: AGHT+IEvQwCu5KlFSVrIsyfFD4FEedBJjE5H3J5n5+KArZ9kYYzxcWis1JxMvNXNH05ayQypBqz28w==
X-Received: by 2002:a17:903:22cc:b0:1b8:2ba0:c9a8 with SMTP id y12-20020a17090322cc00b001b82ba0c9a8mr1114184plg.2.1696379040778;
        Tue, 03 Oct 2023 17:24:00 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id y20-20020a1709029b9400b001c0a414695dsm2241525plp.62.2023.10.03.17.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 17:24:00 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Justin Sanders <justin@coraid.com>,
        Justin Stitt <justinstitt@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Xu Panda <xu.panda@zte.com.cn>, Yang Yang <yang.yang29@zte.com>
In-Reply-To: <20230919-strncpy-drivers-block-aoe-aoenet-c-v2-1-3d5d158410e9@google.com>
References: <20230919-strncpy-drivers-block-aoe-aoenet-c-v2-1-3d5d158410e9@google.com>
Subject: Re: [PATCH v2] aoe: replace strncpy with strscpy
Message-Id: <169637903951.2062263.17214636672785738003.b4-ty@kernel.dk>
Date:   Tue, 03 Oct 2023 18:23:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 19 Sep 2023 05:27:45 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> `aoe_iflist` is expected to be NUL-terminated which is evident by its
> use with string apis later on like `strspn`:
> | 	p = aoe_iflist + strspn(aoe_iflist, WHITESPACE);
> 
> It also seems `aoe_iflist` does not need to be NUL-padded which means
> `strscpy` [2] is a suitable replacement due to the fact that it
> guarantees NUL-termination on the destination buffer while not
> unnecessarily NUL-padding.
> 
> [...]

Applied, thanks!

[1/1] aoe: replace strncpy with strscpy
      commit: 5e9b7cfc209b84d135993b8cb75ea383f24b2bba

Best regards,
-- 
Jens Axboe



