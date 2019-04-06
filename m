Return-Path: <SRS0=s1xr=SI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0633BC10F06
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 15:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28632083E
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 15:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfDFPd5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Apr 2019 11:33:57 -0400
Received: from bout01.mta.xmission.com ([166.70.11.15]:52149 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfDFPd5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Apr 2019 11:33:57 -0400
Received: from mx04.mta.xmission.com ([166.70.13.214])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hCn2P-0005rs-AR; Sat, 06 Apr 2019 09:15:21 -0600
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx04.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hCn2O-0005EI-1P; Sat, 06 Apr 2019 09:15:21 -0600
Received: from hacktheplanet (c-68-50-23-202.hsd1.in.comcast.net [68.50.23.202])
        by plesk14.xmission.com (Postfix) with ESMTPSA id 1A6741C8FEB;
        Sat,  6 Apr 2019 15:15:18 +0000 (UTC)
Date:   Sat, 6 Apr 2019 11:15:09 -0400
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Message-ID: <20190406151444.GA10294@hacktheplanet>
References: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <1550103368-4605-2-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550103368-4605-2-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1hCn2O-0005EI-1P;;;mid=<20190406151444.GA10294@hacktheplanet>;;;hst=mx04.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
Subject: Re: [PATCH 01/16] block: sed-opal: fix IOC_OPAL_ENABLE_DISABLE_MBR
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on mx04.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 14, 2019 at 01:15:53AM +0100, David Kozub wrote:
> The implementation of IOC_OPAL_ENABLE_DISABLE_MBR handled the value
> opal_mbr_data.enable_disable incorrectly: enable_disable is expected
> to be one of OPAL_MBR_ENABLE(0) or OPAL_MBR_DISABLE(1). enable_disable
> was passed directly to set_mbr_done and set_mbr_enable_disable where
> is was interpreted as either OPAL_TRUE(1) or OPAL_FALSE(0). The end
> result was that calling IOC_OPAL_ENABLE_DISABLE_MBR with OPAL_MBR_ENABLE
> actually disabled the shadow MBR and vice versa.
> 
> This patch adds correct conversion from OPAL_MBR_DISABLE/ENABLE to
> OPAL_FALSE/TRUE. The change affects existing programs using
> IOC_OPAL_ENABLE_DISABLE_MBR but this is typically used only once when
> setting up an Opal drive.
> 
> Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
> Acked-by: Jon Derrick <jonathan.derrick@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
