Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BA3C67838
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 04:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DEA22084D
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 04:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gk7wej82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DEA22084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbeLJEan (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Dec 2018 23:30:43 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57382 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbeLJEal (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Dec 2018 23:30:41 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBA4SvlE183892;
        Mon, 10 Dec 2018 04:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=LZe0diQtVrs49/aC6pDftkvnoPmktMBHW+MlNxMM8Ok=;
 b=Gk7wej82v4BiTOU8839Aq7VChgAGQdtkQaWJxNETnm7CuLkbrmD3WWB+BP6rlYXY6vez
 qvXpkwCfPQae3Jp+WJgj0P/7iSVziqWU/8heD+ih3E01hsyrnSNYwMN/VgkomXDPSkyr
 1CQkTdD/V2Yxos37xiOUX09o/oiwNWikLZ/D6glOqwZM/3WUO5nj8mgJMBEx2MrH2s3n
 QXH1FiQB4HXYNOidU/3enHqAy9RjVJ/aRPb/129zLPU02yqfP+GGAJA3sEWZkt2b8EPm
 KZYw3uMowIWpIclTsoZlz9Rp4Wa9oT2UaGA9z6NV0RGPuVn+giSO1STqLIl4lx0oexC5 qQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2p83fduu5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 04:30:19 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBA4UJiC020024
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 04:30:19 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBA4UHOH022588;
        Mon, 10 Dec 2018 04:30:17 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 09 Dec 2018 20:30:17 -0800
Date:   Sun, 9 Dec 2018 20:30:15 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Bob Liu <bob.liu@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com
Subject: Re: [RFC PATCH v1 0/7] Block/XFS: Support alternative mirror device
 retry
Message-ID: <20181210043015.GS24487@magnolia>
References: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
 <20181128053303.GL6311@dastard>
 <20181128074544.GA20702@infradead.org>
 <f7bf5329-e756-1edb-af3f-41aca02691fe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7bf5329-e756-1edb-af3f-41aca02691fe@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9102 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812100042
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Dec 08, 2018 at 10:49:44PM +0800, Bob Liu wrote:
> On 11/28/18 3:45 PM, Christoph Hellwig wrote:
> > On Wed, Nov 28, 2018 at 04:33:03PM +1100, Dave Chinner wrote:
> >> 	- how does propagation through stacked layers work?
> > 
> > The only way it works is by each layering driving it.  Thus my
> > recommendation above bilding on your earlier one to use an index
> > that is filled by the driver at I/O completion time.
> > 
> > E.g.
> > 
> > 	bio_init:		bi_leg = -1
> > 
> > 	raid1:			submit bio to lower driver
> > 	raid 1 completion:	set bi_leg to 0 or 1
> > 
> > Now if we want to allow stacking we need to save/restore bi_leg
> > before submitting to the underlying device.  Which is possible,
> > but quite a bit of work in the drivers.
> > 
> 
> I found it's still very challenge while writing the code.
> save/restore bi_leg may not enough because the drivers don't know how to do fs-metadata verify.
> 
> E.g two layer raid1 stacking
> 
> fs:                  md0(copies:2)
>                      /          \
> layer1/raid1   md1(copies:2)    md2(copies:2)
>                   /    \          /     \
> layer2/raid1   dev0   dev1      dev2    dev3
> 
> Assume dev2 is corrupted
>  => md2: don't know how to do fs-metadata verify. 
>    => md0: fs verify fail, retry md1(preserve md2).
> Then md2 will never be retried even dev3 may also has the right copy.
> Unless the upper layer device(md0) can know the amount of copy is 4 instead of 2? 
> And need a way to handle the mapping.
> Did I miss something? Thanks!

<shrug> It seems reasonable to me that the raid1 layer should set the
number of retries to (number of raid1 mirrors) * min(retry count of all
mirrors) so that the upper layer device (md0) would advertise 4 retry
possibilities instead of 2.

--D


> -Bob
> 
> >> 	- is it generic/abstract enough to be able to work with
> >> 	  RAID5/6 to trigger verification/recovery from the parity
> >> 	  information in the stripe?
> > 
> > If we get the non -1 bi_leg for paritity raid this is an inidicator
> > that parity rebuild needs to happen.  For multi-parity setups we could
> > also use different levels there.
> > 
> 
