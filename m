Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7B8C04FDE
	for <linux-block@archiver.kernel.org>; Tue, 13 Dec 2022 12:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbiLMM3E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Dec 2022 07:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235674AbiLMM3D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Dec 2022 07:29:03 -0500
X-Greylist: delayed 905 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Dec 2022 04:29:00 PST
Received: from smtp.tiscali.it (santino-notr.mail.tiscali.it [213.205.33.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 828C514004
        for <linux-block@vger.kernel.org>; Tue, 13 Dec 2022 04:28:59 -0800 (PST)
Received: from [192.168.178.50] ([87.15.83.83])
        by santino.mail.tiscali.it with 
        id voDn2802s1ns05j01oDoMD; Tue, 13 Dec 2022 12:13:52 +0000
x-auth-user: fantonifabio@tiscali.it
Message-ID: <e42dd6c7-6365-75be-0fcd-3329b8f8ba35@tiscali.it>
Date:   Tue, 13 Dec 2022 13:13:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Reply-To: fantonifabio@tiscali.it
Subject: Re: [PATCH v2 03/21] documentation, capability: fix Generic Block
 Device Capability
To:     Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk,
        corbet@lwn.net
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
 <20221209142331.26395-4-sergei.shtepa@veeam.com>
From:   Fabio Fantoni <fantonifabio@tiscali.it>
In-Reply-To: <20221209142331.26395-4-sergei.shtepa@veeam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 221213-0, 13/12/2022), Outbound message
X-Antivirus-Status: Clean
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1670933632; bh=zUNL1AzJb7Uzdlx47B9/0o8wRh3Bhbs6NWEEPysoQb8=;
        h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To;
        b=eQh/KfFfLAjfYWZWcanbu/k/4syXDE+y1hNr1/pJi0yo36II7H7RgDvQezdqNDhE0
         GqDtTrjW5QHyB8nEXv7G/33M+fBM3o90+kqHKU6pA763b1hnCOS7kj4bkY/BIv4AvZ
         uFTevywFPyDhLQ9vzpRyVYCus6H9XNfbR7Es0d+s=
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Il 09/12/2022 15:23, Sergei Shtepa ha scritto:
> When adding documentation for blkfilter, new lines of documentation
> appeared in the file include/linux/blkdev.h. To preserve the appearance
> of this document, the required sections and function descriptions were
> explicitly specified.
>
> Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
> ---
>   Documentation/block/capability.rst | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/block/capability.rst b/Documentation/block/capability.rst
> index 2ae7f064736a..8fad791980bb 100644
> --- a/Documentation/block/capability.rst
> +++ b/Documentation/block/capability.rst
> @@ -8,3 +8,6 @@ This file documents the sysfs file ``block/<disk>/capability``.
>   capabilities a specific block device supports:
>   
>   .. kernel-doc:: include/linux/blkdev.h
> +	:DOC: genhd capability flags
> +.. kernel-doc:: include/linux/blkdev.h
> +	:functions: disk_openers blk_alloc_disk bio_end_io_acct
Thanks for spotting this, I think this is not related to blkfilter patch 
but was already wrong/broken before and should be posted in a single 
patch out of the blksnap serie (also fixing title, as reported by Bagas 
Sanjaya, like "documentation: fix Generic Block Device Capability")

from a fast look seems to me should have only:

+    :DOC: genhd capability flags

and out of that looking older version of doc 
(https://www.kernel.org/doc/html/v5.10/block/capability.html) seems to 
me that this DOC in blkdev.h need improvement as it seems to me it was 
better in the past, for example also reporting the corresponding 
hexadecimal value in parentheses
