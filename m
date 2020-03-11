Return-Path: <SRS0=mBf9=44=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2153CC10F27
	for <linux-block@archiver.kernel.org>; Wed, 11 Mar 2020 10:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2840208E4
	for <linux-block@archiver.kernel.org>; Wed, 11 Mar 2020 10:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgCKK3E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Mar 2020 06:29:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:41084 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgCKK3E (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Mar 2020 06:29:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 59AB5B1DC;
        Wed, 11 Mar 2020 10:29:02 +0000 (UTC)
Message-ID: <209f06496c1ef56b52b0ec67c503838e402c8911.camel@suse.com>
Subject: Re: disk revalidation updates and OOM
From:   Martin Wilck <mwilck@suse.com>
To:     He Zhe <zhe.he@windriver.com>, Christoph Hellwig <hch@lst.de>,
        jack@suse.cz, Jens Axboe <axboe@kernel.dk>,
        viro@zeniv.linux.org.uk, bvanassche@acm.org, keith.busch@intel.com,
        tglx@linutronix.de, yuyufen@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 11 Mar 2020 11:29:06 +0100
In-Reply-To: <93b395e6-5c3f-0157-9572-af0f9094dbd7@windriver.com>
References: <93b395e6-5c3f-0157-9572-af0f9094dbd7@windriver.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2020-03-02 at 11:55 +0800, He Zhe wrote:
> Hi,
> 
> Since the following commit
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.5/disk-revalidate&id=6917d0689993f46d97d40dd66c601d0fd5b1dbdd
> until now(v5.6-rc4),
> 
> If we start udisksd service of systemd(v244), systemd-udevd will scan
> /dev/hdc
> (the cdrom device created by default in qemu(v4.2.0)). systemd-udevd
> will
> endlessly run and cause OOM.

I've tried to reproduce this, but so far I haven't been able to.
Perhaps because the distro 5.5.7 kernel I've tried (which contains the
offending commit 142fe8f) has no IDE support - the qemu IDE CD shows up
as sr0, with the ata_piix driver. I have systemd-udevd 244. Enabling
udisksd makes no difference, the system runs stably. ISO images can
be "ejected" and loaded, single uevents are received and processed.

Does this happen for you if you use ata_piix?

Regards
Martin


