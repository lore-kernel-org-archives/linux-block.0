Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476B1C10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 07:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1197D217F4
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 07:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1ojnjue4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbfDJHby (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:31:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52130 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfDJHby (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 03:31:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3A7NsOe133457;
        Wed, 10 Apr 2019 07:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=xeeGlaLTwW/tL/sCAqj0/Be7yl757SOqU3CmbE3nnzE=;
 b=1ojnjue4E+X/VXoh8608O5DvV4nk13UvmYb94O1iEHHLR0aVYHB8bk65nZ/EBGZWAta2
 c1gcZ/VftIYFHHu64LRLGqbJvls/+S2Kk5yJbsgjYA8AW3j66kiSCm0w+2mlxFou+mNb
 uECbPuaW6zFcfoXy+m4653z3MKy5FxOYWtdTl9G3ZO0gdCTotQDcptDwE18G13Y4Ghpt
 SqMG5mO8KMhtY47F4qKsddroSvKkR4+Yf0Ohr+SaZkjNRXtXsMQn6sxywKUakMmiLYl/
 nWbxLL0M8esaY27vp8m6HM8zUYsJfheYNoZ77xsDVAdIBjcxKuNljmI4UyIeMQL6euE5 /Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2rpmrq985u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 07:31:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3A7UVXJ092315;
        Wed, 10 Apr 2019 07:31:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2rph7t22r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 07:31:41 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3A7Vbhp018321;
        Wed, 10 Apr 2019 07:31:39 GMT
Received: from kadam (/197.157.0.42)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Apr 2019 00:31:37 -0700
Date:   Wed, 10 Apr 2019 10:31:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Greg Edwards <gedwards@ddn.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] block: make blk_queue_zone_sectors() return sector_t type
Message-ID: <20190410073126.GP6070@kadam>
References: <20190410061006.GA18813@kadam>
 <BYAPR04MB5816CFE5C37FABB137D496DEE72E0@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB5816CFE5C37FABB137D496DEE72E0@BYAPR04MB5816.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904100054
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904100054
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 10, 2019 at 07:20:27AM +0000, Damien Le Moal wrote:
> On 2019/04/10 15:10, Dan Carpenter wrote:
> > My static checker complains about this line from dmz_get_zoned_device()
> > 
> > 	aligned_capacity = dev->capacity & ~(blk_queue_zone_sectors(q) - 1);
> > 
> > The problem is that "aligned_capacity" and "dev->capacity" are sector_t
> > type (which is a u64) but blk_queue_zone_sectors(q) returns a u32 so the
> > higher 32 bits in aligned_capacity are always cleared to zero.
> > 
> > Declaring blk_queue_zone_sectors() as a sector_t addresses this warning
> > and it feels intuitive based on the function name.  I updated
> > bdev_zone_sectors() as well just to be consistent.
> > 
> > Fixes: 114e025968b5 ("dm zoned: ignore last smaller runt zone")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > Please review this one extra carefully.  I'm not positive it's correct.
> > 
> >  include/linux/blkdev.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index 4b85dc066264..1785a7f506be 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -670,7 +670,7 @@ static inline bool blk_queue_is_zoned(struct request_queue *q)
> >  	}
> >  }
> >  
> > -static inline unsigned int blk_queue_zone_sectors(struct request_queue *q)
> > +static inline sector_t blk_queue_zone_sectors(struct request_queue *q)
> >  {
> >  	return blk_queue_is_zoned(q) ? q->limits.chunk_sectors : 0;
> >  }
> > @@ -1419,7 +1419,7 @@ static inline bool bdev_is_zoned(struct block_device *bdev)
> >  	return false;
> >  }
> >  
> > -static inline unsigned int bdev_zone_sectors(struct block_device *bdev)
> > +static inline sector_t bdev_zone_sectors(struct block_device *bdev)
> >  {
> >  	struct request_queue *q = bdev_get_queue(bdev);
> 
> Indeed, using sector_t instead of unsigned int is more intuitive and changing to
> sector_t matches the 64bits zone length in struct blk_zone too, so no problem on
> this front.
> 
> However, q->limits.chunk_sectors is an unsigned int, which is why I used that
> type, to reflect the fact that even though the API allows values larger than 4G
> sectors, the handling through the queue limits truncates that to at most 4G-1
> sectors. Furthermore, the unsigned int type is used wherever
> blk_queue_zone_sectors() and bdev_zone_sectors() are called (block/ioctl.c,
> block/blk-zoned.c, f2fs, etc). That needs in depth checking.
> 
> I would rather keep the unsigned int since the queue limits will give only 32
> bit values anyway. What about a cast for the aligned capacity line ? Something like:
> 
> aligned_capacity = dev->capacity & ~((u64)blk_queue_zone_sectors(q) - 1);
> 
> Would that make your checker happy ?
> 

Yeah.  Or a sector_t cast.

	aligned_capacity = dev->capacity & ~((sector_t)blk_queue_zone_sectors(q) - 1);

regards,
dan carpenter

