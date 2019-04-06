Return-Path: <SRS0=s1xr=SI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2979C10F06
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 15:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4C12146F
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 15:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfDFP1M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Apr 2019 11:27:12 -0400
Received: from bout01.mta.xmission.com ([166.70.11.15]:51553 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfDFP1L (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Apr 2019 11:27:11 -0400
Received: from mx02.mta.xmission.com ([166.70.13.212])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hCnDq-0006pm-D5; Sat, 06 Apr 2019 09:27:10 -0600
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hCnDp-0004i9-NG; Sat, 06 Apr 2019 09:27:10 -0600
Received: from hacktheplanet (c-68-50-23-202.hsd1.in.comcast.net [68.50.23.202])
        by plesk14.xmission.com (Postfix) with ESMTPSA id DAACF203056;
        Sat,  6 Apr 2019 15:27:08 +0000 (UTC)
Date:   Sat, 6 Apr 2019 11:26:57 -0400
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     David Kozub <zub@linux.fjfi.cvut.cz>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Message-ID: <20190406152657.GA10728@hacktheplanet>
References: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1hCnDp-0004i9-NG;;;mid=<20190406152657.GA10728@hacktheplanet>;;;hst=mx02.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
Subject: Re: [PATCH 00/16] sed-opal: fix shadow MBR enable/disable and clean
 up code
X-SA-Exim-Version: 4.2.1 (built Fri, 13 May 2016 17:07:30 -0600)
X-SA-Exim-Scanned: Yes (on mx02.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org




On Thu, Feb 14, 2019 at 01:15:52AM +0100, David Kozub wrote:
> David Kozub (12):
>   block: sed-opal: fix IOC_OPAL_ENABLE_DISABLE_MBR
>   block: sed-opal: fix typos and formatting
>   block: sed-opal: close parameter list in cmd_finalize
>   block: sed-opal: unify cmd start
>   block: sed-opal: unify error handling of responses
>   block: sed-opal: reuse response_get_token to decrease code duplication
>   block: sed-opal: add token for OPAL_LIFECYCLE
>   block: sed-opal: unify retrieval of table columns
>   block: sed-opal: use named Opal tokens instead of integer literals
>   block: sed-opal: pass steps via argument rather than via opal_dev
>   block: sed-opal: don't repeat opal_discovery0 in each steps array
>   block: sed-opal: rename next to execute_steps
> 
> Jonas Rabenstein (4):
>   block: sed-opal: use correct macro for method length
>   block: sed-opal: unify space check in add_token_*
>   block: sed-opal: print failed function address
>   block: sed-opal: split generation of bytestring header and content
> 
>  block/opal_proto.h            |   2 +
>  block/sed-opal.c              | 716 ++++++++++++++--------------------
>  include/uapi/linux/sed-opal.h |   2 +-
>  3 files changed, 287 insertions(+), 433 deletions(-)

Jens,

We have all the reviews done for this series from Jon, Christoph, and myself.
When you get time will you please queue this up for 5.2?

Thank you.
