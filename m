Return-Path: <SRS0=NSF0=DQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE201C433DF
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 18:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 948F022284
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 18:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zCzSUP6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388297AbgJIScg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Oct 2020 14:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388240AbgJIScg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Oct 2020 14:32:36 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1918C0613D2
        for <linux-block@vger.kernel.org>; Fri,  9 Oct 2020 11:32:35 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k8so7590374pfk.2
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2020 11:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LvcOdkgIn267v6Ct/Tb39ej0Gu0ap14EIELiXdF00RY=;
        b=zCzSUP6nlXG+MHgoqqn1BmdIR1MXhHDY8w12wR/e/nX6CNSDJCDjLrlFY6NRj00ROf
         Tj/u/sHHiZKsw+O02ra3RNsRJAz7MS7tOSd3VbLNeUGpF7My7GU90OrG63zrCuipaD0S
         b2A6+DBPcaxA6xG9Uh/pgz6C0NDxNGnRit0g1i23g64h7t21cFeziNPK6gGL3xtg33oO
         zK3Cyq8KTSF8jy/nDsdXBu6aJWeyvKzHC/FkKH4TyzD2YSyBtk7+CM0HUR+gujSG17/t
         JjHLrjOhpD8SZQQ2/+GxYN5TgrDmJ49nVAISqxlb/E1yJsGeOU9kZMXI497sRTHwwiL6
         +HEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LvcOdkgIn267v6Ct/Tb39ej0Gu0ap14EIELiXdF00RY=;
        b=BpXGwTWSio7S5eLK+7nU5Q+41FB9SxcFx6PXLZ0dLdhPBnlHhnTTuTHTwqvXwl6nCF
         TJYEYmuXSmDggLZTNzZ9taPzdexJ/ASv5WiEVo4fLRmBfdBguFYD2L37OpvJarine+di
         EhVBNjUDd2CA1z4CpqscTH5gTkO0VCkBhY48xxd0Yhw2pMkjKJkkfoTZ0GkN2H2haXGu
         TOZvC2Pfywy7B95rAK3YGXimHe4DMx3+a1+RHjFSGpg/e/ABvXUn7R8dt4yyQBvR3YH7
         ItN8jOYyV7rgr7xC0aasEHrBK4PYmMIDHSTQIrPGls9lxmt2iYz/fKCUOqnKA6ulvyYY
         wwDw==
X-Gm-Message-State: AOAM532Pb74vBWlh/U50LkkdH5U6YhY34jFeqf8dkf6wirP4z/mul/7M
        nnOATw80xMvumNiZf8/sJXAAPa19bkccnIs4
X-Google-Smtp-Source: ABdhPJyRxyKX8T2qBeWxO45ZuNG/flNbF1Lx+Ab9CAJQ0oxdwz4BU4nEhKlPWp6qWqi411qc5Q+zNw==
X-Received: by 2002:a62:7d15:0:b029:155:29ed:db4c with SMTP id y21-20020a627d150000b029015529eddb4cmr11869843pfc.77.1602268355103;
        Fri, 09 Oct 2020 11:32:35 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id h11sm11321093pgi.10.2020.10.09.11.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 11:32:34 -0700 (PDT)
Subject: Re: [PATCH] percpu_ref: don't refer to ref->data if it isn't
 allocated
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20201009040356.43802-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d47025ed-9aee-4146-a28f-11da1eb988a0@kernel.dk>
Date:   Fri, 9 Oct 2020 12:32:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201009040356.43802-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/8/20 10:03 PM, Ming Lei wrote:
> We can't check ref->data->confirm_switch directly in __percpu_ref_exit(), since
> ref->data may not be allocated in one not-initialized refcount.

Added with reported-by.

-- 
Jens Axboe

