Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9A0C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 00:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5DB20835
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 00:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="PlP4+RjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfCTAo1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Mar 2019 20:44:27 -0400
Received: from a9-46.smtp-out.amazonses.com ([54.240.9.46]:56642 "EHLO
        a9-46.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725958AbfCTAo0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Mar 2019 20:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1553042665;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=l7GGzMPK2ZJjVEBw3exJiICCgYRKwnNAiKS5bg6nqGs=;
        b=PlP4+RjHhS99d2viVKcqtgP13+3ae9Tceh7+ncOi1pmU/SV90eao0W6UVO4C/ysv
        bNKfYHD0TzHglvVEcijO11H/eX6miTYFt0JcCQdbZNOfnu9WN5xAD9dT4X/tJTX14dv
        btQifloIUFWP1UlOx8StJAo3W4BZdudfSoVgoHeA=
Date:   Wed, 20 Mar 2019 00:44:25 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     linux-mm@kvack.org, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [RFC 2/2] mm, sl[aou]b: test whether kmalloc() alignment works
 as expected
In-Reply-To: <20190319211108.15495-3-vbabka@suse.cz>
Message-ID: <01000169988e707d-e6a091d6-b04f-4774-89b0-61f985885ac8-000000@email.amazonses.com>
References: <20190319211108.15495-1-vbabka@suse.cz> <20190319211108.15495-3-vbabka@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.03.20-54.240.9.46
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 19 Mar 2019, Vlastimil Babka wrote:

> Quick and dirty init test that kmalloc() alignment works as expected for
> power-of-two sizes after the previous patch.

There is already an allocator testing function in mm/slub.c. Can you
generalize it or portions and put the into mm/slab_common.c?
