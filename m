Return-Path: <SRS0=gQfC=TF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7A6C004C9
	for <linux-block@archiver.kernel.org>; Sun,  5 May 2019 14:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F99208C0
	for <linux-block@archiver.kernel.org>; Sun,  5 May 2019 14:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfEEOns (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 May 2019 10:43:48 -0400
Received: from bout01.mta.xmission.com ([166.70.11.15]:45475 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbfEEOns (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 May 2019 10:43:48 -0400
Received: from mx01.mta.xmission.com ([166.70.13.211])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hNIMc-00042t-7p; Sun, 05 May 2019 08:43:38 -0600
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1hNIMb-0007j9-Kk; Sun, 05 May 2019 08:43:38 -0600
Received: from hacktheplanet (c-68-50-23-202.hsd1.in.comcast.net [68.50.23.202])
        by plesk14.xmission.com (Postfix) with ESMTPSA id E6B3C1C5B9A;
        Sun,  5 May 2019 14:43:36 +0000 (UTC)
Date:   Sun, 5 May 2019 10:43:30 -0400
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Message-ID: <20190505144330.GB1030@hacktheplanet>
References: <1556666459-17948-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <20190501134917.GC24132@infradead.org>
 <alpine.LRH.2.21.1905032058110.30331@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1905032058110.30331@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1hNIMb-0007j9-Kk;;;mid=<20190505144330.GB1030@hacktheplanet>;;;hst=mx01.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
Subject: Re: [PATCH 0/3] block: sed-opal: add support for shadow MBR done
 flag and write
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mx01.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 03, 2019 at 10:32:19PM +0200, David Kozub wrote:
> On Wed, 1 May 2019, Christoph Hellwig wrote:
> 
> > > I successfully tested toggling the MBR done flag and writing the shadow MBR
> > > using some tools I hacked together[4] with a Samsung SSD 850 EVO drive.
> > 
> > Can you submit the tool to util-linux so that we get it into distros?
> 
> There is already Scott's sed-opal-temp[1] and a fork by Jonas that adds
> support for older version of these new IOCTLs[2]. There was already some
> discussion of getting that to util-linux.[3]
> 
> While I like my hack, sed-opal-temp can do much more (my tool supports just
> the few things I actually use). But there are two things which sed-opal-temp
> currently lacks which my hack has:
> 
> * It can use a PBKDF2 hash (salted by disk serial number) of the password
>   rather than the password directly. This makes it compatible with sedutil
>   and I think it's also better practice (as firmware can contain many
>   surprises).
> 
> * It contains a 'PBA' (pre-boot authorization) tool. A tool intended to be
>   run from shadow mbr that asks for a password and uses it to unlock all
>   disks and set shadow mbr done flag, so after restart the computer boots
>   into the real OS.
> 
> @Scott: What are your plans with sed-opal-temp? If you want I can update
> Jonas' patches to the adapted IOCTLs. What are your thoughts on PW hashing
> and a PBA tool?

I will accept any and all patches to sed opal tooling, I am not picky. I will
also give up maintainership of it is someone else feels they can (rightfully
so) do a better job.

Jon sent me a patch for the tool that will deal with writing to the shadow MBR,
so once we know these patches are going in i'll pull that patch into the tool.

Then I guess that leaves PBKDF2 which I don't think will be too hard to pull in.

With regard to your PBA tool, is that actually being run post-uefi/pre-linux?
IE are we writing your tool into the SMBR and that's what is being run on bootup?

Jon, if you think it's a good idea can you ask David if Revanth or you wants
to take over the tooling? Or if anyone else here wants to own it then let me know.

