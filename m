Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD12C05027
	for <linux-block@archiver.kernel.org>; Mon,  6 Feb 2023 06:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjBFGUt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Feb 2023 01:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBFGUl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2023 01:20:41 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7DB5599
        for <linux-block@vger.kernel.org>; Sun,  5 Feb 2023 22:20:40 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D4A1268C7B; Mon,  6 Feb 2023 07:20:37 +0100 (CET)
Date:   Mon, 6 Feb 2023 07:20:37 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [bug report] RIP: 0010:blkg_free+0xa/0xe0 observed on latest
 linux-block/for-next
Message-ID: <20230206062037.GA9567@lst.de>
References: <CAHj4cs-ZvyXKU9iAVKSkh2NfN5238rh-OaU8_uDBHVFtJb2ASQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs-ZvyXKU9iAVKSkh2NfN5238rh-OaU8_uDBHVFtJb2ASQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 06, 2023 at 01:22:23PM +0800, Yi Zhang wrote:
> Hello
> CKI reported one new issue with the latest linux-block/for-next, pls
> help check it, thanks.
> 
> linux-block.git@for-next
> commit: 99bd489eac97
> 
> [ 4407.784047] Running test [R:13334567 T:10 - Storage - block -

What actual test is this?

> storage fio numa - Kernel: 6.2.0-rc6]
> [ 4509.133240] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [ 4509.133654] #PF: supervisor read access in kernel mode
> [ 4509.133930] #PF: error_code(0x0000) - not-present page
> [ 4509.134206] PGD 0 P4D 0
> [ 4509.134373] Oops: 0000 [#1] PREEMPT SMP PTI
> [ 4509.134579] CPU: 2 PID: 965 Comm: auditd Tainted: G          I
>   6.2.0-rc6 #1
> [ 4509.135384] Hardware name: HP ProLiant DL360p Gen8, BIOS P71 05/24/2019
> [ 4509.135758] RIP: 0010:blkg_free+0xa/0xe0

Can you resolve this to a line using

gdb vmlinux
l *(blkg_free+0xa/0xe0)

