Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BD9C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 12:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E402146E
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 12:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lnZNAO6U";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lnZNAO6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfC0MCR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:02:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58138 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfC0MCR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 08:02:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A4E5C60CF1; Wed, 27 Mar 2019 12:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553688136;
        bh=d8OIWgQ+HFsqF+/1669O8AOqclvMD9W6J6ZOJwwvRy0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lnZNAO6U6pHLdsbJ1NtUu26z2l7o1kx7pXIGuL/H0a3I10/tuuxvFQkuXuxd+yxUl
         VLKCI4LMYdkV0DV+MtkwqgBj73rZLzN+k+8+F+9aOhqTShecGq0lOGqt3p/ZINwUTA
         dkOo5Brww26flTg+dy/gQr+Omgw9S+sF/kXBokpc=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C629560790;
        Wed, 27 Mar 2019 12:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553688136;
        bh=d8OIWgQ+HFsqF+/1669O8AOqclvMD9W6J6ZOJwwvRy0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lnZNAO6U6pHLdsbJ1NtUu26z2l7o1kx7pXIGuL/H0a3I10/tuuxvFQkuXuxd+yxUl
         VLKCI4LMYdkV0DV+MtkwqgBj73rZLzN+k+8+F+9aOhqTShecGq0lOGqt3p/ZINwUTA
         dkOo5Brww26flTg+dy/gQr+Omgw9S+sF/kXBokpc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C629560790
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] floppy: fix usercopy direction
To:     Jann Horn <jannh@google.com>, Jiri Kosina <jikos@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20190326220348.61172-1-jannh@google.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <b9b3fd01-7a9d-11df-31f9-96f95263dac5@codeaurora.org>
Date:   Wed, 27 Mar 2019 17:32:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190326220348.61172-1-jannh@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 3/27/2019 3:33 AM, Jann Horn wrote:
> As sparse points out, these two copy_from_user() should actually be
> copy_to_user().
>
> Fixes: 229b53c9bf4e ("take floppy compat ioctls to sodding floppy.c")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

> ---
> compile-tested only
>
>   drivers/block/floppy.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 95f608d1a098..8c641245ff12 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -3749,7 +3749,7 @@ static int compat_getdrvprm(int drive,
>   	v.native_format = UDP->native_format;
>   	mutex_unlock(&floppy_mutex);
>   
> -	if (copy_from_user(arg, &v, sizeof(struct compat_floppy_drive_params)))
> +	if (copy_to_user(arg, &v, sizeof(struct compat_floppy_drive_params)))
>   		return -EFAULT;
>   	return 0;
>   }
> @@ -3785,7 +3785,7 @@ static int compat_getdrvstat(int drive, bool poll,
>   	v.bufblocks = UDRS->bufblocks;
>   	mutex_unlock(&floppy_mutex);
>   
> -	if (copy_from_user(arg, &v, sizeof(struct compat_floppy_drive_struct)))
> +	if (copy_to_user(arg, &v, sizeof(struct compat_floppy_drive_struct)))
>   		return -EFAULT;
>   	return 0;
>   Eintr:
