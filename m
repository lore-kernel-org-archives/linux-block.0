Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921E2C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 18:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F01920855
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 18:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="k/1yINXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F01920855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725739AbeK0FcZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:32:25 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37457 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeK0FcZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 00:32:25 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so14292024plr.4
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 10:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y5mp6wnwuTBXC8+zLUcwQIuF3wvB0dEVtGfHEj5c98o=;
        b=k/1yINXPRlVVQSz1FmxOJpmlsDy6OCcdTJdhDTRKM6RO1lwghtFOa/P8h2k/047oGT
         IXbq5HB2FlDg4WvV+vQeP3hI2EDGEkghLS+J1v+P+eDlMWynF0fnZ31AQmmbYdCk2LaD
         8W3HFsFEauh5uALmx3fVybxWa9r8gdtIcdv7F4VYx+oW7MPzGCVDAfdSnl9BreWvpuSq
         82uIFnorsz+EOxsf0hP4+OLgmmpt8EjZ6B+oKY7cekV9a9wtRH/h3TXGdFs0PgiFQhYx
         glqOGQw/vZX5gtK8GA/IfDITLtUXWMRfZX12VoGQio2e8+LgP7Nyc55EcK+R7/W0nSmh
         cIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y5mp6wnwuTBXC8+zLUcwQIuF3wvB0dEVtGfHEj5c98o=;
        b=gpJVl/0C6ZeNieRrpjI+xcASNN0bUYn2NStGB3Hnti55HkUn3fqDSr+h7Ks2YOL1Mf
         K0t2DU3M8Clgu9XuotsUy5/TZ3LqCAL6ERhyfOSJhTnrxmzsaV4/wQKsTnRlVbrVIpku
         UuTk/j14cHYVdtZLu7rR96V8CUYkcO4+qAlJBfB+MjGmZqm+xeDFQC69IAd6zjWggtRf
         fLuBLhqaW1V39beWDVjEUIeAqQ6ehE14lCYpAvYyYO2/FkXoTS1+d2B4aXTCUpMvq1yg
         Uz4VVBSvxuxQARS4Jimpu9zf9+FiVS1Oj50ea0DgFrt9HKntHYAlZU704vqs6S/v+RRe
         zl6A==
X-Gm-Message-State: AA+aEWaolD7m3jBjKCVvyQdTMFa9D3gf26h4mjmPH+GWhmnr0y1lCU1H
        p3MXfy7sEu8g1PQEifdEPjIIm0od+h0=
X-Google-Smtp-Source: AFSGD/XmnpeTH93LZ9BFlkgYV3IAS27+LwRTaNlS3n+mA+uiq8T8fQfIzx1Ki0yQeaQnsUMAED32jQ==
X-Received: by 2002:a17:902:850c:: with SMTP id bj12mr28440036plb.46.1543257446311;
        Mon, 26 Nov 2018 10:37:26 -0800 (PST)
Received: from vader ([2620:10d:c090:180::1:fd28])
        by smtp.gmail.com with ESMTPSA id w10sm938067pgi.81.2018.11.26.10.37.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 10:37:25 -0800 (PST)
Date:   Mon, 26 Nov 2018 10:37:23 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] Add use of logger so that syslog files show
 when each test starts
Message-ID: <20181126183723.GB30411@vader>
References: <20181029161557.7652-1-tytso@mit.edu>
 <20181123010221.GA6311@thunk.org>
 <20181126175057.GA30411@vader>
 <20181126183211.GA31885@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126183211.GA31885@thunk.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 26, 2018 at 01:32:11PM -0500, Theodore Y. Ts'o wrote:
> On Mon, Nov 26, 2018 at 09:50:57AM -0800, Omar Sandoval wrote:
> > 
> > Hey, Ted, sorry, I meant to ask you about this in person at LPC but
> > forgot to. Forgive my ignorance about syslog, but does syslog not pick
> > up the line we write to dmesg?
> 
> Unfortunately, it does not.
> 
> root@xfstests-ltm:~# echo foo testing >> /dev/kmsg 
> root@xfstests-ltm:~# dmesg | tail
> [    7.103899] random: crng init done
> [    7.104759] random: 7 urandom warning(s) missed due to ratelimiting
> [    7.154525] EDAC MC: Ver: 3.0.0
> [    7.221973] EDAC sbridge: Seeking for: PCI ID 8086:2fa0
> [    7.221977] EDAC sbridge:  Ver: 1.1.1 
> [    7.259154] device-mapper: uevent: version 1.0.3
> [    7.267252] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel@redhat.com
> [    7.762306] EXT4-fs (sda1): resizing filesystem from 2620928 to 13106683 blocks
> [    8.541258] EXT4-fs (sda1): resized filesystem to 13106683
> [840160.646340] foo testing
> root@xfstests-ltm:~# tail /var/log/kern.log
> root@xfstests-ltm:~# grep kern.log /etc/rsyslog.conf 
> kern.*				-/var/log/kern.log
> 
> So as you can see nothing written to kern.log, even though we wrote to
> /dev/kmsg.
> 
> To prove that kern.log will get kernel messages:
> 
> root@xfstests-ltm:~# mke2fs -t ext4 -Fq /tmp/foo.img 8M
> root@xfstests-ltm:~# mount -t ext4 /tmp/foo.img /mnt
> root@xfstests-ltm:~# echo testing > /sys/fs/ext4/loop0/trigger_fs_error 
> root@xfstests-ltm:~# tail /var/log/kern.log
> Nov 26 13:30:22 xfstests-ltm kernel: [840286.728296] loop: module loaded
> Nov 26 13:30:22 xfstests-ltm kernel: [840286.752181] EXT4-fs (loop0): mounted filesystem with ordered data mode. Opts: (null)
> Nov 26 13:30:41 xfstests-ltm kernel: [840305.773418] EXT4-fs error (device loop0): trigger_test_error:123: comm bash: testing
> root@xfstests-ltm:~# 

Hm, what if we output it as KERN_INFO?

diff --git a/check b/check
index f6c3537..9b4765f 100755
--- a/check
+++ b/check
@@ -314,7 +314,7 @@ _call_test() {
 
 	if [[ -w /dev/kmsg ]]; then
 		local dmesg_marker="run blktests $TEST_NAME at ${TEST_RUN["date"]}"
-		echo "$dmesg_marker" >> /dev/kmsg
+		echo "<6>$dmesg_marker" >> /dev/kmsg
 	else
 		local dmesg_marker=""
 		CHECK_DMESG=0
