Return-Path: <SRS0=+4Fh=VV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F7CC7618B
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 15:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B183221738
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 15:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="b7wci5v+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387514AbfGXPMK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jul 2019 11:12:10 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40768 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387503AbfGXPMK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jul 2019 11:12:10 -0400
Received: by mail-io1-f68.google.com with SMTP id h6so3774869iom.7
        for <linux-block@vger.kernel.org>; Wed, 24 Jul 2019 08:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QJHssONEhZIyAmvNE/Dt5/SrjwAj1mcDMbQg9vLevbA=;
        b=b7wci5v+oCm7RxTvEBS5kZABHnS7btZ3cV5tLZqAXk6YUle2WBE3OcUCpCK6NxgMU6
         JmT3hYwfNyg8jLQWAEZQ/7nuclviKeviSmK4V1d1IFAg9LdErsnjLbdJmX58LHWwggDH
         TmLTuuEHzdg9Ov7O0LwyOtrPXD1ntFd2hME9NMgGk8PxVMA9RH15KBBL3Zakt7AENPki
         xmN5psB0KdURkO9ucA3Y7XYPhW/sMXnCXfS/CJwzl0Ofc/5ht73UGU0u2Wr/FNDnzGAp
         Og3e2H+Sj7404GkZlHPtm9BcB6AeCdD+mCAQl/1vrjgFgx3PWNEKVEuFmlQoGApSDGwW
         Mtxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QJHssONEhZIyAmvNE/Dt5/SrjwAj1mcDMbQg9vLevbA=;
        b=LL3mn5RPDWLoEpvSMsiPEPMUx2gZie6bX+xnAaxLXwOMF2F/xHxdwH39OFEuCLdZEP
         /wvyxOHz2Zm4AtsQ/2UbGVfXPc3PcI07/u7WSgPnXs6ucgf7nIeHZzzsVJAREe2ZXnrE
         c6diphoeSFix5iDhJJiWQr63SAXsDl4Vw0ypg8YAfunEZx/log832JBFsJCMQyUyn34h
         Sx7r0NuLX/tX8sZUd6s4e3dW1Cc6slhygo0URazOGJc1Wdxpaf2nsiu8WFGTT2P4f6f8
         78eCjX4SspmW8MK/EywPW4f9PWpfCb8MNFOGrM+bvJzSF6icEJpfVrqpeSVpD10Kjfjn
         JTRg==
X-Gm-Message-State: APjAAAWQrdIigOOHCb5/TH/n6YSxPGr2gFdtDdPhhRBRkozSb2Fb8fJl
        EM1i0A9lZU6Qmc+3H3ZgycbIpf21tfk=
X-Google-Smtp-Source: APXvYqxBvbVarpxI5hXCuvn8ANYsE8HbbflFSePljhd8cbGsZKgnV7WZ/H3nhmkMgn+2T0+rdDmfkw==
X-Received: by 2002:a6b:ee12:: with SMTP id i18mr16611404ioh.172.1563981128744;
        Wed, 24 Jul 2019 08:12:08 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a7sm37195262iok.19.2019.07.24.08.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 08:12:07 -0700 (PDT)
Subject: Re: [PATCH liburing 0/4] Fedora packaging preparation
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>,
        Jeff Moyer <jmoyer@redhat.com>, linux-block@vger.kernel.org
References: <20190724082450.12135-1-stefanha@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <64f0511e-36d9-a59e-abb6-acae1aed2653@kernel.dk>
Date:   Wed, 24 Jul 2019 09:12:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724082450.12135-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/24/19 2:24 AM, Stefan Hajnoczi wrote:
> This patch series includes further steps towards Fedora packaging.  The most
> notable one is moving private headers into <liburing/*.h> to prevent naming
> collisions with other software.  Existing applications are unaffected because
> the public <liburing.h> header remains in its old location.

Applied, thanks.

-- 
Jens Axboe

