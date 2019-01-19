Return-Path: <SRS0=VL3J=P3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB837C61CE4
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 17:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A222084F
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 17:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfASRx3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Jan 2019 12:53:29 -0500
Received: from bout01.mta.xmission.com ([166.70.11.15]:38169 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbfASRx2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Jan 2019 12:53:28 -0500
Received: from mx04.mta.xmission.com ([166.70.13.214])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1gkuoB-0006N7-IG; Sat, 19 Jan 2019 10:53:27 -0700
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx04.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1gkuoB-0003dr-5k; Sat, 19 Jan 2019 10:53:27 -0700
Received: from hacktheplanet (unknown [73.58.156.101])
        by plesk14.xmission.com (Postfix) with ESMTPSA id 8265E211E0C;
        Sat, 19 Jan 2019 17:53:26 +0000 (UTC)
Date:   Sat, 19 Jan 2019 12:53:21 -0500
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     linux-block@vger.kernel.org
Message-ID: <20190119175321.GA15951@hacktheplanet>
References: <1547760716-7304-1-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547760716-7304-1-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1gkuoB-0003dr-5k;;;mid=<20190119175321.GA15951@hacktheplanet>;;;hst=mx04.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
Subject: Re: [PATCH v2 00/16] block: sed-opal: support shadow MBR done flag
 and write
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on mx04.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 17, 2019 at 09:31:40PM +0000, David Kozub wrote:

> There is a fork of sed-opal-temp that can use these new IOCTLs.[3] I tested
> these on Samsung 840 EVO and 850 EVO drives, on x86-64 and arm64 systems.

Generally the series looks fine. Can you please, do some more sanity testing on
error conditions? Unlock with bad password, try and set up LR with bad PW, or
too large of a LR, like 242 or something. This series really changes the core
portion of this driver that essentially makes all this run and it looks like all
the normal conditions are fine, but im worried about some error conditions.

Resend V3 and I'll do some sanity tests on my end once I find my one nvme drive
with opal support. 


> -- 
> 2.20.1
