Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35479C00307
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 06:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCD32089F
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 06:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="RW7yB7VN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfIIGJI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Sep 2019 02:09:08 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:37358 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfIIGJH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Sep 2019 02:09:07 -0400
X-Greylist: delayed 317 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Sep 2019 02:09:06 EDT
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id C2C755D6045;
        Mon,  9 Sep 2019 08:03:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1568009027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vcNUCkbMLofJESYwiLvXZxB1JxtkjqS0l4Y8aXZHaB8=;
        b=RW7yB7VNqZ//fQmFwXf6q/ueYkqf4/OLcTr1Wnpy4T8uTQNZBU6vpXJyQYu+fh7ua5dlaX
        cud3B6xoWA/fdK1fSaQC7pF6QbwS/QzlqbNpHLl10T/TKSGbAjV/1Br33mbJ0X+AEc4VCf
        bEZi5jJ4YI5dyQ0iy3NRY02XxwzcvKc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Sep 2019 08:03:47 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com
Subject: Re: [PATCH 0/4] block, bfq: series of improvements and small fixes of
 the injection mechanism
In-Reply-To: <20190822152037.15413-1-paolo.valente@linaro.org>
References: <20190822152037.15413-1-paolo.valente@linaro.org>
Message-ID: <9088f78edc97279e34f6a96277d088f9@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.10
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1568009028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vcNUCkbMLofJESYwiLvXZxB1JxtkjqS0l4Y8aXZHaB8=;
        b=Mr9oP/lV/M2M52dZIg4L9ybmL3UhN5khVLwPiBbsr+V1BWl9/T3PZILDtGYqn7exK6ak+u
        BXJ6iGo7BA4HEDsBPzxGaPm5wOo1fDb6qxrnGowdVtYbIDjhrRllBM+rkKok/Mxy3RELQP
        UFa8PXVHBokdWKd2KMXgFpLcgTzHevI=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1568009028; a=rsa-sha256;
        cv=none;
        b=PbYcbBiP6sBkCNLu7WQxL2h490EROYLol/K59+8xCpvmxM88RaqCZeO1raRT+fPkONmyIi
        DT2exlJHqPiF/Y7VuVKG13QLGSmGn3SXSa59/Sts3RGLhfG8Moo0qw5m1sdWudBMgtlAen
        6uB1RjCKsNJn0IqIQEm1X40BuTtUZrs=
ARC-Authentication-Results: i=1;
        vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 22.08.2019 17:20, Paolo Valente wrote:
> Hi Jens,
> this patch series makes the injection mechanism better at preserving
> control on I/O.
> 
> Thanks,
> Paolo
> 
> Paolo Valente (4):
>   block, bfq: update inject limit only after injection occurred
>   block, bfq: reduce upper bound for inject limit to max_rq_in_driver+1
>   block, bfq: increase update frequency of inject limit
>   block, bfq: push up injection only after setting service time
> 
>  block/bfq-iosched.c | 35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)
> 
> --
> 2.20.1

FWIW, Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name> (I run 
it for quite some time already).

-- 
   Oleksandr Natalenko (post-factum)
