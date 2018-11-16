Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77CEC43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B23A2087A
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="pO7EwOKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B23A2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeKPSoX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:44:23 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37949 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbeKPSoX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 13:44:23 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so797569plb.5
        for <linux-block@vger.kernel.org>; Fri, 16 Nov 2018 00:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HrxtWUzRIX/NZGXKJbz3e2fIIOO4kXdMVtObkw1TnaU=;
        b=pO7EwOKMPUzbPgWrLuXsvTnERotylajq1iztl3U95IfMkPOzmgJIPPzGG6FRYoDmej
         v31Vfns6jRQlMN6dCqxvrFR9WvLIbO74w/USri6jO/FTgNWunxyXh5ZmMpJU0Ta4686J
         ybnULwra/KDpDv0hFqFjtH8ug2Od6buidjLxeMq3mWfLJxJVLUsN+B2y/+ar0eKYSrVE
         pvUQ83AXRMuh9iPKoDNK07tUWXJxrmuvYaNYLKQ1kM4p6HH8++GssU/GMvbPXZVGepAT
         IlhMp8HDz9IeFzOyRYQ1zX71JujdkXNjJy8UqUwYEsMHMdC/E84VFKDB6kw0qgs7H8qG
         1LrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HrxtWUzRIX/NZGXKJbz3e2fIIOO4kXdMVtObkw1TnaU=;
        b=WpavoPZ0szVTv3ovF9924ZvtWxJ+l2XNj7OsAkTBBd4Dg0RgBg+u/cpLWl7AWcu8oF
         aYu3wyizXm9Cawf/AywmcX8nASxrd+UvEk+B9z4VSS7zCC6R26WEGOjrhPGiDOpMjGkR
         xx7spzG1X3yqxE17dr3R9ZLPiTl6HMLl+WwTQt6efK6+bKLsTpZUZhA0hsY51uzxsKGz
         7JVbKqQid4Qvixk2p1G7reRVH+KyVXzY9od9F2LWA0FPWVul4cczpFISBHnnFhSRzrTQ
         UCw7m67000L+K5S3wcM/UgT7Dsf/xX4BXz4jAXtViop1C+4u5KTBvA5/fyzEdaU3Y0Rw
         C2rA==
X-Gm-Message-State: AGRZ1gKsghWeSn/fPTBEmaJ1xLw8pVOStA9NWlxRAGgEH7DPNn1E45NI
        1CGAfX+FhZRfIXHuIXhHgyV32g==
X-Google-Smtp-Source: AJdET5eQYwUv0c/QImQzQ1dywpvh09ibxwbK/t8oM+u0nogzKWswWjT7Xb6LONE3L8wfGYW0LomWwg==
X-Received: by 2002:a17:902:e005:: with SMTP id ca5-v6mr9625634plb.195.1542357182816;
        Fri, 16 Nov 2018 00:33:02 -0800 (PST)
Received: from vader ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id c14-v6sm33513654pfc.92.2018.11.16.00.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 00:33:02 -0800 (PST)
Date:   Fri, 16 Nov 2018 00:33:01 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        linux-block@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 1/6] block: remove the rq_alloc_data request_queue field
Message-ID: <20181116083301.GN23828@vader>
References: <20181116081006.5083-1-hch@lst.de>
 <20181116081006.5083-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116081006.5083-2-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 16, 2018 at 09:10:01AM +0100, Christoph Hellwig wrote:

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/blkdev.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 1d185f1fc333..5c5ef461845f 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -567,7 +567,6 @@ struct request_queue {
>  	bool			mq_sysfs_init_done;
>  
>  	size_t			cmd_size;
> -	void			*rq_alloc_data;
>  
>  	struct work_struct	release_work;
>  
> -- 
> 2.19.1
> 
