Return-Path: <SRS0=LW4I=4O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEA5C4BA10
	for <linux-block@archiver.kernel.org>; Wed, 26 Feb 2020 14:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914E724680
	for <linux-block@archiver.kernel.org>; Wed, 26 Feb 2020 14:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CZ6SogvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgBZOYK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Feb 2020 09:24:10 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42185 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgBZOYJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Feb 2020 09:24:09 -0500
Received: by mail-io1-f67.google.com with SMTP id z1so3500092iom.9
        for <linux-block@vger.kernel.org>; Wed, 26 Feb 2020 06:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VjOUi1Fi7+2MpzROLuPBLYpl9LM0MiHFG+cIU7G/DUs=;
        b=CZ6SogvG+jLe4CyeZOEKf5Sl6s5/iivnqWDugz3ywfIG1HZ1peGLEafs38pRnulyth
         Cw9+Ifm3bjjTIlrM3KCoe+AuJbm1KrF1BMBD0Xypg89hOClvbsMu2FrpCfet2C9q0k/5
         bQ3WBlNC3gQbaBdW+VaNwnK4NqE9QYVyPzHOIyxCDs2WbG9eXBpu5p2K6z9mxmYBMV2t
         Fi46+auwvSjCghV1SoMlh0ZzipBn1rIFclBFNvwrNshChqHEDjd7+giv7yzTumUa52CD
         diVlQEiCxeBC2p+0OPlDgUuXLrgJs5arqz8O7DXBbb6YUyjq+PzXhkrsmRYTYQySD5cL
         ySlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VjOUi1Fi7+2MpzROLuPBLYpl9LM0MiHFG+cIU7G/DUs=;
        b=n5hEpCKLO9qW/KnKS7ssY9XJs69KagACas1kin1BCYiQQmUyM+DK6RndPYivbXGnij
         3KyRrQVCG9rIqQpBSG7ETgzyLh2/nbVdJLbbUspeyi050NAorQo1ZWOeljd0/agNtXag
         evJ180MFZvKZDJyn5CMBKAMPiX9X+MsCduhDfVGJrYIYaZTivpyEpPDBC8kQL4T7pGZD
         0HkBknexepo8DGstihrlmvgkgyf6os489jhqJbpWgUvumwYF/AuzknxcpXoBYQcQug4L
         tOS12H5d/nesYcTCenYKUAwb4RYwcA9RdK2+z/sCN+C+0vCeTePUmjh04wuYClGJ3k2j
         6ZJw==
X-Gm-Message-State: APjAAAWta7DLdvhGIjpiEiC63RPz3abVOI/VqAMFqzQAYBLLfMilmRn5
        clfovRTZyBjMUS0k2HnADs/ltM5bXT2uTg==
X-Google-Smtp-Source: APXvYqwFNHqgHKYrcTeD09SifzEJkv7rgKvB2Q0zfnjOZ97sfYrsnpIOGWRvfm0QC3HjTi2ixxkfvQ==
X-Received: by 2002:a02:950d:: with SMTP id y13mr4507649jah.139.1582727047686;
        Wed, 26 Feb 2020 06:24:07 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b17sm622145ioj.81.2020.02.26.06.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 06:24:06 -0800 (PST)
Subject: Re: [PATCH 1/4] io_uring: add IORING_OP_READ{WRITE}V_PI cmd
To:     Bob Liu <bob.liu@oracle.com>, linux-block@vger.kernel.org
Cc:     martin.petersen@oracle.com, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, io-uring@vger.kernel.org
References: <20200226083719.4389-1-bob.liu@oracle.com>
 <20200226083719.4389-2-bob.liu@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6e466774-4dc5-861c-58b5-f0cc728bacff@kernel.dk>
Date:   Wed, 26 Feb 2020 07:24:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226083719.4389-2-bob.liu@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/26/20 1:37 AM, Bob Liu wrote:
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index a3300e1..98fa3f1 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -62,6 +62,8 @@ enum {
>  	IORING_OP_NOP,
>  	IORING_OP_READV,
>  	IORING_OP_WRITEV,
> +	IORING_OP_READV_PI,
> +	IORING_OP_WRITEV_PI,
>  	IORING_OP_FSYNC,
>  	IORING_OP_READ_FIXED,
>  	IORING_OP_WRITE_FIXED,

So this one renumbers everything past IORING_OP_WRITEV, breaking the
ABI in a very bad way. I'm guessing that was entirely unintentional?
Any new command must go at the end of the list.

You're also not updating io_op_defs[] with the two new commands,
which means it won't compile at all. I'm guessing you tested this on
an older version of the kernel which didn't have io_op_defs[]?

-- 
Jens Axboe

