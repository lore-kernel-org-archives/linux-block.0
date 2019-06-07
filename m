Return-Path: <SRS0=19b2=UG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4C4C28CC3
	for <linux-block@archiver.kernel.org>; Fri,  7 Jun 2019 07:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9D42089E
	for <linux-block@archiver.kernel.org>; Fri,  7 Jun 2019 07:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="l7WHDDr/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfFGHaO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jun 2019 03:30:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36790 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfFGHaO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jun 2019 03:30:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so1069181wrs.3
        for <linux-block@vger.kernel.org>; Fri, 07 Jun 2019 00:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lrr6ioZcekx4kANZ44iPzLZQJWO8X7giUJsRwhjFEb0=;
        b=l7WHDDr/x6pU8uYm5wJ0Y3fV2Q55Li+9kzbMpZNFSrpIEQLoGXyM/b9hnONT/bYi9P
         qAxGdnrXTd6FnF1ucQ5wtRB7h3DwuJyP22h8w18Mt5CrPgx6aN/2+qnc15mpd+xvAL8A
         btd5J7vllSPG8ebzjZBzAFWQvkhxxIxMR4vcgpZ7Vzh4DSCrWQvFvwsrwCDAOaEtXvxS
         z5FbtRgH+fm++h4OdrqYP4+tEsxGthbOQguem2DmX5g5YkFvRclrEFllTxW4MazRNdob
         O38cT/HoWGTw2ezDOjCL4zEtJdixjl2NnvFTcADXiwFHgE6Hee3j5+Lk2RCg1n+qe+cj
         E25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lrr6ioZcekx4kANZ44iPzLZQJWO8X7giUJsRwhjFEb0=;
        b=Im/Tqg/YuiqjE20OR/6fdg7su4CEl8nlRRaViD9VAGVdQk5UDbDNDx/90CFt4tDB+O
         f+R6gK4qLrBTMfLKBsossOGy2Tolnj4FY9sP3Ve/Vg39UyS89qs26vnpqLH58VuyEdbm
         nfqYm4T9XIcRzcsVrxhk6TXYDM6jBag304JkUQhjugdt4RZnqbZKLieNt4AUEOduFbgh
         jigkf8nHDi75Uoib9VppAboALBr3BL3Q56AOhsI0JGblOUpI5zy8qiQYnGT/9UwJIq2s
         2e55IPNjOsgpwJ1Cz/zC9lOHSUyhCFBTQWjYSCeHuTgz5zHi3Vn+c1ea2XG4tZR4PUsx
         B8Mg==
X-Gm-Message-State: APjAAAW+djUYJx5kUgo5/Ikn592P87EwtvkXnFQ46DwQyyfSHdgdsQ0S
        ccTyFCWuvKvZNwIxVNMvsqKoKg==
X-Google-Smtp-Source: APXvYqxgu9KpnCoFF4B/lcXMArKLgM38fRJe5qI9vG94/+fP1scTodXoLuQNEpByJ8nvA5GHPTV6kw==
X-Received: by 2002:adf:dc0c:: with SMTP id t12mr32465037wri.101.1559892612170;
        Fri, 07 Jun 2019 00:30:12 -0700 (PDT)
Received: from [10.97.4.179] (aputeaux-682-1-82-78.w90-86.abo.wanadoo.fr. [90.86.61.78])
        by smtp.gmail.com with ESMTPSA id q24sm971429wmc.43.2019.06.07.00.30.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 00:30:11 -0700 (PDT)
Subject: Re: [PATCH 0/2] block, bfq: add weight symlink to the bfq.weight
 cgroup parameter
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name
References: <20190521080155.36178-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <854dd83a-bd07-c1c3-d005-ef7a62f0fa35@kernel.dk>
Date:   Fri, 7 Jun 2019 01:30:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190521080155.36178-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/21/19 2:01 AM, Paolo Valente wrote:
> Many userspace tools and services use the proportional-share policy of
> the blkio/io cgroups controller. The CFQ I/O scheduler implemented
> this policy for the legacy block layer. To modify the weight of a
> group in case CFQ was in charge, the 'weight' parameter of the group
> must be modified. On the other hand, the BFQ I/O scheduler implements
> the same policy in blk-mq, but, with BFQ, the parameter to modify has
> a different name: bfq.weight (forced choice until legacy block was
> present, because two different policies cannot share a common parameter
> in cgroups).
> 
> Due to CFQ legacy, most if not all userspace configurations still use
> the parameter 'weight', and for the moment do not seem likely to be
> changed. But, when CFQ went away with legacy block, such a parameter
> ceased to exist.
> 
> So, a simple workaround has been proposed by Johannes [1] to make all
> configurations work: add a symlink, named weight, to bfq.weight. This
> pair of patches adds:
> 1) the possibility to create a symlink to a cgroup file;
> 2) the above 'weight' symlink.

Applied, thanks.

-- 
Jens Axboe

