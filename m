Return-Path: <SRS0=Ukdl=Y7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE330C5DF61
	for <linux-block@archiver.kernel.org>; Thu,  7 Nov 2019 19:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9851621D7E
	for <linux-block@archiver.kernel.org>; Thu,  7 Nov 2019 19:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LgVB184n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfKGTI3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:08:29 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44700 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbfKGTIU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Nov 2019 14:08:20 -0500
Received: by mail-io1-f67.google.com with SMTP id j20so3253836ioo.11
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2019 11:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6tc+3dFnObbCsZTOmcaVyw6tfhQMQsGco5do8dKeQEQ=;
        b=LgVB184nuWNpFfGTtXqtzbPQCgBsxaiS3I2ido28o3uv6Be63L007ZEgJmeI4p0/bU
         gZ6XCsGvaUXpCS9kQrcCCvJGsC6gBbU5UgGuwiQXUL2Yq7wIEFglIILOgZw8P9sQ59j7
         DVtDRA39e/w+eVu+5Fh80AmOIS+cIts7L5UOC6aEPlA7E1tDZ3rxeD/TiAUidkN3wOUr
         1nHZaIYFTXT5S+tb7PTGosHYi4WLU/P4nMLLf2YXPVRMFdaZd4mZ8LM0dz/v2xb6ZclM
         3VZLjZEqUWsplJQaLrY2K2NJQ4QLwMKeezr3/t5BIKT6nsMzzJ4vjASSNPhTr64cZv0u
         0dSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6tc+3dFnObbCsZTOmcaVyw6tfhQMQsGco5do8dKeQEQ=;
        b=ae7Ymnwejgt1x4pMaAxPAC41CcQpYVxk/DhnAI1lYR42eF+AYlsB20ktWBQt7qI0mK
         7ZEF+c763DnatAYSfXQkTxseknySr8FxVbIUutf61pubZSpmviVCP883bHR0L2gNCL8o
         cXarLbPJdGM9QMcG/a0P2qqvVO53Q7AQRwx9xAREp7FWjdYNcDaL4XBr3uzaUDJqQtDG
         PhfL/GhphazvurDLaBCL/4/1dyJ9rUcnn7VtLFz6QlgupV9tpk6xKc8Wd4sIkStjOss8
         tkKEwEHyk8OKPh9RtCmnErE7xco7LrFaRLBgvMrSVhQTcBGjHOJBlOG83b5IV9rOONj4
         Ellw==
X-Gm-Message-State: APjAAAVu5x6yapbu8ntIRIBRjlmJFbyp+wEj5YvDtk2Vh04K83TEe0lJ
        bi6nktQgL52OimiqFLHgsgyHQ0BJ3C4=
X-Google-Smtp-Source: APXvYqx5C+YXiG1tSukATm3surkdJTv8OYGBUPh1k6tE3QzNgmrmLWbq9IaV79OTLCPZKjDdSzPfLA==
X-Received: by 2002:a02:b710:: with SMTP id g16mr3463376jam.111.1573153698830;
        Thu, 07 Nov 2019 11:08:18 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r1sm237453iod.69.2019.11.07.11.08.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 11:08:17 -0800 (PST)
Subject: Re: [PATCH 0.5/5] bfq-iosched: relocate bfqg_*rwstat*() helpers
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, kernel-team@fb.com
References: <20191106215838.3973497-1-tj@kernel.org>
 <20191107190459.GA3622521@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4d34b6a3-b141-f0fe-c7e1-e68e0fa52cfb@kernel.dk>
Date:   Thu, 7 Nov 2019 12:08:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191107190459.GA3622521@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/7/19 12:04 PM, Tejun Heo wrote:
> Jens, this is an extra patch to help fixing the build bug when
> !CONFIG_BFQ_CGROUP_DEBUG.  The git tree has been updated accordingly.
> Please let me know if you want the whole series reposted.

I seem to run into issues applying the series with the 0.5 added first
and with the updated patch 1. So maybe a resend isn't a bad idea :-)

-- 
Jens Axboe

