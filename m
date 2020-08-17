Return-Path: <SRS0=fuqo=B3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2388C433E1
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 13:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 828552076E
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 13:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NhI2wzO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgHQN47 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgHQN4x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 09:56:53 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309E1C061343
        for <linux-block@vger.kernel.org>; Mon, 17 Aug 2020 06:56:51 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id u10so7561077plr.7
        for <linux-block@vger.kernel.org>; Mon, 17 Aug 2020 06:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EwBPUmMzjIeHY9w/IO7ylAcRHQqFTujUKmssL35PKKE=;
        b=NhI2wzO1qeTXti9CRXY54ifwyBrtv+1cyUKGAnmLB+qkI/Ad/ttTAE4MS6frrQZTIy
         UklMiOldDLEg/2iq8o/kwL7QcnM4PW5x4zDPOAw4vqJqExEiAt2la0jdn4Ko8+gWedCF
         YIOSIbD3Jt5xipp76Tv/sgFbnT9Vmjtq3ZshhjIZbjUpZ022ydnqam/S1LuGECtVj9bX
         fhuNy/pMsrgoBavqvtwD02Cnk4L6GfjTSHc6OhNlNM0LbhTMd5LzQmrN32S4NyJuGq7q
         aUyvx/VivDzdk17iJjbU5VzwHeSWBXq4ZhyaJmooHCDVq0kk5DtBsme/8jiml+FhEGej
         4Ozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EwBPUmMzjIeHY9w/IO7ylAcRHQqFTujUKmssL35PKKE=;
        b=PI3y7CUgWMqf9PGEfsfmtWhBS/VE/h2bwho8eOMak6zGitGrApvfcpmr8uF8Ws601W
         7xctM2nEn3n7ecA06Mb8bcsWvoetGvbfxjJjq4jdKY5ZUrf3BBsTXQh7pQgaCaWaGR+7
         7CErHt+N052Gzc9KAio8LbZeywGuHCXm6XG//Prn/3Pd0YtXAWXpMnZXrYOrT7MMR00e
         VwKgg+7iSgtL0G97ym+rmo0Wuza8/gneDaAbpS6u5CKW8QRFaSpBkUi/71i0AcMjSsYm
         UnIQa4/qc/2hcoguhkXoTH5DQmfNNcGetsVKkIAYt/tRYYcVNtGdZ2WSTo0BGPD8Al8n
         wlTA==
X-Gm-Message-State: AOAM53054HgxNgRrp3ec9GYscDiNkPf8Le7j9HXFRW1zNFmDamS95NLa
        jNhLVyDIGizoeDrZxAGfocdghsphJBwnaLiB
X-Google-Smtp-Source: ABdhPJwFH7lYBEvzR88kR4QnSmlWPYxSL+tz5BkwayIdACL+uMf+Xuv3Zqrzz0fKeCUB4oQlNJhqsQ==
X-Received: by 2002:a17:90a:5aa2:: with SMTP id n31mr12383701pji.33.1597672611292;
        Mon, 17 Aug 2020 06:56:51 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:ff2c:a74f:a461:daa2? ([2605:e000:100e:8c61:ff2c:a74f:a461:daa2])
        by smtp.gmail.com with ESMTPSA id y126sm5565062pfy.138.2020.08.17.06.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 06:56:50 -0700 (PDT)
Subject: Re: [PATCH] block: convert tasklets to use new tasklet_setup() API
To:     Allen Pais <allen.cryptic@gmail.com>, jdike@addtoit.com,
        richard@nod.at, anton.ivanov@cambridgegreys.com, 3chas3@gmail.com,
        stefanr@s5r6.in-berlin.de, airlied@linux.ie, daniel@ffwll.ch,
        sre@kernel.org, James.Bottomley@HansenPartnership.com,
        kys@microsoft.com, deller@gmx.de, dmitry.torokhov@gmail.com,
        jassisinghbrar@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, maximlevitsky@gmail.com, oakad@yahoo.com,
        ulf.hansson@linaro.org, mporter@kernel.crashing.org,
        alex.bou9@gmail.com, broonie@kernel.org, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, mitch@sfgoth.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     keescook@chromium.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-block@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        openipmi-developer@lists.sourceforge.net,
        linux1394-devel@lists.sourceforge.net,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-hyperv@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-input@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-ntb@googlegroups.com, linux-s390@vger.kernel.org,
        linux-spi@vger.kernel.org, devel@driverdev.osuosl.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
References: <20200817091617.28119-1-allen.cryptic@gmail.com>
 <20200817091617.28119-2-allen.cryptic@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b5508ca4-0641-7265-2939-5f03cbfab2e2@kernel.dk>
Date:   Mon, 17 Aug 2020 06:56:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817091617.28119-2-allen.cryptic@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/17/20 2:15 AM, Allen Pais wrote:
> From: Allen Pais <allen.lkml@gmail.com>
> 
> In preparation for unconditionally passing the
> struct tasklet_struct pointer to all tasklet
> callbacks, switch to using the new tasklet_setup()
> and from_tasklet() to pass the tasklet pointer explicitly.

Who came up with the idea to add a macro 'from_tasklet' that is just
container_of? container_of in the code would be _much_ more readable,
and not leave anyone guessing wtf from_tasklet is doing.

I'd fix that up now before everything else goes in...

-- 
Jens Axboe

