Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9152C31E49
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E4E20B7C
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gcm4y7Z5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbfFMPsp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:48:45 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46685 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731726AbfFMJSJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 05:18:09 -0400
Received: by mail-yb1-f196.google.com with SMTP id p8so7530715ybo.13
        for <linux-block@vger.kernel.org>; Thu, 13 Jun 2019 02:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rWRYQfTQ2CGUN47KzzewtdkARkI8D2HQXHjNEPkT2fM=;
        b=gcm4y7Z5tiPt34XEseRf897HHaBYWht5YRdwUUXywf4/NMVLTaAkyJ3n9FN2e07T56
         laSscI/KiTjgDi9+Ak7fL1bHEUjGp4LNidEU20YZo0bXBLnFEtVwDbBw0MGXFo1hK67g
         d8yMOD8UvmXaeXYxmBae+8Tb5N+eJKiAXsYMprxMEd/l34UB11BagkeyLTyBfRXzgtiC
         LLDYsxuFGNJ5750N2+Zm+b8U54INv1gx9EJpypgasTP0xGE/8DkDz7Vmxz8mKxizdkzB
         5d0Txz/8dStSmlUiNZja16qapSSOcVwr8kNLYUxyX3bPjortqwPPzrh++lshI0gqbvYf
         WRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rWRYQfTQ2CGUN47KzzewtdkARkI8D2HQXHjNEPkT2fM=;
        b=lP/pGwClabXybZ+xARCLygTDuhoqFRV2AcgzsmqwnZeIQB40Q6wPxtM95kgMB9NjML
         kqrQZQRRHQ8nbmONqlKzYokDaLGYGonBS9Et8gMyGluFoMtxeMnrezRDiSMfolhzdGBo
         9pTFjtqztgCSpwvz9l13zmgrm0oXmug3DxAVHD2Xi2t8LpXDQ/1l31DOW0l2Wr1cOwPT
         Um5Tukw53o6gAG4O5YJxjXZgCsA6bgmpSLrOg9BCRsILkNcUOHEUhLWR2454Cd+nV7zD
         aog/eUVHmH5SXrr3qRtSr6Dkpgbz9Y6MszaXnGs687qYCMNPFoq7x6ExJGZMHRs8nBzm
         HwSQ==
X-Gm-Message-State: APjAAAWN3aXa2R9rNqu8ilVNYB04QmeUGNf52QxLm3137MCv0EDVx5y7
        a8S4kA0JxLJhlZu/qtHM0girLGE+EwEKsN0x
X-Google-Smtp-Source: APXvYqxLGysOgdpeENWfSfydoLuDyyMBrKZQKgBENiQq24AdUBHUlZN8NTSTBAgmInA19Qv2H7zdFw==
X-Received: by 2002:a5b:412:: with SMTP id m18mr44123343ybp.497.1560417488445;
        Thu, 13 Jun 2019 02:18:08 -0700 (PDT)
Received: from [172.20.10.3] (mobile-166-172-57-221.mycingular.net. [166.172.57.221])
        by smtp.gmail.com with ESMTPSA id l14sm625653ywb.59.2019.06.13.02.18.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 02:18:07 -0700 (PDT)
Subject: Re: [PATCH] block/ps3vram: Use %llu to format sector_t after LBDAF
 removal
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jim Paris <jim@jtan.com>, Geoff Levand <geoff@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org
References: <20190613073006.13459-1-geert+renesas@glider.be>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <da98e8b2-8abf-77c1-ac98-6b164ebf9d34@kernel.dk>
Date:   Thu, 13 Jun 2019 03:18:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613073006.13459-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/13/19 1:30 AM, Geert Uytterhoeven wrote:
> The removal of CONFIG_LBDAF changed the type of sector_t from "unsigned
> long" to "u64" aka "unsigned long long" on 64-bit platforms, leading to
> a compiler warning regression:
> 
>      drivers/block/ps3vram.c: In function ‘ps3vram_probe’:
>      drivers/block/ps3vram.c:770:23: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘sector_t {aka long long unsigned int}’ [-Wformat=]
> 
> Fix this by using "%llu" instead.

Applied, thanks.

-- 
Jens Axboe

