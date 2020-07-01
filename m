Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C066C433E0
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 13:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C170206BE
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 13:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rXuxcGyW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbgGAN0y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729689AbgGAN0x (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 09:26:53 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C825C08C5C1
        for <linux-block@vger.kernel.org>; Wed,  1 Jul 2020 06:26:53 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id u8so10680340pje.4
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2020 06:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8BbeHW9IIOk3PdF0WARtl38cHXgtbslDyE/1MVd4Fss=;
        b=rXuxcGyWgHlJsANms2hD+cC/UAfI9dgrCnTxOkRZdk5qY7cs2Stb1V9q0aOkuWx6Gj
         BXrj6vjhQBxVYPBMb/UtCQawJtpvBVDJWBG+5ONv+rTt+6LR8b9bc58ChR6XN/CzWIIg
         HurB5n1tcl3AjvVnBlT6ERwkIrztU7tLoStHH3jB6ZPgxn8ToPIZlgsZinjQ3zCdQxPB
         JuW5d2HGF8Qj6m9W49oT0UDvPKw3/GkTkAAKcKK+fwyjWbSLb/e+93i/3qIPcTSeIzi+
         wzb0+xP2y9tJMWoOM2BjYafylv49eiDOecPfohDWeB22cFAW14g3vGeamYlIWOj/X3l6
         hH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8BbeHW9IIOk3PdF0WARtl38cHXgtbslDyE/1MVd4Fss=;
        b=Iwr6grefe8uEvRvdRDzwiS5m2CBY2MM1RpzLti974hNMBdZ5hzTilVW4Wji+EF2bC0
         0dW/6nytYtQH8rwPUybVG0Vlewax+bQ+NToofJCNlu7PmvlcL4QnPlBmamPmVAMIX0DM
         MkxbOPGWOBM8l2/XIeIR2BszUNkxiHAgukDtUpW9EUu4FOtHoJjRFwiY8Y6l88pkY2OD
         PEWH07oO0j4+ZAbn9RfD8bUSLPY/5MSNt6HmWK/0aux4J4T5o0ye+eUyiydTpeMfj9E1
         WeI9150A9VfzGw9SXWfQjzSAQdU5NY+3tiQDvlFZJURbZrePrBqg4xpmIZi2Fnsxd0IN
         03Mg==
X-Gm-Message-State: AOAM531BLijsebWhjhy1zeXt5zqGSkYdjL+zhlTYWoUiEHxSoRCkh8/T
        Xx5OMVDeHFED/FGxQ0wiGk7u1WsgHYPPww==
X-Google-Smtp-Source: ABdhPJw63C2DYXpAmNIcsLTezVMmEX/hDbXi/sX+bfgxKN8kNtMUFF/NrPz2l9jL6Yqlkj/LrfLqSw==
X-Received: by 2002:a17:90a:898a:: with SMTP id v10mr26773288pjn.95.1593610013028;
        Wed, 01 Jul 2020 06:26:53 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:64c1:67b1:df51:2fa8? ([2605:e000:100e:8c61:64c1:67b1:df51:2fa8])
        by smtp.gmail.com with ESMTPSA id b4sm5302729pjn.38.2020.07.01.06.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 06:26:52 -0700 (PDT)
Subject: Re: [PATCH 1/1] blk-mq: remove the pointless call of list_entry_rq()
 in hctx_show_busy_rq()
To:     Hou Tao <houtao1@huawei.com>, linux-block@vger.kernel.org
Cc:     Bart Van Assche <bart.vanassche@sandisk.com>
References: <20200427131250.13725-1-houtao1@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cd6cae50-377a-7ed4-0857-bc7ec9859c55@kernel.dk>
Date:   Wed, 1 Jul 2020 07:26:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200427131250.13725-1-houtao1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/27/20 7:12 AM, Hou Tao wrote:
> And use rq directly.

I re-wrote your commit message a bit - but otherwise, thanks, applied.

-- 
Jens Axboe

