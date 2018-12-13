Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF07C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 15:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F8720851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 15:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XrB6a+gg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F8720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbeLMPQq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:16:46 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33137 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbeLMPQq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 10:16:46 -0500
Received: by mail-io1-f66.google.com with SMTP id t24so1882867ioi.0
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 07:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IPsUxUmVBbBWTlfGI+DJ4JAD2E1cTzv+jmJJFKEpWlQ=;
        b=XrB6a+gg4K4vTZwC3ImnoDNxk9hAz6LXutwYAVz01FzRQh6GYTZmdr2UKKXRsxsFW4
         uy14jQpmxxMWZLeOi7ngqK5tBujIa7usCxYYR6ECte+y6hf8gn3ytibqzFJwP4hrX461
         hnY++FCS2Gbi6Vad3DIyWV8HJRzIX0F3Ph8HJHK6SxuZXcfgGPIyOjgkUAtYK0aKmk0W
         LGLBbxXp5GlZTHpZGD2k56JBNc9FyCrL61mLEel6lYX9p4y0obQfmkeV4Z7KQrJ9sqZr
         4m0+2zBGiZyVuT98vPLQZIN8i6hQwogzr4FT4Aiq3IOs8TjKL80YylsyJrws5dm5DMxV
         a2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IPsUxUmVBbBWTlfGI+DJ4JAD2E1cTzv+jmJJFKEpWlQ=;
        b=RZ1gU4Cnxb6vaEIVvR4mcGVJJoOMZFLwlQRcVCnzLh8GohLXb5k2/8RUChtBEGfz43
         vzZG0FsBS/+IrhexOM7H9mUx6GINBPROXaFKU8VMTs9jJ5Pe4/tLhyQ9z7QN/KTqN8kD
         oxbaPJkjMf2zTbg0+oIvHKFzhdZvrL4eHiFweIZoflWvNem5+C/msNZTTh19Cgsnuy4Q
         +B1hvz2Gd7+x9xxPYD6jNe3351025l/Em7LsRND8jZroE7p9sGNvA+NhqkYCsFw9Cmv5
         koNkjiL+J7jDy2RB+wRjJ1615wtoILMuqgEZuAR4PHUiPHKXZphovHfxN9DIdXz0afdq
         27yw==
X-Gm-Message-State: AA+aEWacKXWSzYO7Qxmtyo5PTOPC6Ch+f3115sQbRU/QmWbnCIGrlyum
        tpcjCfe2aRmzx5NiBkh/pysF4hNbfzgndQ==
X-Google-Smtp-Source: AFSGD/UQhPAS5ND3KdAN1qNl2cxGcbn6vIz6/YuyV3HSUzh1cpzsRk6hVekNMiYCIMDq3DWNiCrnTg==
X-Received: by 2002:a6b:730a:: with SMTP id e10mr2540016ioh.264.1544714204553;
        Thu, 13 Dec 2018 07:16:44 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w26sm767170iol.60.2018.12.13.07.16.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 07:16:43 -0800 (PST)
Subject: Re: [PATCH 00/12] bcache patches for Linux v4.21
To:     Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20181213145357.38528-1-colyli@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2443d456-f537-ef08-f550-3e4ac2a116af@kernel.dk>
Date:   Thu, 13 Dec 2018 08:16:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213145357.38528-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/13/18 7:53 AM, Coly Li wrote:
> Hi Jens,
> 
> Here are the patches for Linux v4.21.
> 
> The patches from me are for a set of disabled-by-default optimization
> for writeback cache mode, which are used by some users I know. Guoju
> Fang contributes a patch to add number of keys in
> trace_bcache_journal_write(). And there are 6 patchges are from Shenghui
> Wang, which removes an unncessary NULL check for
> debugfs_remove_recursive() and debugfs_remove(), adds useful code
> comments for bcache, and improves sysfs information display for bcache
> writeback rate parameters.
> 
> We don't have important or big change in this run. Please take these
> patches.

Applied, thanks.

Note that I reformated some of the commit messages and patch headers.
Keep them within 72 chars, then everything is much more readable
in git log.

-- 
Jens Axboe

