Return-Path: <SRS0=GSyA=X4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60ED3C10F14
	for <linux-block@archiver.kernel.org>; Thu,  3 Oct 2019 16:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0CA215EA
	for <linux-block@archiver.kernel.org>; Thu,  3 Oct 2019 16:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbfJCQCd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:02:33 -0400
Received: from bout01.mta.xmission.com ([166.70.11.15]:49701 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732006AbfJCQCc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Oct 2019 12:02:32 -0400
X-Greylist: delayed 1285 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Oct 2019 12:02:31 EDT
Received: from mx04.mta.xmission.com ([166.70.13.214])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1iG3Ff-00086p-9O; Thu, 03 Oct 2019 09:42:47 -0600
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx04.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1iG3FP-0007KK-Lf; Thu, 03 Oct 2019 09:42:47 -0600
Received: from hacktheplanet (c-68-50-34-150.hsd1.in.comcast.net [68.50.34.150])
        by plesk14.xmission.com (Postfix) with ESMTPSA id A270F126779;
        Thu,  3 Oct 2019 15:42:28 +0000 (UTC)
Date:   Thu, 3 Oct 2019 11:42:27 -0400
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, axboe <axboe@kernel.dk>,
        Scott Bauer <sbauer@plzdonthack.me>,
        jonathan.derrick@intel.com, revanth.rajashekar@intel.com
Message-ID: <20191003154227.GB2450@hacktheplanet>
References: <807d7b7f-623b-75f0-baab-13b1b0c02e9d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <807d7b7f-623b-75f0-baab-13b1b0c02e9d@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1iG3FP-0007KK-Lf;;;mid=<20191003154227.GB2450@hacktheplanet>;;;hst=mx04.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
Subject: Re: [PATCH 1/2] block: sed-opal: fix sparse warning: obsolete array
 init.
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on mx04.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 02, 2019 at 07:23:05PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix sparse warning: (missing '=')
> ../block/sed-opal.c:133:17: warning: obsolete array initializer, use C99 syntax
> 
> Fixes: ff91064ea37c ("block: sed-opal: check size of shadow mbr")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> Cc: David Kozub <zub@linux.fjfi.cvut.cz>
> ---

Un cc'd David and Jonas, +CC'd Jon and Revanth.

This looks fine to me too.

Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
