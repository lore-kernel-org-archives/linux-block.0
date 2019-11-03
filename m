Return-Path: <SRS0=L9ug=Y3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255A6CA9EB0
	for <linux-block@archiver.kernel.org>; Sun,  3 Nov 2019 23:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D2B21D56
	for <linux-block@archiver.kernel.org>; Sun,  3 Nov 2019 23:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfKCXwn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 3 Nov 2019 18:52:43 -0500
Received: from bout01.mta.xmission.com ([166.70.11.15]:33344 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbfKCXwm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 3 Nov 2019 18:52:42 -0500
Received: from mx02.mta.xmission.com ([166.70.13.212])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1iRPfk-0005g6-Mn; Sun, 03 Nov 2019 16:52:40 -0700
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1iRPfk-0008CE-76; Sun, 03 Nov 2019 16:52:40 -0700
Received: from hacktheplanet (c-68-50-34-150.hsd1.in.comcast.net [68.50.34.150])
        by plesk14.xmission.com (Postfix) with ESMTPSA id 36EC521701C;
        Sun,  3 Nov 2019 23:52:38 +0000 (UTC)
Date:   Sun, 3 Nov 2019 18:52:31 -0500
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     Revanth Rajashekar <revanth.rajashekar@intel.com>
Cc:     linux-block@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Jonas Rabenstine <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>,
        Jens Axboe <axboe@kernel.dk>
Message-ID: <20191103235231.GA12665@hacktheplanet>
References: <20191031161322.16624-1-revanth.rajashekar@intel.com>
 <20191031161322.16624-2-revanth.rajashekar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031161322.16624-2-revanth.rajashekar@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1iRPfk-0008CE-76;;;mid=<20191103235231.GA12665@hacktheplanet>;;;hst=mx02.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
Subject: Re: [PATCH v3 1/3] block: sed-opal: Generalizing write data to any
 opal table
X-SA-Exim-Version: 4.2.1 (built Mon, 03 Jun 2019 09:49:16 -0600)
X-SA-Exim-Scanned: Yes (on mx02.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 31, 2019 at 10:13:20AM -0600, Revanth Rajashekar wrote:
> This patch refactors the existing "write_shadowmbr" func and
> creates a new generalized function "generic_table_write_data",
> to write data to any opal table. Also, a few cleanups are included
> in this patch.
> 
> Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
> Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>

Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
Looks good.



