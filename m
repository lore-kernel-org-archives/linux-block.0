Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14157C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Jul 2022 16:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbiGMQ2n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jul 2022 12:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbiGMQ2n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jul 2022 12:28:43 -0400
X-Greylist: delayed 401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Jul 2022 09:28:38 PDT
Received: from adrastea.uberspace.de (adrastea.uberspace.de [185.26.156.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EB4A183
        for <linux-block@vger.kernel.org>; Wed, 13 Jul 2022 09:28:37 -0700 (PDT)
Received: (qmail 21136 invoked by uid 990); 13 Jul 2022 16:21:54 -0000
Authentication-Results: adrastea.uberspace.de;
        auth=pass (plain)
Message-ID: <0790e1fa-f9b5-9da8-7817-99023ea900f1@manueljacob.de>
Date:   Wed, 13 Jul 2022 18:21:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US-large
To:     linux-block@vger.kernel.org
From:   Manuel Jacob <me@manueljacob.de>
Subject: FALLOC_FL_ZERO_RANGE is faster on dm-crypt device than on underlying
 block device
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: MIME_GOOD(-0.1)
X-Rspamd-Score: -0.1
Received: from unknown (HELO unkown) (::1)
        by adrastea.uberspace.de (Haraka/2.8.28) with ESMTPSA; Wed, 13 Jul 2022 18:21:54 +0200
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I noticed that `mkfs.ext4 -E lazy_itable_init=0,lazy_journal_init=0` was 
a lot faster on a dm-crypt device (1min 30s) than on the underlying NVMe 
drive (MKNSSDPL2TB-D8, 8min). I tracked it down to the `fallocate` 
system calls made while writing the inode tables (with mode 
FALLOC_FL_ZERO_RANGE).

To show the difference more pronouncedly, I ran the `fallocate` command 
with a bigger size (1 GiB) on the block devices directly. Before each 
test, I ran `echo 3 > /proc/sys/vm/drop_caches`, and after each test, I 
ran `sync` but it finished almost instantly.

fallocate --zero-range /dev/mapper/test -o 1073741824 -l 1073741824
real	0m0.488s
user	0m0.000s
sys	0m0.026s

fallocate --zero-range /dev/nvme0n1p1 -o 1073741824 -l 1073741824
real	0m15.253s
user	0m0.000s
sys	0m0.037s

When opening the dm-crypt device with NO_READ_WORKQUEUE and 
NO_WRITE_WORKQUEUE, the difference is not quite as big. It is probably 
because the encryption happens on one core instead of in 8 tasks on 4 
physical cores.

fallocate --zero-range /dev/mapper/test -o 1073741824 -l 1073741824
real	0m0.943s
user	0m0.003s
sys	0m0.939s

The slowdown on the unencrypted device doesn’t really affect me except 
when running benchmarks (the original goal was testing the performance 
of various operations ON the file system, not file system creation), but 
if I can help tracking down the source of the slowdown, I’d be happy to 
provide more information.
