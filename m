Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5AEC11F65
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 20:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26512610E6
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 20:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbhF3UlH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 16:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbhF3UlG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 16:41:06 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21322C061756
        for <linux-block@vger.kernel.org>; Wed, 30 Jun 2021 13:38:37 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id o10so4204574ils.6
        for <linux-block@vger.kernel.org>; Wed, 30 Jun 2021 13:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vuEwF44PEA0Pv7slvdt7r1zkEZ5xYY1EblWbq88/Fmc=;
        b=bEBuP/yawR56TgWmm90eOVPFFVCM1vVKqtk4mfU6oVV8TJPIKQAuarqzx/bTmFYo2t
         C2pM1MHTEF4rDy0w8vyGS2E+1LioN4bc+NrWglVsKCT5tFJtOIXpoa2U4V3w3bhJx9yj
         5LVG2QJi+jKUcxEZj+A6UVEGR/CmGbrDAPFUsTy0U4//h4ee308SMpNFklyRSlPRHFWi
         MWuCEUmM3cUmotnR6H+SI5cKgAMPj1BZllH/Jv+M3bBmTkHTOKvYPk53aExckpV0Mm4x
         dKS2DYM5W9YSy5Gs1yt1z57LSfDTulJ5m3cCnvUmFQ4PzHVfFln+AZQrp/Gi8u6ju3Nn
         Jvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vuEwF44PEA0Pv7slvdt7r1zkEZ5xYY1EblWbq88/Fmc=;
        b=rurzp8l91upj7WckJk1cAcFFqoDW5VzTl1XOsz+XDzcjqrIg+A6wLBKJUwEXBZ4rgw
         XapXxuQ0M5412leO2iaQkxbwE8C7eviguWPAhzQkzGjtGETfU8/G07o+CJZbLsMAWpPR
         9POE0GiJACcH5Qg6ERoLYNFssnO75TWTgpvQXCkRFRSmHSxs/47+JRO8Rel7veuYWH/+
         LqtlGFvvruxW0kg+5dXe5EDLBySWDFVLns8dKq4WmXkbrKgj8tPZQ5e+xvdtKAyM7whs
         1kmFAqATjVAXsdWMHYg2obQCpIrPstrlRXB9o2QVaGzBf0vOdXQ4/OJwtYehcXZjKggq
         LudQ==
X-Gm-Message-State: AOAM531kxY44vazFnoiaQnzJOFZ5GMNlQNfZ7jzOtN8jwTDHbAr/2om1
        Iujv/C+pC9ez3hMFggUuB/X/TQ==
X-Google-Smtp-Source: ABdhPJyeEk2UIVLxvqn9I/GdrD/fANuzFu5qk6dAOoz7IijJHD6MdbOEAqlqm0mLJm1hArh/RSzDkQ==
X-Received: by 2002:a92:750c:: with SMTP id q12mr27043167ilc.303.1625085516578;
        Wed, 30 Jun 2021 13:38:36 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id s2sm9791102ioo.45.2021.06.30.13.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 13:38:36 -0700 (PDT)
Subject: Re: [PATCH] block: Declearing print_disk_stats static to remove
 [-Wmissing-prototypes]
To:     Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20210630203720.208003-1-abd.masalkhi@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5742bdb2-6d99-f32d-33a2-b9c5f51e9345@kernel.dk>
Date:   Wed, 30 Jun 2021 14:38:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210630203720.208003-1-abd.masalkhi@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/30/21 2:37 PM, Abd-Alrhman Masalkhi wrote:
> In the first patch I have not defined the print_disk_stats function
> static so it triggered an [-Wmissing-prototypes] warning, fixing it
> by defineing the function static.

Just send a v2 of the patch, there's no point in applying a known
broken patch to then just do a followup of it.

-- 
Jens Axboe

