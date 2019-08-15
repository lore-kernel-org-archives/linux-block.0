Return-Path: <SRS0=WP4r=WL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2987C433FF
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 04:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24DB2067D
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 04:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfHOEu6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Aug 2019 00:50:58 -0400
Received: from bout01.mta.xmission.com ([166.70.11.15]:57255 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfHOEu6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Aug 2019 00:50:58 -0400
Received: from mx02.mta.xmission.com ([166.70.13.212])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hy6xW-0004Vh-FI; Wed, 14 Aug 2019 22:01:54 -0600
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hy6xV-00082g-UW; Wed, 14 Aug 2019 22:01:54 -0600
Received: from hacktheplanet (unknown [8.25.222.2])
        by plesk14.xmission.com (Postfix) with ESMTPSA id 623DE727A8;
        Thu, 15 Aug 2019 04:01:53 +0000 (UTC)
Date:   Thu, 15 Aug 2019 00:01:48 -0400
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     Revanth Rajashekar <revanth.rajashekar@intel.com>
Cc:     linux-block@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@intel.com>
Message-ID: <20190815040140.GA31938@hacktheplanet>
References: <20190813214340.15533-1-revanth.rajashekar@intel.com>
 <20190813214340.15533-2-revanth.rajashekar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813214340.15533-2-revanth.rajashekar@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1hy6xV-00082g-UW;;;mid=<20190815040140.GA31938@hacktheplanet>;;;hst=mx02.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
Subject: Re: [PATCH 1/3] block: sed-opal: Add/remove spaces
X-SA-Exim-Version: 4.2.1 (built Mon, 03 Jun 2019 09:49:16 -0600)
X-SA-Exim-Scanned: Yes (on mx02.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 13, 2019 at 03:43:38PM -0600, Revanth Rajashekar wrote:
> Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
looks fine
Reviewed-by Scott Bauer <sbauer@pldonthack.me>
