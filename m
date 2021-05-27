Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759CCC47089
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 13:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A31E613BA
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 13:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbhE0NkS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 09:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbhE0NkR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 09:40:17 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95497C061574
        for <linux-block@vger.kernel.org>; Thu, 27 May 2021 06:38:44 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id r1-20020a4aa2c10000b029023e8c840a7fso107971ool.12
        for <linux-block@vger.kernel.org>; Thu, 27 May 2021 06:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4eHU56OavFWesCLDdAv7Vdf5HO31M1iMmqu3fhWgUAk=;
        b=eqo68ERsC2eAQcqwxYhWPsRrMzGg3aydusljL3RA08ZrnIdWwgndYDNxI811wMrB9h
         oC1PdNcYGx/D4qy0RmH519bA5vNW1zaWgJSLLYKEDgGuqKZ2503csGufug0gt+L2RXmk
         z2O0Gyp/7YIknfhmxnGshr/sMyGJcvK3lxCiyUw1phiB4nMNrDJ3SpZWrE5C2SdpTKZX
         vs5n0REbGxnGotyMFtTS7IcJ7jXZ4iACYhcQRzxAdIGwlG54EH0I/MRyjSoJZgIi4JFo
         bdLSMG8k1bGEYexUgjGOsql9IvgH1EgF9+3g4FUcr0l54kGKs10ODa6eeaFoHKU1bzGL
         UVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4eHU56OavFWesCLDdAv7Vdf5HO31M1iMmqu3fhWgUAk=;
        b=fOAhueN7eZjU2mjhQdjpAYJCZeOL7FkYj8gvsnVDFOjuhw3dWqIjtPOJ85RY3oBAQK
         aO5CMQrWmRSyu0u13iDKB2dsj+5DuWf1/Nz+vDgLkWqRFCUt+sdsGQ//hGOCjfKoXLy7
         OdzOKtQfTD15X4EbufRbqjIe1lJBF0lemzRTHRa/GZBHq2UdgneQ6le1eEJJySK/apvO
         w6Jb8hRYzq5kWh7W86DzLOKxv/KzLYPW49cpSgafg2QBgG0jaNQwGzF3KhJ5xRPdVbPf
         WS8v2EVcvccvJq/fDYg+h06EUiQqtF5C4EGke9a9mmGcKUMqGBCDLgcJUSkoqVeCk9BT
         JyEQ==
X-Gm-Message-State: AOAM533s19L1bUKe0NrujckM+tSRulJP+vLAwajRwcFW11FKdNVuCxBH
        S78V5/fHb3q39RGchomgeNypPQ==
X-Google-Smtp-Source: ABdhPJy8c7dZ7F012TVZTqv6U/eX6J1o7e+ZSdOPhqpFyLu6FzrJ4As1ekPlFgGBFeOD+IF9e6iIaQ==
X-Received: by 2002:a4a:97ab:: with SMTP id w40mr828880ooi.19.1622122723881;
        Thu, 27 May 2021 06:38:43 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.233.147])
        by smtp.gmail.com with ESMTPSA id x11sm477677otr.36.2021.05.27.06.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 06:38:42 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.13
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YK+JXQOdbaoUH4Zr@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <95f7e606-fdc2-4668-af69-a68d85e82144@kernel.dk>
Date:   Thu, 27 May 2021 07:38:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YK+JXQOdbaoUH4Zr@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/27/21 5:58 AM, Christoph Hellwig wrote:
> The following changes since commit bc6a385132601c29a6da1dbf8148c0d3c9ad36dc:
> 
>   block: fix a race between del_gendisk and BLKRRPART (2021-05-20 07:59:35 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.13-2021-05-27

Thanks, pulled.

-- 
Jens Axboe

