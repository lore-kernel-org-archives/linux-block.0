Return-Path: <SRS0=cicp=DF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A43BC2D0A8
	for <linux-block@archiver.kernel.org>; Mon, 28 Sep 2020 05:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B954239EE
	for <linux-block@archiver.kernel.org>; Mon, 28 Sep 2020 05:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="J1vchcQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgI1FCV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Sep 2020 01:02:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:42548 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgI1FCV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Sep 2020 01:02:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601269340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9rxnAUlcW+c8s9Zamrhw0M/6zu/bkDouk22bA14g5DY=;
        b=J1vchcQfxzo7NWAx2bYIFRLbsBRDxS8XoVmiLTJQmmI00QuDugwAPI9VNLDd70kxoJx8d/
        ZVCTxdgTUVwhtIhPbEC66wZ5bshbM58A+7ch2hBGIDZYDsC8FkeSQRyi9wpym1jr45esQ7
        sC8B6s3Gbg1uynjQRyOkoaFatX9+YZM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3CEE6AD73;
        Mon, 28 Sep 2020 05:02:20 +0000 (UTC)
Subject: Re: Kernel panic on 'floppy' module load, Xen HVM, since 4.19.143
To:     =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>,
        Denis Efremov <efremov@linux.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     xen-devel <xen-devel@lists.xenproject.org>,
        Roman Shaposhnik <roman@zededa.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200927111405.GJ3962@mail-itl>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <26fe7920-d6a8-fb8a-b97c-59565410eff4@suse.com>
Date:   Mon, 28 Sep 2020 07:02:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200927111405.GJ3962@mail-itl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 27.09.20 13:14, Marek Marczykowski-Górecki wrote:
> Hi all,
> 
> I get kernel panic on 'floppy' module load. If I blacklist the module,
> then everything works.
> The issue happens in Xen HVM, other virtualization modes (PV, PVH) works
> fine. PV dom0 works too. I haven't tried bare metal, but I assume it
> works fine too.

Could you please try bare metal?

Working in PV and PVH mode, but not in HVM, is pointing towards either
an issue in IRQ handling (not Xen specific) or in qemu.

It might be that Xen is advertising a rarely used APIC mode. In case
bare metal is working it might be helpful to have APIC related boot
message differences between HVM guest and bare metal.


Juergen
