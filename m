Return-Path: <SRS0=BoNv=CN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BBEC43461
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 11:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43CE02087C
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 11:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbgIDLGx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Sep 2020 07:06:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35564 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726171AbgIDLGh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Sep 2020 07:06:37 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-NqmhaGTGO-KN6Ma-LGgdZw-1; Fri, 04 Sep 2020 07:06:26 -0400
X-MC-Unique: NqmhaGTGO-KN6Ma-LGgdZw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BE241DDE8;
        Fri,  4 Sep 2020 11:06:25 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 94C7D7FB80;
        Fri,  4 Sep 2020 11:06:25 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 853AA1832FC1;
        Fri,  4 Sep 2020 11:06:25 +0000 (UTC)
Date:   Fri, 4 Sep 2020 07:06:25 -0400 (EDT)
From:   Veronika Kabatova <vkabatov@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     CKI Project <cki-project@redhat.com>, linux-block@vger.kernel.org,
        Changhui Zhong <czhong@redhat.com>, axboe@kernel.dk
Message-ID: <491751.10128377.1599217585366.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200904010233.GA817918@T590>
References: <cki.538AE6A321.BMB0X5ZYG5@redhat.com> <20200904010233.GA817918@T590>
Subject: =?utf-8?Q?Re:_=F0=9F=92=A5_PANICKED:_Test_report_for=09k?=
 =?utf-8?Q?ernel_5.9.0-rc3-020ad03.cki_(block)?=
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.40.192.15, 10.4.195.8]
Thread-Topic: ? PANICKED: Test report for kernel 5.9.0-rc3-020ad03.cki (block)
Thread-Index: Ha2jgI6n/BnzVCm/HSupvpvlrqqssw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



