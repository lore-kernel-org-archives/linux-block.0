Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE024C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 21:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB7F21916
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 21:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfCTVsI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 17:48:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:43204 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727381AbfCTVsI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 17:48:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B61CEAFBD;
        Wed, 20 Mar 2019 21:48:06 +0000 (UTC)
Subject: Re: [RFC 0/2] guarantee natural alignment for kmalloc()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christopher Lameter <cl@linux.com>, linux-mm@kvack.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20190319211108.15495-1-vbabka@suse.cz>
 <01000169988d4e34-b4178f68-c390-472b-b62f-a57a4f459a76-000000@email.amazonses.com>
 <5d7fee9c-1a80-6ac9-ac1d-b1ce05ed27a8@suse.cz>
 <20190320185347.GZ19508@bombadil.infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <b5290e04-6f29-c237-78a7-511821183efe@suse.cz>
Date:   Wed, 20 Mar 2019 22:48:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190320185347.GZ19508@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 3/20/2019 7:53 PM, Matthew Wilcox wrote:
> On Wed, Mar 20, 2019 at 09:48:47AM +0100, Vlastimil Babka wrote:
>> Natural alignment to size is rather well defined, no? Would anyone ever
>> assume a larger one, for what reason?
>> It's now where some make assumptions (even unknowingly) for natural
>> There are two 'odd' sizes 96 and 192, which will keep cacheline size
>> alignment, would anyone really expect more than 64 bytes?
> 
> Presumably 96 will keep being aligned to 32 bytes, as aligning 96 to 64
> just results in 128-byte allocations.

Well, looks like that's what happens. This is with SLAB, but the alignment
calculations should be common: 

slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
kmalloc-96          2611   4896    128   32    1 : tunables  120   60    8 : slabdata    153    153      0
kmalloc-128         4798   5536    128   32    1 : tunables  120   60    8 : slabdata    173    173      0
