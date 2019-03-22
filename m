Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA6EC43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 17:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A804E2083D
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 17:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="e1GXrN0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfCVRw1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:52:27 -0400
Received: from a9-46.smtp-out.amazonses.com ([54.240.9.46]:49172 "EHLO
        a9-46.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727801AbfCVRw1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 13:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1553277146;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=4LmkY378p9IKWuPaxRNrOpznTZtEYeypgpUdKx9r6Vo=;
        b=e1GXrN0yDwa0T8TV5m5Wqs4aJ+t7LB51Oh3a8UvZRW7aYkbfdw131t5ua28iVA5J
        9PUjeLS565oBrK4sUjVng25TgdtBqwPK7fvvCaxeyAY7d/YXa7Be2flDAGwkW5BUnQ0
        lJzae1gKtLzFhDrcOOVDXC7sYlEwIvEwszRDzY24=
Date:   Fri, 22 Mar 2019 17:52:25 +0000
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
In-Reply-To: <4d2a55dc-b29f-1309-0a8e-83b057e186e6@suse.cz>
Message-ID: <01000169a68852ed-d621a35c-af0c-4759-a8a3-e97e7dfc17a5-000000@email.amazonses.com>
References: <20190319211108.15495-1-vbabka@suse.cz> <01000169988d4e34-b4178f68-c390-472b-b62f-a57a4f459a76-000000@email.amazonses.com> <5d7fee9c-1a80-6ac9-ac1d-b1ce05ed27a8@suse.cz> <010001699c5563f8-36c6909f-ed43-4839-82da-b5f9f21594b8-000000@email.amazonses.com>
 <4d2a55dc-b29f-1309-0a8e-83b057e186e6@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.03.22-54.240.9.46
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 21 Mar 2019, Vlastimil Babka wrote:

> That however doesn't work well for the xfs/IO case where block sizes are
> not known in advance:
>
> https://lore.kernel.org/linux-fsdevel/20190225040904.5557-1-ming.lei@redhat.com/T/#ec3a292c358d05a6b29cc4a9ce3ae6b2faf31a23f

I thought we agreed to use custom slab caches for that?

