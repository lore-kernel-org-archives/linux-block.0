Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA82FC433EF
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 10:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95AA2610C7
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 10:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhJ2LBy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Oct 2021 07:01:54 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:37104 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231740AbhJ2LBw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Oct 2021 07:01:52 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 0F9E145F78;
        Fri, 29 Oct 2021 10:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received; s=mta-01; t=1635505160;
         x=1637319561; bh=XbtFXgX+3A2Va7HCGLvO7J2EZp3D+M6ExN4dpSw4Km8=; b=
        hB8CmHAT8SOCo0VegCBnQlxl4Ar5fYsgjlHnLUpM/M8K9TEE6UBs1y+u/Ffekghd
        XFGZPZetScAQYKO/eV5CC9EV7UCzr5Q7rCYUtDwWdhnuHrLXt5pIgbiqv5LEmwiw
        4NjW7nTmu02u+b2Mul8cbhLkgp/ZlUrpVVSOoA91hmI=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6lQJ9e9zXfkG; Fri, 29 Oct 2021 13:59:20 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id B2A9F4618B;
        Fri, 29 Oct 2021 13:59:19 +0300 (MSK)
Received: from yadro.com (10.178.116.186) by T-EXCH-04.corp.yadro.com
 (172.17.100.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 29
 Oct 2021 13:59:18 +0300
Date:   Fri, 29 Oct 2021 13:59:16 +0300
From:   "Alexander V. Buev" <a.buev@yadro.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Mikhail Malygin <m.malygin@yadro.com>, <linux@yadro.com>
Subject: Re: [PATCH 1/3] block: bio-integrity: add PI iovec to bio
Message-ID: <20211029105916.6eedcdpd2jho2c5q@yadro.com>
Mail-Followup-To: "Alexander V. Buev" <a.buev@yadro.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Mikhail Malygin <m.malygin@yadro.com>, linux@yadro.com
References: <20211028112406.101314-1-a.buev@yadro.com>
 <20211028112406.101314-2-a.buev@yadro.com>
 <yq1cznov6q7.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <yq1cznov6q7.fsf@ca-mkp.ca.oracle.com>
X-Originating-IP: [10.178.116.186]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-04.corp.yadro.com (172.17.100.104)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> 
> Alexander,
> 
> Thanks for working on this!
> 
> > +		if (bip->bip_flags & BIP_RELEASE_PAGES) {
> > +			bio_integrity_payload_release_pages(bip);
> > +		}
> 
> In my parallel attempt the flag was called BIP_USER_MAPPED to mirror
> BIO_USER_MAPPED. But with the latter now gone it doesn't really
> matter. BIP_RELEASE_PAGES is fine.
ok 

> I find bio_integrity_payload_release_pages() a bit long. All the other
> functions just use a bio_integrity_ prefix and take a bio. But no
> biggie.
> 
> > +int bio_integrity_add_pi_iovec(struct bio *bio, struct iovec *pi_iov)
> 
> bio_integrity_add_iovec(), please. _pi is redundant.

I definitely agree with this (As with other similar notes)
It's just my habit of naming functions by struct name.

> 
> > +	bip_set_seed(bip, bio->bi_iter.bi_sector);
> > +
> > +	if (bi->flags & BLK_INTEGRITY_IP_CHECKSUM)
> > +		bip->bip_flags |= BIP_IP_CHECKSUM;
> 
> The last couple of months I have been working on a version of our DIX/PI
> qualification tooling that does not depend on the DB I/O stack.
> 
> For the test tooling to work I need to be able to pass the seed and the
> BIP_* flags as part of the command. The tooling needs to be able to
> select the type of checksum and to be able to disable checking for
> initiator and target on a per-I/O basis. So these would need to be
> passed in.
> 
> Note that extended PI formats have been defined in NVMe. These allow for
> larger CRCs and reference tags to be specified in addition to a storage
> tag. So we'll need to be careful when defining the SQE fields here.
 
After discussion, I plan to start by adding a pointer to the PI data 
in SQE struct.
This struct now has some padding that can be used for this.
Size of PI data can be determined according to integrity profile of
device and size of normal data.

Also, as recommended, the new version will use opcodes instead of the flag.

Thanks everyone for the detailed feedback. It's important for me.
I will try to correct all the issue's in the next version.

But some later )


-- 
Alexander Buev
