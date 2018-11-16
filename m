Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71715C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 06:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDE8224E0
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 06:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWSeUbvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FDE8224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeKPRDL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 12:03:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:33048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbeKPRDL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 12:03:11 -0500
Received: from localhost (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DAC82089D;
        Fri, 16 Nov 2018 06:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542351125;
        bh=1UcOG7cUsg87ZYutt4JYxBPgNPLy5aPi8kYGxWM5RyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IWSeUbvb+qchSUlZOydKqA+Xw5HpC0An8V3RuwhBj5QLBpGmkCabOh/vvOavoSk1x
         hf9Pl3kfrWfSDS+3xUPCTkzq4FeBsAeBJCH4K8WAcvTzyf1EDJBRlopFGtVvS0kRY4
         MEqP180pUeK8MzoYi11aAp2PMi9fkiiFHRRK3ERE=
Date:   Fri, 16 Nov 2018 01:52:05 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] blk-mq: not embed .mq_kobj and ctx->kobj into queue
 instance
Message-ID: <20181116065205.GD1706@sasha-vm>
References: <20181116032826.11901-1-ming.lei@redhat.com>
 <20181116032826.11901-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181116032826.11901-2-ming.lei@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 16, 2018 at 11:28:25AM +0800, Ming Lei wrote:
>Even though .mq_kobj, ctx->kobj and q->kobj share same lifetime
>from block layer's view, actually they don't because userspace may
>grab one kobject anytime via sysfs, so each kobject's lifetime has
>to be independent, then the objects(mq_kobj, ctx) which hosts its
>own kobject have to be allocated dynamically.
>
>This patch fixes kernel panic issue during booting when DEBUG_KOBJECT_RELEASE
>is enabled.
>
>Reported-by: Guenter Roeck <linux@roeck-us.net>
>Cc: Guenter Roeck <linux@roeck-us.net>
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Cc: stable@vger.kernel.org
>Signed-off-by: Ming Lei <ming.lei@redhat.com>

What does this patch depend on? It doesn't apply to Linus's tree nor to
the block tree.

Also, could you please cc lkml with patches?

--
Thanks,
Sasha
