Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F891C433EF
	for <linux-block@archiver.kernel.org>; Mon, 17 Jan 2022 14:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbiAQO2V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jan 2022 09:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbiAQO2U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jan 2022 09:28:20 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6A9C061574
        for <linux-block@vger.kernel.org>; Mon, 17 Jan 2022 06:28:20 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id s11so13664975ioe.12
        for <linux-block@vger.kernel.org>; Mon, 17 Jan 2022 06:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n+DljS4RzwBILeFVL/Vq3aQO0XZxLwiS73iZppTY38Q=;
        b=iBk2VCO/BtCxuliRpyarRi3pxs+nl0In7kgf68UY4r/VeDG9eCfPhEam8M2xznWSaT
         Qc9r8nqP9vHFfwkF609NspjjWPsG+SaPtthau5lkEF8IGQ8tUNDK5bFh5WDaKZVb6l3N
         IySs4lNpPpGuuKfSpM5rnHnxVukyE3w3aznBLD7ZCTD2ZMyou+RwRqxWUTGWxV6y6dDN
         5NIY6bR9YdosWzSOpeI00mgrgqpcyz3O5CFaYDyTBOK84GxRGjIVIZHee6ez8TpjDhqD
         2Qq41isYxfyE5/AuoCSEg2Xm8IqLxwWCdRmiTRVQifKWQvz/LMZUZfblyNEQvMGl6NSQ
         Vppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n+DljS4RzwBILeFVL/Vq3aQO0XZxLwiS73iZppTY38Q=;
        b=XxrtQdkeckLJkN+i9w1wQMCMNE7M/I7sjeFsHGSi80myJ7GcARkaLKVYbWsvuxSAhg
         fM4B+3yu/9FpGLBPV617PPAB5bGOhQyoG6Au5dNzzbjSN2xRWBBTfpCiNbR9uJTgWp8u
         wPaF4CAgL84aI9MWMvq8sEhBtQQDBgAotMuDUNZXn1mQ9qPDQCMdyxeSxUPKTrzgnzJ+
         RGhvmXRIEWxfokT+bF40O1pCZyI9Ti6SgTpV59CYRoIRC6pgTAHPV4L1A40cOcOsWBw6
         PpfAmNO/9Hvb0+cPi3YU9oZUCNBy7kWPf/ycJtAZCF53YfuUIca+z2d4ehy2gefyp1j9
         xMCA==
X-Gm-Message-State: AOAM530VnXBHo3pZ0yG2N/QWkATBxc9HKvbYw76/4T7lI4vyp9PL+OYE
        Yab/015CZjkDmAPW3XSRnlI1oXCBl+uj7w==
X-Google-Smtp-Source: ABdhPJzeQHFSFhZuaREi2GwP/hoImxZyAXCT+qZqNSHe19zILOUWjkQRYIqCQkUtPbX5UeDVl8eQSw==
X-Received: by 2002:a05:6602:1548:: with SMTP id h8mr5446509iow.91.1642429700140;
        Mon, 17 Jan 2022 06:28:20 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id a9sm9045526ilb.7.2022.01.17.06.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 06:28:19 -0800 (PST)
Subject: Re: [PATCH v2] block: deprecate autoloading based on dev_t
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp
References: <20220104071647.164918-1-hch@lst.de>
 <20220117084308.GA23131@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bc90e4dd-a759-3777-5eb9-7bf1e0c80482@kernel.dk>
Date:   Mon, 17 Jan 2022 07:28:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220117084308.GA23131@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/17/22 1:43 AM, Christoph Hellwig wrote:
> On Tue, Jan 04, 2022 at 08:16:47AM +0100, Christoph Hellwig wrote:
>> Make the legacy dev_t based autoloading optional and add a deprecation
>> warning.  This kind of autoloading has ceased to be useful about 20 years
>> ago.
> 
> ping?

Looks fine to me, just slightly deferred until the 5.18 block branch opens
up.

-- 
Jens Axboe

