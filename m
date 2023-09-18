Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7626CD37B0
	for <linux-block@archiver.kernel.org>; Mon, 18 Sep 2023 15:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjIRPwD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Sep 2023 11:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjIRPwC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Sep 2023 11:52:02 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBAC197
        for <linux-block@vger.kernel.org>; Mon, 18 Sep 2023 08:50:24 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c45c45efeeso923045ad.0
        for <linux-block@vger.kernel.org>; Mon, 18 Sep 2023 08:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695051966; x=1695656766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Vk4FgIcW1TSMW2JsWYrGwWF6KGqyDjo8gszSBQuYas=;
        b=J8SI1ZNIWJoyYw7zeYz+M4t2izbwYCaP5Qph5przJvpPWHkRu7KDZQsJwQe+whnafs
         AnkH2xxdixu/9mIp5VfzFMujIOlhl6l1LW9W7zoJ8KNwEV3TrsDZoUMfdEI4XRW0OUHQ
         t1qeH0gS+VseXehcNfsoSmeKkWQYLS4Pss0CPjCxj1R36LgSmqnkqWo3hH+e1MExrXOF
         Nsgo19IMwqoihjgMkcCd1VLJWtOaVtmsiTo7Oq+AgxHcQ6yrpYjJKVIZ72oVEMV7r1V7
         c4wtqtwmQRRLQGPn0Le3mMU4pI3u36Nvpr4+jVVnjJCBWG3ijbRd79Rwhl6piH2ZN1cG
         dl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695051966; x=1695656766;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Vk4FgIcW1TSMW2JsWYrGwWF6KGqyDjo8gszSBQuYas=;
        b=okFhS5RTqeEbHDoKw4wLTbWLOE1uj2gXpUylBjMVOQF16FI9b1n9BKrElMHxSUcwIQ
         CeljTjjihq1D69mcBNfZ2onJcWO5in8R3Yu18Aoc0egwindScE+zJMYfPkQV1RJGdB4D
         +ndaCJZze07nUzu3BnMky7Y80U7/ajN4pwQpuw5xQ8HylURqq52tE5ar8YndUHcjPamO
         LYITP7jVohq5Q42SLSAo7aSvNZaD9BmJOoWXtQNhatya7eGXNqGCUxkOaePQDzsxa5mQ
         ovUBT2JxZqYyHpNqG01r6KWPUk6K7jM0+yJOXqqo88p6CbRRDxSww6nbAF5yQc9cYXu3
         7hWA==
X-Gm-Message-State: AOJu0YxFvWNr6lzO6IXbkzsQ+WGXGl6nh8GpcA3beKB31lrcTIZV/3EK
        NsONIr0XZSkPXoP8jwDBktWnJ6YvxUrZQpppbCU+fg==
X-Google-Smtp-Source: AGHT+IF0ETGJxFGCPdWLjhdcq5kYB6tsNKFHCvPsF+dF0bkZx+4sJ6IG49WpbNpJND4QZJhorYYf7Q==
X-Received: by 2002:a05:6602:88c:b0:792:8011:22f with SMTP id f12-20020a056602088c00b007928011022fmr8546560ioz.0.1695045568156;
        Mon, 18 Sep 2023 06:59:28 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id em8-20020a0566384da800b0042b068d921esm2836235jab.16.2023.09.18.06.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 06:59:27 -0700 (PDT)
Message-ID: <a6dc1618-249c-48db-a7d5-fe0415ae2afb@kernel.dk>
Date:   Mon, 18 Sep 2023 07:59:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] null_blk: refactor deprecated strncpy
Content-Language: en-US
To:     Justin Stitt <justinstitt@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
References: <20230918-strncpy-drivers-block-null_blk-main-c-v2-1-cd9b109edfdf@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230918-strncpy-drivers-block-null_blk-main-c-v2-1-cd9b109edfdf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/18/23 1:25 AM, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].

Commit title again...

-- 
Jens Axboe

