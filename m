Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3864C6783B
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1B420851
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A1B420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeLKXFS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:05:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbeLKXFR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 18:05:17 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D365F750DA;
        Tue, 11 Dec 2018 23:05:17 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CB515C219;
        Tue, 11 Dec 2018 23:05:15 +0000 (UTC)
Date:   Tue, 11 Dec 2018 18:05:14 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        dm-devel@redhat.com
Subject: Re: for-next hangs on test srp/012
Message-ID: <20181211230514.GA20445@redhat.com>
References: <1544569107.185366.391.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544569107.185366.391.camel@acm.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 11 Dec 2018 23:05:17 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 11 2018 at  5:58pm -0500,
Bart Van Assche <bvanassche@acm.org> wrote:

> Hi Jens,
> 
> If I run the following subset of blktests:
> 
>   while :; do ./check -q srp && ./check -q nvmeof-mp; done
> 
> against today's for-next branch (commit dd2bf2df85a7) then after some
> time the following hang is reported:

Jens has applied a fix from me today that I think is very relevant;
it'll be in tomorrow's for-next:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-4.21/block&id=c4576aed8d85d808cd6443bda58393d525207d01

Please try with that and see how things go.

Thanks,
Mike
