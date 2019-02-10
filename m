Return-Path: <SRS0=XSHr=QR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E01C282C2
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 20:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687C62145D
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 20:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfBJU1G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Feb 2019 15:27:06 -0500
Received: from mx2.cyber.ee ([193.40.6.72]:45571 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfBJU1G (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Feb 2019 15:27:06 -0500
Subject: Re: ext4 corruption on alpha with 4.20.0-09062-gd8372ba8ce28
To:     linux-alpha@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org
References: <fb63a4d0-d124-21c8-7395-90b34b57c85a@linux.ee>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <1c26eab4-3277-9066-5dce-6734ca9abb96@linux.ee>
Date:   Sun, 10 Feb 2019 22:27:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <fb63a4d0-d124-21c8-7395-90b34b57c85a@linux.ee>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

02.01.19 17:52 I wrote:

> I have noticed ext4 filesystem corruption on two of my test alphas with 4.20.0-09062-gd8372ba8ce28.

Retried it, still happens with 5.0.0-rc5-00358-gdf3865f8f568 - rsync of emerge --sync just fail with nothing in dmesg.
  
> On AlphaServer DS10:
> [10749.664418] EXT4-fs error (device sda2): __ext4_iget:5052: inode #1853093: block 1: comm rsync: invalid block
> 
> On AlphaServer DS10L:
> [ 5325.064656] EXT4-fs error (device sda2): htree_dirblock_to_tree:1007: inode #1191951: block 4731728: comm rm: bad entry in directory: directory entry overrun - offset=76, inode=417080, rec_len=61816, name_len=35, size=4096
> [ 5325.069539] EXT4-fs error (device sda2): htree_dirblock_to_tree:1007: inode #1191951: block 4731728: comm rm: bad entry in directory: directory entry overrun - offset=76, inode=417080, rec_len=61816, name_len=35, size=4096
> [ 5325.077351] EXT4-fs error (device sda2): ext4_empty_dir:2718: inode #1191951: block 4731728: comm rm: bad entry in directory: directory entry overrun - offset=76, inode=417080, rec_len=61816, name_len=35, size=4096
> 
> Two other alphas, PC-164 and Eiger, worked fine with the same kernel version (different kernel configs according to hardware).
> 
> The details:
> 4.20 worked fine, with gentoo emerge package update after bootup.
> Next, 4.20.0-06428-g00c569b567c7 worked fine, with gentoo emerge after bootup.
> Next, 4.20.0-09062-gd8372ba8ce28 booted up fine but rsync and rm during start of gentoo emerge errored out like above.
> 
> So the corruption _might_ have happened during bootup of previous kernel but it looks more likely that only the latest kernel with blk-mq introduced the problems. mq-deadline is in use on all the alphas.
> 
> DS10 has Symbios 53C896 SCSI (sym2 driver), DS10L has QLogic ISP1040, so they are different. Working Eiger and PC164 have sym2 based scsi controllers too.

-- 
Meelis Roos <mroos@linux.ee>
