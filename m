Return-Path: <SRS0=+obT=ZO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DBFC432C0
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 17:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0744320714
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 17:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfKVRFZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Nov 2019 12:05:25 -0500
Received: from bout01.mta.xmission.com ([166.70.11.15]:33767 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfKVRFZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Nov 2019 12:05:25 -0500
Received: from mx04.mta.xmission.com ([166.70.13.214])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1iYCN1-0000ir-SN; Fri, 22 Nov 2019 10:05:23 -0700
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx04.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1iYCN0-0002jD-Kf; Fri, 22 Nov 2019 10:05:23 -0700
Received: from hacktheplanet (c-68-50-34-150.hsd1.in.comcast.net [68.50.34.150])
        by plesk14.xmission.com (Postfix) with ESMTPSA id AFB8814E2E8;
        Fri, 22 Nov 2019 17:05:15 +0000 (UTC)
Date:   Fri, 22 Nov 2019 12:05:07 -0500
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "Rajashekar, Revanth" <revanth.rajashekar@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <20191122170507.GA362@hacktheplanet>
References: <20191122161854.70939-1-revanth.rajashekar@intel.com>
 <45c05efa3fb1947de41a47f6cb6fc043fa904f65.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45c05efa3fb1947de41a47f6cb6fc043fa904f65.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1iYCN0-0002jD-Kf;;;mid=<20191122170507.GA362@hacktheplanet>;;;hst=mx04.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
Subject: Re: [PATCH] block: sed-opal: Cleanup trivial patch
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on mx04.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 22, 2019 at 04:28:06PM +0000, Derrick, Jonathan wrote:
> Acked-by: Jon Derrick <jonathan.derrick@intel.com>
Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
