Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2904DC636D3
	for <linux-block@archiver.kernel.org>; Mon, 30 Jan 2023 23:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjA3XY2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Jan 2023 18:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjA3XY1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2023 18:24:27 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722D7EC50
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 15:24:26 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id 5so13322476plo.3
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 15:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dwROn1mPsy/kk9N99ydvqBeMM2O2HAtXlONjIBsBtw8=;
        b=xxGxFvWVTHchteWkrGLVN87rZtWQkFiCxzY68BpeJVBgX7tReOeydvbM95V0Aq4CCl
         vHzAuADH9mpHuHkcDV4y077Mku51ieEhX4uv3tNKLg/fV9wlVnghUZC+Qqcj6qtUIjsd
         52uIMtucOiDZGo2ciwqYGgRNZXxUwDdB/GH/0GwMSwijRy26JsMBQP74zJnIayIyl9lJ
         Te26KbAIxlqkbU86bhr3lqJrGiC7szZ64p9T2BTXJwRMqMhg0+VkpYfJn1Lt/CgaeQ0f
         dya2uNnHiWPBP3Qvak5U7gKtqN7IrqRBasItA/nM7ffaS1txsYKSc+xc8lG1z++B6XOF
         WSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dwROn1mPsy/kk9N99ydvqBeMM2O2HAtXlONjIBsBtw8=;
        b=aWzBo/Bb/R4OuCYPs7li27N9TTb5k+uCNsVpbmKWAcqco1cBAtOsL5mqq7rq5mTZRq
         ddYtk4oezPJS0qF1hLvn3KtwQ6Z0Ar1khQjiBPfK0mMACdt0FrdNbsKcvMHnoyDfQmz9
         iKrCTKW2/EszxvsHEi4edQmaJ0DLw5+Yc8FdFHKWGuKXFxsMyyQBihKHscLRy5qH23VE
         bE2xG8F/wIMlWs20Vy2srmCF3nLG/8SLaQ7r+q1Gs32gYUqMKYqJUcNUV2Lt5mA/WPe1
         ootin24XSFkcszTMK/KRHnwyK00+bYTVaNDQcdi1VkN99FIwlAjiIXwNgbEjvQqRIhte
         SFng==
X-Gm-Message-State: AFqh2koLHfBu8AuEr9JU4M/ksEgJg6y7YXhvBV6ufSj4pQMyKSVc75ek
        SJxI7FF4kRHiht8N9+q9w4KRFQ==
X-Google-Smtp-Source: AMrXdXtwvzAVUVQcTEDmRvSkP9UYKDjI1dCGwoHCj3Jhl1jNF1LvHS4uV9XDtAqnjyagFkGrzW5Hqg==
X-Received: by 2002:a17:902:ab16:b0:195:ea0e:3221 with SMTP id ik22-20020a170902ab1600b00195ea0e3221mr9818704plb.3.1675121065913;
        Mon, 30 Jan 2023 15:24:25 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g12-20020a63374c000000b00476d1385265sm7190333pgn.25.2023.01.30.15.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 15:24:25 -0800 (PST)
Message-ID: <f3a157d7-839f-ffa9-f2a0-d50ad8d45792@kernel.dk>
Date:   Mon, 30 Jan 2023 16:24:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] drivers/block: Remove PARIDE core and high-level
 protocols
To:     Ondrej Zary <linux@zary.sk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <d4f7ebd5-d90d-fb96-0fad-bd129ac162dc@opensource.wdc.com>
 <20230130211050.16753-1-linux@zary.sk>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230130211050.16753-1-linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/30/23 2:10 PM, Ondrej Zary wrote:
> Remove PARIDE core and high level protocols, taking care not to break
> low-level drivers (used by pata_parport). Also update documentation.
> 
> Signed-off-by: Ondrej Zary <linux@zary.sk>

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


