Return-Path: <SRS0=/PDd=CJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAF3C2BB4D
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 15:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38D1E207EA
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 15:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="x/p33DHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgHaPjc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgHaPiv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Aug 2020 11:38:51 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A4AC061573
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 08:38:50 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id q14so1498111ilm.2
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 08:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z4HUQWA3GefTjgAhlZ3zitTeaamVvr6/rpOjMH3aSW8=;
        b=x/p33DHrbarbMYtfOSZ/rPXjhV4iWSoDg+harqWTLy2UIGFiPfeTkbOY/PY7ogYSX9
         EzJ26qecDbTSGi22ZgIVLdZUPQmfCiaTCxnaOeyA6fS70oCbLOjVnu4WSR2AdBYURIwX
         fSDwLOC841MUSoPGG7qVaE9i2r/4oGzorc3j3hbGedV7DZLRKtkT9f9HH4WckfiKoim1
         Nte/NRF5xebeN0ScjQZv4jXmtxDxMf7h/Xcs9mBLz2scuLl1gZM39SHIOtXdhjMi8Ha4
         tLe386pgdACwcgAY2Bw4A67WFqvLPFqxhWQqCL2s6GWmFTBrJcjBQT+HJ6REEeQ1NoRK
         KQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z4HUQWA3GefTjgAhlZ3zitTeaamVvr6/rpOjMH3aSW8=;
        b=r+ulkiU9orxJDGDsaWt8cEao8ExJTgsObSteDjiIEe5X88MxGGptMmQBtb3sZ8sqd1
         bggcVx55bmzzqZHAMI74op3VH/xv5590quB/n/mEEykSSo9Qr1f36lp4t95g7zYFBslR
         JFmMCDyDanuDujd4C2FLlmRFRjCtbc9M79MOAPn0OhWcsWODJtWXjivFtp7gnkWFs9o5
         tl5seG32plXcSvdafNnbBvlQMo7Bely6zt57GO548a6yzZ6a+oSwwE8ZZoRGIykX7Av4
         y43ic/GZJY0pm6s+aWnx1xLjPKgvVP3JkJtmnQ/pQndHo62MVlbArvfjl4wHHIShdvIp
         EyqA==
X-Gm-Message-State: AOAM533XI64zphghdeJTRwvTiyFiGukZRozZXk7b/yMqcnu6TDhqcNyx
        MGE4mIS2lw8q1i+6LOt+G7/dfCRaFlJwcvTM
X-Google-Smtp-Source: ABdhPJx+NfdCs8EPJfJliXCwiAxd1dNJgl+vk0APgfT7FvaVuOY1AQfuu59SwssMcJS/hGzNlBRorw==
X-Received: by 2002:a92:48da:: with SMTP id j87mr1934420ilg.78.1598888329706;
        Mon, 31 Aug 2020 08:38:49 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 3sm4744495ily.31.2020.08.31.08.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 08:38:48 -0700 (PDT)
Subject: Re: [PATCH 1/2] block: Return blk_status_t instead of errno codes
To:     Ritika Srivastava <RITIKA.SRIVASTAVA@ORACLE.COM>
Cc:     linux-block@vger.kernel.org
References: <1596062878-4238-1-git-send-email-ritika.srivastava@oracle.com>
 <1596062878-4238-2-git-send-email-ritika.srivastava@oracle.com>
 <20200814062620.GA24167@infradead.org>
 <C6F86C38-BE29-422A-8A57-5144E26C4569@ORACLE.COM>
 <de5c94ec-9079-22b7-bbcd-667f3b0fe94e@kernel.dk>
 <A0A0C5C0-957C-44DB-9B42-3EEC473D74C6@ORACLE.COM>
 <3C0C6E56-ECEF-457A-89A1-0944E004DC77@ORACLE.COM>
 <d5c2818f-ed6e-e8ff-709d-ecc4858ff4de@kernel.dk>
 <67BDE4B3-830C-476F-939F-5AB2634E0F7D@ORACLE.COM>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6d864384-2b6c-0a1f-8f85-9ec5acb5b484@kernel.dk>
Date:   Mon, 31 Aug 2020 09:38:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <67BDE4B3-830C-476F-939F-5AB2634E0F7D@ORACLE.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/28/20 11:10 AM, Ritika Srivastava wrote:
> Thanks Jens for the update.
> I will look out for 5.10 branch and send the updated patches.

I pushed it out this morning.

-- 
Jens Axboe

