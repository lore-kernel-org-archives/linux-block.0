Return-Path: <SRS0=IU7b=QD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F7DC282CA
	for <linux-block@archiver.kernel.org>; Sun, 27 Jan 2019 21:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBB52087F
	for <linux-block@archiver.kernel.org>; Sun, 27 Jan 2019 21:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfA0VHq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Jan 2019 16:07:46 -0500
Received: from bout01.mta.xmission.com ([166.70.11.15]:40452 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfA0VHq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Jan 2019 16:07:46 -0500
Received: from mx02.mta.xmission.com ([166.70.13.212])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1gnreb-0001qi-Cg; Sun, 27 Jan 2019 14:07:45 -0700
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1gnreb-0000Pa-0e; Sun, 27 Jan 2019 14:07:45 -0700
Received: from hacktheplanet (c-68-50-23-202.hsd1.in.comcast.net [68.50.23.202])
        by plesk14.xmission.com (Postfix) with ESMTPSA id 4020A217D06;
        Sun, 27 Jan 2019 21:07:44 +0000 (UTC)
Date:   Sun, 27 Jan 2019 16:07:36 -0500
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Message-ID: <20190127210736.GJ21149@hacktheplanet>
References: <1548196307-12987-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <1548196307-12987-11-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548196307-12987-11-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1gnreb-0000Pa-0e;;;mid=<20190127210736.GJ21149@hacktheplanet>;;;hst=mx02.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
Subject: Re: [PATCH v3 10/16] block: sed-opal: add ioctl for done-mark of
 shadow mbr
X-SA-Exim-Version: 4.2.1 (built Fri, 13 May 2016 17:07:30 -0600)
X-SA-Exim-Scanned: Yes (on mx02.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 22, 2019 at 11:31:41PM +0100, David Kozub wrote:
> From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> 
> Enable users to mark the shadow mbr as done without completely
> deactivating the shadow mbr feature. This may be useful on reboots,
> when the power to the disk is not disconnected in between and the shadow
> mbr stores the required boot files. Of course, this saves also the
> (few) commands required to enable the feature if it is already enabled
> and one only wants to mark the shadow mbr as done.
> 
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
