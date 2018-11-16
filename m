Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A97AC43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 07:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094D920869
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 07:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 094D920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeKPSAb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:00:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbeKPSAb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 13:00:31 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA9A2307EA94;
        Fri, 16 Nov 2018 07:49:17 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 19614608F2;
        Fri, 16 Nov 2018 07:49:10 +0000 (UTC)
Date:   Fri, 16 Nov 2018 15:49:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] blk-mq: not embed .mq_kobj and ctx->kobj into queue
 instance
Message-ID: <20181116074905.GB5520@ming.t460p>
References: <20181116032826.11901-1-ming.lei@redhat.com>
 <20181116032826.11901-2-ming.lei@redhat.com>
 <20181116065205.GD1706@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116065205.GD1706@sasha-vm>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 16 Nov 2018 07:49:18 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 16, 2018 at 01:52:05AM -0500, Sasha Levin wrote:
> On Fri, Nov 16, 2018 at 11:28:25AM +0800, Ming Lei wrote:
> > Even though .mq_kobj, ctx->kobj and q->kobj share same lifetime
> > from block layer's view, actually they don't because userspace may
> > grab one kobject anytime via sysfs, so each kobject's lifetime has
> > to be independent, then the objects(mq_kobj, ctx) which hosts its
> > own kobject have to be allocated dynamically.
> > 
> > This patch fixes kernel panic issue during booting when DEBUG_KOBJECT_RELEASE
> > is enabled.
> > 
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> What does this patch depend on? It doesn't apply to Linus's tree nor to
> the block tree.
> 
> Also, could you please cc lkml with patches?

It depends on for-4.21/block.

thanks,
Ming
