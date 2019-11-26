Return-Path: <SRS0=BQu2=ZS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C6EC432C3
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 10:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C7120863
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 10:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574762588;
	bh=xGCbmWzbnll5u+eUEBhlLq9PaIZXUzSktU0Zep/ysCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ewZrx6fe25zPWJ1jGLhw4atbM+yBdZnIignbyPrZLMBMUrViW0qKXmzArUk+aH6Ha
	 xn4ZyP74fu1G65tR0e6zZEnEzzCT7jI4O1ZUEcrcTaIyV11Re+bIZX78XpHBb99bd9
	 JTJI87SzJJkQZTjSdVwql/e4F0DfE5qXzq44v0Sg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfKZKDH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Nov 2019 05:03:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:59200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727624AbfKZKDH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Nov 2019 05:03:07 -0500
Received: from localhost (unknown [84.241.194.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36FB12075C;
        Tue, 26 Nov 2019 10:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574762586;
        bh=xGCbmWzbnll5u+eUEBhlLq9PaIZXUzSktU0Zep/ysCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SXOP4i52ZwwOLyarWsp60kVhR7XlHhafZ0YPjr+mzOBtFKXxSDPCMtUPO+SulJrkd
         COeHeDzuJwgYFLw3eOQoKyYKHU0owLjj2RmzqeedmFZMcy6aXNpUrBn4LH+Vyd/1h1
         pQTXEpfSVzdjoNfZq5I+H6CFKkw6/YiDhqB9z79k=
Date:   Tue, 26 Nov 2019 10:57:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kc27041980@gmail.com
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] block/drbd/drbd_debugfs.c: Protect &connection->kref
 with resource->req_lock
Message-ID: <20191126095738.GA1415341@kroah.com>
References: <1574742858-23131-1-git-send-email-KC17041980@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574742858-23131-1-git-send-email-KC17041980@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 26, 2019 at 10:04:18AM +0530, kc27041980@gmail.com wrote:
> From: KC27041980 <kc27041980@gmail.com>
> 
> Protect &connection->kref by moving it under resource->req_lock.
> 
> Signed-off-by: KC27041980 <kc27041980@gmail.com>

We need a real name here, something you sign legal documents with.
Please see the in-kernel documentation about submitting patches for all
of the details.

thanks,

gre gk-h
