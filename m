Return-Path: <SRS0=+obT=ZO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF16C432C3
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 18:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E844F2071F
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 18:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="v5F6MF9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfKVSzR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:55:17 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35279 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfKVSzP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Nov 2019 13:55:15 -0500
Received: by mail-pl1-f194.google.com with SMTP id s10so3469475plp.2
        for <linux-block@vger.kernel.org>; Fri, 22 Nov 2019 10:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X6rPmQDZwe/5i7ZTCvqZcbNZzoAWqfhhq8dBz2pi7Wk=;
        b=v5F6MF9AvTQxk7Vd5aRT1Y9yCCk/Z9IA82/6jCjumROrrWFeFp1LbnUS5FJt9Xc7db
         NEEbLR70LWuDqes2CfBtQ6aUTKTa3SB2WZDmj2X1TaEa7JG03Ov0oOxccgWiam8ANZ9v
         Eme8ZIJlZTJNGSlQ2LoRYWSuhJgV+FRdjjdsymttU5qfRuZMpr5S+CfdK9q5V32uuJk9
         s7spTGMpIFLp1KaoDmWmCcrrqZNnqsDUpcMkn2PrQZjOT5cArAy/2zeoGmp5XTAGBQTc
         RAzOzoIri1O2C2TGJS1yJ14UMeJUn/+FRqi0nUY3jgHvmBRTYJ9eptMHcUQ9eczjbpgJ
         TN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X6rPmQDZwe/5i7ZTCvqZcbNZzoAWqfhhq8dBz2pi7Wk=;
        b=t4QS90Wsn6JUb4dRgwkcnP3Acan7e5aiCHjOgvGMGwBEZuxsQuo48Lc5lA1FElGqbi
         crE3dCWhMRHd1Fvu3/+IRtPH1ikcu5gsRdbkMDelRnz+UHtgeXRsYJazeKTl0453iXHa
         6Q4cUXC8Kg0vodlYKcwU8yfBuLpPnvUEWn4qdAJkA+7YWKUFclrfAwi0S0xGHe96sY1Y
         knEYDCnQkfx0Y/MiEPetQBE9M8brLRNWnXctVAue0ipv+8YmtmPna6/lXzA1RliG3cxQ
         1mH2/Sus/xZ8RtfzobjjYyAqr6v+yY7b848eZkAauFHKftLp5BAonZZtsK2zMEpVCH7P
         CP7g==
X-Gm-Message-State: APjAAAUFCbwvnxTTkiuCz4xuHaef2KGqyONIsmziHGxmNHAaVPg4SUkf
        kd1X6ItTEcKMqM6Pf9Kt2h3NKg==
X-Google-Smtp-Source: APXvYqx1Uy8tt1rwA8LCWhELsYyAcxykGcj1cwQ1xSbh9BYAAVccoQ2Oqc8lATpIDKDKayjMbyalYg==
X-Received: by 2002:a17:902:d70a:: with SMTP id w10mr16035047ply.279.1574448913595;
        Fri, 22 Nov 2019 10:55:13 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1132::1126? ([2620:10d:c090:180::835b])
        by smtp.gmail.com with ESMTPSA id c3sm8303326pfi.91.2019.11.22.10.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 10:55:12 -0800 (PST)
Subject: Re: [PATCH] block: Replace bio_check_ro()'s WARN_ON()
To:     Kees Cook <keescook@chromium.org>
Cc:     syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180824211535.GA22251@beast> <201911221052.0FDE1A1@keescook>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <181810c8-657d-d603-a833-215f753be5be@kernel.dk>
Date:   Fri, 22 Nov 2019 11:55:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <201911221052.0FDE1A1@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/22/19 11:53 AM, Kees Cook wrote:
> Friendly ping! I keep tripping over this. Can this please get applied so
> we can silence syzbot and avoid needless WARNs? :)

I'll get it applied, I did see syzbot complain about this again.

-- 
Jens Axboe

