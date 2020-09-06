Return-Path: <SRS0=+tUj=CP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E46C433E2
	for <linux-block@archiver.kernel.org>; Sun,  6 Sep 2020 03:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BF162086A
	for <linux-block@archiver.kernel.org>; Sun,  6 Sep 2020 03:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WroN2i5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgIFDTa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Sep 2020 23:19:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53327 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728257AbgIFDT3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 5 Sep 2020 23:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599362366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y7C6/v52JOCoyzXs3EvnyF3sQ6pK3y/ClJ5ONjCN7FI=;
        b=WroN2i5YNz3PqBmK/lT4jNKx9cunmQ2hH4jWI/bw9Xm/S75mIzXWpTPpY+oZUQ3YniXdZa
        ComC4hS3MDS3LjhsZ4YRE+qC+xz/TtFogQzjNf22mJioRsBAlkopORAZJMAO99alF+lrSI
        hGFAiUu5ATze41zCKfI8iLuCFRTD5z8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-KhKIQCf4NqqSvPtl_yEZNg-1; Sat, 05 Sep 2020 23:19:22 -0400
X-MC-Unique: KhKIQCf4NqqSvPtl_yEZNg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CC241DDEA;
        Sun,  6 Sep 2020 03:19:21 +0000 (UTC)
Received: from T590 (ovpn-12-73.pek2.redhat.com [10.72.12.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C96EE6FDB6;
        Sun,  6 Sep 2020 03:19:12 +0000 (UTC)
Date:   Sun, 6 Sep 2020 11:19:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Veronika Kabatova <vkabatov@redhat.com>
Cc:     CKI Project <cki-project@redhat.com>, linux-block@vger.kernel.org,
        Changhui Zhong <czhong@redhat.com>, axboe@kernel.dk
Subject: Re: =?utf-8?B?8J+SpSBQQU5JQ0tFRA==?= =?utf-8?Q?=3A?= Test report
 for?kernel 5.9.0-rc3-020ad03.cki (block)
Message-ID: <20200906031908.GB894392@T590>
References: <cki.538AE6A321.BMB0X5ZYG5@redhat.com>
 <20200904010233.GA817918@T590>
 <491751.10128377.1599217585366.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <491751.10128377.1599217585366.JavaMail.zimbra@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Veronika,

On Fri, Sep 04, 2020 at 07:06:25AM -0400, Veronika Kabatova wrote:
> 
> 
> ----- Original Message -----
> > From: "Ming Lei" <ming.lei@redhat.com>
> > To: "CKI Project" <cki-project@redhat.com>
> > Cc: linux-block@vger.kernel.org, axboe@kernel.dk, "Changhui Zhong" <czhong@redhat.com>
> > Sent: Friday, September 4, 2020 3:02:33 AM
> > Subject: Re: 💥 PANICKED: Test report for	kernel 5.9.0-rc3-020ad03.cki (block)
> > 
> > On Thu, Sep 03, 2020 at 05:07:57PM -0000, CKI Project wrote:
> > > 
> > > Hello,
> > > 
> > > We ran automated tests on a recent commit from this kernel tree:
> > > 
> > >        Kernel repo:
> > >        https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> > >             Commit: 020ad0333b03 - Merge branch 'for-5.10/block' into
> > >             for-next
> > > 
> > > The results of these automated tests are provided below.
> > > 
> > >     Overall result: FAILED (see details below)
> > >              Merge: OK
> > >            Compile: OK
> > >              Tests: PANICKED
> > > 
> > > All kernel binaries, config files, and logs are available for download
> > > here:
> > > 
> > >   https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/09/02/613166
> > > 
> > > One or more kernel tests failed:
> > > 
> > >     ppc64le:
> > >      💥 storage: software RAID testing
> > > 
> > >     aarch64:
> > >      💥 storage: software RAID testing
> > > 
> > >     x86_64:
> > >      💥 storage: software RAID testing
> > > 
> > > We hope that these logs can help you find the problem quickly. For the full
> > > detail on our testing procedures, please scroll to the bottom of this
> > > message.
> > > 
> > > Please reply to this email if you have any questions about the tests that
> > > we
> > > ran or if you have any suggestions on how to make future tests more
> > > effective.
> > > 
> > >         ,-.   ,-.
> > >        ( C ) ( K )  Continuous
> > >         `-',-.`-'   Kernel
> > >           ( I )     Integration
> > >            `-'
> > > ______________________________________________________________________________
> > > 
> > > Compile testing
> > > ---------------
> > > 
> > > We compiled the kernel for 4 architectures:
> > > 
> > >     aarch64:
> > >       make options: make -j30 INSTALL_MOD_STRIP=1 targz-pkg
> > > 
> > >     ppc64le:
> > >       make options: make -j30 INSTALL_MOD_STRIP=1 targz-pkg
> > > 
> > >     s390x:
> > >       make options: make -j30 INSTALL_MOD_STRIP=1 targz-pkg
> > > 
> > >     x86_64:
> > >       make options: make -j30 INSTALL_MOD_STRIP=1 targz-pkg
> > > 
> > > 
> > > 
> > > Hardware testing
> > > ----------------
> > > We booted each kernel and ran the following tests:
> > > 
> > >   aarch64:
> > >     Host 1:
> > >        ✅ Boot test
> > >        ✅ ACPI table test
> > >        ✅ LTP
> > >        ✅ Loopdev Sanity
> > >        ✅ Memory function: memfd_create
> > >        ✅ AMTU (Abstract Machine Test Utility)
> > >        ✅ Ethernet drivers sanity
> > >        ✅ storage: SCSI VPD
> > >        🚧 ✅ CIFS Connectathon
> > >        🚧 ✅ POSIX pjd-fstest suites
> > > 
> > >     Host 2:
> > > 
> > >        ⚡ Internal infrastructure issues prevented one or more tests (marked
> > >        with ⚡⚡⚡) from running on this architecture.
> > >        This is not the fault of the kernel that was tested.
> > > 
> > >        ⚡⚡⚡ Boot test
> > >        ⚡⚡⚡ xfstests - ext4
> > >        ⚡⚡⚡ xfstests - xfs
> > >        ⚡⚡⚡ storage: software RAID testing
> > >        ⚡⚡⚡ stress: stress-ng
> > >        🚧 ⚡⚡⚡ xfstests - btrfs
> > >        🚧 ⚡⚡⚡ Storage blktests
> > > 
> > >     Host 3:
> > >        ✅ Boot test
> > >        ✅ xfstests - ext4
> > >        ✅ xfstests - xfs
> > >        💥 storage: software RAID testing
> > >        ⚡⚡⚡ stress: stress-ng
> > >        🚧 ⚡⚡⚡ xfstests - btrfs
> > >        🚧 ⚡⚡⚡ Storage blktests
> > > 
> > >   ppc64le:
> > >     Host 1:
> > >        ✅ Boot test
> > >        🚧 ✅ kdump - sysrq-c
> > > 
> > >     Host 2:
> > >        ✅ Boot test
> > >        ✅ xfstests - ext4
> > >        ✅ xfstests - xfs
> > >        💥 storage: software RAID testing
> > >        🚧 ⚡⚡⚡ xfstests - btrfs
> > >        🚧 ⚡⚡⚡ Storage blktests
> > > 
> > >     Host 3:
> > > 
> > >        ⚡ Internal infrastructure issues prevented one or more tests (marked
> > >        with ⚡⚡⚡) from running on this architecture.
> > >        This is not the fault of the kernel that was tested.
> > > 
> > >        ✅ Boot test
> > >        ⚡⚡⚡ LTP
> > >        ⚡⚡⚡ Loopdev Sanity
> > >        ⚡⚡⚡ Memory function: memfd_create
> > >        ⚡⚡⚡ AMTU (Abstract Machine Test Utility)
> > >        ⚡⚡⚡ Ethernet drivers sanity
> > >        🚧 ⚡⚡⚡ CIFS Connectathon
> > >        🚧 ⚡⚡⚡ POSIX pjd-fstest suites
> > > 
> > >   s390x:
> > >     Host 1:
> > >        ✅ Boot test
> > >        ✅ stress: stress-ng
> > >        🚧 ✅ Storage blktests
> > > 
> > >     Host 2:
> > >        ✅ Boot test
> > >        ✅ LTP
> > >        ✅ Loopdev Sanity
> > >        ✅ Memory function: memfd_create
> > >        ✅ AMTU (Abstract Machine Test Utility)
> > >        ✅ Ethernet drivers sanity
> > >        🚧 ✅ CIFS Connectathon
> > >        🚧 ✅ POSIX pjd-fstest suites
> > > 
> > >   x86_64:
> > >     Host 1:
> > >        ✅ Boot test
> > >        ✅ Storage SAN device stress - qedf driver
> > > 
> > >     Host 2:
> > >        ⏱  Boot test
> > >        ⏱  Storage SAN device stress - mpt3sas_gen1
> > > 
> > >     Host 3:
> > >        ✅ Boot test
> > >        ✅ xfstests - ext4
> > >        ✅ xfstests - xfs
> > >        💥 storage: software RAID testing
> > >        ⚡⚡⚡ stress: stress-ng
> > >        🚧 ⚡⚡⚡ xfstests - btrfs
> > >        🚧 ⚡⚡⚡ Storage blktests
> > > 
> > >     Host 4:
> > >        ✅ Boot test
> > >        ✅ Storage SAN device stress - lpfc driver
> > > 
> > >     Host 5:
> > >        ✅ Boot test
> > >        🚧 ✅ kdump - sysrq-c
> > > 
> > >     Host 6:
> > >        ✅ Boot test
> > >        ✅ ACPI table test
> > >        ✅ LTP
> > >        ✅ Loopdev Sanity
> > >        ✅ Memory function: memfd_create
> > >        ✅ AMTU (Abstract Machine Test Utility)
> > >        ✅ Ethernet drivers sanity
> > >        ✅ kernel-rt: rt_migrate_test
> > >        ✅ kernel-rt: rteval
> > >        ✅ kernel-rt: sched_deadline
> > >        ✅ kernel-rt: smidetect
> > >        ✅ storage: SCSI VPD
> > >        🚧 ✅ CIFS Connectathon
> > >        🚧 ✅ POSIX pjd-fstest suites
> > > 
> > >     Host 7:
> > >        ✅ Boot test
> > >        ✅ kdump - sysrq-c - megaraid_sas
> > > 
> > >     Host 8:
> > >        ✅ Boot test
> > >        ✅ Storage SAN device stress - qla2xxx driver
> > > 
> > >     Host 9:
> > >        ⏱  Boot test
> > >        ⏱  kdump - sysrq-c - mpt3sas_gen1
> > > 
> > >   Test sources: https://gitlab.com/cki-project/kernel-tests
> > 
> > Hello,
> > 
> 
> Hi Ming,
> 
> first the good news: Both issues detected by LTP and RAID test are
> officially gone after the revert. There's some x86_64 testing still
> running but the results look good so far!
> 
> > Can you share us the exact commands for setting up xfstests over
> > 'software RAID testing' from the above tree?
> > 
> 
> It's this test (which seeing your @redhat email, you can also trigger
> via internal Brew testing if you use the "stor" test set):
> 
> https://gitlab.com/cki-project/kernel-tests/-/tree/master/storage/swraid/trim
> 
> The important part of the test is:
> 
> https://gitlab.com/cki-project/kernel-tests/-/blob/master/storage/swraid/trim/main.sh#L27
> 
> The test maintainer (Changhui) is cced on this thread in case you need
> any help or have questions about the test.
> 
> 
> 
> I'll just quickly mention, please be careful if you're planning on
> testing LTP/msgstress04 on ppc64le in Beaker, as the conserver overload
> is causing issues to lab owners.
> 
> 
> Let us know if we can help you with something else,

I have verified the revised patches does fix kernel oops in 'software
RAID storage test'. However, I can't reproduce the OOM in LTP/msgstress04.

Could you help to check if LTP/msgstress04 can pass with the following
tree(top three patches) which is against the latest for-5.10/block:

	https://github.com/ming1/linux/commits/v5.9-rc-block-test

Thanks,
Ming

