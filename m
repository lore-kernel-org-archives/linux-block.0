Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35980C43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 16:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiGNQap (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 12:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiGNQao (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 12:30:44 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA5C65593
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 09:30:43 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so9155691pjm.2
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 09:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=j73152At3Tez8Ku+H4U593w6FOIkEmXuldDavt74jYo=;
        b=E+ZrkllF13Yqbcs1uNnH2jjnHMT80auNTYEwrH3XGniySbcAACKd5ogvvsdrNp5tiH
         IOo3E2VIKZPfTWPAtp4s+s7IloMz6BUulDqleWS96wxVXlMIEIIMC3oo5bfqfT7UqXRa
         74vfVdm9H2a3BveGtIsrsxcUQORrFpx+Gc7aKrCcI9jFAxggsHYb+GHVEW7WDHuVfcTI
         GfOWnxNP1xca5GNsmY26wPCgQ25JYuP6nz2J+ne2zHLtLib1pIBZgfP45yNr3BXbUiST
         du9OsVq9rYm8N37nr1QlSb+06/WM9VZ9m/yWKYmbz0gZCfpoiWMw8J/sraSwGuGcLSFX
         Fxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j73152At3Tez8Ku+H4U593w6FOIkEmXuldDavt74jYo=;
        b=IjX+FOEqUQ3Xkk9z0UhF1v2w6f26PxEediyHn817yMTlovuX7ZBm3mj4Jnn+zINRKb
         Q1adrr7PMKQpcBCsQ116LdAKJMmoQISXBkABQeHIEcUn7XK4G+6NGtwjFHtB76PSxbYC
         n7jv6vekrq6cgtE3AtGgZfF+6OHdKi0TYqzjRViZMLmqNdhVwuOPV5/8yrRXo11zWWVe
         KX5j6sOj8eQi1wwVX4V/SjGrXehjqR1ffMHF2RrDbnnoFOfnjyh6JV7LEooRCohfgpCg
         029K308PDBKG96ITFqqsyU2ObtDYoPtWmdjzQlXLjtx3rG/hevtEbuMOJJbJU8SBNESU
         ljyg==
X-Gm-Message-State: AJIora+8sCYnopisTJYLLdZC/zjj9UkFsIZu0o8AmkHAirk3PCPKHoCH
        xxmb/sNLX2SoHk819PGsRNT7wQ==
X-Google-Smtp-Source: AGRyM1tAcOJzsWy+ScsCmtUZKsxabSBS8iERcX/7YK6OSUV65sWQU7PAE0VP4P1XIREHrjomgIJ6HA==
X-Received: by 2002:a17:903:445:b0:16c:5d4f:c329 with SMTP id iw5-20020a170903044500b0016c5d4fc329mr9197186plb.104.1657816243043;
        Thu, 14 Jul 2022 09:30:43 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l1-20020a63da41000000b004114aad90ebsm1579313pgj.49.2022.07.14.09.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 09:30:42 -0700 (PDT)
Message-ID: <f67a182c-7f56-8e6a-9a0d-5b333afd1135@kernel.dk>
Date:   Thu, 14 Jul 2022 10:30:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] nvme updates for Linux 5.20
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YtApX8HC+BcN3NvL@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YtApX8HC+BcN3NvL@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/14/22 8:34 AM, Christoph Hellwig wrote:
> The following changes since commit 3b56590b1715b998cb5c73a5bd2e9d340ccb42dc:
> 
>   rnbd-clt: make rnbd_clt_change_capacity return void (2022-07-06 07:38:40 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.20-2022-07-14

Pulled, thanks.

-- 
Jens Axboe

