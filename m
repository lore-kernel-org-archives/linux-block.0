Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71A7CD4844
	for <linux-block@archiver.kernel.org>; Fri, 22 Sep 2023 16:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjIVQ3y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Sep 2023 12:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjIVQ3x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2023 12:29:53 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A58122
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2023 09:29:47 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-79f8df47bfbso24446939f.0
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2023 09:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695400187; x=1696004987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zfu9KE5FyBSR/O0z5XFbdb72LTChkuBOU7sWNPErj8o=;
        b=n63qYiK5V4QR/q7az1dgpmD/qIXGx8a/H9hzETByE8t9YumIIgMhYx3rXOP4tPJZkS
         sIMh4ZOUE79lXh8TZQtMDrS+R9xt3vvqFUGG1Zc2wgpNrQFThYVsY/hpBqEPKs7kpEkf
         Z3OdR7hhKpQp3p27YGotYxxprsW6amP1u6O/frB1HDXHPh4bPkTPPCn/q4U9MtfneUyF
         0DiOriTcbAznlyW1wW9jMDn9UoGivbEeSFmocyNdKlaF+v40bGq5HGcYCJgs4b+jOKth
         dN7jLRgvgTdlRwv9+mLbb4CKVpt3zDT6xHqDrir3wJufpAezbnK3zXJWw54L1QR/Y0ab
         4Chw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695400187; x=1696004987;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zfu9KE5FyBSR/O0z5XFbdb72LTChkuBOU7sWNPErj8o=;
        b=r03Xe4RsZOXvj8TV0v88+t7fMaC+9zHfAm5zlV3ilA1rvOSsjqxzcH3YQiO7yO0dBA
         AsJ+xQL9PcbLFgrjGucnRffXVItWEpgNW8tL+78g0OK1lWPZYcKUGO1AIBnTcc5WRs8N
         ifQ9Q9ls+52J6dptF7a1LAeZRs1rD4HhBBTggMWizgD/JALUzG0sBYixHxmMZAwMoFHc
         jjC8ClwlytVLb0zbeH8Im+61bQjDgU4aJGIxbdMaN3oPpvUdYFTZ7F2M14TLvniKf0XF
         mtq2WW9oj5Wr9r33gv4c2lP3zNsSoJF/Gm4OEwEh+h6DqGFQqunOTNVIAQE2nm35jy6x
         bSfQ==
X-Gm-Message-State: AOJu0YzQiIYrg9tw2cOHkMpVqhMlwDLhDQajkJ94AuH+Qj1Xu6vFZ1X4
        fFs/q4SNFCoKL9CFv3hDf0MpLQ==
X-Google-Smtp-Source: AGHT+IETFS7NSB77Epw9pCJRfzzcjSErqPf7DJpjKsBH210dkfHQIxbcFoSHOl1u7D3jmeMR4wU/sQ==
X-Received: by 2002:a05:6602:3788:b0:792:7c78:55be with SMTP id be8-20020a056602378800b007927c7855bemr9272371iob.0.1695400187350;
        Fri, 22 Sep 2023 09:29:47 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id n18-20020a056638121200b0042b0ce92dddsm1055745jas.161.2023.09.22.09.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 09:29:46 -0700 (PDT)
Message-ID: <0df2790b-1122-40a5-9bfb-3da6048c24ff@kernel.dk>
Date:   Fri, 22 Sep 2023 10:29:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/2] io_uring: retain top 8bits of uring_cmd flags for
 kernel internal use
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Gabriel Krisman Bertazi <krisman@suse.de>
References: <20230922160943.2793779-1-ming.lei@redhat.com>
 <20230922160943.2793779-2-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230922160943.2793779-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/22/23 10:09 AM, Ming Lei wrote:
> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> index 537795fddc87..52a455b67163 100644
> --- a/io_uring/uring_cmd.c
> +++ b/io_uring/uring_cmd.c
> @@ -90,7 +90,7 @@ int io_uring_cmd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>  	if (sqe->__pad1)
>  		return -EINVAL;
>  
> -	ioucmd->flags = READ_ONCE(sqe->uring_cmd_flags);
> +	ioucmd->flags = READ_ONCE(sqe->uring_cmd_flags) & IORING_URING_CMD_MASK;
>  	if (ioucmd->flags & ~IORING_URING_CMD_FIXED)
>  		return -EINVAL;
>  

Do we want to mask it here? If any of the upper bits are set at prep
time, that should be an EINVAL condition.

-- 
Jens Axboe

