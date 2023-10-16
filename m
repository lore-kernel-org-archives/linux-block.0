Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A21CDB465
	for <linux-block@archiver.kernel.org>; Mon, 16 Oct 2023 15:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjJPPhz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Oct 2023 11:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjJPPhy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Oct 2023 11:37:54 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D840AC
        for <linux-block@vger.kernel.org>; Mon, 16 Oct 2023 08:37:51 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27d21168d26so679289a91.0
        for <linux-block@vger.kernel.org>; Mon, 16 Oct 2023 08:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697470671; x=1698075471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oaOTKWkhj+Ncly5skMVpADRKfvKmkl49ZSj9OUlLEMI=;
        b=SIZIxrgjuqqRbx5QzX+VurzqQtOYf8EfJRR5dW5eWIYKtTG41ECwyRhiVWmt1kLJRt
         L8LdMxRgovwn0yC1EOO6If0cIoQ0B6gnPO5KqbQS/MDXzjep8NLQry04c226hopvcekz
         xSKoDwY7r1suEMaGNKLjzt7KSy7V9Ta7meatoHPbgHntB1oYrEj5QfJDcLjiQjdBUeCx
         C45GmF7IZMWVsMUeMqf5q3zeBXqYizqrpUUpFmaQ/L8nfk9/jIO5mmgps/iASk7IDQNX
         29XvpZEC99Q3TPeeu+WpsCLFIxFom3z52jmrPmGhp+n/nGLZHnxYTZCYe2jB/D4qxECC
         NHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697470671; x=1698075471;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oaOTKWkhj+Ncly5skMVpADRKfvKmkl49ZSj9OUlLEMI=;
        b=V2JRZpVzQyUCNT392/1eExU8a/dIUGQS7RYZVDeADcZkduGUacbNGTk37PTE14QTEX
         Qt/HKCHKJtDlNBYqYc/u79/FD+QS3QTooB3/5hAhm5WRc6jJDwhG3fbkt94SXcs5pplP
         CozNeHS/5wBt/tYbM7i/HbyuSEvNIN5jDA8HZFbz+mIbUBmp432mpHnaQoHlSqfgBFzu
         G7GekJlpRNzHDNafJ1dm/GX1fvw+8X5XS0WGLElnzR7UtMB1Vmtbn065/tKCTvtQIMJt
         UIG34Ym9azEBFGFN88HxvpaAPZsgFxl3tHh0hR5SgTSisG/tEbW/XtdonvqeMNE591s0
         zQcQ==
X-Gm-Message-State: AOJu0YxT+THlAAunK+Cq7EijSvf0ZOrqy+DAmuo6NLa//seSYHzV8vlN
        vvFZCIhDT/wFKYqe1po8XtqS4A==
X-Google-Smtp-Source: AGHT+IEt6IQopXt79C7UVRKDQuxG88LVLlKv2JonJNh16F7MbNICzKRuaf6/mNKWk4b5FhoAjcCwTA==
X-Received: by 2002:a17:90a:4ca4:b0:274:99ed:a80c with SMTP id k33-20020a17090a4ca400b0027499eda80cmr31810476pjh.3.1697470670913;
        Mon, 16 Oct 2023 08:37:50 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id on6-20020a17090b1d0600b0027d0adf653bsm4886462pjb.7.2023.10.16.08.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 08:37:50 -0700 (PDT)
Message-ID: <40652eee-1cea-4888-86e2-e65a23475182@kernel.dk>
Date:   Mon, 16 Oct 2023 09:37:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: simplify bdev_del_partition()
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20231016-fototermin-umriss-59f1ea6c1fe6@brauner>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231016-fototermin-umriss-59f1ea6c1fe6@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/16/23 9:27 AM, Christian Brauner wrote:
> BLKPG_DEL_PARTITION refuses to delete partitions that still have
> openers, i.e., that has an elevated @bdev->bd_openers count. If a device
> is claimed by setting @bdev->bd_holder and @bdev->bd_holder_ops
> @bdev->bd_openers and @bdev->bd_holders are incremented.
> @bdev->bd_openers is effectively guaranteed to be >= @bdev->bd_holders.
> So as long as @bdev->bd_openers isn't zero we know that this partition
> is still in active use and that there might still be @bdev->bd_holder
> and @bdev->bd_holder_ops set.
> 
> The only current example is @fs_holder_ops for filesystems. But that
> means bdev_mark_dead() which calls into
> bdev->bd_holder_ops->mark_dead::fs_bdev_mark_dead() is a nop. As long as
> there's an elevated @bdev->bd_openers count we can't delete the
> partition and if there isn't an elevated @bdev->bd_openers count then
> there's no @bdev->bd_holder or @bdev->bd_holder_ops.
> 
> So simply open-code what we need to do. This gets rid of one more
> instance where we acquire s_umount under @disk->open_mutex.

Reviwed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


