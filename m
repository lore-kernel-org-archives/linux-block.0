Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1518CC43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 18:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A149D20862
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 18:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="vZNmMwIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A149D20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbeK0F1K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:27:10 -0500
Received: from imap.thunk.org ([74.207.234.97]:57296 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725739AbeK0F1K (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 00:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=9wS913BCzE2IB+oVdqv0Ts3TuQCCh4ZL7AYsJpJgAn4=; b=vZNmMwIhAaDyqjRJb462+uNdr4
        V+A1RRfqrXJfnP3EoV7Ryp/Uwf94h8EbJmk/xco2Umlj9MMQ21g85aHjeC79FEhWiZiWBKC+LidEX
        rxf5AwGiVp439NBzDOnA3elSPh+VoOzTJokFhUKTytOcrgGXshd8gyyYD8H6xFDr4+Zg=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gRLg4-0004Pd-KR; Mon, 26 Nov 2018 18:32:12 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E94EB7A445A; Mon, 26 Nov 2018 13:32:11 -0500 (EST)
Date:   Mon, 26 Nov 2018 13:32:11 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] Add use of logger so that syslog files show
 when each test starts
Message-ID: <20181126183211.GA31885@thunk.org>
References: <20181029161557.7652-1-tytso@mit.edu>
 <20181123010221.GA6311@thunk.org>
 <20181126175057.GA30411@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126175057.GA30411@vader>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 26, 2018 at 09:50:57AM -0800, Omar Sandoval wrote:
> 
> Hey, Ted, sorry, I meant to ask you about this in person at LPC but
> forgot to. Forgive my ignorance about syslog, but does syslog not pick
> up the line we write to dmesg?

Unfortunately, it does not.

root@xfstests-ltm:~# echo foo testing >> /dev/kmsg 
root@xfstests-ltm:~# dmesg | tail
[    7.103899] random: crng init done
[    7.104759] random: 7 urandom warning(s) missed due to ratelimiting
[    7.154525] EDAC MC: Ver: 3.0.0
[    7.221973] EDAC sbridge: Seeking for: PCI ID 8086:2fa0
[    7.221977] EDAC sbridge:  Ver: 1.1.1 
[    7.259154] device-mapper: uevent: version 1.0.3
[    7.267252] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel@redhat.com
[    7.762306] EXT4-fs (sda1): resizing filesystem from 2620928 to 13106683 blocks
[    8.541258] EXT4-fs (sda1): resized filesystem to 13106683
[840160.646340] foo testing
root@xfstests-ltm:~# tail /var/log/kern.log
root@xfstests-ltm:~# grep kern.log /etc/rsyslog.conf 
kern.*				-/var/log/kern.log

So as you can see nothing written to kern.log, even though we wrote to
/dev/kmsg.

To prove that kern.log will get kernel messages:

root@xfstests-ltm:~# mke2fs -t ext4 -Fq /tmp/foo.img 8M
root@xfstests-ltm:~# mount -t ext4 /tmp/foo.img /mnt
root@xfstests-ltm:~# echo testing > /sys/fs/ext4/loop0/trigger_fs_error 
root@xfstests-ltm:~# tail /var/log/kern.log
Nov 26 13:30:22 xfstests-ltm kernel: [840286.728296] loop: module loaded
Nov 26 13:30:22 xfstests-ltm kernel: [840286.752181] EXT4-fs (loop0): mounted filesystem with ordered data mode. Opts: (null)
Nov 26 13:30:41 xfstests-ltm kernel: [840305.773418] EXT4-fs error (device loop0): trigger_test_error:123: comm bash: testing
root@xfstests-ltm:~# 

					- Ted
