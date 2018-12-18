Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52895C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 21:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F88E21852
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 21:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="bInJwsRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeLRV5c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:57:32 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44550 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeLRV5c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 16:57:32 -0500
Received: by mail-io1-f68.google.com with SMTP id r200so13989443iod.11
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 13:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=55oujOUnmmZg2AfxbqrWeTrHQLKUmXvuMBjhtTuAsJo=;
        b=bInJwsROZwQKH3oNQ0pNfCfC7tV+z++JE7Xj5fU2dqkgZUHO3t2M5ahUQSIwikebrU
         mhw5aPOFvn8lizjrQvmBC4QR/nDSFIY9glQjhGDU0Q4+8C+iwprw3NgdMAwPNDuFqyRQ
         wRzZz4JP0uFGM19hmcTWeDVWR3Rne2Qv6R3sAiNV0/bnxMOwoU2YdxwajULEkuQ4nmlu
         QOu1z2f7QnXcVG0cINKJY6LygMI0ZG3WHWbCLp/YTCMVGKjB4Kh9vcNehRzIvlRz9UAN
         INH5vMhV9tIFJwYQyIILG3FzOQGuXcGP1/ok8gpuRdMeKJGX06XljtVMQt3w5F6Olj0m
         HcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=55oujOUnmmZg2AfxbqrWeTrHQLKUmXvuMBjhtTuAsJo=;
        b=FawSAa6z72dqU8OLgdPqE2nltZvPZcQ5DK1NqopLGFsF9AisKRiudFnj8ZVhyJv42N
         lllHEmfH6M2lIuBZtdu5LP+GY/QQJfk+wJoFX6+4RoX0IoqB7E+t3C48DmVxQzx/XCuw
         RcLlutIFYGs99fECZ5JJKrItUBLD/W/cPpG3+KVkepndjrrNFh8kiZCPWX7FAB+5aaHm
         /Ud0z8klYTIyJwBCoqzPPlUBOY/P0e8zYZGyaT14awhvBJ/m2+ux8wcLS7Z95IHxa9P/
         1zVtXJLCLI8PPHHyf96tJHw0LIgDMTet83wp0Pio4GDLftHsDnDoBfeGkBVmQJazs405
         V1vQ==
X-Gm-Message-State: AA+aEWaGcfKvgi4/wjXd/JzDOBiPK3oXjTJFgF1H/OlBkPdTjHyBOfQP
        +QKNH43lkTiNUbPHlizK3IaEpdi9EZWm2g==
X-Google-Smtp-Source: AFSGD/WcB6i6Qvn7FnPDnrTCYEyezTLAl7quf3yZP5peWj5nRnvREnaHPW9stFf91irWTcogpnILGQ==
X-Received: by 2002:a6b:7514:: with SMTP id l20mr12341582ioh.120.1545170250995;
        Tue, 18 Dec 2018 13:57:30 -0800 (PST)
Received: from vader ([2620:10d:c090:200::7:ffa])
        by smtp.gmail.com with ESMTPSA id d9sm2845368iom.72.2018.12.18.13.57.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 13:57:30 -0800 (PST)
Date:   Tue, 18 Dec 2018 13:57:29 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH blktests] blktests: Fix compilation warning
Message-ID: <20181218215729.GA12683@vader>
References: <20181217055108.11461-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181217055108.11461-1-damien.lemoal@wdc.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 17, 2018 at 02:51:08PM +0900, Damien Le Moal wrote:
> Fix strncpy length to "sizeof(buf) - 1" to avoid the compiler warning:
> cc  -O2 -Wall -Wshadow  -o sg/syzkaller1 sg/syzkaller1.c
> sg/syzkaller1.c: In function ‘syz_open_dev.constprop’:
> sg/syzkaller1.c:204:16: warning: ‘strncpy’ specified bound 1024 equals
> destination size [-Wstringop-truncation]
>      NONFAILING(strncpy(buf, (char*)a0, sizeof(buf)));
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> sg/syzkaller1.c:143:7: note: in definition of macro ‘NONFAILING’
>        __VA_ARGS__;                                                     \
>        ^~~~~~~~~~~
> 
> Since the last character of buf is forced set to 0, there is no
> functional change introduced by this patch.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

Applied, thanks, Damien.
