Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53254 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936739AbdLSKrL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Dec 2017 05:47:11 -0500
From: Johannes Thumshirn <jthumshirn@suse.de>
To: xiao yang <yangx.jy@cn.fujitsu.com>
Cc: <osandov@osandov.com>, <eguan@redhat.com>,
        <fstests@vger.kernel.org>, <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] block/013: Add test for BLKRRPART ioctl
References: <20171204182953.GA16308@vader.DHCP.thefacebook.com>
        <1513679423-13067-1-git-send-email-yangx.jy@cn.fujitsu.com>
Date: Tue, 19 Dec 2017 11:47:09 +0100
In-Reply-To: <1513679423-13067-1-git-send-email-yangx.jy@cn.fujitsu.com> (xiao
        yang's message of "Tue, 19 Dec 2017 18:30:23 +0800")
Message-ID: <mqd8tdzataq.fsf@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

xiao yang <yangx.jy@cn.fujitsu.com> writes:

> +requires() {
> +	_have_program mkfs.ext3
> +}
[...]
> +	# Format
> +	mkfs.ext3 -F "$TEST_DEV" >> "$FULL" 2>&1

What's the reason to limit the test case to ext3 only? Can you switch it
to the generic 'mkfs' command? IIRC we require 'util-linux' to be
present for blktests but mkfs.ext3 is (at least in SUSE based distros)
in the e2fsprogs package.

apart from that:
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
