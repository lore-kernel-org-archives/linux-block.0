Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80805C43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 15:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB1422419
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 15:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="tEAQMwLj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB1422419
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388388AbeKPBu2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:50:28 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:31490 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388317AbeKPBu2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 20:50:28 -0500
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id CCDAB46F50B;
        Thu, 15 Nov 2018 16:42:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1542296524;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZUQbZVTpYqrz/LfYbA0NgZXCAeJR1wLkt7HtSNw1xHs=;
        b=tEAQMwLjfCex8QhzvYs8mjI3SrfMoaiXX6UCESjg6ut6j94q6hR8//aZnnMz1XcsLGSXLi
        MuJqY6JlR4UxxMIEClTaW04CuEIvW+OU0dJ7cNl1GUOgUoZbJAXjNF2cpqty9rKwj73S6e
        43QvSrX6CMkA3dg3g12sxZGbOIsyqAM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 15 Nov 2018 16:42:04 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Angelo Ruocco <angelo.ruocco.90@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH 00/12] unify the interface of the proportional-share
 policy in blkio/io
In-Reply-To: <CADiTV-3tSpEMG7EHz3XGvfekNdtN8k_KQiDMtyykgOb81cvO0g@mail.gmail.com>
References: <20181112095632.69114-1-paolo.valente@linaro.org>
 <9e8adb3271680165d85994a225713391@natalenko.name>
 <E8A20452-A73C-4A31-B5EC-48EFB9937832@linaro.org>
 <e85cfae0-7743-8c51-c2c9-0855c26f868e@kernel.dk>
 <CADiTV-37tqWsbxmeZJsqq+pqSqxN-_L9+T9R+PmBBJhfO-G09g@mail.gmail.com>
 <CADiTV-3tSpEMG7EHz3XGvfekNdtN8k_KQiDMtyykgOb81cvO0g@mail.gmail.com>
Message-ID: <03b320ba47a0b2567f9135d17d5d93bd@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1542296524;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZUQbZVTpYqrz/LfYbA0NgZXCAeJR1wLkt7HtSNw1xHs=;
        b=z7FG0t785mVxooeUpTCjTXJMqRktcXImo4RS6k5a0CeSX3NnbooYg3rZkXlvTXLdXYOyli
        6bSa8Gp78U7vUdm7eBLfTkk1EFJugw3tHgTSuMfeokVdW2omUsaatU9zBirEC++lzbmA7d
        JbPIT5pBmPt3JcoQ7hTs+SKPBv7w+Ak=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1542296524; a=rsa-sha256;
        cv=none;
        b=rET39wO5hdEq6IokL7PaFispuiKDyQrCDmJIDnsk7Ovjd2OkjFCvsphqR9Z+KzHxK51J3AKs65MWgP0eD/NjJCXTwxwcD8hAmCXUZUyRhTI17nXtWy1dZmfgnwRLMv+KIX1tFcJcqbAueVcRBxLC5lN8APaHa7kyHgxYVeIazk8=
ARC-Authentication-Results: i=1;
        vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi.

On 15.11.2018 16:33, Angelo Ruocco wrote:
> I have realized that I didn't clearly explain my actions. I did do a
> rebase, but that is not the cause of the problem I reported. I mean,
> this is enough to trigger the issue:
> 
> git add remote block [1]
> git fetch block
> git checkout for-4.21/block
> 
> make
> 
> [1] git://git.kernel.dk/linux-block [1]

Checking this:

http://git.kernel.dk/cgit/linux-block/tree/include/net/xfrm.h?h=for-4.21/block#n1465

and `git blame`, I don't see any `spruct` there.

Is your storage OK? Or, maybe, that was some accidental edit?

-- 
   Oleksandr Natalenko (post-factum)
