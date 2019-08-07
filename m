Return-Path: <SRS0=SzsG=WD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579D8C433FF
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 17:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF632229C
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 17:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="hRm9zNyE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbfHGRXw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Aug 2019 13:23:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44482 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729804AbfHGRXw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Aug 2019 13:23:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id t14so41766296plr.11
        for <linux-block@vger.kernel.org>; Wed, 07 Aug 2019 10:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iiUAaQABvJQsj7iHkIxpQo3EFcbvQS3L1vw4Ou0AMd4=;
        b=hRm9zNyEQiFMRp75nOnYOzy6WrWcSxuGFqhJcxqtu3HkT99/ThFIlkGUxJM0jXXOSi
         5oNI9cIZZWy6G6OPRG1RMD4Lo0F+/etw5KUviML0FEUv5WGpdH7Vdh3s2yS6J1EUA7my
         GJwJCFM1k18XBtlDZ90L/wBlXihBd8eqTmMkZdkMYAwqUw9CR0qRfOuY4rHL+IISRAP9
         RjxONi8Dlghl8+iauXz0LYguHzFBUndxpnWPLqL4FIktc18x+aSy2HYyde0INLhave1x
         6vMHq98gK7nfyJ6gNnDrYQYELR5h10SrLwEUqNdF/sjgi7K3Xun1D+iS19zUzCYJ72eD
         g35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iiUAaQABvJQsj7iHkIxpQo3EFcbvQS3L1vw4Ou0AMd4=;
        b=kkitBV1hIvnbe7KAQ1dWl1IO10QhchOnVPia5GTFQvHiSp2kRPQpbOcVPSwl3lZzuE
         yhBnGIEuoI5iSiNvbqQs1daVemuKuoSQJppLI7AToV54TsAPfhn9ppeOSmxlKubZLkbq
         yzagz+hUMlD1s7ZMn2N8MnvQuA2M5EdfF1MGwZ70XIA7fWCQBYwzppdbRknEmk08sj86
         Pxb8UgG3DjhA+37zm7xf+QXN9xtHTLBgXeY5zFGM39bIuxpIEAdRvLUm4Gd/OOAr/DgU
         txwHMwK97K1H0y7D+OI3fgQpZPwvU5lc6rciLKvuq/1qQh/5vC54BHByqxOgDlSIpQP4
         Nlgg==
X-Gm-Message-State: APjAAAXd9qF45kOufcF1gHRRTL/1jbsLE3ajqgFjv+Y4JmtgY7GvCShu
        +FBuy+kOeHeF/9CfJbo2HCH4zQ==
X-Google-Smtp-Source: APXvYqxMJDCc0nCwDzbRH6dZbkrcwt9XPc/Bj3i23FOIPf/i2rotDcUoswDreWAwWpdQa4TbMFTCYA==
X-Received: by 2002:a62:5214:: with SMTP id g20mr10434008pfb.187.1565198631502;
        Wed, 07 Aug 2019 10:23:51 -0700 (PDT)
Received: from vader ([2601:602:8b00:55d3:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id y22sm107273013pfo.39.2019.08.07.10.23.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 10:23:50 -0700 (PDT)
Date:   Wed, 7 Aug 2019 10:23:50 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH blktests] Make the NVMe tests more reliable
Message-ID: <20190807172350.GB18948@vader>
References: <20190805232512.50992-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805232512.50992-1-bvanassche@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 05, 2019 at 04:25:12PM -0700, Bart Van Assche wrote:
> When running blktests with kernel debugging enabled it can happen that
> _find_nvme_loop_dev() returns before the NVMe block device has appeared
> in sysfs. This patch avoids that the NVMe tests fail as follows:
> 
> +cat: /sys/block/nvme1n1/uuid: No such file or directory
> +cat: /sys/block/nvme1n1/wwid: No such file or directory
> 
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  tests/nvme/rc | 8 ++++++++
>  1 file changed, 8 insertions(+)

Thanks, Bart, I made Johannes' suggested change and applied.
