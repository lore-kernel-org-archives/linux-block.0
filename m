Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423C5C54EAA
	for <linux-block@archiver.kernel.org>; Mon, 30 Jan 2023 23:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjA3XY3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Jan 2023 18:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjA3XY1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2023 18:24:27 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F87C149
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 15:24:24 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d3so13277076plr.10
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 15:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jqwk2vPFIVhtsM+UVJdEJNGhKk+m+eItQrOKOkasYN8=;
        b=MbY0klynh2MLeTrDRAq4ZzTUlTDB+POkBSkEUKCxaQ2FplHlLp8fsr0ACfwgRqugTF
         +/Ff10extEQHpC/gW9gA/vJNqeRFqYMU1jNoYunRpqxdPmQJsCuL75OgEKcyXd/7RraK
         I2bZl3p7hYoshO4cNj9zAxEzuMzPKSjcRTyPS0zWxTU5Wxbyk7N2TYD4mgHZzJG758dH
         /heefY7DXJ3+iXltsIb9sQyt99pnCfuavUpeX/nj0YU5OWfCCJUlqx7hWXMMlx+a8SMD
         q/D6+aHwgbg3Bbo25MecqqhoBTsXxg7c0W0st01TJd8zmtLQetUG3p253W5L5ZymiqY6
         WMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jqwk2vPFIVhtsM+UVJdEJNGhKk+m+eItQrOKOkasYN8=;
        b=X9lNLtKkeLuossiLTXf5E8imWRyKEAcf1T+W+DhTFLBmi9WxQ6WOKYI6bP3lGEOi9o
         JQvE9XImLucvIGnUg2rRVG5isg6hxu/vMB6Rk2SFydgfzXsqNjRHKzdDaOlPlbhbdNmc
         6ukWv11F+mxtCmrMlnl/PjcznE6BMoI1EK9UnqIemMTOOnVXtlv8yy9Z+fB+IisX7rY4
         EwluPCP5YmUwuTvFqutq11nGORt7jpf0IPsB7GaOZ2rNR94/gnPsmdWSG0Wctw429Qt2
         mHE4Bd+HZfWPNq1z+ZFi3iDLGK0zc2KUmJa4g5fSxy0BWOFfSe9b9ZMBsWrb939fZSUw
         bfJQ==
X-Gm-Message-State: AFqh2kruZT4IzdgfYEtimoQJF5A4glx0iVPBSoxatBMyrPkkdxFDWw6C
        QGRBN0c57TZYA4C82gXVHYdgTQ==
X-Google-Smtp-Source: AMrXdXtAyNYMaV/6Re9nYsIr5DYubM+IfUx3VBh3F/HXClfNxoN//On4PcIy2blXZOeTFs++a5YB9Q==
X-Received: by 2002:a17:902:b591:b0:18f:a0de:6ac8 with SMTP id a17-20020a170902b59100b0018fa0de6ac8mr12602160pls.2.1675121064051;
        Mon, 30 Jan 2023 15:24:24 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902a60700b00192b0a07891sm8316169plq.101.2023.01.30.15.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 15:24:23 -0800 (PST)
Message-ID: <12358848-d3dd-ec0e-9a8e-39e0ed807e86@kernel.dk>
Date:   Mon, 30 Jan 2023 16:24:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] drivers/block: Move PARIDE protocol modules to
 drivers/ata/pata_parport
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <d4f7ebd5-d90d-fb96-0fad-bd129ac162dc@opensource.wdc.com>
 <20230130211050.16753-1-linux@zary.sk> <20230130211050.16753-2-linux@zary.sk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230130211050.16753-2-linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/30/23 2:10 PM, Ondrej Zary wrote:
> Move PARIDE protocol modules out of drivers/block and update CONFIG_
> symbol names to PATA_PARPORT.

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


