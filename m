Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED987C282DE
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 08:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B800021473
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 08:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfDIIHq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:07:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:44388 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726588AbfDIIHp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Apr 2019 04:07:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DAE55AC97;
        Tue,  9 Apr 2019 08:07:43 +0000 (UTC)
Subject: Re: [RFC 0/2] guarantee natural alignment for kmalloc()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christopher Lameter <cl@linux.com>, linux-mm@kvack.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, lsf-pc@lists.linux-foundation.org
References: <20190319211108.15495-1-vbabka@suse.cz>
 <01000169988d4e34-b4178f68-c390-472b-b62f-a57a4f459a76-000000@email.amazonses.com>
 <5d7fee9c-1a80-6ac9-ac1d-b1ce05ed27a8@suse.cz>
 <010001699c5563f8-36c6909f-ed43-4839-82da-b5f9f21594b8-000000@email.amazonses.com>
 <4d2a55dc-b29f-1309-0a8e-83b057e186e6@suse.cz>
 <01000169a68852ed-d621a35c-af0c-4759-a8a3-e97e7dfc17a5-000000@email.amazonses.com>
 <2b129aec-f9a5-7ab8-ca4a-0a325621d111@suse.cz> <20190407080020.GA9949@lst.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <af1e0b95-f654-4fa9-d400-af01043907ab@suse.cz>
Date:   Tue, 9 Apr 2019 10:07:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190407080020.GA9949@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/7/19 10:00 AM, Christoph Hellwig wrote:
> On Fri, Apr 05, 2019 at 07:11:17PM +0200, Vlastimil Babka wrote:
>> On 3/22/19 6:52 PM, Christopher Lameter wrote:
>> > On Thu, 21 Mar 2019, Vlastimil Babka wrote:
>> > 
>> >> That however doesn't work well for the xfs/IO case where block sizes are
>> >> not known in advance:
>> >>
>> >> https://lore.kernel.org/linux-fsdevel/20190225040904.5557-1-ming.lei@redhat.com/T/#ec3a292c358d05a6b29cc4a9ce3ae6b2faf31a23f
>> > 
>> > I thought we agreed to use custom slab caches for that?
>> 
>> Hm maybe I missed something but my impression was that xfs/IO folks would have
>> to create lots of them for various sizes not known in advance, and that it
>> wasn't practical and would welcome if kmalloc just guaranteed the alignment.
>> But so far they haven't chimed in here in this thread, so I guess I'm wrong.
> 
> Yes, in XFS we might have quite a few.  Never mind all the other
> block level consumers that might have similar reasonable expectations
> but haven't triggered the problematic drivers yet.

What about a LSF session/BoF to sort this out, then? Would need to have people
from all three MM+FS+IO groups, I suppose.
