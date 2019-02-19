Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCB3C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 09:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B59421904
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 09:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550566891;
	bh=hO5bHD3brKt+ZvBi0aqsZhusk0JCVPqgtbDD0VBMUZo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=AhumxLakFzNGcBK+hS52QjyCVt4Zu4CGzToi4xlG4QnSbUrxuAiz0/Y+vBhYIpUzR
	 rVERPY/3tAMW8Rt2OzTNJk4Ln34VhZtq+BCgF69gMrQVWF/fjDdaw1M/9l9MqGvZP/
	 KbkFuHEydy88b7kz6e9MqzmZuh4P2xtT/7TKChgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfBSJB3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:01:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbfBSJB3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Feb 2019 04:01:29 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0616F21902;
        Tue, 19 Feb 2019 09:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550566888;
        bh=hO5bHD3brKt+ZvBi0aqsZhusk0JCVPqgtbDD0VBMUZo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=agnDva5DNxOLl02FbP94T6ITnAoIgiNTS84+lvUNPERwzpvVtIvfpgQqO5qwfEGoW
         4JbCOBKCqyyZmHXQnNlVh744b6vCIOpMqIW3xmL+1KlJ8VAkXtIF6VAqmU33dEsHeL
         LzcjA5Be+d1wUilyOrJMVZOfZEdV7xcrDlyYawrM=
Date:   Tue, 19 Feb 2019 10:01:25 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] floppy: remove set but not used variable 'q'
In-Reply-To: <20190218084232.193878-1-yuehaibing@huawei.com>
Message-ID: <nycvar.YFH.7.76.1902191001070.11598@cbobk.fhfr.pm>
References: <20190218084232.193878-1-yuehaibing@huawei.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 18 Feb 2019, YueHaibing wrote:

> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/block/floppy.c: In function 'request_done':
> drivers/block/floppy.c:2233:24: warning:
>  variable 'q' set but not used [-Wunused-but-set-variable]
> 
> It's never used and can be removed.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Jiri Kosina <jkosina@suse.cz>

Jens, could you please take this through your tree?

Thanks.

-- 
Jiri Kosina
SUSE Labs

