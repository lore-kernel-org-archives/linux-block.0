Return-Path: <SRS0=NSF0=DQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92BBC433E7
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 18:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77830222BA
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 18:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TnO4+Fp6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387680AbgJISrP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Oct 2020 14:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733050AbgJISrP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Oct 2020 14:47:15 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA4BC0613D2
        for <linux-block@vger.kernel.org>; Fri,  9 Oct 2020 11:47:15 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id c6so4875881plr.9
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2020 11:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=4kJGOhJiRobN4JIdukAgdgD/2GSI6s8jm5UKtfeAL4U=;
        b=TnO4+Fp6Vwkx7VXqpUYM5z10GK1DlZvu5gvm4EMhVcDoF6da5GV3uijYfz+8ZWki5K
         janv/P6s6JN3sR6H79+Bz3peFljww0hcZAtJpbfnyH8HhUxiKAsGQdLInG4M3Iifo4GX
         8edQS4oLIiZkPSU/wYv+rIcmRh7LXZM/NEJ8XB9gVagtUdZGDaUUb9w1L4yH9A9Zuy1B
         7SsWf/fqjBTlV2EpOEZWGuqJ8wYty4IFNh+gypeety08+tw2x8zGJF86Bo0GGaFdmnuA
         DKtRYIv0b1UJhULpOYE0auK8OgL7rVIUEmdTWakIxyoJkYs/G61tbQ0mIMomEvJD4AIX
         AOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4kJGOhJiRobN4JIdukAgdgD/2GSI6s8jm5UKtfeAL4U=;
        b=I1rdR4X4fr6G738/fFAiZ1LB7GSnHV66wBf7coe03xcGuh61zxsGOElHeDmBYjiUMH
         QdpR/NOFi9wE2NvzxCMpUJxqH139bSxrC87M0jULLo+v0lhQ4oTHDivB5BuvLjrwkuO2
         vz8sHIBzdTRTIClgCsBRsQmod1SfSe3TCrkx11FRRkIAM7Gq9B8z51r0AhGi5s5aMR6H
         LsrduU6w0xDEZcdAsI/E7IBgILIh97PDZaTDgYc8xJ1CxnF/75YBYBFGsBSycnbWVtF6
         zeIHA910+Q5L8tcvOAg8zwH7HUG65OwkVYz0OdyejJOPjG/6cEZq85x5NIm4gwIAqyaT
         BRKw==
X-Gm-Message-State: AOAM532Z6/vvHf14texXuCc1bWKLDaaD9UYGJa2+dV5Xtb4DIQc55pDq
        ns/WpbPZm5SSwhNrP7QFHS8aB+TWahE+drdG
X-Google-Smtp-Source: ABdhPJwvA459/3+vvMPIv1mn88Fsq1PNNaOB3kEEvd4kmy60DV0M42TAKjmJVBJu5GHyjyx5L7V9DQ==
X-Received: by 2002:a17:902:d68d:b029:d3:dcce:d7f1 with SMTP id v13-20020a170902d68db02900d3dcced7f1mr13164127ply.84.1602269234860;
        Fri, 09 Oct 2020 11:47:14 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id ge19sm12470580pjb.55.2020.10.09.11.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 11:47:14 -0700 (PDT)
Subject: Re: [PATCH] block: fix uapi blkzoned.h comments
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
References: <20201009090714.285968-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5d13086f-66bb-a475-7f58-b40fdab627b5@kernel.dk>
Date:   Fri, 9 Oct 2020 12:47:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201009090714.285968-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/9/20 3:07 AM, Damien Le Moal wrote:
> Update the kdoc comments for struct blk_zone (capacity field description
> missing) and for struct blk_zone_report (flags field description
> missing).

Applied, thanks.

-- 
Jens Axboe

