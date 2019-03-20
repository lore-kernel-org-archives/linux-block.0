Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7B0C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 00:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033D220835
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 00:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="VBwKJkug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfCTAnM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Mar 2019 20:43:12 -0400
Received: from a9-112.smtp-out.amazonses.com ([54.240.9.112]:37312 "EHLO
        a9-112.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725958AbfCTAnM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Mar 2019 20:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1553042591;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=B9sioxXwJ8rVpdbilI7Fnpz1yz5RdR7tc4Xt5PO+emc=;
        b=VBwKJkug3HTMEURo5qyOD/z9okFI4YVhcpxmD0DrF5468WQ+ew8H9nnZbSc3g7aC
        73YNYCesh3CpjPthWstPYZD59v0KRTJ8bhUvP+WmW+teVrsGiQTJDhYOAccKtv58/WN
        ama1QEg4t9G6OAHEP7NJs8i+YtezrZ212eZIzZ8g=
Date:   Wed, 20 Mar 2019 00:43:11 +0000
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
Subject: Re: [RFC 0/2] guarantee natural alignment for kmalloc()
In-Reply-To: <20190319211108.15495-1-vbabka@suse.cz>
Message-ID: <01000169988d4e34-b4178f68-c390-472b-b62f-a57a4f459a76-000000@email.amazonses.com>
References: <20190319211108.15495-1-vbabka@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.03.20-54.240.9.112
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 19 Mar 2019, Vlastimil Babka wrote:

> The recent thread [1] inspired me to look into guaranteeing alignment for
> kmalloc() for power-of-two sizes. Turns out it's not difficult and in most
> configuration nothing really changes as it happens implicitly. More details in
> the first patch. If we agree we want to do this, I will see where to update
> documentation and perhaps if there are any workarounds in the tree that can be
> converted to plain kmalloc() afterwards.

This means that the alignments are no longer uniform for all kmalloc
caches and we get back to code making all sorts of assumptions about
kmalloc alignments.

Currently all kmalloc objects are aligned to KMALLOC_MIN_ALIGN. That will
no longer be the case and alignments will become inconsistent.

I think its valuable that alignment requirements need to be explicitly
requested.

Lets add an array of power of two aligned kmalloc caches if that is really
necessary. Add some GFP_XXX flag to kmalloc to make it ^2 aligned maybe?

