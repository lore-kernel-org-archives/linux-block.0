Return-Path: <SRS0=CCtz=CH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F7AC433E2
	for <linux-block@archiver.kernel.org>; Sat, 29 Aug 2020 16:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F14B20838
	for <linux-block@archiver.kernel.org>; Sat, 29 Aug 2020 16:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="m+jv6bJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgH2QrU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Aug 2020 12:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728439AbgH2QrS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Aug 2020 12:47:18 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EE7C061239
        for <linux-block@vger.kernel.org>; Sat, 29 Aug 2020 09:47:17 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ds1so976106pjb.1
        for <linux-block@vger.kernel.org>; Sat, 29 Aug 2020 09:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5Rt5+Gjo0UGdPCISf5CydG1I/Z+wq56+kU1eC124qs0=;
        b=m+jv6bJZRhsllEVJr5l4EY9W/YKC3BAZMM01kcSyMJjFYDecSRzG/FmZTuCJs/t2ny
         OTZ9rLbXL2RR9XafeWT8qZMVX3EveS6Y24+PU4GHbshyYp9ee+dMK+C0YDAdbf9aKVfG
         jFqCByaqPcul+XLJJeoNuBseGgzPL/FnONYDc4Cu2YlXVbpi+Vb87s5ho1nAAniIHKh2
         KXR7ViPjwNUAJWYxoNcQWgVEZejYo15uNzb3F2nN2WGlqbFQbig7tdJIWt883ZSPHmjM
         5IySceO5HRVeWhmNoEcv3uAu5gm6m3KKHdwRHSbGF0wVoZVgzPve+VtbuXjvG8XJZ7Uy
         as5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Rt5+Gjo0UGdPCISf5CydG1I/Z+wq56+kU1eC124qs0=;
        b=NjCJDaZlJp4AuLe2sWB99GtGQEjeIm6ws27Nbjq5vFZk/voK1ht1PXTvSmNffhAId6
         hqGnTX119/Fclj0vBaXTiCEQfnk+K9cd0xrK9QUok9Om2ZfsBQ2bMrW/98sax+KiMmnD
         uTjl/h3c4QFU1s6WzxMZLlQ0rlBP6t3LjkpmH1GqKqlMECbVBiOiONP8AocjP3PuXICo
         zC1SOPW5pmLlSk+Sy/9y13OomQDlputS8A2mYGDcHEJqg7X1sLAFsZVQ4kV+N8rLc0pq
         TE0+mgONyPr50v2JhicESbLfl5hvQT8/4Ge65b7LMSGhbpdcoanVYwKoJzKIizgaRf4e
         IobQ==
X-Gm-Message-State: AOAM533Hs7+S7RhygVfoo4Cj9DQ4upVcvo7RhMHQSQ34qvJKv0kkCc+o
        eBnCOwf5sk3DGxrOW8qiByiOVA==
X-Google-Smtp-Source: ABdhPJwh/IaT8sjJze0JR0UOlWwMhEHIvT0ikyEXE/ycXPb0JRTnRL4uDSst200BKNS1envrwdz+3g==
X-Received: by 2002:a17:90a:c917:: with SMTP id v23mr3622499pjt.97.1598719634004;
        Sat, 29 Aug 2020 09:47:14 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id w82sm3114901pfc.183.2020.08.29.09.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2020 09:47:13 -0700 (PDT)
Subject: Re: fix block device size update serialization v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Xianting Tian <xianting_tian@126.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
References: <20200823091043.2600261-1-hch@lst.de>
 <20200827074758.GA8009@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b1960016-c265-1e1d-cfd7-de2330bc5eac@kernel.dk>
Date:   Sat, 29 Aug 2020 10:47:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827074758.GA8009@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/27/20 1:47 AM, Christoph Hellwig wrote:
> Jens, can you consider this for 5.9?  It reliably fixes the reported
> hangs with nvme hotremoval that we've had for a few releases.

I've queued this up for 5.10. I think it's too late for 5.9 at this
point, and it's not a regression in this release.

-- 
Jens Axboe

