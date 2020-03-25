Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D627C1975A
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 16:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E73206F8
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 16:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MLMa49Ky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgCYQ1e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 12:27:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38632 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbgCYQ1e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 12:27:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PGIHAl040559;
        Wed, 25 Mar 2020 16:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=T54XmWMJ9nW/BeP4QaO9ECLZh+YI7p5D93ZEFmVIpVU=;
 b=MLMa49KygIn1Ro2v03egKUdzqa8ZtH6pPcni2s4sW4r1FRwNBXlqzdvlF0p+qB0WKc1z
 xuPM9F4vJra/hLQMrvQE5NQCNwdHxTvckSjWhlEyEysN3l93CDMQsSEn5dUi8NR2LJL3
 qf+lP5fDY1LWXSQjFTV9heXdrOk/80Ij01Dy5kd+yOU7hN2VXjc5W3y0f2tANjOdIQ3+
 uTLEApAuHLLHlsc1EVxczrx8/F4m9Mrh/grixnIz/hgvoyLLgFcuFL4cLAYQ9yVIXYhL
 kbjx0sppTBSs6fDIsJY5YboPJWTix6aK+kYeyEdMGR/np+53eSuZX66t7DxIT+03+m7b KA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 3005kv9sw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 16:27:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PGLqh9185365;
        Wed, 25 Mar 2020 16:27:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 3006r6v7a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 16:27:04 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02PGQxmx024402;
        Wed, 25 Mar 2020 16:27:00 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Mar 2020 09:26:59 -0700
Date:   Wed, 25 Mar 2020 09:26:56 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, axboe@kernel.dk,
        bob.liu@oracle.com, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, song@kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, Chaitanya.Kulkarni@wdc.com,
        ming.lei@redhat.com, osandov@fb.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/6] block: Introduce REQ_ALLOCATE flag for
 REQ_OP_WRITE_ZEROES
Message-ID: <20200325162656.GJ29351@magnolia>
References: <158157930219.111879.12072477040351921368.stgit@localhost.localdomain>
 <e2b7cbab-d91f-fd7b-de6f-a671caa6f5eb@virtuozzo.com>
 <69c0b8a4-656f-98c4-eb55-2fd1184f5fc9@virtuozzo.com>
 <67d63190-c16f-cd26-6b67-641c8943dc3d@virtuozzo.com>
 <20200319102819.GA26418@infradead.org>
 <yq1tv2k8pjn.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1tv2k8pjn.fsf@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003250131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003250130
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 19, 2020 at 09:03:40AM -0400, Martin K. Petersen wrote:
> 
> Christoph,
> 
> >> Some comments? Some requests for reworking? Some personal reasons to
> >> ignore my patches?
> >
> > I'm still completely opposed to the magic overloading using a flag.
> > That is just a bad design waiting for trouble to happen.
> 
> The observation was that Kirill's original patch set was a line-for-line
> carbon copy of the write zeroes handling throughout the stack. The only
> difference between the two was at the bottom. Instead of duplicating all
> that code it seemed cleaner to use shared plumbing since these
> operations need to be split and merged exactly the same way in the block
> layer.
> 
> Also, we already have REQ_NOUNMAP, not sure why an additional handling
> flag would lead to trouble? Note that I suggested renaming
> REQ_OP_WRITE_ZEROES to something else to separate the semantics from the
> plumbing.
> 
> We need to be able to express:
> 
>  - zero & allocate block range (REQ_OP_WRITE_ZEROES, REQ_NOUNMAP)
>  - zero & deallocate block range (REQ_OP_WRITE_ZEROES, !REQ_NOUNMAP)
>  - allocate block range (?, don't care about zeroing)
>  - deallocate block range (REQ_OP_DISCARD, don't care about zeroing)
> 
> It just seems like a full-fledged REQ_OP_ALLOCATE is an overkill to fill
> that gap.
> 
> That said, I do think that we have traditionally put emphasis on the
> wrong part of these operations. All we ever talk about wrt. discard and
> friends is the zeroing aspect. But I actually think that, semantically,
> the act of allocating and deallocating blocks is more important. And
> that zeroing is an optional second order effect of those operations. So
> if we could go back in time and nuke multi-range DSM TRIM/UNMAP, I would
> like to have REQ_OP_ALLOCATE/REQ_OP_DEALLOCATE with an optional REQ_ZERO
> flag. I think that would be cleaner. I have a much easier time wrapping
> my head around "allocate this block and zero it if you can" than "zero
> this block and do not deallocate it". But maybe that's just me.

I'd love to transition to that.  My brain is not good at following all
the inverse logic that NOUNMAP spread everywhere.  I have a difficult
time following what the blockdev fallocate code does, which is sad since
hch and I are the primary stuckees^Wmeddlers^Wauthors of that function. :/

--D

> -- 
> Martin K. Petersen	Oracle Linux Engineering
