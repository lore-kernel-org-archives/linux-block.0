Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E850C433B4
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 20:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B87D61422
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 20:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbhDVUZS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Apr 2021 16:25:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:35864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237046AbhDVUZS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Apr 2021 16:25:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619123082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jvCcmd7kyHEYnLcAJvO+wHYTOLlZkJbkRR0o6BOquRg=;
        b=JFgXDWIHzyVKX91no+upetS1UwKOfKmPd9NhLm9n/AR5IGYyVPFk1/qAcW8vzrun3buD3e
        MlvciNbAt6/pX9W6nD792FJlujfgDXeVB7lRSdC7cAO0yaVcQjnphWv378vSz6XkX1P81g
        Lah6sR4heRlcNRoEyqe/4CyCRnja7kc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 149F6AEE5;
        Thu, 22 Apr 2021 20:24:42 +0000 (UTC)
Message-ID: <a3e14a692f4237d62d646b84d503f21b6a41ce34.camel@suse.com>
Subject: Re: [*RFC* PATCH] dm: dm_blk_ioctl(): implement failover for SG_IO
 on dm-multipath
From:   Martin Wilck <mwilck@suse.com>
To:     Mike Snitzer <snitzer@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-block@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Benjamin Marzinski <bmarzins@redhat.com>
Date:   Thu, 22 Apr 2021 22:24:41 +0200
In-Reply-To: <20210422202130.30906-1-mwilck@suse.com>
References: <20210422202130.30906-1-mwilck@suse.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I forgot the "RFC" subject prefix. Adding it this way, sorry.

Martin




