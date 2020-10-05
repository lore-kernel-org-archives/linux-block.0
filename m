Return-Path: <SRS0=syOM=DM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AC3C4363A
	for <linux-block@archiver.kernel.org>; Mon,  5 Oct 2020 16:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99A13207BC
	for <linux-block@archiver.kernel.org>; Mon,  5 Oct 2020 16:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EXHjpbbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbgJEQsU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Oct 2020 12:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgJEQsS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Oct 2020 12:48:18 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756EBC0613CE
        for <linux-block@vger.kernel.org>; Mon,  5 Oct 2020 09:48:18 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k25so9884317ioh.7
        for <linux-block@vger.kernel.org>; Mon, 05 Oct 2020 09:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+JrT5f4ODECOY6SLMg6ZmVv5vw3hnZeQHmUKznSjjA8=;
        b=EXHjpbbYBzPCQUtwgIQJuUvC/iLMwOJMiCKxS51uaJFQyuishzIiVwXnOQFrQ+ozAo
         NKzZm/jwPFZFZXAdy5+45xNMXeLoQNSzAYRoFDKK9SnA+HNbW8RLKlz5vtFi1SV/NAOY
         XrP051y8idHZvXY3jS12G2PwyvG6B+jXPfk67Skyj8GjGrgOSiC7kc/zTehaQTpTTb75
         rFhSNI5Y5o1TsDaOL39Y6i0Z0/MiaOmj+vgyB3gM4YhEV3AuhPhXBoLUnQOH9JiwEeLB
         1+oabFJY+TGWcojB5qGa9C7q4tJDnj0A63BgGl5lqo9Q7M0y2zvnbeGPAhE1JexLgngL
         XeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+JrT5f4ODECOY6SLMg6ZmVv5vw3hnZeQHmUKznSjjA8=;
        b=rZdfo0x2Nwx/+8Quf2qCxkb2IAJr1wHdjuG/PnnaJGBxlVuMwNa52EK3+JCqHdCl0o
         HWNuDTFFlTA2KRZlCWn3k1K8PBkMK3VYV3ZNAUtDlrEGy7lHKSRfF/qS78w0WIVQqQMi
         XoXoKm20TuCSC/APijubonrevNXRLl7J/2pJa6XSC9Opg5J+sjWOtDfuNWF/wwiMbRMl
         WYUMgcVeq9luw6YBV45j38o/ALjjgt0rzgR2ltxK8dlnbmJWKIlFc1IEd9pr6CgDrvLs
         RjLaD8FrNHATyrgLqqJYuyVAaiwq5rup28IQlWDzUB//iEdF/+ExBNrTcPfbs2UMZZue
         DNGQ==
X-Gm-Message-State: AOAM5300mnIegkblmHioN1+WMiJty/yIltbL3k3qO6lpTgJWFLa5kDyM
        IyMfhVINR2eYObVgpYL6AXUd1A==
X-Google-Smtp-Source: ABdhPJzloX6QJEEcEQVQh8m+fFPWalOjPXRzbAMgwJTGWE8+oGR3GAtbw5onccd1LTQlSaWTLbmFXA==
X-Received: by 2002:a05:6602:2d90:: with SMTP id k16mr378592iow.19.1601916497737;
        Mon, 05 Oct 2020 09:48:17 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s10sm178133ilh.33.2020.10.05.09.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 09:48:17 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] block: fix up bio_crypt_ctx allocation
To:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org
Cc:     dm-devel@redhat.com, Satya Tangirala <satyat@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>
References: <20200916035315.34046-1-ebiggers@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b84faa9c-f5e7-8c90-d54b-6a1dbf68a35b@kernel.dk>
Date:   Mon, 5 Oct 2020 10:48:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200916035315.34046-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/15/20 9:53 PM, Eric Biggers wrote:
> This series makes allocation of encryption contexts either able to fail,
> or explicitly require __GFP_DIRECT_RECLAIM (via WARN_ON_ONCE).
> 
> This applies to linux-block/for-next.
> 
> Changed since v1 (https://lkml.kernel.org/r/20200902051511.79821-1-ebiggers@kernel.org):
>     - Added patches 2 and 3.
>     - Added kerneldoc for bio_crypt_clone().
>     - Adjusted commit message.

Applied for 5.10, thanks.

-- 
Jens Axboe

