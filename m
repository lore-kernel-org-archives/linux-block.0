Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2E0C433DF
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 20:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECC0A206D8
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 20:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HTrLGCcU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgEPU3H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 16:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726422AbgEPU3H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 16:29:07 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E016CC061A0C
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 13:29:06 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q16so2419257plr.2
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 13:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SdBLRP65Ocj9233FayPxmRnKz5JpCqqs+uVfKTWKdAE=;
        b=HTrLGCcUAunZh86I5B0lD97wRgaG7rIxkyJKmnt8RdxkceTWSMzdiYi6p444j8xl1H
         +jjopNHSDIGw+T3JXarjhcmVmNE++hNxyPIr3aQfCY6iGLJALTNRK33qlHHwZbPVlWJq
         MwUeoNnCloXm0R+c4chY0DiSZfgaw/qgeA6xLDryvYYvGBGMt8ehLwcbO7sR3u23KhjX
         BuW0iGgS/bkJeOOZyV9auFiRCOkr34I6ZRutrIywKsMEnGscmf54PWfa4cL/fsOAPd6u
         TgDUfa3AXEmH6I3NOoSlXWui2vCh1V0VVVFxqIp41ws47fJij5D18e/hwoRCalI8Ex20
         huRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SdBLRP65Ocj9233FayPxmRnKz5JpCqqs+uVfKTWKdAE=;
        b=lmJ6j1lTi8/fhAIGkhpHFEStnip+XvjANLWWI1XCHdKk6iiAnFeve79eE/cPoD1bE1
         8z49W5bkF0T+lczrVPbNVvLz8zTfjfkgeztmJI/fLqcSLMeuN9MuL+ognoJ1Yxk+6ewH
         wBrS2k4UWUoW/Ozdrl0TKzBp/PtvO9xwsEvEqKOpN/gW8XyglsxPllwVx9Ssafq/ah/R
         hb84zSr+Aqod9BUmbCGcjqHSXbr6ZhGEK81gvKSM8NuTvAB0kDgn5yhQSdNa3qcJWhiT
         q+neO0xBVtlbTe7ohjgGruQKeMRAnJq33GROe9RF4cx1N1Bju09faRiwhRbU6hXATMwC
         +gkQ==
X-Gm-Message-State: AOAM532BUWH4+8gjRaY2fh/Iz2Ti05ivvVHDM7HSg/UIVw4wYS+PrKKp
        cMYYva0r9IDaQpnW/Mx1mtZdLu2fGts=
X-Google-Smtp-Source: ABdhPJxre/hOwbSb74nUSAAqja4UBRpAJupgdssAxISUSWAqUNwMUQJXJfd7fu1XrnnJxvFoM1mScg==
X-Received: by 2002:a17:90a:a591:: with SMTP id b17mr10705933pjq.90.1589660946169;
        Sat, 16 May 2020 13:29:06 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:41fd:9201:9a30:5f75? ([2605:e000:100e:8c61:41fd:9201:9a30:5f75])
        by smtp.gmail.com with ESMTPSA id q9sm4718613pff.62.2020.05.16.13.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 13:29:05 -0700 (PDT)
Subject: Re: [PATCH] drivers: block: use set_current_state macro
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200507071211.15709-1-vulab@iscas.ac.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3d94f908-b3c6-12ce-24b2-47c5e481a1d4@kernel.dk>
Date:   Sat, 16 May 2020 14:29:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507071211.15709-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/7/20 1:12 AM, Xu Wang wrote:
> Use set_current_state macro instead of current->state = TASK_RUNNING.

Applied, thanks.

-- 
Jens Axboe

