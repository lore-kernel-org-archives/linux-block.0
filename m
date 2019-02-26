Return-Path: <SRS0=PBJN=RB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4990C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 16:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817982173C
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 16:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qQ0vpRj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfBZQRb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:17:31 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55764 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbfBZQRb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Feb 2019 11:17:31 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1QGCqAC033528;
        Tue, 26 Feb 2019 16:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=PFOmNSXERoShH2nRHfdwWjGkF5WH9Hmxoe3env79QL0=;
 b=qQ0vpRj814sZq4kSa2WnFuCwals7O5fdfQAPqvcNMDj08ztBMyjbjb+BwfnTGRKfZbtu
 Rro5ouRnSmoXOma1SJ1HJ9yfnxI87fYvtj4I7ancivEccqcMzfFOIIJ6GLb0+FX9qrDi
 4LudWZ0isLmxxCc7KzCyPhjKYypp4mTLikbNeAKFGi9NU8Dq0+KVBFOAE9Mx19qKb/WX
 u2ZW3gNfCjrFvPymOS7ol6IZ8FORYt2fU1fL1jUXzDDiwzKNufvEAIudXZRR83+aPzoE
 BxaY64pR+a3YClDr/rFn6+YDvbDJTZOhAmhvX8tI4fFRGltPR8AT7M4GaFUA4QvhRz4Q 5A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2qtwku5m91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Feb 2019 16:14:46 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1QGEeUj005011
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Feb 2019 16:14:40 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1QGEckn024347;
        Tue, 26 Feb 2019 16:14:39 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Feb 2019 08:14:38 -0800
Date:   Tue, 26 Feb 2019 08:14:33 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Ming Lei <tom.leiming@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Christopher Lameter <cl@linux.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-block <linux-block@vger.kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] xfs: allocate sector sized IO buffer via page_frag_alloc
Message-ID: <20190226161433.GH21626@magnolia>
References: <20190226032737.GA11592@bombadil.infradead.org>
 <20190226045826.GJ23020@dastard>
 <20190226093302.GA24879@ming.t460p>
 <a641feb8-ceb2-2dac-27aa-7b1df10f5ae5@suse.cz>
 <CACVXFVMX=WpTRBbDTSibfXkTZxckk3ootetbE+rkJtHhsZkRAw@mail.gmail.com>
 <20190226121209.GC11592@bombadil.infradead.org>
 <20190226123545.GA6163@ming.t460p>
 <20190226130230.GD11592@bombadil.infradead.org>
 <20190226134247.GA30942@ming.t460p>
 <20190226140440.GF11592@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226140440.GF11592@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9178 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902260115
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 26, 2019 at 06:04:40AM -0800, Matthew Wilcox wrote:
> On Tue, Feb 26, 2019 at 09:42:48PM +0800, Ming Lei wrote:
> > On Tue, Feb 26, 2019 at 05:02:30AM -0800, Matthew Wilcox wrote:
> > > Wait, we're imposing a ridiculous amount of complexity on XFS for no
> > > reason at all?  We should just change this to 512-byte alignment.  Tying
> > > it to the blocksize of the device never made any sense.
> > 
> > OK, that is fine since we can fallback to buffered IO for loop in case of
> > unaligned dio.
> > 
> > Then something like the following patch should work for all fs, could
> > anyone comment on this approach?
> 
> That's not even close to what I meant.
> 
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index ec2fb6fe6d37..dee1fc47a7fc 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -1185,18 +1185,20 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,

Wait a minute, are you all saying that /directio/ is broken on XFS too??
XFS doesn't use blockdev_direct_IO anymore.

I thought we were talking about alignment of XFS metadata buffers
(xfs_buf.c), which is a very different topic.

As I understand the problem, in non-debug mode the slab caches give
xfs_buf chunks of memory that are aligned well enough to work, but in
debug mode the slabs allocate slightly more bytes to carry debug
information which pushes the returned address up slightly, thus breaking
the alignment requirements.

So why can't we just move the debug info to the end of the object?  If
our 512 byte allocation turns into a (512 + a few more) bytes we'll end
up using 1024 bytes on the allocation regardless, so it shouldn't matter
to put the debug info at offset 512.  If the reason is fear that kernel
code will scribble off the end of the object, then return (*obj + 512).
Maybe you all have already covered this, though?

--D

>  	struct dio_submit sdio = { 0, };
>  	struct buffer_head map_bh = { 0, };
>  	struct blk_plug plug;
> -	unsigned long align = offset | iov_iter_alignment(iter);
>  
>  	/*
>  	 * Avoid references to bdev if not absolutely needed to give
>  	 * the early prefetch in the caller enough time.
>  	 */
>  
> -	if (align & blocksize_mask) {
> +	if (iov_iter_alignment(iter) & 511)
> +		goto out;
> +
> +	if (offset & blocksize_mask) {
>  		if (bdev)
>  			blkbits = blksize_bits(bdev_logical_block_size(bdev));
>  		blocksize_mask = (1 << blkbits) - 1;
> -		if (align & blocksize_mask)
> +		if (offset & blocksize_mask)
>  			goto out;
>  	}
>  
