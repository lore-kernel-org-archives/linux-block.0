Return-Path: <SRS0=SzsG=WD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E065C433FF
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 07:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F042199C
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 07:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfHGHOR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Aug 2019 03:14:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:53526 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727179AbfHGHOR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Aug 2019 03:14:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83269AF56;
        Wed,  7 Aug 2019 07:14:16 +0000 (UTC)
Date:   Wed, 7 Aug 2019 09:14:15 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH blktests] Make the NVMe tests more reliable
Message-ID: <20190807071415.GA28023@x250.microfocus.com>
References: <20190805232512.50992-1-bvanassche@acm.org>
 <9f8a82f6-5a7b-89ff-4a3a-fa4e9853fc35@suse.de>
 <fe2fbdc2-8585-74fd-a222-b946fdab8909@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe2fbdc2-8585-74fd-a222-b946fdab8909@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 06, 2019 at 08:11:02AM -0700, Bart Van Assche wrote:
> On 8/6/19 1:11 AM, Johannes Thumshirn wrote:
> > On 06/08/2019 01:25, Bart Van Assche wrote:
> > [...]
> > 
> > > +			for ((i=0;i<10;i++)); do
> > > +				[ -e /sys/block/$dev/uuid ] &&
> > > +					[ -e /sys/block/$dev/wwid ] &&
> > > +					return 0
> > > +				sleep .1
> > > +			done
> > > +			return 1
> > >   		fi
> > >   	done
> > > +	return 1
> > 
> > Hmmm, I don't really understand why you're adding the return {0,1} here.
> > None of the callers of _find_nvme_loop_dev() does anything with the
> > return value of the function.
> > 
> > They expect either a nvme-device or an empty string and fail if the
> > string is empty due to a non-empty diff in the golden output.
> 
> Hi Johannes,
> 
> The "return 0" statement has been added to break out of the two for-loops.
> The first "return 1" statement has been added to make sure that the echo
> "$dev" statement is executed at most once. The final "return 1" statement
> has been added to make the return value consistent.
> 
> Do you perhaps want me to leave out {0,1} from the return statements?

Yes, I think this is less confusing for readers.

With that,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
