Return-Path: <SRS0=/PDd=CJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79A7C433E6
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 18:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 830302083E
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 18:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="N/ZgTait"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgHaSKO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbgHaSKN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Aug 2020 14:10:13 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB8FC061573
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 11:10:13 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t4so1998537iln.1
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 11:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uRRvPiCxTh0cQCTrfg3Fth4VL9KJPMgKRrLomhiuBtI=;
        b=N/ZgTaitrtvhgydpuVRs73cHccBD3HThC2WI/5nr2T927O5UHXvvjnmXJuwqM7RGTS
         m/BWRm4qzmumdQrOkQiEDp9xoLS0KiZXIoNDdO138faEHaa4XRMg6onfj/kEbcuJoWF/
         nldbEn2OCx+Sdg02Yr9dPjBuYR9lFx5Sy/pRuwHXHOReulRus9UYJ2MncvEjrFTl2YX6
         MXM4OnbdQMzqopaIjg6gyMzUPD3shWut7xfKs2/eri6IxdLXJ+TXinfy89VQeSRW4EPF
         FV/yybijFfhePzVomwxlK/sSRtOr2pZsJXPZUbWYVGxGP8+Z3comZb1i7XeVPDq5XAtl
         3jcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uRRvPiCxTh0cQCTrfg3Fth4VL9KJPMgKRrLomhiuBtI=;
        b=RK8FXGeMOzekphe07DgXo8dGgJFr/brNdtzbS+gaofC07rYONl/bdf6bRkew1W1xk3
         ZIsKZYoRV0qiWtjQAdMm7Fg3lZqD5S4ubRjpFR050j+IPpImR4Y6hLqHxVnHvs9m1L2d
         v+UoEAZBQykyapZ/POvvDeXQBf2CMzf9k31opk9y47a1LUVmBybb/okZXY7dfD9QvgYZ
         wNXuUDLSd5UuQOlaWEQU3D1bZrJwA8F1rUEZc/G4zN35j0Jrf67pdi6KJOVbuOi8jghY
         tD50rALCxXNG3KV7HRWRuaK+m7CgStlWbGJOzaw3scwcA2G7tA+GtS9bB9rsE/dxnFOJ
         c6ew==
X-Gm-Message-State: AOAM533XY+aFneYAndAnTPJizE4kNtDeET2ez7Y05MC8fJWpxZHtTEqc
        4Wx2t2PrwglqyfPXwyYDh5sOd8TGgWDViSkS
X-Google-Smtp-Source: ABdhPJzULLJhGAC9dl6A/WqaG3mzSJWdotfNL3j3qEtXe+9GsyH2uhTDrxRkxEVNIq3a9z0msOy73A==
X-Received: by 2002:a92:6612:: with SMTP id a18mr2171116ilc.94.1598897412724;
        Mon, 31 Aug 2020 11:10:12 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q87sm5040851ili.8.2020.08.31.11.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 11:10:12 -0700 (PDT)
Subject: Re: [PATCH] block: ensure bdi->io_pages is always initialized
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <346e5bf5-b08e-84e8-7b0e-c6cb0c814f96@kernel.dk>
 <878sdu66sa.fsf@mail.parknet.co.jp>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8eb3881a-8ebd-fecb-d88b-3e1d77bc952f@kernel.dk>
Date:   Mon, 31 Aug 2020 12:10:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <878sdu66sa.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/31/20 11:53 AM, OGAWA Hirofumi wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> If a driver leaves the limit settings as the defaults, then we don't
>> initialize bdi->io_pages. This means that file systems may need to
>> work around bdi->io_pages == 0, which is somewhat messy.
>>
>> Initialize the default value just like we do for ->ra_pages.
>>
>> Cc: stable@vger.kernel.org
>> Reported-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> When queued to submit, please let us know to drop fatfs workaround
> "fat-avoid-oops-when-bdi-io_pages==0.patch" in akpm series.

Will do - planning on submitting it for 5.9, so probably end this
week.

-- 
Jens Axboe

