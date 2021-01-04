Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01901C433DB
	for <linux-block@archiver.kernel.org>; Mon,  4 Jan 2021 23:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B844D2255F
	for <linux-block@archiver.kernel.org>; Mon,  4 Jan 2021 23:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbhADXWB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbhADXWA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Jan 2021 18:22:00 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AB4C061794
        for <linux-block@vger.kernel.org>; Mon,  4 Jan 2021 15:21:45 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id b23so15406104vsp.9
        for <linux-block@vger.kernel.org>; Mon, 04 Jan 2021 15:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EVvjl8FPHaSAgzlwZ8FX4Brn/IkTBmXnnCWWjce03KI=;
        b=bCEoldXf+rgnBgH5gRZhIgmP4UtKc7PsXRo+y07x+fBOL2XUjqKg8VZ1rDPJtevHFA
         LSwFIywtbjvGJ6zOdeKpqljJHAISyk0E2038udeT2ss/rcAsKSrn44Se5Z93S89uBxHd
         EI9QLcfZWsebkjhagb60u8A4/RBSyZtZ5mUATmATrEX5mk2PbfXP36CZRN5ffxQlNIZy
         c5y/0UTM+LNwWhX2F9/SUOLjRPY2HsdgoEQVW1vp2T9pHQUh2Hjv2xhi7XUwlx6D9sWB
         0oDiVwfXcKljrbgqoVFbRwJoWTcJiD7C8vOiQaLpz/AAQGEolbTMVbR/Vp/y1PV7g0BI
         F4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EVvjl8FPHaSAgzlwZ8FX4Brn/IkTBmXnnCWWjce03KI=;
        b=WDr0fx4OpWalCJknnzPNclI3jGu3alF6pc6nc0C4wy7hL0CR1DbL9RO57S8NJcKHSi
         qNyWR/ISe5ZSQ3EpolSsFHjrm2DruVPPbqPYw/o67uzCNrjFcieLEf/c6yb27I8Ow4uS
         5gO7OgAPwQASzr2JHKgsUAqR1wUVQO0e7Juj3NSXZooPXNN+xyJ4YdUGfn6+0ncgdKJr
         WHbnQYZQFHL8qzc0CDVTPU16n2lFvwdcqCAATkcwjNDrVn3alkNhlpsoTSPDVThGoWB6
         NlaDepsHfiQGrSxh99gxfHZGx9YedIqMFEnhuexsZ+emz7VcJCfgUNveHfTSNxvSzIol
         E1fg==
X-Gm-Message-State: AOAM531KGWziSnUvdOs1HTuLsnV9prG4juL51Y3F3VQuwAOZiaDJ17X+
        pp+delQ6BhTV/rG8DMHxsn715Y8YRDEB6Q==
X-Google-Smtp-Source: ABdhPJyIWryZI/2VEPq41I2TdTwAw0QGxrPFUu9ddmFBWHTz8pUedEe4WTR9djRG9xZygAcSIkIWww==
X-Received: by 2002:a17:902:fe17:b029:da:799a:8bfd with SMTP id g23-20020a170902fe17b02900da799a8bfdmr74508182plj.10.1609801103888;
        Mon, 04 Jan 2021 14:58:23 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:a87e])
        by smtp.gmail.com with ESMTPSA id d4sm54877555pfo.127.2021.01.04.14.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 14:58:22 -0800 (PST)
Date:   Mon, 4 Jan 2021 14:58:21 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests v3 0/2] Support max_open_zones and
 max_active_zones
Message-ID: <X/OdjdrazFmYHV2T@relinquished.localdomain>
References: <20201229004434.927644-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229004434.927644-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 29, 2020 at 09:44:32AM +0900, Shin'ichiro Kawasaki wrote:
> Linux kernel 5.9 introduced new sysfs attributes max_active_zones and
> max_open_zones for zoned block devices. Blktests already handles
> max_active_zones. However, max_open_zones handling is missing. Also,
> zbd/005 lacks support for the two attributes.
> 
> This patch series fills the missing attributes handling. The first patch
> modifies the helper function for max_active_zones to support both
> max_active_zones and max_open_zones. The second patch modifies zbd/005 to
> handle the attributes.
> 
> Changes from v2:
> * Added Reviewed-by tags
> 
> Changes from v1:
> * Reflected comments on the list
> * Added Reviewed-by tags
> 
> Shin'ichiro Kawasaki (2):
>   common/rc: Check both max_active_zones and max_open_zones
>   zbd/005: Provide max_active/open_zones limit to fio command
> 
>  common/rc       | 19 ++++++++++++++++---
>  tests/block/004 |  2 +-
>  tests/zbd/003   |  6 +++---
>  tests/zbd/005   | 13 ++++++++-----
>  4 files changed, 28 insertions(+), 12 deletions(-)

Thanks, applied.
