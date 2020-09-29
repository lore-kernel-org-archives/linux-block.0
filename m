Return-Path: <SRS0=YBZ7=DG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE83C4727D
	for <linux-block@archiver.kernel.org>; Tue, 29 Sep 2020 14:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD07D20C09
	for <linux-block@archiver.kernel.org>; Tue, 29 Sep 2020 14:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ewHwiI49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbgI2ONH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Sep 2020 10:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgI2ONG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Sep 2020 10:13:06 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF54C061755
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2020 07:13:04 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k6so2684475ior.2
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2020 07:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pIqAOqrn6h0sWTOG6HQcdrGe1pJQq2qqrnbCVqbIgK8=;
        b=ewHwiI493jKey9fnPfl//AmXDX3kVu2s6HJz1Vb9Hu7z26kP0rDDqWys9IU7lcNE/k
         JFHIG/W9k5nNwlEs/Wnw3qvTnuxuiI37gYGYowcIV6OR9eN+HLF5xx2vtMOR1d5t7ruA
         2iVl4x/jzPtSh79NtDTrreBP8eCKty6KM4FLSf4zjvQKu3dIeZ6Zo3r//G5iMPbpZyJ4
         Nmtd2028l9Dcxz8RUS+xiA1WV/iGQnd90OZLTtYvOLi1BXCVqyIlTLm/gzC0hTe5QKF9
         mE5TC/xgZUtBWF3GeeKLmG8i85jts+BLh5mhgtciEtvHNT3wz08PEdagNVdzVRChRkLo
         218A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pIqAOqrn6h0sWTOG6HQcdrGe1pJQq2qqrnbCVqbIgK8=;
        b=Zt7FDDGGG8kM9ZaTMTSR+GYSa59MQy22AsZ0UnIMj3k/ulWExR8nZPK+ZA3sH9Ok38
         YUJ+GeuYaUjGBtAlShb4V+8EclT9HRLMnXnE7U6aB1BSXllhbbZF5ePxpQTXwMjHJj5O
         lmtxCilmLGa0D/20oT2dqHkQFrG1zGxVolnPl5upUd4E7N944XIAJND7t9lirKJJolRR
         7xLGcyCgWXH/fzSDIg6fgmM2TPqYuqm7MhBP8vzI/CvOmg+hTy/U+hz4hv0XS2BEQj3h
         OiT0JfdSJ8h4rMg/BWWiIX396nbFDbaOFY95RCIf+t7rMb2toaq+/1hJU/VBOj7A+xpJ
         x3Ew==
X-Gm-Message-State: AOAM532QK7+qbKQTK36y3UqD/kKFM8jTESgKyqu4PSdBXfiH5AaE3NzH
        gWf4z+vlJoyKZo+nBs+2oCfQag==
X-Google-Smtp-Source: ABdhPJxQPOLCOgpVlhV5WKBv4IpAqB78vNhpqOcppe1fOObbXJynagNpVFBnb2oq44Wxf0zr3YAFjw==
X-Received: by 2002:a5d:8b4a:: with SMTP id c10mr2629435iot.143.1601388784174;
        Tue, 29 Sep 2020 07:13:04 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l6sm2406115ilo.21.2020.09.29.07.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 07:13:03 -0700 (PDT)
Subject: Re: [PATCH v3] null_blk: add support for max open/active zone limit
 for zoned devices
To:     Niklas Cassel <niklas.cassel@wdc.com>
Cc:     damien.lemoal@wdc.com, johannes.thumshirn@wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200828105400.80893-1-niklas.cassel@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ea94a097-c5c1-1996-3398-a08d64503941@kernel.dk>
Date:   Tue, 29 Sep 2020 08:13:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828105400.80893-1-niklas.cassel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/28/20 4:54 AM, Niklas Cassel wrote:
> Add support for user space to set a max open zone and a max active zone
> limit via configfs. By default, the default values are 0 == no limit.
> 
> Call the block layer API functions used for exposing the configured
> limits to sysfs.
> 
> Add accounting in null_blk_zoned so that these new limits are respected.
> Performing an operation that would exceed these limits results in a
> standard I/O error.
> 
> A max open zone limit exists in the ZBC standard.
> While null_blk_zoned is used to test the Zoned Block Device model in
> Linux, when it comes to differences between ZBC and ZNS, null_blk_zoned
> mostly follows ZBC.
> 
> Therefore, implement the manage open zone resources function from ZBC,
> but additionally add support for max active zones.
> This enables user space not only to test against a device with an open
> zone limit, but also to test against a device with an active zone limit.

Applied, thanks.

-- 
Jens Axboe

