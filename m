Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A06C3A5A7
	for <linux-block@archiver.kernel.org>; Thu,  8 Dec 2022 16:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiLHQ1P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Dec 2022 11:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiLHQ1E (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Dec 2022 11:27:04 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC036FF00
        for <linux-block@vger.kernel.org>; Thu,  8 Dec 2022 08:27:03 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id z9so1226410ilu.10
        for <linux-block@vger.kernel.org>; Thu, 08 Dec 2022 08:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGASGdT0r7NnaA1e4kT6G5JiKwWgMW8ILoizErp/fuA=;
        b=3cTmyGd7FiNaOd4/sthMFl990S0QTtP747E5NX3mtjTVd8iTdTnwR3pgcy/Qys0cO9
         faIqpdtoDWkJdKzd6wVT4kaXnz7ODbkhdWHZ27ATrsdgYcYqxV5K9JkSEivflyXztXXZ
         981U95OZZptesAhsvqD2D/kjcv0L0l3oxa8T7oTzk4hrRunjRckDcu+wAdA5UcanTc6p
         /jE1RH9RYBN9RCFBB4OJhSa19D6fGkEzRTO9DIccojqIVoiyQhj1GETx0KKUz12wuP3D
         bw7/TYwQGv4Zhwcgt88TAKQQxFEoGfwl3CDKVxjkuFgNu0vW3bi+64K7MXcwE6Zs19LW
         rduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGASGdT0r7NnaA1e4kT6G5JiKwWgMW8ILoizErp/fuA=;
        b=QDwzigyx9D4ca3aMencqfYYeb2hlOXfE63+j8TYSieI4J2pyqfnG2cs1Q7Gy9fGSku
         SHmT07OsPsMcLRRxPwTGVANIzwyXS4odZGi/8QecsSCl+I3bWtEx6FGMhGU07thJxM6i
         rxcEFhd1UFvLjpcQTqyVNedFPyZswp3UTIegx2/0GyovqB6Sv2eRWZa8LV0Xn9mjCgsC
         A4tNgDAOKVZE+9WvvqzMR8SbM0Mufd9jQqq0+ujek2dqjLNU/6xQm1shxU1A/SpK58UI
         J7abvlic0tXEPYyJv9X8e7Sfs0R0iFUFcDw9S4bgozJR0Nq/t5SXIEU5c4dtd/jpNZx0
         pkUw==
X-Gm-Message-State: ANoB5pmeFE7v6Xbp3JlLFG2ApbCXNDZAYOUfhc92C75Tj81fitRA1xJq
        R8O8wl/2croKvu3oU8s6lhu9yw==
X-Google-Smtp-Source: AA0mqf6Ob3YAi8F6yT37MUpRm8pcfPCY/knzinw6rL7EeVxhm+NGLSkCMgPpGmDYfDo8gge8xn3VAQ==
X-Received: by 2002:a05:6602:2109:b0:6e0:194a:4f47 with SMTP id x9-20020a056602210900b006e0194a4f47mr6359294iox.134.1670516823258;
        Thu, 08 Dec 2022 08:27:03 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id l10-20020a92d8ca000000b003030d8b3cb7sm882758ilo.42.2022.12.08.08.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:27:02 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     rostedt@goodmis.org, mhiramat@kernel.org, acme@redhat.com,
        mingo@elte.hu, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Jihong <yangjihong1@huawei.com>
In-Reply-To: <20221122040410.85113-1-yangjihong1@huawei.com>
References: <20221122040410.85113-1-yangjihong1@huawei.com>
Subject: Re: [PATCH] blktrace: Fix output non-blktrace event when blk_classic
 option enabled
Message-Id: <167051682259.135565.3126267294037734458.b4-ty@kernel.dk>
Date:   Thu, 08 Dec 2022 09:27:02 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-50ba3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 22 Nov 2022 12:04:10 +0800, Yang Jihong wrote:
> When the blk_classic option is enabled, non-blktrace events must be
> filtered out. Otherwise, events of other types are output in the blktrace
> classic format, which is unexpected.
> 
> The problem can be triggered in the following ways:
> 
>   # echo 1 > /sys/kernel/debug/tracing/options/blk_classic
>   # echo 1 > /sys/kernel/debug/tracing/events/enable
>   # echo blk > /sys/kernel/debug/tracing/current_tracer
>   # cat /sys/kernel/debug/tracing/trace_pipe
> 
> [...]

Applied, thanks!

[1/1] blktrace: Fix output non-blktrace event when blk_classic option enabled
      commit: f596da3efaf4130ff61cd029558845808df9bf99

Best regards,
-- 
Jens Axboe


