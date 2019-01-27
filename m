Return-Path: <SRS0=IU7b=QD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30055C282CA
	for <linux-block@archiver.kernel.org>; Sun, 27 Jan 2019 21:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27E42133F
	for <linux-block@archiver.kernel.org>; Sun, 27 Jan 2019 21:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfA0VPA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Jan 2019 16:15:00 -0500
Received: from bout01.mta.xmission.com ([166.70.11.15]:40669 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfA0VPA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Jan 2019 16:15:00 -0500
Received: from mx04.mta.xmission.com ([166.70.13.214])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1gnrla-00028C-Ho; Sun, 27 Jan 2019 14:14:58 -0700
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx04.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1gnrla-0004vP-00; Sun, 27 Jan 2019 14:14:58 -0700
Received: from hacktheplanet (c-68-50-23-202.hsd1.in.comcast.net [68.50.23.202])
        by plesk14.xmission.com (Postfix) with ESMTPSA id 2CC24217FD9;
        Sun, 27 Jan 2019 21:14:57 +0000 (UTC)
Date:   Sun, 27 Jan 2019 16:14:49 -0500
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Message-ID: <20190127211449.GP21149@hacktheplanet>
References: <1548196307-12987-1-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548196307-12987-1-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1gnrla-0004vP-00;;;mid=<20190127211449.GP21149@hacktheplanet>;;;hst=mx04.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
Subject: Re: [PATCH v3 00/16] block: sed-opal: support shadow MBR done flag
 and write
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on mx04.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 22, 2019 at 11:31:31PM +0100, David Kozub wrote:
> This patch series extends OPAL support: it adds IOCTL for setting the shadow
> MBR done flag which can be useful for unlocking an OPAL disk on boot and it adds
> IOCTL for writing to the shadow MBR. Also included are some minor fixes and
> improvements.
> 
> This series is based on the original work done by Jonas Rabenstein which was
> submitted in March 2018.[1] I tried to apply suggestions made in review on the
> list and do some further improvements.
> 
> The most contentious issue in the original series was the IOCTL for shadow MBR
> write but I think no better approach was found[2] so this was not changed. I'm
> open to suggestions.
> 
> There is a fork of sed-opal-temp that can use these new IOCTLs.[3] I tested
> these on Samsung 840 EVO and 850 EVO drives, on x86-64 and arm64 systems.
> 
> The series applies on v5.0-rc3.
> 
> Changes from v2 to v3:
> * review suggestions from Scott Bauer
> 
> As Scott suggested I tried to do a more thorough testing, esp. with things like
> wrong passwords/invalid values. I did not observe any crash or unexpected
> behavior.
> 
> David Kozub (8):
>   block: sed-opal: fix typos and formatting
>   block: sed-opal: close parameter list in cmd_finalize
>   block: sed-opal: unify cmd start
>   block: sed-opal: unify error handling of responses
>   block: sed-opal: reuse response_get_token to decrease code duplication
>   block: sed-opal: pass steps via argument rather than via opal_dev
>   block: sed-opal: don't repeat opal_discovery0 in each steps array
>   block: sed-opal: rename next to execute_steps
> 

You forgot to send 16/16 again in v3. I pulled and tested off your github page.
If you send a v4 or just resend that patch you can add my reviewed-by, as I reviewed it
on my tree/from your github.

