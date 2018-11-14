Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE344C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 22:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB792254C
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 22:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cbkQJIel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB792254C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbeKOIcD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:32:03 -0500
Received: from mail-it1-f182.google.com ([209.85.166.182]:35634 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOIcC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 03:32:02 -0500
Received: by mail-it1-f182.google.com with SMTP id v11so26403594itj.0
        for <linux-block@vger.kernel.org>; Wed, 14 Nov 2018 14:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8lAGQl5PNsb6SeAmNMfGQNqndWsnnu2bIdRFuCiYvGI=;
        b=cbkQJIelSzEBEncmdZxwM3sfM9UEBvxs6hmH0twrD89sYOdMmKyWicePRA1Kh4j6aN
         32rrNhaHl6oBm4VGOC8BlSjT6XntX+cysNuQSaw8FqPozw9AEYHMPKHtG5VXbaDDfTuv
         x8wpeUG79eFoTY773PZcMYWNImrFKHiJTK8agFmJorgy6jEeg3XPdX16R4oBlmX0LkV4
         gbk0HB0mil7Dv14tB9JsimUognPwDZAHM4re1hH721z9bam/xKor9kGwbNfG/ISj7oyN
         Z4rL7/qxuT+n40bJWc8GGMpdU1Md2+t6GX3+yehHw/0qnSCaBfD5GuG3LN8VluMAj0az
         8G4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8lAGQl5PNsb6SeAmNMfGQNqndWsnnu2bIdRFuCiYvGI=;
        b=tZNknvEmp/vzs6mA3kSH6Z+b1AK1deRAs+GHFyoNr4n9v7LSCAZR/oYZt7z7yq97ad
         1E3Cid7TFlf8GNN/kSdUdkj5MKZD+3pAR8jkox1WQ88H4whfMYwc6tTdBfQD9Trarpet
         l7POM+6rHauIzZI58DRlz6RXGbPZLEty8NDvEKTKYsbg6ktCTaPKQzfTQFcO8dCW4T/d
         +ZT0mmpneg6RAMKipwqhiQYXCx3hFM5vQqOszjafNTZYpiAlQpQKxXbjU/Gq4R+RCIRv
         MbqsIn+hE2gopZQ4jr+VAp3w3UyezsV27xp4kMO3Or4lo4skOttHJvPqH/7wsHiIgcne
         j/gA==
X-Gm-Message-State: AGRZ1gJxa6jLzmePzvQKY7mOod8UTPOkRtydQIc9w/l3+Xy82b3ZRWMT
        dZ+7KiWCkG+wVI/aHCwRkG6dlQ==
X-Google-Smtp-Source: AJdET5e9dNHZiGvUhrsK8/wVeT+WAX02QOgXYQI7/MIxZhGO0TpN7a6TQnxV5GT1vJU48HbzO88eIA==
X-Received: by 2002:a02:8785:: with SMTP id t5mr2737287jai.73.1542234009852;
        Wed, 14 Nov 2018 14:20:09 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t64-v6sm8717224iof.19.2018.11.14.14.20.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 14:20:08 -0800 (PST)
Subject: Re: [PATCH][next] block: clean up dead code that is now redundant
To:     Colin King <colin.king@canonical.com>, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181114221705.17207-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4ec214ef-d434-df9a-2bb3-9bda2ef55fbe@kernel.dk>
Date:   Wed, 14 Nov 2018 15:20:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181114221705.17207-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/14/18 3:17 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The boolean next_sorted is set to false and is never changed, hence
> the code that checks if it is true is dead code and can now be
> removed.  This dead code occurred from a previous commit that cleaned
> up the elevator and removed the setting of next_sorted to true.

Ah nice, it's also the last "user" of q->nr_sorted, so that one can
go away as well.

-- 
Jens Axboe

