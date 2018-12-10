Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8FCC65BB3
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 15:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C622081F
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 15:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xG6wocbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C622081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbeLJPf1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:35:27 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:47052 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbeLJPf1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 10:35:27 -0500
Received: by mail-io1-f68.google.com with SMTP id v10so9015419ios.13
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 07:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:references:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rp9NjtwTLvLkq9bO3C+o2UEkLnn3En9h9N7awG2ucfg=;
        b=xG6wocbBg6CwbQv4kc4dqHrQJ8K8RQdj6EVROtt3aS9NNu4MWE6HqIclCzI3Fm+gOC
         wLAdEInG4cQyOMNXcfoK/c+eXbrVjtaWUev43oM81s+JyWtdNp56vUmlz745KuIoXBRo
         BxYWItDc8KEqIN44iMH4OYpnj+h7eCaFKLcp76TGYNDdnxPLottqonStpbJbxstFkXIt
         e344igm3BZ0HSJOVbe6Ct5FYII+fWRDul66wKGBal1X6BxudxjIPjO6dUWgdCA+Q8Z8H
         oK/s8U6pdzmJARmDv+SCXDVa/nm9fFEPrHx+VCiTHj+ixm8ww1QQ2EnRgtcQmERBJvrv
         H+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rp9NjtwTLvLkq9bO3C+o2UEkLnn3En9h9N7awG2ucfg=;
        b=hfvvE94rZWDwElvN7mkC4bjpKp5CzYcqrfMmLCmva50d7qEqb8rTbqrFIYRfzIMiZQ
         cPUYHx91+bwAndgLr1+TwfHk9uK/2DpRiyYJhLpPLrCG88o7ZtCp4iTSgUMTBpD1aK81
         2MeQ7WQvcpAc7D5kePyIP+OrXeuT7LwMrxqMFKKuA9lfV2IsTnw2wl3owzmVnYcym4F7
         8KfL7jxRSm5S3AAS+0ENcbPixg+BWFvxXos0IkEOQTIhk0IGmeo/75TZOu2yEwuad+1D
         Nh1XnGV8H+itTQg4OuvEiv/UBkxbFRNLo1c8/f3JQhMmTc6xqoKzD2Moms7W/IADNlwc
         T7hA==
X-Gm-Message-State: AA+aEWbfPy7qHl5MudafBrbZs5mYdZX2nc4i4kCLcm+jAferzoJ+B45t
        PBJ/WzsRqiNq68aGnR39COdeXL3DjO8=
X-Google-Smtp-Source: AFSGD/XsiUZ4EDwlFh3+I1fpfRJBVhxzPd5gx5FfC3gqm0UlSq+7o8FeJ9P1SQXElsUpotUG9Ch68w==
X-Received: by 2002:a5d:8609:: with SMTP id f9mr9100514iol.275.1544456126241;
        Mon, 10 Dec 2018 07:35:26 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t2sm5292119iob.7.2018.12.10.07.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 07:35:25 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 0/7] per-cpu in_flight counters for bio-based drivers
To:     Mike Snitzer <snitzer@redhat.com>
References: <20181206164122.2166-1-snitzer@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Message-ID: <2dc7bd99-200b-6239-f604-c071c2de55a1@kernel.dk>
Date:   Mon, 10 Dec 2018 08:35:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181206164122.2166-1-snitzer@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 6, 2018 at 9:41 AM Mike Snitzer <snitzer@redhat.com> wrote:
>
> Hey,
>
> This v4 addresses the compile issues on various archs when CONFIG_SMP
> isn't set (by introducing appropriate wrappers in genhd.h)
>
> Testing with this v4 I was unable to reproduce the issue you reported
> where iostat always reports 0 for avgqu-sz -- but please let me know
> if you still see problems like that.

Looks good to me, and also passes my testing. Dropped the mq special
cases and used this in general, also works fine. I was hoping we could
get rid of the tag iteration with this, but that still seems to be more
efficient for blk-mq. But at least we're better off for stacked devices
with this.

-- 
Jens Axboe

