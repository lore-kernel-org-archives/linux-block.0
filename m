Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1E0C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 22:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898AB20868
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 22:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfAQWK3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:10:29 -0500
Received: from bout01.mta.xmission.com ([166.70.11.15]:40063 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbfAQWK2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 17:10:28 -0500
X-Greylist: delayed 3381 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Jan 2019 17:10:28 EST
Received: from mx04.mta.xmission.com ([166.70.13.214])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1gkEz5-0005TA-Uk; Thu, 17 Jan 2019 14:13:56 -0700
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx04.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1gkEz5-0001Wh-DM; Thu, 17 Jan 2019 14:13:55 -0700
Received: from hacktheplanet (unknown [66.244.75.217])
        by plesk14.xmission.com (Postfix) with ESMTPSA id AEC64210DB9;
        Thu, 17 Jan 2019 21:13:54 +0000 (UTC)
Date:   Thu, 17 Jan 2019 16:13:52 -0500
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     linux-kernel@vger.kernel.org, hch@infradead.org,
        jonathan.derrick@intel.com, linux-block@vger.kernel.org
Message-ID: <20190117211306.GA29671@hacktheplanet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1gkEz5-0001Wh-DM;;;mid=<20190117211306.GA29671@hacktheplanet>;;;hst=mx04.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
Subject: Re: [PATCH 00/16] block: sed-opal: support shadow MBR done flag and
 write
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on mx04.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 16, 2019 at 09:56:51PM +0000, David Kozub wrote:
>   block: sed-opal: rename next to execute_steps

I don't see this change anywhere on the lists. I have 0->15, but am missing 16/16.

Please resend v2 with the changes Christoph requested, so it's easier to review.

Lastly, please CC me on the changes, and I will review them:
sbauer@plzdonthack.me

I don't work at Intel anymore -- maintainers never got updated.


> Jonas Rabenstein (8):
>   block: sed-opal: use correct macro for method length
>   block: sed-opal: unify space check in add_token_*
>   block: sed-opal: print failed function address
>   block: sed-opal: split generation of bytestring header and content
>   block: sed-opal: add ioctl for done-mark of shadow mbr
>   block: sed-opal: ioctl for writing to shadow mbr
>   block: sed-opal: unify retrieval of table columns
>   block: sed-opal: check size of shadow mbr
> 
>  block/opal_proto.h            |  18 +
>  block/sed-opal.c              | 843 +++++++++++++++++-----------------
>  include/linux/sed-opal.h      |   2 +
>  include/uapi/linux/sed-opal.h |   9 +
>  4 files changed, 449 insertions(+), 423 deletions(-)
> 
> -- 
> 2.20.1
