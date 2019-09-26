Return-Path: <SRS0=S7xR=XV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C44C432C2
	for <linux-block@archiver.kernel.org>; Thu, 26 Sep 2019 07:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE7E222C3
	for <linux-block@archiver.kernel.org>; Thu, 26 Sep 2019 07:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VFGoxo+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfIZHMm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Sep 2019 03:12:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34584 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbfIZHMm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Sep 2019 03:12:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id y135so5874968wmc.1
        for <linux-block@vger.kernel.org>; Thu, 26 Sep 2019 00:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u/+FmsO2fNzcsmYglT3xz6RDpSXgM0989c2PSz8Zvf4=;
        b=VFGoxo+2NsxxwxjafuC2PpLHAFStjdosoGEbFmrM8SZ3rrImY4Sqc1/3J0DL/nSiek
         cKXmLnyFis+D0MbKrVE0ATCMolB8ETO3TmYRdu83WYIqnQN2/9Kr879GEZ2XHDJJp0Np
         sfEk1iSsp2VIf4BX2N7yHGkfOznLAcThCZOePG9i/g9qzTRvaEjv8bR5rGYL86uzXlQx
         FVWTg05Jc+tDb3dA6Y661ABAFal9Jdn4j3GNAfXvyNBLm7YFtNgG3YtiZnpvk0ZpjpRu
         SfIdUGBrMNXSt8Y7+NgK6sl1kd11BTn6K3rme6akMMJnevDRjfsXmJnf+0J+hfgcnGmm
         f3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u/+FmsO2fNzcsmYglT3xz6RDpSXgM0989c2PSz8Zvf4=;
        b=rg5st0nGqN89FAuWnc+kOH5kvWXO9QG28WumUvZe25/BxW/8aqwIQWBhu1+QQGyg5y
         3GU1gu4zejFBQP8xfRHyyGJe54PGVSS1NzPQQ43eOvZFfO8KP9ahI4TRM1KHutB9E421
         t3aBm10vnsYtGYUHrET8v36Uu7WSd759B8MDtt+RaQryC/aBqeWCIYy/Z2BBvPlly1de
         Pq4IU1bFSEya+x02F3TvSRBM2zE0ZbCMHaknQtTuf/ici8uCtnrgH/0neZMSO7Jquo0+
         emE8hxXb3v/86RaCTO+XgOq1pdcnhwulMr2QS43FJmsOjpYMCEMwYWLyA06wlD1jI2rC
         qvaA==
X-Gm-Message-State: APjAAAUrmciosPj0cRFC0I6zZcUzjp+eAA7w3ZifB/uJrNHWeYQAXIg6
        GfyXobFMwQrxpycmp1u4J9glag==
X-Google-Smtp-Source: APXvYqxUdYUgUVi64u3ylV/Yid+SC9QyZEwS24BKb72e7Ncis6ktKTA6eLgV/hoc7bSxXa1p5PZeZg==
X-Received: by 2002:a1c:7c15:: with SMTP id x21mr1547161wmc.36.1569481960055;
        Thu, 26 Sep 2019 00:12:40 -0700 (PDT)
Received: from [172.20.9.27] ([83.167.33.93])
        by smtp.gmail.com with ESMTPSA id a14sm1398033wmm.44.2019.09.26.00.12.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 00:12:39 -0700 (PDT)
Subject: Re: [PATCH 1/3 for-5.4/block] iocost: better trace vrate changes
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org
References: <20190925230207.GI2233839@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <310739da-b606-6485-9979-9bc03a592265@kernel.dk>
Date:   Thu, 26 Sep 2019 09:12:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925230207.GI2233839@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/26/19 1:02 AM, Tejun Heo wrote:
> vrate_adj tracepoint traces vrate changes; however, it does so only
> when busy_level is non-zero.  busy_level turning to zero can sometimes
> be as interesting an event.  This patch also enables vrate_adj
> tracepoint on other vrate related events - busy_level changes and
> non-zero nr_lagging.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> Hello, Jens.
> 
> I've encountered vrate regulation issues while testing on a hard disk
> machine.  These are three patches to improve vrate adj visibility and
> fix the issue.

Applied 1-3 for 5.4, thanks Tejun.

-- 
Jens Axboe

