Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E4EC10F13
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 23:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F4D20850
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 23:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfDKXOy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 19:14:54 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:59864 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726646AbfDKXOy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 19:14:54 -0400
Received: from dread.disaster.area (pa49-195-160-97.pa.nsw.optusnet.com.au [49.195.160.97])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 9F97C105E6F9;
        Fri, 12 Apr 2019 09:14:44 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hEiu3-0008Sw-S5; Fri, 12 Apr 2019 09:14:43 +1000
Date:   Fri, 12 Apr 2019 09:14:43 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     jglisse@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Ernesto A =?iso-8859-1?Q?=2E_Fern=E1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>, Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v1 12/15] fs/direct-io: keep track of wether a page is
 coming from GUP or not
Message-ID: <20190411231443.GD1695@dread.disaster.area>
References: <20190411210834.4105-1-jglisse@redhat.com>
 <20190411210834.4105-13-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190411210834.4105-13-jglisse@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=UJetJGXy c=1 sm=1 tr=0 cx=a_idp_d
        a=EHa8gIBQe3daEtuMEU8ptg==:117 a=EHa8gIBQe3daEtuMEU8ptg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=8nJEP1OIZ-IA:10 a=oexKYjalfGEA:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=eWkzej_naR1Ak5NVtaAA:9
        a=wPNLvfGTeEIA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 11, 2019 at 05:08:31PM -0400, jglisse@redhat.com wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> We want to keep track of how we got a reference on page when doing DIO,
> ie wether the page was reference through GUP (get_user_page*) or not.
> For that this patch rework the way page reference is taken and handed
> over between DIO code and BIO. Instead of taking a reference for page
> that have been successfuly added to a BIO we just steal the reference
> we have when we lookup the page (either through GUP or for ZERO_PAGE).
> 
> So this patch keep track of wether the reference has been stolen by the
> BIO or not. This avoids a bunch of get_page()/put_page() so this limit
> the number of atomic operations.

Is the asme set of changes appropriate for the fs/iomap.c direct IO
path (i.e. XFS)?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
