Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE9BC4360F
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 11:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677B0206C0
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 11:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WiwMZqrw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfDDL2U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:28:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54618 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728775AbfDDL2U (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Apr 2019 07:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZjwA9bBAqDZG+ml5BFZSkpHCRFNpvjIjCm42eG0iWhk=; b=WiwMZqrwYn/59tRw9u8l9eG2Y
        9fjZjP7NmBA3EJ9tRt9pWfHJNrrr2pKXExAGvsIPELJOcNdz50XBEvXvUQ08nFSvqpVzi2xOv37dI
        jouIfPS6QVC+IbhHHVinPRfQriXCoEgDdL5mghWYu9dLC0zNP9qOfrqdpfCKXmZpOhnKkcmPDpS0n
        cgiz/43tw6DvvWEFvk9jK+v7ehN1LR0S/HcnjCppZcaHFazeTFRg0gbjrO3mi53v+i4t7a4r7OmQo
        zp8yTb0mYlPb5LJQc2tNJzYbmaQ7miLJLysivGvuI24gVevk1ZKvQq59nOmfwykz1+fCd1cXTV4G5
        lgPKJedPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hC0XQ-00038L-Ft; Thu, 04 Apr 2019 11:28:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AD34629AA465D; Thu,  4 Apr 2019 13:28:05 +0200 (CEST)
Date:   Thu, 4 Apr 2019 13:28:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        kernel-janitors@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpumask: Introduce possible_cpu_safe()
Message-ID: <20190404112805.GZ4038@hirez.programming.kicks-ass.net>
References: <20190404100218.GA26946@kadam>
 <20190404103528.GG12864@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404103528.GG12864@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 04, 2019 at 12:35:28PM +0200, Michal Hocko wrote:
> On Thu 04-04-19 13:02:19, Dan Carpenter wrote:
> > There have been two cases recently where we pass user a controlled "cpu"
> > to possible_cpus().  That's not allowed.  If it's invalid, it will
> > trigger a WARN_ONCE() and an out of bounds read which could result in an
> > Oops.
> > 
> > This patch introduces possible_cpu_safe() which first checks to see if
> > the cpu is valid, turns off speculation and then checks if the cpu is
> > possible.
> 
> Why cannot we do the check in possible_cpu directly? Is it used from any
> hot path? I am quite skeptical people will use the new helper
> consistently.

Why only possible? What is to say stop anyone from using garbage (aka.
user input) in any other of the cpumask APIs.

I'd much rather have the explicit validate call and keep assuming @cpu
as used in the rest of the API is sane.
