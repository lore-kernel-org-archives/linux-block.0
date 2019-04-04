Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A6AC4360F
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 10:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E802171F
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 10:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hxNvuI8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfDDKpe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:45:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35254 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbfDDKpd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Apr 2019 06:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uKbxkaS4O3vvetKjsQOGzUVgF1/3j86xWVebVWs4s1A=; b=hxNvuI8+BqwGG023VYcl54avy
        K7alQzyB55oMNxKXAqUGw38hqH4E4JKEsxb2I8X4nPsoHM0Kz70u4FyV/Jimb5Kmuhhefj3580w83
        T8XFO+Kij52CgAoR1pOTrUYviVtUWI4w7PQTwpWGpkNAWWpMYZn4D6oKGKjUTTsMIHe1oeae0yV8d
        RLe6gSk1t7o8iMCOpIVLwlt3NfPo7xlgfAMDtBhy86iY88i6HBdSexB7g6933SiMmgR2GspFoTbQ9
        fMu/jg4d1O8M9QWRevjCKXW0WTF6wbT7zjNQUqfxo//HE8Ex1wKDuD+ZXsUw+Z2dOSQ+PRP/bBv52
        8xXKcr6gg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBzsA-00004s-45; Thu, 04 Apr 2019 10:45:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 940C3201AF566; Thu,  4 Apr 2019 12:45:27 +0200 (CEST)
Date:   Thu, 4 Apr 2019 12:45:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        kernel-janitors@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpumask: Introduce possible_cpu_safe()
Message-ID: <20190404104527.GX4038@hirez.programming.kicks-ass.net>
References: <20190404100218.GA26946@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404100218.GA26946@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 04, 2019 at 01:02:19PM +0300, Dan Carpenter wrote:
> There have been two cases recently where we pass user a controlled "cpu"
> to possible_cpus().  That's not allowed.  If it's invalid, it will
> trigger a WARN_ONCE() and an out of bounds read which could result in an
> Oops.

> +/**
> + * cpumask_test_cpu_safe - test for a cpu in a cpumask
> + * @cpu: cpu number
> + * @cpumask: the cpumask pointer
> + *
> + * Returns 1 if @cpu is valid and set in @cpumask, else returns 0
> + */
> +static inline int cpumask_test_cpu_safe(int cpu, const struct cpumask *cpumask)
> +{
> +	if ((unsigned int)cpu >= nr_cpu_ids)
> +		return 0;
> +	cpu = array_index_nospec(cpu, NR_CPUS);

That should be:

	cpu = array_index_nospec(cpu, nr_cpu_ids);

NR_CPUS might still be out-of-bounds for dynamically allocated cpumasks.

> +	return test_bit(cpu, cpumask_bits(cpumask));
> +}

That said; I don't particularly like this interface not its naming, how
about something like:

static inline unsigned int cpumask_validate_cpu(unsigned int cpu)
{
	if (cpu >= nr_cpumask_bits)
		return nr_cpumask_bits;
	return array_index_nospec(cpu, nr_cpumask_bits);
}

Which you can then use like:

	cpu = cpumask_validate_cpu(user_cpu);
	if (cpu >= nr_cpu_ids)
		return -ENORANGE;

	/* @cpu is valid, do what needs doing */
