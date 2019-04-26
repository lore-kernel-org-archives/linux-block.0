Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562E4C43218
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 23:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDDE206DD
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 23:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfDZXNj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 19:13:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbfDZXNj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 19:13:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0EF2A3082E72;
        Fri, 26 Apr 2019 23:13:39 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 77C341001DD9;
        Fri, 26 Apr 2019 23:13:33 +0000 (UTC)
Date:   Sat, 27 Apr 2019 07:13:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block/028: check if T10 verification fails
Message-ID: <20190426231326.GA308@ming.t460p>
References: <20190426023937.19584-1-ming.lei@redhat.com>
 <20190426145711.GA12338@infradead.org>
 <SN6PR04MB452733A7DC62133964DEA4E9863E0@SN6PR04MB4527.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB452733A7DC62133964DEA4E9863E0@SN6PR04MB4527.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 26 Apr 2019 23:13:39 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 26, 2019 at 06:24:08PM +0000, Chaitanya Kulkarni wrote:
> Until we fix this, I'm okay to have this change in the blktest, if this 
> is breaking any exiting behavior.

This is a patch for enhancing/fixing block/028 test case, so that we
can't hide the kernel issue. Now when the issue is triggered, block/028
still shows 'passed'.

It is nothing do with fix in kernel side.

Even though it is fixed upstream, there may be other old kernel releases
which needs to expose the issue.

Even it is fixed completely, sometimes regression may come up again.


Thanks,
Ming
