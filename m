Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84DAC433EF
	for <linux-block@archiver.kernel.org>; Sat, 25 Jun 2022 02:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiFYC53 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 22:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbiFYC51 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 22:57:27 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B490162BD2
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 19:57:26 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id p5so4365391pjt.2
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 19:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bl6oXFbY9TDP378dyXpZwe1n450A56bEAzzcwYHghNI=;
        b=1SSuNfRPF28/maUN8UxTnDJTIm6qKbK4ONhuUemlrxFOEdfg418RVHIV/oR9WdFbOL
         7hiUnuPcX5lh4jXhW9N+p/P52J4v6WIJgm6vw6BDO6xbMqNFPYamlPUzJwbokwIsXz7I
         huZTMC4eL+glgO3IpAXlpvQRZu+A+MUGkC7KaxuXCO+PKoqfDiACsEdbWbyqHugSJPzC
         RsPsg0mpCRcUwNn6MB0mpOeL7pNSkvbOOwEBjcfSX8YEeYrld4+fcpjmTNDkuJKVg6oj
         Mox/sFK3ckExGOI7UYzpgHDJGGa0LKar4Du3kYS4m4FFfuSK+7trwunBaE1TniriGowq
         UiIA==
X-Gm-Message-State: AJIora82EfYRn15am4Vf/8lk3oebpgXf2kDYrwtR1nnTrdBnTkTJxWug
        2fvvgGzbvxDUzLKV0xtcVKCuaC+rN14=
X-Google-Smtp-Source: AGRyM1vgWxdCCPT65obVsh/VM4okQJsX1RGSXNDA0km/x9i9Y+LEqPD4sz9FpDwr1Yhrh8BN685AJg==
X-Received: by 2002:a17:902:d50b:b0:16a:2cb3:750d with SMTP id b11-20020a170902d50b00b0016a2cb3750dmr2239771plg.17.1656125846063;
        Fri, 24 Jun 2022 19:57:26 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id r12-20020a170902ea4c00b001679a4711e5sm2488872plg.108.2022.06.24.19.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 19:57:25 -0700 (PDT)
Message-ID: <29c57d42-83d8-bbcb-d4a7-659920cd9137@acm.org>
Date:   Fri, 24 Jun 2022 19:57:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/6] block: simplify blktrace sysfs attribute creation
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20220624052510.3996673-1-hch@lst.de>
 <20220624052510.3996673-2-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220624052510.3996673-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/23/22 22:25, Christoph Hellwig wrote:
> diff --git a/block/genhd.c b/block/genhd.c
> index bf9be06af2c8d..12b0eda8d125b 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1134,6 +1134,9 @@ static struct attribute_group disk_attr_group = {
>   
>   static const struct attribute_group *disk_attr_groups[] = {
>   	&disk_attr_group,
> +#ifdef CONFIG_BLK_DEV_IO_TRACE
> +        &blk_trace_attr_group,
> +#endif

The space in front of '&' is probably unintended? Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
