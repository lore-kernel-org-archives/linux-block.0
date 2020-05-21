Return-Path: <SRS0=t9QE=7D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3316BC433DF
	for <linux-block@archiver.kernel.org>; Thu, 21 May 2020 14:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03E6E207F7
	for <linux-block@archiver.kernel.org>; Thu, 21 May 2020 14:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UmxtNUqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbgEUOrw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 May 2020 10:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbgEUOrw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 May 2020 10:47:52 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8B3C061A0E
        for <linux-block@vger.kernel.org>; Thu, 21 May 2020 07:47:50 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 23so3421690pfy.8
        for <linux-block@vger.kernel.org>; Thu, 21 May 2020 07:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pEqbZNmL9UvqLxXF45hO3Fkf+T1Eq8EXfTFLo5srohI=;
        b=UmxtNUqIS4/GOZ7swsb2Q/EghJxBj7107Va+pCQuLNA9e5Y5iQzhxJO46/FogakcDx
         orWzu3m/PZP60JVKfD1Ha+a7+nF6NSIiUm1J4pA2R6ar7MXJRwle6bjh1xT1EoqgbaID
         sq07E+NrYMszDm+cot0MsD0DJRnPIUHIRMOIOP2Uv+gmhgWVh+iAnGxA0luIVSDQup2a
         m47XbWosNmI53qHADbKVz4O1oBizLBmtlMc/LB2i85yG51R1zghMYyQ6gn6sqSRdyvBy
         OJUSHfFTNik/InUcDzxXiKvnlllikxpDwemuJwZlFI2yB9RG5c3cdW4oymigPYj85aLh
         sQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pEqbZNmL9UvqLxXF45hO3Fkf+T1Eq8EXfTFLo5srohI=;
        b=CMh463wxnOtoOBhSgOcGgUTQ5jeK/u4pmqQkB1BzxJ9QPTpPe0uPObbpctLmjYsp7Q
         8mc1OGmj8/l/GzzYBLC3ZQwqaWiCWXQ7LC9O8OyPC6IfsrwhxhFq7kKo+Jjbxt4KlEAV
         Mgd6XdsHM2WS8CLXRcWEloYhp27zl3Z4w6CuTbvbSNBs1HlpGv5J86JdQkJZrqeVp8WB
         rxhwshLzKA7NTaKzh8CcTxz8fyXCwUKRPIPwHaXn1QI3PdEUPsTJ31nBtRd9xAcjQXYt
         H9i8WEN2PZ47dHcwo20gWdIpqEdGaw82g2trqSroyts9A2qWgUoCdplJzQuxvmBrGJ9N
         kZNQ==
X-Gm-Message-State: AOAM532Hfgti2NXRzMJfVZ1D9Ogxctx0mh744II7QIsxjx9IlZttU1IS
        YTdHsFNbjMyYB4A6TCYldQCMf39zu4c=
X-Google-Smtp-Source: ABdhPJzofgyH8sG0HQtOqTm/q8nzkG6/hGkloEuoCHzMTrENjT19NFk4LCLFyjK2xvcX6Nbx7pKwMw==
X-Received: by 2002:aa7:93b1:: with SMTP id x17mr9962864pff.275.1590072470127;
        Thu, 21 May 2020 07:47:50 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:c00a:8fd2:4246:efbe? ([2605:e000:100e:8c61:c00a:8fd2:4246:efbe])
        by smtp.gmail.com with ESMTPSA id w21sm5135611pfu.47.2020.05.21.07.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 07:47:49 -0700 (PDT)
Subject: Re: [PATCH 0/2]null_blk: small fixes for zoned mode
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org
References: <20200520230152.36120-1-chaitanya.kulkarni@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6dfacde8-0632-5a78-f3df-44c946e66914@kernel.dk>
Date:   Thu, 21 May 2020 08:47:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520230152.36120-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/20/20 5:01 PM, Chaitanya Kulkarni wrote:
> Hi,
> 
> This is a small patch-series which fixes potential oops for zoned mode.
> Also, it disables the discard when nullb configured as zoned for
> membacked mode.

Applied for 5.7, thanks.

-- 
Jens Axboe

