Return-Path: <SRS0=gQfC=TF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF118C004C9
	for <linux-block@archiver.kernel.org>; Sun,  5 May 2019 14:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AFD208C2
	for <linux-block@archiver.kernel.org>; Sun,  5 May 2019 14:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfEEO13 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 May 2019 10:27:29 -0400
Received: from bout01.mta.xmission.com ([166.70.11.15]:44595 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbfEEO12 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 May 2019 10:27:28 -0400
Received: from mx03.mta.xmission.com ([166.70.13.213])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hNI6x-0002sR-Ec; Sun, 05 May 2019 08:27:27 -0600
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hNI6w-0003Fn-Ri; Sun, 05 May 2019 08:27:27 -0600
Received: from hacktheplanet (c-68-50-23-202.hsd1.in.comcast.net [68.50.23.202])
        by plesk14.xmission.com (Postfix) with ESMTPSA id 297B01C585B;
        Sun,  5 May 2019 14:27:26 +0000 (UTC)
Date:   Sun, 5 May 2019 10:27:15 -0400
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Message-ID: <20190505142715.GA1030@hacktheplanet>
References: <1556666459-17948-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <1556666459-17948-4-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556666459-17948-4-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1hNI6w-0003Fn-Ri;;;mid=<20190505142715.GA1030@hacktheplanet>;;;hst=mx03.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
Subject: Re: [PATCH 3/3] block: sed-opal: check size of shadow mbr
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on mx03.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 01, 2019 at 01:20:59AM +0200, David Kozub wrote:
> From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> 
> Check whether the shadow mbr does fit in the provided space on the
> target. Also a proper firmware should handle this case and return an
> error we may prevent problems or even damage with crappy firmwares.
> 
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
> Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
> Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
re-reviewed and looks fine again: Scott Bauer <sbauer@plzdonthack.me>
