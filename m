Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917A7C32771
	for <linux-block@archiver.kernel.org>; Fri, 19 Aug 2022 20:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352214AbiHSU43 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Aug 2022 16:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352079AbiHSU4Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Aug 2022 16:56:25 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A4AEA8
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 13:56:22 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id a22so5315540pfg.3
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 13:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc;
        bh=8+IfiWRKL+MQ/1/EAfazVxov40f3SAKzLdawV25F/EU=;
        b=IfWP453Cv578LklJX8Kv/lqYygdzcDHWs5b31OMNpqNz9aBGOwqHMyXTHFSf8p9/Pt
         +de4DoMoG/0u8eaEVnFO/7OD9uYk2sAv+t9uoKSAzsX+Hy7kvquli5vy1qk4U7IT4q7U
         8NB6i8YRdbf+2akf9+GQWUTT3X7nyVkP0FK2tf6yhispsN25FL8Sb/VydWsAkU6OwuBt
         Gni/kRMzzjMD7XVZ4TtzR9mjHVt4Jmj1FqQmY7Ht2yfNJopG3rHB+Qra20S/gJFHrskV
         Tsijfjn3w1rb+Xh/+4HnJaKejZgu4U4XjtN4+1sCbyCBjf1fS0Q71s/Wp3MMA0CCUjkP
         c2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc;
        bh=8+IfiWRKL+MQ/1/EAfazVxov40f3SAKzLdawV25F/EU=;
        b=oDGdSiLF2LGHWWbc3aLJqB3mG8n2ntKVMBvd8gdSF+ifHZ1M1+ZdpdXqhhsGZtwj1Y
         29xbPa08wtjp+yvUGIQ6CXit4qDtmqFF0/X/uzgg99C318P0g84v/0YO//aq5abKgPe5
         CNmYXCPbbrbdFiHGctqIWNuZXss2LUHZYDrCn2cv5rU4nY8pqnlR5Ihi1ZrBS9XM+Mnj
         EIVwgklVmIp2GKJDxmiaw9f7ny3WWmfUuZ6WwC35TTJfoAAtHayiPLhl5138sFfKNe0Y
         y7yOUnf0qxVp+KnMeRHWHbJNyI2jN0gaRkkHDsMKAz1Ho9azZjPNgTCcLVv7ls90uqlM
         4z0w==
X-Gm-Message-State: ACgBeo2rShTfft5NtTg6N9pAmimO7Mxi8D+GMpnstSKefde99PehVfha
        f51MhCVSjNoo3Hx6yFkwilMm7w==
X-Google-Smtp-Source: AA6agR7T667f8sV4aTprnUUCejdY7pKARzfKXPPQ5tNaWZWHNnh0okLru8Ot7FYjYRlvWUhLDNzJ5g==
X-Received: by 2002:a63:4e25:0:b0:41c:62a2:ecc3 with SMTP id c37-20020a634e25000000b0041c62a2ecc3mr7810620pgb.596.1660942581614;
        Fri, 19 Aug 2022 13:56:21 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l18-20020a170903005200b001712c008f99sm3584603pla.11.2022.08.19.13.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:56:21 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     luca.boccassi@gmail.com, linux-block@vger.kernel.org
Cc:     gmazyland@gmail.com, dougmill@linux.vnet.ibm.com,
        hch@infradead.org, Jonathan.Derrick@solidigmtechnology.com
In-Reply-To: <20220816140713.84893-1-luca.boccassi@gmail.com>
References: <20220816140713.84893-1-luca.boccassi@gmail.com>
Subject: Re: [PATCH v7] block: sed-opal: Add ioctl to return device status
Message-Id: <166094258060.37308.11668013247195344136.b4-ty@kernel.dk>
Date:   Fri, 19 Aug 2022 20:56:20 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 16 Aug 2022 15:07:13 +0100, luca.boccassi@gmail.com wrote:
> From: "dougmill@linux.vnet.ibm.com" <dougmill@linux.vnet.ibm.com>
> 
> Provide a mechanism to retrieve basic status information about
> the device, including the "supported" flag indicating whether
> SED-OPAL is supported. The information returned is from the various
> feature descriptors received during the discovery0 step, and so
> this ioctl does nothing more than perform the discovery0 step
> and then save the information received. See "struct opal_status"
> and OPAL_FL_* bits for the status information currently returned.
> 
> [...]

Applied, thanks!

[1/1] block: sed-opal: Add ioctl to return device status
      commit: 5ba3cd2f94a4fbc952f7a343a267e5c570412dd8

Best regards,
-- 
Jens Axboe


