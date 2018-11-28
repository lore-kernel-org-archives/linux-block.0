Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4CFC43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 05:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFF22086B
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 05:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uNP8Ao1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EFF22086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbeK1QuA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 11:50:00 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52194 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeK1QuA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 11:50:00 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAS5n2o6076924;
        Wed, 28 Nov 2018 05:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=stkumeVBw+HasnLqc6B3nzZJcbXp8cfzAYpIuTba5uQ=;
 b=uNP8Ao1FYiBzkxf/pNg0GKKGcizCjf70zR1tfGdoGRhZgnv2MxBhrv+yy+SAZ34UOj/H
 W03dzWFGAqHWk1Zx3qS6NfJP6NKTZkyCJxCmxa21cE9fouQvT1cE0g/sbEYAQkB7tEEj
 pyV8sXJp2aH190ihVqG80iVllknr8rfTG+lE2yDIKuIAR5i3lofOeXn3WsMC8mHQMWQo
 hGGq+ooxf4wKLtiuPuJK5kqMI6bmJUcl3y1GihqIjzuMqEDQ4bXETVFnBt4Hl7+zsHkb
 Jk8DuZ8UCp0kqFxzJggRnyF/nvTMaBAdalimZ3Aj6DizBJNhmElHNZcAbHfkxDK89isn yw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2nxxkqg271-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 05:49:32 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAS5nPIh032750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 05:49:26 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAS5nPxm017410;
        Wed, 28 Nov 2018 05:49:25 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Nov 2018 21:49:25 -0800
Date:   Tue, 27 Nov 2018 21:49:23 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Allison Henderson <allison.henderson@oracle.com>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        bob.liu@oracle.com
Subject: Re: [RFC PATCH v1 0/7] Block/XFS: Support alternative mirror device
 retry
Message-ID: <20181128054923.GF8125@magnolia>
References: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
 <20181128053303.GL6311@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128053303.GL6311@dastard>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9090 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811280053
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 28, 2018 at 04:33:03PM +1100, Dave Chinner wrote:
> On Tue, Nov 27, 2018 at 08:49:44PM -0700, Allison Henderson wrote:
> > Motivation:
> > When fs data/metadata checksum mismatch, lower block devices may have other
> > correct copies. e.g. If XFS successfully reads a metadata buffer off a raid1 but
> > decides that the metadata is garbage, today it will shut down the entire
> > filesystem without trying any of the other mirrors.  This is a severe
> > loss of service, and we propose these patches to have XFS try harder to
> > avoid failure.
> > 
> > This patch prototype this mirror retry idea by:
> > * Adding @nr_mirrors to struct request_queue which is similar as
> >   blk_queue_nonrot(), filesystem can grab device request queue and check max
> >   mirrors this block device has.
> >   Helper functions were also added to get/set the nr_mirrors.
> > 
> > * Expanding bi_write_hint to bi_rw_hint, now @bi_rw_hint has three meanings.
> >  1.Original write_hint.
> >  2.end_io() will update @bi_rw_hint to reflect which mirror this i/o really happened.
> >  3.Fs set @bi_rw_hint to force driver e.g raid1 read from a specific mirror.
> > 
> > * Modify md/raid1 to support this retry feature.
> > 
> > * Add b_rw_hint to xfs_buf
> >   This patch adds a new field b_rw_hint to xfs_buf.  We will use this to set the
> >   new bio->bi_rw_hint when submitting the read request, and also to store the
> >   returned mirror when the read compleates
> 
> One thing that is going to make this more complex at the XFS layer
> is discontiguous buffers. They require multiple IOs (and therefore
> bios) and so we are going to need to ensure that all the bios use
> the same bi_rw_hint.

Hmm, we hadn't thought about that.  What happens if we have a
discontiguous buffer mapped to multiple blocks, and there's only one
good copy of each block on separate disks in the whole array?

e.g. we have 8k directory blocks on a 4k block filesystem, only disk 0
has a good copy of block 0 and only disk 1 has a good copy of block 1?

I think we're just stuck with failing the whole thing because we can't
check the halves of the 8k block independently and there's too much of a
combinatoric explosion potential to try to mix and match.

> This is another reason I suggest that bi_rw_hint has a magic value
> for "block layer selects mirror" and separate the initial read from

(As mentioned in a previous reply of mine, setting rw_hint == 0 is the
magic value for "device picks mirror"...)

> the retry iterations. That allows us to let he block layer ot pick
> whatever leg it wants for the initial read, but if we get a failure
> we directly control the mirror we retry from and all bios in the
> buffer go to that same mirror.
> 
> > We're not planning to take over all 16 bits of the read hint field; just looking for
> > feedback about the sanity of the overall approach.
> 
> It seems conceptually simple enough - the biggest questions I have
> are:
> 
> 	- how does propagation through stacked layers work?

Right now it doesn't, though once we work out how to make stacking work
through device mapper (my guess is that simple dm targets like linear
and crypt can set the mirror count to min(all underlying devices).

> 	- is it generic/abstract enough to be able to work with
> 	  RAID5/6 to trigger verification/recovery from the parity
> 	  information in the stripe?

In theory we could supply a raid5 implementation, wherein rw_hint == 0
lets the raid do as it pleases; rw_hint == 1 reads from the stripe; and
rw_hint == 2 forces stripe recovery for the given block.

A trickier scenario that I have no idea how to solve is the question of
how to handle dynamic redundancy levels.  We don't have a standard bio
error value that means "this mirror is temporarily offline", so if you
have a raid1 of two disks and disk 0 goes offline, the retry loop in xfs
will hit the EIO and abort without even asking disk 1.  It's also
unclear if we need to designate a second bio error value to mean "this
mirror is permanently gone".

[Also insert handwaving about whether or not online fsck will want to
control retries and automatic rewrite; I suspect the answer is that it
doesn't care.]

[[Also insert severe handwaving about do we expose this to userspace so
that xfs_repair can use it?]]

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
