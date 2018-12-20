Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFD1C43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 16:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38129217D8
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 16:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbeLTQ4u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:56:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:24918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730950AbeLTQ4u (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 11:56:50 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 50A927FD59;
        Thu, 20 Dec 2018 16:56:50 +0000 (UTC)
Received: from ming.t460p (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42B847E482;
        Thu, 20 Dec 2018 16:56:44 +0000 (UTC)
Date:   Fri, 21 Dec 2018 00:56:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, osandov@osandov.com
Subject: Re: [PATCHSET v2] Fix kyber hang
Message-ID: <20181220165638.GB27758@ming.t460p>
References: <20181220160149.4042-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220160149.4042-1-axboe@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 20 Dec 2018 16:56:50 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 20, 2018 at 09:01:47AM -0700, Jens Axboe wrote:
> Since the wrong kyber patch was included in the first one, here's a
> v2 with just that one line corrected.
> 
> First one adds the necessary sbitmap helpers for users to be able to
> do add_wait_queue() and list_del(wait_entry) type operations, and
> still work with the optimized wakeup checking.
> 
> Second one converts kyber to use it, fixing a hang with domain tokens.

With the two patches, can't reproduce the io hang issue any more when
kyber is used.

Tested-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
