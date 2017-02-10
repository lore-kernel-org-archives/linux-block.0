Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:62494 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751828AbdBJBOE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Feb 2017 20:14:04 -0500
Subject: Re: [PATCH 1/1] dm-zoned: Zoned block device target
To: Mike Snitzer <snitzer@redhat.com>
References: <20170209041849.30964-1-damien.lemoal@wdc.com>
 <20170209152745.GA10638@redhat.com>
Cc: dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@sandisk.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <0342cba2-6745-fddd-e318-db0adf6f1ca4@wdc.com>
Date: Fri, 10 Feb 2017 10:09:47 +0900
MIME-Version: 1.0
In-Reply-To: <20170209152745.GA10638@redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Mike,

On 2/10/17 00:27, Mike Snitzer wrote:
> Looks like this work has come a long way.  While I am _still_ not
> hearing from any customers (or partners) that SMR is a priority I do
> acknowledge that that obviously isn't the case for WDC and others.
> 
> So, I'll sign up for reviewing this DM target, with a focus on DM
> interface and implementation details, _after_ I get some technical
> review (e.g. Reviewed-by) from people like Hannes and others more
> invested in the SMR technologies.  Basically I don't know enough about
> the constraints of these devices to fully appreciate and catch some
> issue in the particulars of the algorithms used to mitigate SMR's
> quirks.

Fair enough. I understand.

I would also like to let you know that I worked closely with Hannes and
Martin and also Shaun Tauncheff (Seagate) to put together the final
patches of the ZBC support for 4.10. I also contributed to part of the
f2fs support for these devices, which also was included in 4.10.
(And I also maintain the libzbc project in github)

> I'd also like to understand how invested WDC is in maintaining this DM
> target for years and years if/when I were to merge this DM target into
> mainline.

We are fully invested. I am part of the system software group in WD
Research and one of our mission is to support Linux kernel and open
source software in general. Bart (Van Assche), who I believe you know,
is also a member of our group now that Sandisk and WD merger completed.

Hannes and Christoph already sent some comments regarding the code. I
will make appropriate changes and re-post the patch for review.

Thank you.

Best regards.

-- 
Damien Le Moal, Ph.D.
Sr. Manager, System Software Research Group,
Western Digital Corporation
Damien.LeMoal@wdc.com
(+81) 0466-98-3593 (ext. 513593)
1 kirihara-cho, Fujisawa,
Kanagawa, 252-0888 Japan
www.wdc.com, www.hgst.com
