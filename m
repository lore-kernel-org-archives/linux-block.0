Return-Path: <SRS0=69Bb=5X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75ACC2D0EC
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 20:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3322074B
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 20:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YIeRtzS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDGUnW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:43:22 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43505 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgDGUnV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Apr 2020 16:43:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id z6so188045plk.10
        for <linux-block@vger.kernel.org>; Tue, 07 Apr 2020 13:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=lAoleMRuYnqDdpdbAtO8SSxhrald+xVhoPKw4jheceE=;
        b=YIeRtzS9twKbUESIFLeTvVmePNQGmVB0TqEOvrqnh5PaJul/yc2RhdgYfyy+ecorbC
         gZSXyE/OLhssrN29ZkXIV0vK89CSR5cri+4OP13XE7o4c4wcuhvZPi1LkhKV+8Ltdc8o
         O2uAytqJnStS63Bjfb2soyRqOeDJWzGgcS+t4kcRwavRanWEBt1W23ORv7zslQFspozf
         pvdJVaT4SFvwzsWGJSAskBD63qa1WEvsG0XeXrLSdizpIJkfaW2tIeWbleBTfXS/oKXw
         nFST4M+r2m9u3HY+Q9IhrflIxYEwtsQYAjtl587QZTq0cZ9lsRKtIWvIsg5T3QtNrOJS
         YXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lAoleMRuYnqDdpdbAtO8SSxhrald+xVhoPKw4jheceE=;
        b=FLpA5b6c3o11V6iFh39rRcr03a5oUuX1yWSsRFlRT/sT2x9NRHl8pIrBaOE/td3JaP
         +wn+NaLCUc/LE8PpmKQ+lYHAgCF2rv7NcrYDmFCUuvUKyrhvtd3XGllDWRn7Vd4rGmz/
         Z33IbamZQbrarH/x994pH4+rXkv2LB1fJ3oVMbGrPN2lNXvzwm1mnKRvzGgkWsptZIDp
         x7lnhAg9P3qiPUrC13G40Vr5SjDzYNE5BiZVST31C3MsIaZqnlALC6BTAZYnYR0K9k7a
         +MiKFFMX95ftn8nk6f+2i9bi6ymSyoTj/urXWRbnLPjMGZPacL4kgEHw/xo4fKd72OuO
         nTPA==
X-Gm-Message-State: AGi0PuZsJtvID8zFii6IDFLtKjcsznij3Lotd0tubN+nhCdeYqhO4CCJ
        QD6SJV2dEzbSSmLHZVeudCadA9QddYBggw==
X-Google-Smtp-Source: APiQypJwrolGH80Q3l24ZzEKdiiRwVo2QR1rXSBajy8RCChhb+dtQOEO8/NYb5BoFS8qEkPZdcSSxA==
X-Received: by 2002:a17:90a:1f0b:: with SMTP id u11mr1299505pja.18.1586292197986;
        Tue, 07 Apr 2020 13:43:17 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:ec7d:96d3:6e2d:dcab? ([2605:e000:100e:8c61:ec7d:96d3:6e2d:dcab])
        by smtp.gmail.com with ESMTPSA id z12sm15233008pfj.144.2020.04.07.13.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 13:43:16 -0700 (PDT)
Subject: Re: [PATCH] block: fix busy device checking in blk_drop_partitions
To:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
References: <20200404065120.655735-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0efdeebf-2d5e-b025-34e2-6d29c6b4e992@kernel.dk>
Date:   Tue, 7 Apr 2020 13:43:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200404065120.655735-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/3/20 11:51 PM, Christoph Hellwig wrote:
> bd_super is only set by get_tree_bdev and mount_bdev, and thus not by
> other openers like btrfs or the XFS realtime and log devices, as well as
> block devices directly opened from user space.  Check bd_openers
> instead.

Applied, thanks.

-- 
Jens Axboe

