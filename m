Return-Path: <SRS0=VjOk=UV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D90C43613
	for <linux-block@archiver.kernel.org>; Sat, 22 Jun 2019 06:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4362070B
	for <linux-block@archiver.kernel.org>; Sat, 22 Jun 2019 06:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRp0PQRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfFVGEs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 22 Jun 2019 02:04:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33518 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfFVGEs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Jun 2019 02:04:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id m4so3758892pgk.0;
        Fri, 21 Jun 2019 23:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yg/1WkKqkNqxYmfahwU10rIwyumik9JOh8CghNFdi84=;
        b=nRp0PQRyhWjbC0KEWHP9ZlUeueQiT/aMpAdU278WcErKsKci2cmQ33E+yrQ2by+tHI
         eE9fbpXci/gaqu9Dsq7+cF7RnqeWWVhMX4uMNhMYY5AweDkxpgNAfXMJF6Ag9Bz6akXu
         OcoYOfafP/zdBotqhZQq35Q62vTQHJ7pv6xsDhC387Q73ETAb383VPMITI7f+IIu+u3P
         lAnEKUgq0Tvz7Hr16ohwQOG79Um6rN46EK8GY2b7eWy0gcVP//MhfUFKoIKPTrE3hpZG
         RNft5hpW4DTdirxzcq9BcgJsQxpREgMaFknx3H08PSgYnPfWc1R9cS3oAO8U9iN/sFBW
         iIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yg/1WkKqkNqxYmfahwU10rIwyumik9JOh8CghNFdi84=;
        b=iIkyHSZaWVbeosXOLfMGjdrSWo+4iWVlbttK2OuI7nQuMpKbapbcIdSiegeBdzCQvr
         2tyMUM9DbqvbgGyKWLI8XSV9k8oOq0Tlgmu6OTl/xka7L5o7z8ieX9NrtfShK+DiR+mR
         uiZ+JztpZxHS+lUVjIp1E2SOkR0b6vrIxx63krdpxpDGzxNA/DMQZV0OKAMdqwtqERkv
         Ygbl4rAk8uFHPboG837udzNx7N+ng8AySxMyR9eS8cCmRVGUdpO3YG8vAnGUBUUdjrqH
         3SCSMQqT8MYwbxhcYMbDhSOiluNBtquOOzJiHlh0t1vf6FB4O7ps78GtILqmArK+ssLY
         1UPw==
X-Gm-Message-State: APjAAAVHlmXH960zkC50DWuSQ7LSvjF+iFNXy4RF7wTxxnrOYpP1CTSI
        NHG/tx9RPNFO7r6YzZEw48X0579O5wY=
X-Google-Smtp-Source: APXvYqwiVKfl8+/c+x6CKHQKpg0wtswg8LUQht15uRDFbh8EiZhYe9L23duyQegRi9Vl4R7neMHrsw==
X-Received: by 2002:a63:5a1f:: with SMTP id o31mr21859229pgb.254.1561183487696;
        Fri, 21 Jun 2019 23:04:47 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id w7sm954242pfb.117.2019.06.21.23.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Jun 2019 23:04:46 -0700 (PDT)
Date:   Sat, 22 Jun 2019 15:04:44 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>
Cc:     axboe@fb.com, hch@lst.de, damien.lemoal@wdc.com,
        chaitanya.kulkarni@wdc.com, dmitry.fomichev@wdc.com,
        ajay.joshi@wdc.com, aravind.ramesh@wdc.com,
        martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        agk@redhat.com, snitzer@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <matias.bjorling@wdc.com>
Subject: Re: [PATCH 1/4] block: add zone open, close and finish support
Message-ID: <20190622060444.GA6975@minwooim-desktop>
References: <20190621130711.21986-1-mb@lightnvm.io>
 <20190621130711.21986-2-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190621130711.21986-2-mb@lightnvm.io>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-06-21 15:07:08, Matias Bjørling wrote:
> @@ -226,6 +228,9 @@ int blkdev_reset_zones(struct block_device *bdev,
>  	if (!blk_queue_is_zoned(q))
>  		return -EOPNOTSUPP;
>  
> +	if (!op_is_zone_mgmt_op(op))
> +		return -EOPNOTSUPP;
> +

nitpick: -EINVAL looks better to return as Damien pointed out.

Otherwise it looks good to me:

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
