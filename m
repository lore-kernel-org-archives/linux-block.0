Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D98AC4338F
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 09:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3056760F11
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 09:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbhHLJnH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Aug 2021 05:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbhHLJnG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 05:43:06 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA739C061765;
        Thu, 12 Aug 2021 02:42:41 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id w20so12346219lfu.7;
        Thu, 12 Aug 2021 02:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tf7xAURtCOwH3Y40n33NRhchLFsigaBEgUnQpYCj/rY=;
        b=gnxWP2cSKbYc7CdxPIKzIgjKo+RRNKvcCjbopRTkJP0SADoOhtkyugvYoiYsH2H10Y
         pE0YHZ9sTJJxDDZjtIqjTy4jAwY29laRQpDPs3RwedNRIbeOBepXzNjfmaQBot3QW//e
         5gBHcqYwUI9RGRK/UN0VqMJQaqGQQiM7DYyWPFDuFl/4MZhUo/b5q9kI75T3LDkklTs2
         HdiBjHYe91xnSYo5BAyDCP0vCso5Jyy6b3r0TcDq5e/1EX8+ivzlEpbdmNwWJ6Zxd6qN
         9b8Hxpdbi5WC8h+AX3OGaAF4Lyl9Rf9hHQqRR49H8NWs7CrzdWx83SSrhSnJc85vZbe/
         9GUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tf7xAURtCOwH3Y40n33NRhchLFsigaBEgUnQpYCj/rY=;
        b=gcOorMrbxZ+giLeWw3J4nCRJEMQNQXAAD6xP1k0Jb9yxsr+EokY1ttqSbXAMUi/aI4
         9Fwq1tGvc6ggfhTJMvyAAoH1jt57f0HqNCLZNFJNcXaQeVoPocw5bkBX43oz+pmKxofB
         JD+U4coEDjNqtQb08zq5Dt6+MUyr7V9JOSjbAHFvYeOvx1N3kJ9BQktRZZ+M2Mcyl2B0
         N5/doEkNt7CqhpOiiZZRjreVFQIaMKIB7O3TzESEu9+gHNp6fkOYgLxY8SHLz2VgdLJ3
         +445Z6ViaFNnCFcqOXrFEnl4yqSKqYRyi1inXYSSaz8eDDuy59Twd0RkI/2ftvrwdNhI
         6NhA==
X-Gm-Message-State: AOAM530P+sLvRoQYbTb7ksWmkCYWNwiFJV2Cywp941JjHLaXu3PDd8FD
        Z8je1SVwktLz1NhxqsJrxaA=
X-Google-Smtp-Source: ABdhPJw3jwErXtsvDnYk1DOVEeUprNfJXKo6pGk3DyUdQRCE+F0Fzxqr31bUQbaznCPC7K30LKTokQ==
X-Received: by 2002:a19:5e0e:: with SMTP id s14mr1991995lfb.534.1628761359660;
        Thu, 12 Aug 2021 02:42:39 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.232])
        by smtp.gmail.com with ESMTPSA id e21sm223581lfq.240.2021.08.12.02.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 02:42:39 -0700 (PDT)
Subject: Re: [PATCH] block: nbd: add sanity check for first_minor
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     hch@lst.de, linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org,
        syzbot+9937dc42271cd87d4b98@syzkaller.appspotmail.com
References: <20210812091501.22648-1-paskripkin@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <7f9a6877-12d9-0177-d09a-6522e5a557ec@gmail.com>
Date:   Thu, 12 Aug 2021 12:42:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210812091501.22648-1-paskripkin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/12/21 12:15 PM, Pavel Skripkin wrote:
> Syzbot hit WARNING in internal_create_group(). The problem was in
> too big disk->first_minor.
> 
> disk->first_minor is initialized by value, which comes from userspace
> and there wasn't any sanity checks about value correctness. It can cause
> duplicate creation of sysfs files/links, because disk->first_minor will
> be passed to MKDEV() which causes truncation to byte. Since maximum
> minor value is 0xff, let's check if first_minor is correct minor number.
> 
> NOTE: the root case of the reported warning was in wrong error handling
> in register_disk(), but we can avoid passing knowingly wrong values to
> sysfs API, because sysfs error messages can confuse users. For example:
> user passed 1048576 as index, but sysfs complains about duplicate
> creation of /dev/block/43:0. It's not obvious how 1048576 becomes 0.
> Log and reproducer for above example can be found on syzkaller bug
> report page.
> 
> Link: https://syzkaller.appspot.com/bug?id=03c2ae9146416edf811958d5fd7acfab75b143d1
> Fixes: b0d9111a2d53 ("nbd: use an idr to keep track of nbd devices")
> Reported-by: syzbot+9937dc42271cd87d4b98@syzkaller.appspotmail.com
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>   drivers/block/nbd.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index c38317979f74..600e9bab5d43 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1725,7 +1725,17 @@ static int nbd_dev_add(int index)
>   	refcount_set(&nbd->refs, 1);
>   	INIT_LIST_HEAD(&nbd->list);
>   	disk->major = NBD_MAJOR;
> +
> +	/* Too big first_minor can cause duplicate creation of
> +	 * sysfs files/links, since first_minor will be truncated to
> +	 * byte in __device_add_disk().
> +	 */
>   	disk->first_minor = index << part_shift;
> +	if (disk->first_minor > 0xff) {
> +		err = -EINVAL;
> +		goto out_free_idr;
> +	}
> +
>   	disk->minors = 1 << part_shift;
>   	disk->fops = &nbd_fops;
>   	disk->private_data = nbd;
> 

Fun thing: I got a reply to this email from
nsd-public@police.gov.hk, which is Hong Kong Police office email. Does 
anyone know what is going on? :) It's a bit scary...



With regards,
Pavel Skripkin
