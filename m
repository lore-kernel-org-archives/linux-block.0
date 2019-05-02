Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2D1C43219
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 12:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63098205C9
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 12:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfEBMbO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 May 2019 08:31:14 -0400
Received: from bout01.mta.xmission.com ([166.70.11.15]:35508 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBMbO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 May 2019 08:31:14 -0400
Received: from mx03.mta.xmission.com ([166.70.13.213])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hMArn-0001ta-0c; Thu, 02 May 2019 06:31:11 -0600
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hMArm-0004cQ-EK; Thu, 02 May 2019 06:31:10 -0600
Received: from hacktheplanet (c-68-50-23-202.hsd1.in.comcast.net [68.50.23.202])
        by plesk14.xmission.com (Postfix) with ESMTPSA id 6F8631C4856;
        Thu,  2 May 2019 12:31:09 +0000 (UTC)
Date:   Thu, 2 May 2019 08:30:58 -0400
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Message-ID: <20190502123036.GA4657@hacktheplanet>
References: <1556666459-17948-1-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556666459-17948-1-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1hMArm-0004cQ-EK;;;mid=<20190502123036.GA4657@hacktheplanet>;;;hst=mx03.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
Subject: Re: [PATCH 0/3] block: sed-opal: add support for shadow MBR done
 flag and write
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on mx03.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 01, 2019 at 01:20:56AM +0200, David Kozub wrote:
> 
> Jonas Rabenstein (3):
>   block: sed-opal: add ioctl for done-mark of shadow mbr
>   block: sed-opal: ioctl for writing to shadow mbr
>   block: sed-opal: check size of shadow mbr
> 
>  block/opal_proto.h            |  16 ++++
>  block/sed-opal.c              | 160 +++++++++++++++++++++++++++++++++-
>  include/linux/sed-opal.h      |   2 +
>  include/uapi/linux/sed-opal.h |  20 +++++
>  4 files changed, 196 insertions(+), 2 deletions(-)
> 

I'll review this over the weekend. Is this essentially the same thing
we reviewed a month or two ago or are there little differences due to
it be split across two different series?


> -- 
> 2.20.1
> 
