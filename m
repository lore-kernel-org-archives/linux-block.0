Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26F9C7EE23
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 06:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjEVGfT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 May 2023 02:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjEVGe5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2023 02:34:57 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4318FA1;
        Sun, 21 May 2023 23:34:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0Vj9B4yc_1684737284;
Received: from 30.221.132.35(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Vj9B4yc_1684737284)
          by smtp.aliyun-inc.com;
          Mon, 22 May 2023 14:34:46 +0800
Message-ID: <e3ee56fc-515a-eb92-b923-360e4a758c12@linux.alibaba.com>
Date:   Mon, 22 May 2023 14:34:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v21 22/30] ocfs2: Provide a splice-read stub
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, ocfs2-devel@oss.oracle.com
References: <376ab23b-52d0-d7fd-2dd9-414cbb474e01@linux.alibaba.com>
 <20230520000049.2226926-1-dhowells@redhat.com>
 <20230520000049.2226926-23-dhowells@redhat.com>
 <2362051.1684736916@warthog.procyon.org.uk>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <2362051.1684736916@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 5/22/23 2:28 PM, David Howells wrote:
> Joseph Qi <joseph.qi@linux.alibaba.com> wrote:
> 
>> Don't see direct IO logic now. Am I missing something?
> 
> See that patch description ;-)
> 
>     Provide a splice_read stub for ocfs2.  This emits trace lines and does an
>     atime lock/update before calling filemap_splice_read().  Splicing from
>     direct I/O is handled by the caller.
> 

Oops, missed the patch 7 of the series since I've only received this
one:(
Have checked it on maillist, it's fine for me now.

Thanks,
Joseph
