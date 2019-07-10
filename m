Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6022FC74A35
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 20:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2836D20651
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 20:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VMpmwqIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfGJUGJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 16:06:09 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:38464 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfGJUGJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 16:06:09 -0400
Received: by mail-pg1-f172.google.com with SMTP id z75so1744579pgz.5
        for <linux-block@vger.kernel.org>; Wed, 10 Jul 2019 13:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Y49E8b44cTzQ1tU6Tj0MGgZwbEwhsGV4mKYcjco0sr4=;
        b=VMpmwqIuT9GETxc1iaeyDfqOp/rpkSt29cizwMSJ1wuDF4c8H2xsGU/ob6qDKTulX6
         z9v0UWWa78rphoOlfPv4GWxR9tjWMIAY+68DIp/gLaakKyiI28mGL8Zf83M+9FUCA0gz
         KbAM4moYSXS6ZqAYi4acUSeCLSz6IATABBoXDHhanJvNEbxC06a973NXlITpWqIV77ku
         Mqr2cH5/qvJvwvqjKCk2QPAxVYMzSwMRQPXfZjt5zEMq7oXwBo/FKHlOkMPDGP8na3qa
         +i6m1LnaJRxxvH/TYVgv7scspo3wa5gXGeuXvvBK5nvWAwwBDbeivXg/nysEvoWKMJq4
         h7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y49E8b44cTzQ1tU6Tj0MGgZwbEwhsGV4mKYcjco0sr4=;
        b=fKiQDzLb4uTiVur8TSdw4ctMjnxasxn/beImOi7tUiiK1Ief50xVAYHF/6zoyFCcgQ
         qKv+8iycE2XWGt4hOAAUwW7b6dM15/L6JFWqrwrOr1XmNISdADXZKpsyIUfVHovrZ2+6
         slq6+LiuT+aNQJ2dsCb5h+rbWBFmUuWRNxhwr/lCKMhfajXOHm/crP6xvjA8SFdtNcYW
         9zJZ7i97NZ8MyD3ubh4QazvLMZtH4h3uzcSf+DA/aHAwjnezYIgoVBifVPHVYXuMiJkC
         fFlfVhWkTyTZcBYfloMlUnaeqk6lH++UZX3uTRwCxm0c/pyhVhOmJtx0h76ldMM5AveS
         Cz3w==
X-Gm-Message-State: APjAAAV4mp9QVkZEaYD4WCVHLYURx0ee/Cdmw3EX16QIT/XqbCvaDh1I
        2kZxBgqxyDa4bijihp5qRrjAylpBhBmyFg==
X-Google-Smtp-Source: APXvYqxxUdTaPw4ELgcnhQ2nhxaL3T/GMymnJXsa60t1XB4Dt9PiqSrUnV1ksu2Kc8D9PWepOqfung==
X-Received: by 2002:a63:5550:: with SMTP id f16mr41020pgm.426.1562789167920;
        Wed, 10 Jul 2019 13:06:07 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id i9sm3074722pgo.46.2019.07.10.13.06.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 13:06:07 -0700 (PDT)
Subject: Re: [PATCH] block: Fix elevator name declaration
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
References: <20190710155741.11292-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <438f6368-79e6-2a14-a367-d7ba48f98e05@kernel.dk>
Date:   Wed, 10 Jul 2019 14:06:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710155741.11292-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/10/19 9:57 AM, Damien Le Moal wrote:
> The elevator_name field in struct elevator_type is declared as an array
> of characters (ELV_NAME_MAX size) but in practice used as a string
> pointer with its initialization done statically within each
> elevator elevator_type structure declaration.
> 
> Change the declaration of elevator_name to the more appropriate
> "const char *" type.

Applied, thanks.

-- 
Jens Axboe

