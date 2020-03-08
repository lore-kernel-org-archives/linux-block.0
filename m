Return-Path: <SRS0=O/R4=4Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF3DC10F28
	for <linux-block@archiver.kernel.org>; Sun,  8 Mar 2020 13:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F02120866
	for <linux-block@archiver.kernel.org>; Sun,  8 Mar 2020 13:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgCHNM2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Mar 2020 09:12:28 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37611 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgCHNM2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Mar 2020 09:12:28 -0400
Received: by mail-lf1-f67.google.com with SMTP id j11so5451777lfg.4;
        Sun, 08 Mar 2020 06:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+Vaw8bBmhQ+Z1j0Ys0keo38e9WfzBC59wAMA1/zMo7M=;
        b=Txy16obncE/vJyksDQoyAU5+AeUI405AcniLUMknR9DQrnwCnkl2/v3ySKnnRzJU4I
         N7A7vimXZRPokotJQPTEdBhSfnFDE4ihok5ooMK6bTyAdLKmpjyQgc+N3pZ/f5QBNGFP
         xLYzOhwTVez5oYqv8KXAufA+D9MQr4uRHLLznBqXbuPZSnIl70cPW9DuMjvLRxnlTWhN
         Rmautr+eMvtXFRkO2jcwzqTMBovqtDZuxV636ON/F3x7hRIIwT8OSAMB1qlvYZUByO49
         Nb6ikfWUYqGLGaGpF1zgl37SZrcwto7HRDh11aXRkBWaBzVSa/tBX0PWQWwtt0SIeNQh
         W5CQ==
X-Gm-Message-State: ANhLgQ07XQR3nSLyxpMv27t44gmdpAMUggv+44+AZUjNYsQkr4XCxYZg
        K/QeWyWdFnD3Nj4oiMzzBdQo4Tck
X-Google-Smtp-Source: ADFU+vu8i7qwxHwe2gMem9pPl8kj5/T4GBw4+shSXE5nvQ1O+12xxDO6jG3O1gXQRsNdtZ696XFKUw==
X-Received: by 2002:ac2:4906:: with SMTP id n6mr6959117lfi.163.1583673144118;
        Sun, 08 Mar 2020 06:12:24 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.gmail.com with ESMTPSA id z23sm17092713ljg.99.2020.03.08.06.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Mar 2020 06:12:23 -0700 (PDT)
To:     Willy Tarreau <w@1wt.eu>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Ian Molton <spyro@f2s.com>,
        Russell King <linux@armlinux.org.uk>
References: <20200301195555.11154-1-w@1wt.eu>
From:   Denis Efremov <efremov@linux.com>
Autocrypt: addr=efremov@linux.com; keydata=
 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
Subject: Re: [PATCH v2 0/6] floppy: make use of the local/global fdc explicit
Message-ID: <e925dc3d-53d3-b656-8c17-470ada66f3f7@linux.com>
Date:   Sun, 8 Mar 2020 16:12:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200301195555.11154-1-w@1wt.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 3/1/20 10:55 PM, Willy Tarreau wrote:
> This is an update to the first minimal cleanup of the floppy driver in
> order to make use of the FDC number explicit so as to avoid bugs like
> the one fixed by 2e90ca68 ("floppy: check FDC index for errors before
> assigning it").
> 
> The purpose of this patchset is to rename the "fdc" global variable to
> "current_fdc" as Linus suggested and adjust the macros which rely on it
> depending on their context.
> 
> The most problematic part at this step are the FD_* macros derived
> from FD_IOPORT, itself referencing the fdc to get its base address.
> These are exclusively used by fd_outb() and fd_inb(). However on ARM
> FD_DOR is also used to compare the register based on the port, hence
> a small change in the ARM specific code to only check the register
> without relying on this hidden memory access.
> 
> In order to avoid touching the fd_outb() and fd_inb() macros/functions
> on all supported architectures, a new set of fdc_outb()/fdc_inb()
> functions was added to the driver to call the former after adding
> the register to the FDC's base address.
> 
> There are still opportunities for more cleanup, though it's uncertain
> they're welcome in this old driver :
>   - the base address and register can be passed separately to fd_outb()
>     and fd_inb() in order to simplify register retrieval in some archs;
> 
>   - a dozen of functions in the driver implicitly depend on current_fdc
>     while passing it as an argument makes the driver a bit more readable
>     but that represents less than half of the code and doesn't address
>     all the readability concerns;
> 
>   - a test was done to limit support to a single FDC, but after these
>     cleanups it doesn't provide any significant benefit in terms of code
>     readability.
> 
> These patches are to be applied on top of Denis' floppy-next branch.
> 
> v2:
>   - CC arch maintainers in ARM patches
>   - fixed issues after Denis' review:
>       - extra braces in floppy.h in declaration of floppy_selects[]
>       - missing parenthesis in fd_outb() macro to silence a warning
>       - used the swap() macro in driveswap()
> Willy Tarreau (6):

Applied, thanks!
https://github.com/evdenis/linux-floppy/commits/floppy-next

Ian, Russell, I hope you don't mind if these patches will go through
the single tree. If you have any comments, please, write.

Tested:
[x] Eye-checked the changes
[x] Checked that kernel builds after every commit on x86, arm (rpc_defconfig)
[x] Checked that there is no binary difference on x86
 
>   floppy: remove dead code for drives scanning on ARM
[x] Checked that there is no dead code left unnoticed

>   floppy: remove incomplete support for second FDC from ARM code
>   floppy: prepare ARM code to simplify base address separation
>   floppy: introduce new functions fdc_inb() and fdc_outb()
>   floppy: separate the FDC's base address from its registers
>   floppy: rename the global "fdc" variable to "current_fdc"
> 
>  arch/arm/include/asm/floppy.h |  88 ++-----------
>  drivers/block/floppy.c        | 284 ++++++++++++++++++++++--------------------
>  include/uapi/linux/fdreg.h    |  18 +--
>  3 files changed, 168 insertions(+), 222 deletions(-)
> 

Denis
