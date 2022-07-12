Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F575C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Jul 2022 20:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiGLUjx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jul 2022 16:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbiGLUjv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jul 2022 16:39:51 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490714F676
        for <linux-block@vger.kernel.org>; Tue, 12 Jul 2022 13:39:50 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id b8so7703033pjo.5
        for <linux-block@vger.kernel.org>; Tue, 12 Jul 2022 13:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=GnU4+UsuMLHKK/2SNUMJrMPlV+rAC3v4haluyK3jv0Y=;
        b=h7SaNRyqO6FmXedci1wt+OWuhyN9R4tjZfppnwXHrV3MOu31tslDc5eB+iXIvnFEKh
         rr02vcEzfQyclojporOsKkLcjCvNf4WCC/mOV7ydTSy3FuJdBPgA0XmW0fPBfBf0YsCA
         K46MZH2YZSYFSe5/obP1pPajR9Sz1NCHwz7qIENQxuqfxAnmG7BhxTdNFMepjcK9zTc4
         ae6FbfMO1ORkPr2s9+DgIwRC01IBDQA+kc4TgkfIvnamED5xxZAyGjQwAhxpEQjLe+CF
         e6LqJ/43Bw1kXiLA37p00bXMcEbvQtS907MXS1ge+Yg/a5Morj4adzlMDOgxSgS1p9T5
         phzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=GnU4+UsuMLHKK/2SNUMJrMPlV+rAC3v4haluyK3jv0Y=;
        b=Fs8rdZaGlJa8Q8i5Uc7QC3/MVDwb4Hv7oGR8qkY4CtS+G7KzJhX/QiILwJ4HBZPjUz
         fOW0m4XyHMxPZ9eZWTzf+OHmR1o+sbDCWIuDCn4t8J6DdPw9xkV2KL/SDRxJFUMcAEHU
         UkDtMqpLRsAOW0f0OHSFkDbzoztBmNCJHzr+WX6QXoWPNa3r5VnwkfLP7m8kUV5C0jGB
         TRYLtVDL28SZgeGk4DKCgWmjbapjp6AlIBcuK7Fc+FSZH3tXEroBPh9RtS3tNfKRXtpg
         Caw66ZVTe5yx7L4R76FiphCjgfyM0dUjBl59laO0hKrlz68UxyJgtGc0SVW0+B5nGf6d
         joKQ==
X-Gm-Message-State: AJIora8tCi0wigzdNKtdzDWOpJSEfYowUS7wkiNKJex3O445zwwySmAt
        x8eCMCmipf4IuRu+F+4c3EJTHMXs8pFINQ==
X-Google-Smtp-Source: AGRyM1uilEx21kiIAKEvcWo8xUaisXaksezhUkTgwbFg4f1noN1lKAK2FLw+0Q7b5jG+y5k0HzsGdg==
X-Received: by 2002:a17:902:db02:b0:16c:5568:d740 with SMTP id m2-20020a170902db0200b0016c5568d740mr7980357plx.100.1657658389614;
        Tue, 12 Jul 2022 13:39:49 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902ceca00b0015e8d4eb2cdsm7312542plg.279.2022.07.12.13.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 13:39:49 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, vincent.fu@samsung.com
Cc:     gost.dev@samsung.com
In-Reply-To: <20220708174943.87787-1-vincent.fu@samsung.com>
References: <CGME20220708174950uscas1p28249281e53bc42b8e148bb76745b39a0@uscas1p2.samsung.com> <20220708174943.87787-1-vincent.fu@samsung.com>
Subject: Re: [PATCH for-next v2 0/2] null_blk: harmonize some module parameter and configfs options
Message-Id: <165765838869.44117.8384067765868369752.b4-ty@kernel.dk>
Date:   Tue, 12 Jul 2022 14:39:48 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 8 Jul 2022 17:49:49 +0000, Vincent Fu wrote:
> These patches add plumbing to allow some options that could formerly only be
> set via module parameters to now be set via configfs and vice versa.
> 
> Changes since v1:
>  - fix documentation formatting in patch 1
> 
> Vincent Fu (2):
>   null_blk: add module parameters for 4 options
>   null_blk: add configfs variables for 2 options
> 
> [...]

Applied, thanks!

[1/2] null_blk: add module parameters for 4 options
      (no commit info)
[2/2] null_blk: add configfs variables for 2 options
      (no commit info)

Best regards,
-- 
Jens Axboe


