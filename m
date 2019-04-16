Return-Path: <SRS0=7JUc=SS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670A6C10F0E
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 00:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD582084B
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 00:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfDPAGu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 20:06:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbfDPAGu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 20:06:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F05D159451;
        Tue, 16 Apr 2019 00:06:49 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C761E6012C;
        Tue, 16 Apr 2019 00:06:38 +0000 (UTC)
Date:   Tue, 16 Apr 2019 08:06:33 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     sandeen@redhat.com
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] nvme/012 & 013: avoid extremely slow xfs IO
Message-ID: <20190416000632.GA670@ming.t460p>
References: <20190415012229.20689-1-ming.lei@redhat.com>
 <SN6PR04MB4527DD7C84A15184AE5F7947862B0@SN6PR04MB4527.namprd04.prod.outlook.com>
 <57a5b163-5d7a-d5a0-fe9a-614b1d638472@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57a5b163-5d7a-d5a0-fe9a-614b1d638472@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 16 Apr 2019 00:06:50 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 15, 2019 at 09:46:02AM -0400, Eric Sandeen wrote:
> On 4/14/19 9:01 PM, Chaitanya Kulkarni wrote:
> > Thanks for the patch Ming. Couple of comments below.
> > On 4/14/19 6:22 PM, Ming Lei wrote:
> >> It is observed that nvme/012 may take ~17 minutes to complete on aarch64,
> >> even worse it may trigger IO timeout on nvme-loop.
> >>
> >> Eric and Dave replied that it is because of too small log size on small
> >> disk.
> >>
> >> So pass '-l size=32m' to avoid the issue.
> >>
> >> With this patch, nvme/012 can be completed in one minute.
> >>
> > Then we should set the QUICK=1 if its taking shorter time.
> > 
> >> Cc: Eric Sandeen <esandeen@redhat.com>
> >> Cc: Dave Chinner <dchinner@redhat.com>
> >> Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> >> Cc: linux-xfs@vger.kernel.org
> >> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >> ---
> >>   tests/nvme/012 | 2 +-
> >>   tests/nvme/013 | 2 +-
> >>   2 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tests/nvme/012 b/tests/nvme/012
> >> index 9a6801511df7..d7a8751ec752 100755
> >> --- a/tests/nvme/012
> >> +++ b/tests/nvme/012
> >> @@ -46,7 +46,7 @@ test() {
> >>   
> >>   	umount ${mount_dir} > /dev/null 2>&1
> >>   
> >> -	mkfs.xfs -f /dev/"${nvmedev}n1" > /dev/null 2>&1
> >> +	mkfs.xfs -l size=32m -f /dev/"${nvmedev}n1" > /dev/null 2>&1
> >>   
> > As a part of this series lets move this to the helper mkfs in the 
> > nvme/rc and use that call in all the file-backed ns related testcases.
> > Let me know if you want me to do that or you would like to do that as a 
> > part of this series. I'm okay with anything.
> 
> We also discussed making the log size larger by default, on small fielsystems,
> but that won't help you yet.
> 
> My only caution is that manually setting the log to 32m may actually create
> a smaller than default log if your backing file happens to be very large.
> Just something to consider.  If the backing files are typically around the
> 4G size of this test (?) then 32m seems reasonable, 128m certainly would
> not hurt.

In the two tests, the device size is 1G, and looks 32m log size works
just fine. 

thanks,
Ming
