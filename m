Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2CFC433EF
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 19:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbhKWT0a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 14:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbhKWT0a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 14:26:30 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4271C061714
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 11:23:21 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id k1so140289ilo.7
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 11:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=OwGxrt5dxdLYQL4ucMdskFmZjKSpW7HApnLSDjm1cTc=;
        b=WMmIx4ja5FNguCxrH/RdHUAGTrcr4m2JmFdSIgDRDetksTmjmc22WGlUaCeVFvBObN
         ZhB79KDQFF06lNQpGAi18MxWXBBdadYbiW6Oa/YYL8GsKbyDe5SV/Y/3H+53R086EeaL
         X9srQPR+GEjkIUWVbYa6EidwCEMMGdknpfWUMBMjTCyENp08VcsLhQCpvOLU0BUti0ki
         QQwwgmxdqzr7JfuzXOruwW+DUxmFckRRqeNzlQKm5QeBD8tQ6DZkCxYEZ17z1Gvtyyre
         ytwHtyq47TjIYFuHANq5IbfSoS/eC02yPQ3jRkVvH7AYCMmq/keYa0cnv6A2rjk20cAO
         /U2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=OwGxrt5dxdLYQL4ucMdskFmZjKSpW7HApnLSDjm1cTc=;
        b=p+6ZW/ce1wBHS+y/Jrk+cNcI8HweY37reS/Vjoiq4VOaCAPDduPjVQg3uLDU5pRegX
         HfjtebH0dk3jDa+q82zxsSaILvPwlbT0LFsOIm2Q5Q4ld8aHrZDzEmGoj+QifdB5v1PI
         3UgnfflCIYTE6mPWuuADgsv3LfBult+AewY1F7rpAkFx9uAlJCLnhMw6YmMMvaydh1ke
         zEO2FJfdY2tKNv2FroQlHiSyO5dTQjTqYyJxqXmmDWYLsWVQrkAJvuT3tuqaCz3AO2sA
         EGGFnr5kFMoPpCpkwmIi1A8qC7t7A72cJCafVO473Y7IVb3x8Je+RqkQE7fJekFaF5CB
         vBBQ==
X-Gm-Message-State: AOAM531DHK/1I1jaodeRpArzMSkcD/7N+/Ru7FkXYgDBbMJH+wEv4Z+W
        CVYBK1dP01BEbPVSGbNUuoDx/8Tc4bUKzDeF
X-Google-Smtp-Source: ABdhPJxtbW/8yyjLd426tCzPFl3H9zt+TsXyBdhAKp482KoivCsmJ8ibnaRYb3FaZeXqw5VRUoX1Zg==
X-Received: by 2002:a05:6e02:1847:: with SMTP id b7mr7867855ilv.23.1637695401064;
        Tue, 23 Nov 2021 11:23:21 -0800 (PST)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id w19sm6241736iov.12.2021.11.23.11.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 11:23:20 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Guo Zhengkui <guozhengkui@vivo.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
Cc:     kernel@vivo.com
In-Reply-To: <20211123063340.25882-1-guozhengkui@vivo.com>
References: <20211123063340.25882-1-guozhengkui@vivo.com>
Subject: Re: [PATCH] blk_mq: remove repeated includes
Message-Id: <163769540063.430590.3615645820510489074.b4-ty@kernel.dk>
Date:   Tue, 23 Nov 2021 12:23:20 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 23 Nov 2021 14:33:40 +0800, Guo Zhengkui wrote:
> Remove a repeated "#include<linux/sched/sysctl.h>".
> 
> 

Applied, thanks!

[1/1] blk_mq: remove repeated includes
      commit: 5da93d507fb52342f1a3245803bc088ca245f5ef

Best regards,
-- 
Jens Axboe