----- Original Message -----
> From: "Ming Lei" <ming.lei@redhat.com>
> To: "CKI Project" <cki-project@redhat.com>
> Cc: linux-block@vger.kernel.org, axboe@kernel.dk, "Changhui Zhong" <czhong@redhat.com>
> Sent: Friday, September 4, 2020 3:02:33 AM
> Subject: Re: 💥 PANICKED: Test report for	kernel 5.9.0-rc3-020ad03.cki (block)
> 
> On Thu, Sep 03, 2020 at 05:07:57PM -0000, CKI Project wrote:
> > 
> > Hello,
> > 
> > We ran automated tests on a recent commit from this kernel tree:
> > 
> >        Kernel repo:
> >        https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> >             Commit: 020ad0333b03 - Merge branch 'for-5.10/block' into
> >             for-next
> > 
> > The results of these automated tests are provided below.
> > 
> >     Overall result: FAILED (see details below)
> >              Merge: OK
> >            Compile: OK
> >              Tests: PANICKED
> > 
> > All kernel binaries, config files, and logs are available for download
> > here:
> > 
> >   https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/09/02/613166
> > 
> > One or more kernel tests failed:
> > 
> >     ppc64le:
> >      💥 storage: software RAID testing
> > 
> >     aarch64:
> >      💥 storage: software RAID testing
> > 
> >     x86_64:
> >      💥 storage: software RAID testing
> > 
> > We hope that these logs can help you find the problem quickly. For the full
> > detail on our testing procedures, please scroll to the bottom of this
> > message.
> > 
> > Please reply to this email if you have any questions about the tests that
> > we
> > ran or if you have any suggestions on how to make future tests more
> > effective.
> > 
> >         ,-.   ,-.
> >        ( C ) ( K )  Continuous
> >         `-',-.`-'   Kernel
> >           ( I )     Integration
> >            `-'
> > ______________________________________________________________________________
> > 
> > Compile testing
> > ---------------
> > 
> > We compiled the kernel for 4 architectures:
> > 
> >     aarch64:
> >       make options: make -j30 INSTALL_MOD_STRIP=1 targz-pkg
> > 
> >     ppc64le:
> >       make options: make -j30 INSTALL_MOD_STRIP=1 targz-pkg
> > 
> >     s390x:
> >       make options: make -j30 INSTALL_MOD_STRIP=1 targz-pkg
> > 
> >     x86_64:
> >       make options: make -j30 INSTALL_MOD_STRIP=1 targz-pkg
> > 
> > 
> > 
> > Hardware testing
> > ----------------
> > We booted each kernel and ran the following tests:
> > 
> >   aarch64:
> >     Host 1:
> >        ✅ Boot test
> >        ✅ ACPI table test
> >        ✅ LTP
> >        ✅ Loopdev Sanity
> >        ✅ Memory function: memfd_create
> >        ✅ AMTU (Abstract Machine Test Utility)
> >        ✅ Ethernet drivers sanity
> >        ✅ storage: SCSI VPD
> >        🚧 ✅ CIFS Connectathon
> >        🚧 ✅ POSIX pjd-fstest suites
> > 
> >     Host 2:
> > 
> >        ⚡ Internal infrastructure issues prevented one or more tests (marked
> >        with ⚡⚡⚡) from running on this architecture.
> >        This is not the fault of the kernel that was tested.
> > 
> >        ⚡⚡⚡ Boot test
> >        ⚡⚡⚡ xfstests - ext4
> >        ⚡⚡⚡ xfstests - xfs
> >        ⚡⚡⚡ storage: software RAID testing
> >        ⚡⚡⚡ stress: stress-ng
> >        🚧 ⚡⚡⚡ xfstests - btrfs
> >        🚧 ⚡⚡⚡ Storage blktests
> > 
> >     Host 3:
> >        ✅ Boot test
> >        ✅ xfstests - ext4
> >        ✅ xfstests - xfs
> >        💥 storage: software RAID testing
> >        ⚡⚡⚡ stress: stress-ng
> >        🚧 ⚡⚡⚡ xfstests - btrfs
> >        🚧 ⚡⚡⚡ Storage blktests
> > 
> >   ppc64le:
> >     Host 1:
> >        ✅ Boot test
> >        🚧 ✅ kdump - sysrq-c
> > 
> >     Host 2:
> >        ✅ Boot test
> >        ✅ xfstests - ext4
> >        ✅ xfstests - xfs
> >        💥 storage: software RAID testing
> >        🚧 ⚡⚡⚡ xfstests - btrfs
> >        🚧 ⚡⚡⚡ Storage blktests
> > 
> >     Host 3:
> > 
> >        ⚡ Internal infrastructure issues prevented one or more tests (marked
> >        with ⚡⚡⚡) from running on this architecture.
> >        This is not the fault of the kernel that was tested.
> > 
> >        ✅ Boot test
> >        ⚡⚡⚡ LTP
> >        ⚡⚡⚡ Loopdev Sanity
> >        ⚡⚡⚡ Memory function: memfd_create
> >        ⚡⚡⚡ AMTU (Abstract Machine Test Utility)
> >        ⚡⚡⚡ Ethernet drivers sanity
> >        🚧 ⚡⚡⚡ CIFS Connectathon
> >        🚧 ⚡⚡⚡ POSIX pjd-fstest suites
> > 
> >   s390x:
> >     Host 1:
> >        ✅ Boot test
> >        ✅ stress: stress-ng
> >        🚧 ✅ Storage blktests
> > 
> >     Host 2:
> >        ✅ Boot test
> >        ✅ LTP
> >        ✅ Loopdev Sanity
> >        ✅ Memory function: memfd_create
> >        ✅ AMTU (Abstract Machine Test Utility)
> >        ✅ Ethernet drivers sanity
> >        🚧 ✅ CIFS Connectathon
> >        🚧 ✅ POSIX pjd-fstest suites
> > 
> >   x86_64:
> >     Host 1:
> >        ✅ Boot test
> >        ✅ Storage SAN device stress - qedf driver
> > 
> >     Host 2:
> >        ⏱  Boot test
> >        ⏱  Storage SAN device stress - mpt3sas_gen1
> > 
> >     Host 3:
> >        ✅ Boot test
> >        ✅ xfstests - ext4
> >        ✅ xfstests - xfs
> >        💥 storage: software RAID testing
> >        ⚡⚡⚡ stress: stress-ng
> >        🚧 ⚡⚡⚡ xfstests - btrfs
> >        🚧 ⚡⚡⚡ Storage blktests
> > 
> >     Host 4:
> >        ✅ Boot test
> >        ✅ Storage SAN device stress - lpfc driver
> > 
> >     Host 5:
> >        ✅ Boot test
> >        🚧 ✅ kdump - sysrq-c
> > 
> >     Host 6:
> >        ✅ Boot test
> >        ✅ ACPI table test
> >        ✅ LTP
> >        ✅ Loopdev Sanity
> >        ✅ Memory function: memfd_create
> >        ✅ AMTU (Abstract Machine Test Utility)
> >        ✅ Ethernet drivers sanity
> >        ✅ kernel-rt: rt_migrate_test
> >        ✅ kernel-rt: rteval
> >        ✅ kernel-rt: sched_deadline
> >        ✅ kernel-rt: smidetect
> >        ✅ storage: SCSI VPD
> >        🚧 ✅ CIFS Connectathon
> >        🚧 ✅ POSIX pjd-fstest suites
> > 
> >     Host 7:
> >        ✅ Boot test
> >        ✅ kdump - sysrq-c - megaraid_sas
> > 
> >     Host 8:
> >        ✅ Boot test
> >        ✅ Storage SAN device stress - qla2xxx driver
> > 
> >     Host 9:
> >        ⏱  Boot test
> >        ⏱  kdump - sysrq-c - mpt3sas_gen1
> > 
> >   Test sources: https://gitlab.com/cki-project/kernel-tests
> 
> Hello,
> 

Hi Ming,

first the good news: Both issues detected by LTP and RAID test are
officially gone after the revert. There's some x86_64 testing still
running but the results look good so far!

> Can you share us the exact commands for setting up xfstests over
> 'software RAID testing' from the above tree?
> 

It's this test (which seeing your @redhat email, you can also trigger
via internal Brew testing if you use the "stor" test set):

https://gitlab.com/cki-project/kernel-tests/-/tree/master/storage/swraid/trim

The important part of the test is:

https://gitlab.com/cki-project/kernel-tests/-/blob/master/storage/swraid/trim/main.sh#L27

The test maintainer (Changhui) is cced on this thread in case you need
any help or have questions about the test.



I'll just quickly mention, please be careful if you're planning on
testing LTP/msgstress04 on ppc64le in Beaker, as the conserver overload
is causing issues to lab owners.


Let us know if we can help you with something else,
Veronika

> BTW I can't reproduce it by running xfstest generic/551 on my simple raid10
> settings, include raid stop/remove steps.
> 
> Thanks,
> Ming
> 
> 

