Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0567CCA47C
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 14:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiFWOXf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 10:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiFWOXf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 10:23:35 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AE433A14
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 07:23:31 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id a10so21117896ioe.9
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 07:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=5mKIV7CULh3Dmn1jAWt9yxanvOIpmC+KdLcwETV5Qi8=;
        b=7Q2GKdnxW6Df5G/bf1iNONBtGoIHgM59P/8JJirSRmMieeChM+SJewmrbcijh5I+qg
         zu42dcDsjaa7ZNHJMIcn8kndwM3rwf2W1YGzTiW5hcB6334w01xvKqed+xq8WAvS6wMb
         KLdz3It8AXJGgUK+g+0cTZI6J34gSkY7PcnyEuPegOtGKyjaUjx7PUAmRaqdQCSf66Bb
         v5vml8LxNItpkUNX8x/qE5DkrP61hm1feUbEnC+DrctGYKrYMZYPwJJtTLlaa5t0ETPz
         Mc9qEOO+ToQIBxRIQvzoz8kEmeLeQd9yHDiQwKmaGNlTbGKWEfcVoU0CFzOSY/TDN6dt
         bH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=5mKIV7CULh3Dmn1jAWt9yxanvOIpmC+KdLcwETV5Qi8=;
        b=VUrp1deNcaB1e1proR7dV6dewUpq0r/++hQhIXz0x4lBG8JjQjkk8gaijKH9isovVv
         DDJo6o82Si3103E4zJ6/9HYqXguKaaPHl2Dv7bY+OJIYWzWVneW+5q2EXxN1RwyX9GjR
         MEnvayjVXe9jXONH3rkRu2dbG1I4xFwZuVz3tqc+V3bguJjVVdonqgEsHeItWSNC6ntd
         AMxqlXjH/TA0pg6fmX+RmK1mV8t0p7jCQLhawl/NdS1LP0Om0tDJIbYOVoIXp6f9SrHm
         6fcsK4GWhDjopxhwd3NcFZSA9WOpiBVbQ+QcVTMmtzy4TzKnYB/UX5JR1MyU5fcQbmkq
         M5Iw==
X-Gm-Message-State: AJIora+rc8JcuCu1Zm36mq840PxqZ0J4I7qQPbWzJdLRDhEvIh25wdKZ
        8HZ5FKxDYG7HvzeUOLxludoK1E53IMkJtg==
X-Google-Smtp-Source: AGRyM1tFHqZ7pfE4jikaP30O7tsYXsiWRBxLqekYCfwRUpp6biEOsjC0Ml9lawhSc4eKEKAEKPpW1A==
X-Received: by 2002:a05:6638:1a0e:b0:331:9a26:57c3 with SMTP id cd14-20020a0566381a0e00b003319a2657c3mr5500736jab.310.1655994210685;
        Thu, 23 Jun 2022 07:23:30 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b27-20020a026f5b000000b00339ec5b3339sm656175jae.47.2022.06.23.07.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 07:23:30 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     jack@suse.cz
Cc:     linux-block@vger.kernel.org, damien.lemoal@opensource.wdc.com,
        stable@vger.kernel.org, Niklas.Cassel@wdc.com, bvanassche@acm.org
In-Reply-To: <20220623074840.5960-1-jack@suse.cz>
References: <20220623074450.30550-1-jack@suse.cz> <20220623074840.5960-1-jack@suse.cz>
Subject: Re: [PATCH 1/9] block: fix default IO priority handling again
Message-Id: <165599420999.483324.5087264584005816987.b4-ty@kernel.dk>
Date:   Thu, 23 Jun 2022 08:23:29 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 23 Jun 2022 09:48:26 +0200, Jan Kara wrote:
> Commit e70344c05995 ("block: fix default IO priority handling")
> introduced an inconsistency in get_current_ioprio() that tasks without
> IO context return IOPRIO_DEFAULT priority while tasks with freshly
> allocated IO context will return 0 (IOPRIO_CLASS_NONE/0) IO priority.
> Tasks without IO context used to be rare before 5a9d041ba2f6 ("block:
> move io_context creation into where it's needed") but after this commit
> they became common because now only BFQ IO scheduler setups task's IO
> context. Similar inconsistency is there for get_task_ioprio() so this
> inconsistency is now exposed to userspace and userspace will see
> different IO priority for tasks operating on devices with BFQ compared
> to devices without BFQ. Furthemore the changes done by commit
> e70344c05995 change the behavior when no IO priority is set for BFQ IO
> scheduler which is also documented in ioprio_set(2) manpage:
> 
> [...]

Applied, thanks!

[1/9] block: fix default IO priority handling again
      commit: f0f5a5e24fa5412f187f429232334ad6832d1a66
[2/9] block: Return effective IO priority from get_current_ioprio()
      commit: 93fd10125cd702d86f1c4005349b54eeb3c02af3
[3/9] block: Generalize get_current_ioprio() for any task
      commit: 86f80bd5f639921c59afb113fa3ebb3ccb46be84
[4/9] block: Make ioprio_best() static
      commit: c85fb98c51a66ff7346f2e12f6c20fb4f60de812
[5/9] block: Fix handling of tasks without ioprio in ioprio_get(2)
      commit: caf2c269be20c536009ccd815a4e493d0c6c6634
[6/9] blk-ioprio: Remove unneeded field
      commit: d2adb01a5bcbe36bc05fbb383028da755f7a919b
[7/9] blk-ioprio: Convert from rqos policy to direct call
      commit: 8f3d8d7f56aba4c6171e48b107b9167255044653
[8/9] block: Initialize bio priority earlier
      commit: 92c3dfe1cfce7dd7cf6cd32b78b05885d824656e
[9/9] block: Always initialize bio IO priority on submit
      commit: 71ad7aabb8968164b1963fff7216b225fdd80f84

Best regards,
-- 
Jens Axboe


