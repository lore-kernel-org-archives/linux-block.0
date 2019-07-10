Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC650C74A21
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 16:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AC52063F
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 16:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXf/x835"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfGJQdZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 12:33:25 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45391 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbfGJQdY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 12:33:24 -0400
Received: by mail-pl1-f193.google.com with SMTP id y8so1481656plr.12
        for <linux-block@vger.kernel.org>; Wed, 10 Jul 2019 09:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0cljU/M08jl5F/siW+zFU3afZj2UI2HM784d436MQIA=;
        b=HXf/x835cftuJJefKr8x5pqSpfQdYoVcbPXrTbidPV9ljX/Je9+UYqzJvRnXOwHcbo
         ESrCpLWfBtP1Aj8m3Nf0TjeyDNQMhfQEfITlLphurTkAlrqUqXoaYubdJ4Fwjl5bl+d3
         GbsWDvMwEvCn3GrtqRv6GOchs+EwLDxcAUer+NPJ84Wkn+GebE2w3AlIkETMDT1b1Nub
         XSW9q9EM1VGIfhQ2m0FPFaiftdsYsXU/aPrTUohSzqZ/pmh8lM8RIBaGYu+rEJUfnC1z
         +FpFEvFlzuE2VM/fNQ5KPfh2qk2v4ukX3ToTI+yCVID/qEM7Kr7UQuMjkwMc/vfUZ6OB
         cU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0cljU/M08jl5F/siW+zFU3afZj2UI2HM784d436MQIA=;
        b=ICq4zW8zQ4A/L58J0UnTtPqHjivzG0Sbf3MbVQt+Kq8IaO5HDy67mfjQ6sYyYzzy4c
         Q+FK+VstHgFtmXtH/3sA7Kk9ny6vxpbTVEJc5BWbkfG15J3z7lfyXqJz7+V1JxcUvmeX
         wvACOsD0VfYBBi7UEYMi1rR4qF7HcYJoTBLOLvKKtnVlUt3+hW6nfpHw5qdZfUFSTv8t
         qUf2125qD/ODphOLJFxm2FODxKaZcRkKUiJ4Er81cpsyYXJAxR3H1g+eCoATyUMt7vcu
         QJ+OVK/+P7loNixvn8m6RQBgf8UfuK0LCBSPGhHqghGVzjNCgB9qcjfAYZvNcytFg48j
         7XvA==
X-Gm-Message-State: APjAAAVsZ9nhx9EO4Qa8b+Z/OLN+4bkMJSv1JZz8VNQH80vYlMdZhX5s
        R6UDO77gyjvmrwmMfd6HBAc=
X-Google-Smtp-Source: APXvYqwXbtlH475C3mOmtDHNavCbGUFFx6ZT3f/dLk8taEUFzAKWeQdbMQpDSZ+sBhg1jvVpl38kTQ==
X-Received: by 2002:a17:902:7043:: with SMTP id h3mr41360240plt.10.1562776404260;
        Wed, 10 Jul 2019 09:33:24 -0700 (PDT)
Received: from continental (189.26.176.28.dynamic.adsl.gvt.net.br. [189.26.176.28])
        by smtp.gmail.com with ESMTPSA id s16sm2661075pfm.26.2019.07.10.09.33.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 09:33:23 -0700 (PDT)
Date:   Wed, 10 Jul 2019 13:34:15 -0300
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: Fix elevator name declaration
Message-ID: <20190710163415.GB26575@continental>
References: <20190710155741.11292-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710155741.11292-1-damien.lemoal@wdc.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 11, 2019 at 12:57:41AM +0900, Damien Le Moal wrote:
> The elevator_name field in struct elevator_type is declared as an array
> of characters (ELV_NAME_MAX size) but in practice used as a string
> pointer with its initialization done statically within each
> elevator elevator_type structure declaration.
> 
> Change the declaration of elevator_name to the more appropriate
> "const char *" type.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  include/linux/elevator.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/elevator.h b/include/linux/elevator.h
> index 9842e53623f3..b73e6f35fbad 100644
> --- a/include/linux/elevator.h
> +++ b/include/linux/elevator.h
> @@ -75,7 +75,7 @@ struct elevator_type
>  	size_t icq_size;	/* see iocontext.h */
>  	size_t icq_align;	/* ditto */
>  	struct elv_fs_entry *elevator_attrs;
> -	char elevator_name[ELV_NAME_MAX];
> +	const char *elevator_name;
>  	const char *elevator_alias;
>  	struct module *elevator_owner;
>  #ifdef CONFIG_BLK_DEBUG_FS

Acked-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>

> -- 
> 2.21.0
> 
