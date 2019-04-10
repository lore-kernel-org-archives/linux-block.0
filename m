Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8856FC10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 08:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570A02084B
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 08:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="poC8zpU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfDJIDx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:03:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52974 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfDJIDx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 04:03:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3A7xfMS162930;
        Wed, 10 Apr 2019 08:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=I8D5vo6UaakkOrfpGZIYpgFOZPS+v5onlQ4LzX1+lQM=;
 b=poC8zpU0xepUIa/sE9KNo7ArvpcHgawlJl7JP5J3wWFOVCePW2GeQTyXpub3/kdJHUYm
 DCDJfS2sOGMaeAEQuU4i7YHRl+l+IhMbF0pcA3CAG+jgEbLoTgWJ+850YS0GSc2Y4I7b
 lb+TRgPraMFmWA14nh0/cLZa8k4bOFC8ZrAlh95fNSMYxIYijFVWnicBIOrYqMmphXX4
 6DQUdEyPjhPLIq1AZ3wvvN9kwW+QeAeVNzeTEodE06O2smqBVCT0me7jCsCIoHK3nGDv
 i1YegHOu7ojdFK+75SqNA4SaYeNUp579O8OERwhuH9xRtF6qdNAn1pBcqojongcMLAAc Gg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2rpmrq9d0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 08:03:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3A8387e098780;
        Wed, 10 Apr 2019 08:03:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2rpkejryng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 08:03:17 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3A83FVv007126;
        Wed, 10 Apr 2019 08:03:16 GMT
Received: from kadam (/197.157.0.42)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Apr 2019 01:03:15 -0700
Date:   Wed, 10 Apr 2019 11:03:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Greg Edwards <gedwards@ddn.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2] dm zoned: Silence a static checker warning
Message-ID: <20190410080305.GQ6070@kadam>
References: <20190410074735.GA28842@kadam>
 <BYAPR04MB58160DF520B305A4328FC438E72E0@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB58160DF520B305A4328FC438E72E0@BYAPR04MB5816.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904100059
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904100059
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 10, 2019 at 07:56:14AM +0000, Damien Le Moal wrote:
> On 2019/04/10 16:48, Dan Carpenter wrote:
> > My static checker complains about this line from dmz_get_zoned_device()
> > 
> > 	aligned_capacity = dev->capacity & ~(blk_queue_zone_sectors(q) - 1);
> > 
> > The problem is that "aligned_capacity" and "dev->capacity" are sector_t
> > type (which is a u64) but blk_queue_zone_sectors(q) returns a u32 so the
> > higher 32 bits in "aligned_capacity" are always cleared to zero.  This
> > patch adds a cast to u64 to address this issue.
> > 
> > Fixes: 114e025968b5 ("dm zoned: ignore last smaller runt zone")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > v2: In v1 I changed blk_queue_zone_sectors() to return a sector_t type,
> > but in v2 I just add a cast.  The v2 fix would end up going through
> > different maintainers and reviewers so the CC list has grown...
> > 
> > Original discussion: https://marc.info/?l=kernel-janitors&m=155487663405737&w=2
> > 
> >  drivers/md/dm-zoned-target.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
> > index 8865c1709e16..b6cb44fa946d 100644
> > --- a/drivers/md/dm-zoned-target.c
> > +++ b/drivers/md/dm-zoned-target.c
> > @@ -643,7 +643,8 @@ static int dmz_get_zoned_device(struct dm_target *ti, char *path)
> >  
> >  	q = bdev_get_queue(dev->bdev);
> >  	dev->capacity = i_size_read(dev->bdev->bd_inode) >> SECTOR_SHIFT;
> > -	aligned_capacity = dev->capacity & ~(blk_queue_zone_sectors(q) - 1);
> > +	aligned_capacity = dev->capacity &
> > +				~((u64)blk_queue_zone_sectors(q) - 1);
> 
> sector_t is an u64 only if CONFIG_LBDAF is defined (I think this option is going
> away though). Otherwise it is an unsigned long which would be u32 on 32 bits
> arch. Not a problem in terms of arithmetic, but why not cast to sector_t directly ?
> 

I would have prefered to do that but I didn't have strong feelings
either way.  I am always slight annoyed when people don't just copy and
paste my code when I tell them how to fix a patch so I decided to go
with your version...  :P

regards,
dan carpenter

