Return-Path: <SRS0=s1xr=SI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7ED7C10F06
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 15:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE3220B1F
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 15:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfDFPUz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Apr 2019 11:20:55 -0400
Received: from bout01.mta.xmission.com ([166.70.11.15]:51062 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfDFPUy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Apr 2019 11:20:54 -0400
Received: from mx01.mta.xmission.com ([166.70.13.211])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hCn7l-0006N8-Gq; Sat, 06 Apr 2019 09:20:53 -0600
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hCn7l-0006ud-1e; Sat, 06 Apr 2019 09:20:53 -0600
Received: from hacktheplanet (c-68-50-23-202.hsd1.in.comcast.net [68.50.23.202])
        by plesk14.xmission.com (Postfix) with ESMTPSA id 5C9FB1BF275;
        Sat,  6 Apr 2019 15:20:52 +0000 (UTC)
Date:   Sat, 6 Apr 2019 11:20:45 -0400
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Message-ID: <20190406152045.GF10294@hacktheplanet>
References: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <1550103368-4605-15-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550103368-4605-15-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1hCn7l-0006ud-1e;;;mid=<20190406152045.GF10294@hacktheplanet>;;;hst=mx01.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
Subject: Re: [PATCH 14/16] block: sed-opal: pass steps via argument rather
 than via opal_dev
X-SA-Exim-Version: 4.2.1 (built Fri, 13 May 2016 17:07:30 -0600)
X-SA-Exim-Scanned: Yes (on mx01.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 14, 2019 at 01:16:06AM +0100, David Kozub wrote:
> The steps argument is only read by the next function, so it can
> be passed directly as an argument rather than via opal_dev.
> 
> Normally, the steps is an array on the stack, so the pointer stops
> being valid then the function that set opal_dev.steps returns.
> If opal_dev.steps was not set to NULL before return it would become
> a dangling pointer. When the steps are passed as argument this
> becomes easier to see and more difficult to misuse.
> 
> Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
