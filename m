Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508D5C001E0
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 14:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbjHJOdZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 10:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbjHJOdY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 10:33:24 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FE92123
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 07:33:23 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-56462258cdeso145036a12.1
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 07:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691678003; x=1692282803;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FDNMaDQzNt6jhmgfr4aEHB2BUEUlzBW0OVG8gpIoUxk=;
        b=z/VbKZ5mI7/5aLnai8F3AZeqNgDPcPxCB3FWI9BquAdSS0XPk5YutwuyGPVme0Gs0F
         r/2hqKD3OVBhg4bL4ejxBOhkJKnRfUDAzRNNKo2SUAWU6jnM9fc/4mzB/jkc2rONvBeB
         CTZauL4rN9WiF7f7u//lM9Tkz15dIEyoH/SrZ+xaimFmr1ZBHmQP9lndcDZv93c2J6au
         H8pePMi22jgg5MweSXC9Me4dKchcu+ol5hMsdEfdd0skj5ByqDunwyxYGkUoIF1S7iw6
         d9+iy/VJuiSO3PuRdg9OuX0cw3LiHg5bQTQrPIo+gsqcs3Jetq0vp72MBCIqQoCiIyDd
         0/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691678003; x=1692282803;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDNMaDQzNt6jhmgfr4aEHB2BUEUlzBW0OVG8gpIoUxk=;
        b=eKBfQmuiRaOwnNzJuLq9Pkh66977s30HSKntB9oiuu3zwv4sGeW9LEFIIQ1ORzYk1J
         xGIKxBg6Y5fmXvaNSi72lhIy/sEPguZPHqV3fwl9M3YQzoDh5hrJeGGYQg/J+zWpT107
         ch/hlIGG/6lpRnAU9tzRXpCynHwLMoaEGMEbepXYjljhGLLLVfbMYpJ1n123bNIzP9Ox
         BCwFqlVbiZeuXjk/CVSMB1QyrHL7+cgcWtcncuaGNKPRdUrQm0EjvzjWCHj3rtncqSk7
         9vSqfpl0d0hSxzlsfxqQnqgXXIuJL5kvTHSdwPDZfpoSQv6wxOR+GFV0DKN4EbaAYoso
         P/hg==
X-Gm-Message-State: AOJu0YyZthtIZwqUDOnMUyoHD2AYgBrxtGPAZnz9OEBQNRPsU5ZvnMHY
        i8mGUAZbrTLeZfWosiWJn9ppSQ==
X-Google-Smtp-Source: AGHT+IEJlMTPwVY7u0voLh5FYZmzIQFws2l8JPFWphla0IH1jFFR5q9s3ib8pYfkAZEcQbRwDkmNMQ==
X-Received: by 2002:a17:90a:5aa2:b0:268:196f:9656 with SMTP id n31-20020a17090a5aa200b00268196f9656mr2399773pji.1.1691678003375;
        Thu, 10 Aug 2023 07:33:23 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090a2ac800b0026307fa0442sm3646151pjg.49.2023.08.10.07.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 07:33:22 -0700 (PDT)
Message-ID: <e7769263-322c-40a6-9ca2-9a44daf3ce98@kernel.dk>
Date:   Thu, 10 Aug 2023 08:33:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] swim3: mark swim3_init() static
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Jack Wang <jinpu.wang@ionos.com>, linux-block@vger.kernel.org
References: <20230810141947.1236730-1-arnd@kernel.org>
 <20230810141947.1236730-6-arnd@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230810141947.1236730-6-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/10/23 8:19 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This is the module init function, which by definition is used only
> locally, so mark it static to avoid a warning:
> 
> drivers/block/swim3.c:1280:5: error: no previous prototype for 'swim3_init' [-Werror=missing-prototypes]

Applied, thanks.

-- 
Jens Axboe

