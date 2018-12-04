Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1616FC04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 00:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B0720850
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 00:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JALfXtv1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B0720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbeLDAOX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:14:23 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:35256 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLDAOX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 19:14:23 -0500
Received: by mail-pg1-f170.google.com with SMTP id s198so6497750pgs.2
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 16:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qlitGsg1X20EWm2iWZwvbgltl8mluLldf1XZLx6X2YI=;
        b=JALfXtv1T4fRuYueWh4YQkavVdEDnkf2zdklgnUOdF9Id0VIHEU0Pg1QRHf2Xgxac8
         MQ4FoVds8sxRYKp1q0rg0a/0sUYqguaBa3rDE+xijp0Y5nrLI3QEfPaCN+M4m+kNdp6e
         Xg2UUPo9uuPAFoesmH0ojwNFX97g1eQTBRGt4/EQsXIDvFkDnKZps9lk72aF24NJTaz7
         MsvfnH8Xo4FqqlPKpeU6vrHMlk1sODSieP/Mq3AaafZiKW+iLHacCoDUKpvW9KNGvtE8
         Oeh0ms3yxogD+6W0QK9PCq36owIjAZXU9ArT1RqK2mM7x25pAl6OOd7799cd+LR06UM7
         kzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qlitGsg1X20EWm2iWZwvbgltl8mluLldf1XZLx6X2YI=;
        b=YLBqKlk6C9RRtJz1o3ejPrtMkeUoCrOCGju9/Pl4g2uZh2JHTloHatcG0YHe5gP4/s
         FfEnd0U7n19aoirGCXiJhLtv0sYaLQqNUJJ+GPsPOWyQvBGn1PAwQCJlqQCg3fXN/uza
         DzccuuFXfPwkHTppDzaG+/SBzUrp+MTU0b+sTegGFo9VpsuGhYEg04UobWWAOAbiccp9
         uG1yqwnM1cnOSAtScPqKSmgbuZFb/6/kRAaeSwLLTZFRowjFLRiAo0XdznT+EfiZesba
         Mp3CmGtXV3nC8uwAARmW/r/y04W9D0kHHNwN1RjEmAM3EVclCFlw50Grhp4IIargpajz
         CllQ==
X-Gm-Message-State: AA+aEWZgL7h8nyRJOD9uXJP9WYJ3mA583pijwQDhlnzJI+cUTmU2Lw+E
        nixV5rK4vDb4pXzHB+5bLMlSiQ==
X-Google-Smtp-Source: AFSGD/WVaiAYxFsx500PQDK7gj6jMMfVeTRIoLa3XxyzOGfae9ivAqihKOfBwqqAK395dBG8lnDVnQ==
X-Received: by 2002:a62:99dd:: with SMTP id t90mr13143217pfk.179.1543882463031;
        Mon, 03 Dec 2018 16:14:23 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id g136sm20255782pfb.154.2018.12.03.16.14.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 16:14:22 -0800 (PST)
Subject: Re: [PATCH] sbitmap: fix sbitmap_for_each_set()
To:     Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc:     kernel-team@fb.com
References: <d83eb1df09213aafdd190fde18f406d1b988af3f.1543877128.git.osandov@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e210ba12-7f7e-6e02-6932-ba5c2be64c72@kernel.dk>
Date:   Mon, 3 Dec 2018 17:14:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d83eb1df09213aafdd190fde18f406d1b988af3f.1543877128.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/3/18 3:45 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> We need to ignore bits in the cleared mask when iterating over all set
> bits.

Thanks Omar, applied.

-- 
Jens Axboe

