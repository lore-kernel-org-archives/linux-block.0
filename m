Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D020C433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 21:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbiBOVO2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 16:14:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240516AbiBOVO2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 16:14:28 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B560C7E09B
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 13:14:17 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id h16so1263770iol.11
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 13:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=XXedcp2yhbUzo3O92znwEibtv2eEO56xS91b3yWI2ys=;
        b=0ZBGtyXpprvtwB02Ug9plwdlXTZcNgMbVrrfq+GoCMWZsFy4kMhFPR7Ik6GYKsdWWm
         8apaMiJqABQECCkZYmE9EiOcpwvPr/is8h0+UHwGOiQP+w2GavCXrykeRgJ3xVqO+tha
         /A+W/eXYZmW49+PRRnIzK0IUMHotFOGZHJv1EOQT749nDlTZyVsROay0wxzG5KdxVcni
         lCifbH5uZtwvXmI9r1oCfmotaVmTwcLQniKLwKT2Lz11TZ/G9p4iUjmeAewQJoAwU7b4
         wz60283Of2U+JnK2Hh6lvdOPr36mjlvJe6PwKH3+NbchhhoCL3VoaCJBt3PA7t/EjDlB
         bYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=XXedcp2yhbUzo3O92znwEibtv2eEO56xS91b3yWI2ys=;
        b=rT7J6SLq5cMEiwLhSNyuibZ5V/JLHD3Eea8KGT9cOcMWBzO9dyCpQAFSV5HRLsWJ3J
         FGDFiv5GYUubH3de+L9lvzwX9r97/ps/OaBAG8ZsBgQvIW6io6ljECNdSPzZfUWmg/Ts
         +Ct4R7M2xNmRRuafgCArUpgmNGXG2mxjEHU3GTC+w1AWTMFUQnWb0CaLIJWw2kKdPlR1
         4kf7VD4ZCZTM5kfpTQsWbrvZxb55tNqsM2zzq1d4S3z/hNlpq6v/z491vU1r+0V66Gk4
         t7mXIq1dm4fLIIRFki6RZii0luhQR6+ldEg0UgdslTxT2T+rHsqG+tmLjCKfoYWM5Fnx
         ZH1A==
X-Gm-Message-State: AOAM532bNZ/RQa2gcYj+Z810cbilHomxQk0PT66TMeryFoZ6ddFD2s4c
        B4DVb5UcMLPo1wDEZSfpJmW4Wg==
X-Google-Smtp-Source: ABdhPJzoYPw1Q4I4tDZdScQxnpjehFexgVWCQnCHRKpXjX7xIIZqHvMbhqxNZ4eJvcYXakCkhL59uA==
X-Received: by 2002:a05:6602:168c:: with SMTP id s12mr486266iow.100.1644959657041;
        Tue, 15 Feb 2022 13:14:17 -0800 (PST)
Received: from m1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b6sm23928798ioz.43.2022.02.15.13.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 13:14:16 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, Chengming Zhou <zhouchengming@bytedance.com>,
        boris@bur.io
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220213085902.88884-1-zhouchengming@bytedance.com>
References: <20220213085902.88884-1-zhouchengming@bytedance.com>
Subject: Re: [PATCH] blk-cgroup: set blkg iostat after percpu stat aggregation
Message-Id: <164495965641.2684.16928611518978800084.b4-ty@kernel.dk>
Date:   Tue, 15 Feb 2022 14:14:16 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 13 Feb 2022 16:59:02 +0800, Chengming Zhou wrote:
> Don't need to do blkg_iostat_set for top blkg iostat on each CPU,
> so move it after percpu stat aggregation.
> 
> 

Applied, thanks!

[1/1] blk-cgroup: set blkg iostat after percpu stat aggregation
      commit: f122d103b564e5fb7c82de902c6f8f6cbdf50ec9

Best regards,
-- 
Jens Axboe


