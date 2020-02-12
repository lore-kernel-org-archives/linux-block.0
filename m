Return-Path: <SRS0=TQg9=4A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FD8C352A4
	for <linux-block@archiver.kernel.org>; Wed, 12 Feb 2020 20:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB1F2467D
	for <linux-block@archiver.kernel.org>; Wed, 12 Feb 2020 20:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n5tiEZ3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgBLUpr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:45:47 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35882 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgBLUpr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Feb 2020 15:45:47 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CKhHe8063973;
        Wed, 12 Feb 2020 20:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=gj5Qo0BoGT5aSf4xLcM9U08tEIZkUwttfv2IH/cD2Y0=;
 b=n5tiEZ3qidyjlQ8l5JGqT0/tp4WtWjsA0a8Ga69U3AqRVDffzVZNy6/tFm4oiTE/JPte
 oELwFA+ORJny2ydVF0UH4DwYUt3JT5Z4EjbSnSfeBSy8qpHjqhKiG9/lTvT0KtvptSzp
 v2tuFTvvZR9LGX27OyBy1E2lCabo88yt/6wHWjCiuBmw7zbPgDfmeLtC3l8nMZHle1xg
 M5nAOnCjGJzLk/rJBwFwJNvYTewY6vA+7uXUAYho5frbwrVFPwuUm/lNohwghWaWEx5p
 dS2GUt+8xAyhlwEVDk90y4dcPqoKQabpxP+Ug1xEXv+++nq8gJEE2FAAVrljPOrSNtgI bg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2y2p3snbhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Feb 2020 20:45:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01CKhIoX032957;
        Wed, 12 Feb 2020 20:45:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2y4k9gd1rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Feb 2020 20:45:10 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01CKj2Z4000618;
        Wed, 12 Feb 2020 20:45:02 GMT
Received: from localhost (/10.159.151.237)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Feb 2020 12:45:02 -0800
Date:   Wed, 12 Feb 2020 12:44:59 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     martin.petersen@oracle.com, bob.liu@oracle.com, axboe@kernel.dk,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        song@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        Chaitanya.Kulkarni@wdc.com, ming.lei@redhat.com, osandov@fb.com,
        jthumshirn@suse.de, minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/6] loop: Add support for REQ_ALLOCATE
Message-ID: <20200212204459.GP6874@magnolia>
References: <158132703141.239613.3550455492676290009.stgit@localhost.localdomain>
 <158132724397.239613.16927024926439560344.stgit@localhost.localdomain>
 <20200212170156.GM6874@magnolia>
 <f108e700-62fb-6ecd-2bba-0ab7a6b9ef7b@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f108e700-62fb-6ecd-2bba-0ab7a6b9ef7b@virtuozzo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120142
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 12, 2020 at 11:00:15PM +0300, Kirill Tkhai wrote:
> On 12.02.2020 20:01, Darrick J. Wong wrote:
> > On Mon, Feb 10, 2020 at 12:34:04PM +0300, Kirill Tkhai wrote:
> >> Support for new modifier of REQ_OP_WRITE_ZEROES command.
> >> This results in allocation extents in backing file instead
> >> of actual blocks zeroing.
> >>
> >> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> >> Reviewed-by: Bob Liu <bob.liu@oracle.com>
> >> ---
> >>  drivers/block/loop.c |   15 ++++++++++++---
> >>  1 file changed, 12 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> >> index 739b372a5112..bfe76d9adf09 100644
> >> --- a/drivers/block/loop.c
> >> +++ b/drivers/block/loop.c
> >> @@ -581,6 +581,15 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
> >>  	return 0;
> >>  }
> >>  
> >> +static unsigned int write_zeroes_to_fallocate_mode(unsigned int flags)
> >> +{
> >> +	if (flags & REQ_ALLOCATE)
> >> +		return 0;
> >> +	if (flags & REQ_NOUNMAP)
> >> +		return FALLOC_FL_ZERO_RANGE;
> >> +	return FALLOC_FL_PUNCH_HOLE;
> >> +}
> >> +
> >>  static int do_req_filebacked(struct loop_device *lo, struct request *rq)
> >>  {
> >>  	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
> >> @@ -604,9 +613,7 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
> >>  		 * write zeroes the range.  Otherwise, punch them out.
> >>  		 */
> > 
> > Please update this comment to reflect the new REQ_ALLOCATE mode, and
> > move it to where you define write_zeroes_to_fallocate_mode().
> > 
> > With that fixed,
> > 
> > Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Just to clarify. Is this "Reviewed-by:" tag for this patch or for the whole series?

Only that patch.

--D

> Kirill
