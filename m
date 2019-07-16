Return-Path: <SRS0=S2CA=VN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE218C7618F
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 14:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C2420693
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 14:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VZHgJXhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387839AbfGPOIm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jul 2019 10:08:42 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41670 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfGPOIl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jul 2019 10:08:41 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so10132467pls.8
        for <linux-block@vger.kernel.org>; Tue, 16 Jul 2019 07:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vGXOu+EdUfZzfqsLfP7nv6ounD2Inp4uFYV/rEnmZdg=;
        b=VZHgJXhecd9UWtMwUX+wub+u//R9ZywexVYig2mBraF216DNcCP4nUCN+GiUwShq9W
         Pk1k+4+jqhP+Ps0k3Gn8UdOa3PivFikjLHYSiflvzkIaBjOHHiPVZ9D/8ZsUrCV8S7hM
         ptrmb4hVu/XU0TqNMJ6ohvq07UBvUQ+DKvpaEzZdSOWdcGllQ8X7msiucoZTvfdhjxK2
         nSpSl4nFIS9UyGm+gUNVKt4FzzN7O5PHxaV9aPlBQdkSDj0e2marum/JrJDVVfaigfbP
         5nS0GCu3Bu2Xff6GFGYsD/kDI/YBzdinPbcIJLa/cT5H0LyX0mjYDAFRnX7drv+/cqmH
         p/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vGXOu+EdUfZzfqsLfP7nv6ounD2Inp4uFYV/rEnmZdg=;
        b=rna44oK8m6yWZ0rEFBFsCs9TCb5ym0LpK80zpVZ0+lloEByFfPXQDfcAtcYcUb/9Ci
         8MmvzFE9C77sc7OiR1oQ1lFdNdwcAl79IzkcjgUfrgSnIpA8a9P6j4GA3AarKDRYR0YT
         ZhfXJlc8d+WbH3qhSf8EJw3bjGvtiocIOL0+jHOc6zwdfOOD/hMfH+hdFZgfpoo6DzcE
         ch+xCpI4Ix5SO9jSeL/Fwt4UbTBA1Y38MtqTLDn8iaKi40yMBXNrkvlsKoUmU1nupz7W
         hutJtWaKDAhiVG2IDQmweKgmmAdwvzI1fEq7HNAW9M1+9wpqcWVfi5wMxWG8ovMEyyS2
         715Q==
X-Gm-Message-State: APjAAAXTXFecKvok4i3FSirroeznXH8ARp/i8A/sFF45DyhGcXOnGpgR
        88H60zWbXIbBUe7qaNAoN4KQsrqz33c=
X-Google-Smtp-Source: APXvYqwykVlVm2gr6HgHePdfqtIxl3Vxfd3TqjUHr0kJ4C3VnXIc82nODRwC944dKuLwWl5wARwIfg==
X-Received: by 2002:a17:902:2006:: with SMTP id n6mr36577498pla.232.1563286120465;
        Tue, 16 Jul 2019 07:08:40 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id n7sm25085731pff.59.2019.07.16.07.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 07:08:39 -0700 (PDT)
Subject: Re: [PATCH 1/2] io_uring: make req from defer and link list not touch
 async list
To:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Cc:     linux-block@vger.kernel.org
References: <20190713035826.2987-1-liuzhengyuan@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a85d49b5-ef2c-4b29-0cbf-845648d86cf6@kernel.dk>
Date:   Tue, 16 Jul 2019 08:08:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190713035826.2987-1-liuzhengyuan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/12/19 9:58 PM, Zhengyuan Liu wrote:
> We would queue a work for each req in defer and link list without
> increasing async->cnt, so we shouldn't decrease it while exiting
> from workqueue as well as shouldn't process the req in async list.

Took a closer look at this one. First comment, can you rewrite
the subject line? I honestly don't quite know what that is
trying to say.

Apart from that:

> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 7e932c572f26..3e48fd7cd08f 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -333,7 +333,8 @@ struct io_kiocb {
>   #define REQ_F_IO_DRAIN		16	/* drain existing IO first */
>   #define REQ_F_IO_DRAINED	32	/* drain done */
>   #define REQ_F_LINK		64	/* linked sqes */
> -#define REQ_F_FAIL_LINK		128	/* fail rest of links */
> +#define REQ_F_LINKED		128	/* linked sqes done */
> +#define REQ_F_FAIL_LINK		256	/* fail rest of links */

_LINKED is poorly chosen, hard to know what the difference between
_LINK and _LINKED is here, they seem identical. Please rename it to
_LINK_DONE or something like that.

Thanks!

-- 
Jens Axboe

