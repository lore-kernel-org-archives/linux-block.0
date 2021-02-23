Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4B1C433DB
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 13:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5EC564E60
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 13:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbhBWNc2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 08:32:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20190 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232926AbhBWNc1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 08:32:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614087060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eKnrZKkO9OgJe9WjsFxFVYra+9HHvyS8VQXGoux/I24=;
        b=QBZFQ5m2Me64ukoJodqOWMCqybAUwqWuZEdPzVx7u8HBRVzi2jHYK7P1mO9yawo/FY3ICv
        bOWoswicdx9RMbwVx4AtalTdV0YOCHj344bhT/MBYmus1R626482Q22cH4qVwqEQAAqFn/
        INhfJCkvbIIqr269XA50HSdjiQoL12s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-JC5Nz89-NOyy8kptdueHnw-1; Tue, 23 Feb 2021 08:30:57 -0500
X-MC-Unique: JC5Nz89-NOyy8kptdueHnw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 902EB1020C54;
        Tue, 23 Feb 2021 13:30:25 +0000 (UTC)
Received: from [172.20.9.196] (unknown [10.0.115.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B008614FF;
        Tue, 23 Feb 2021 13:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   CKI Project <cki-project@redhat.com>
To:     skt-results-master@redhat.com, linux-block@vger.kernel.org,
        axboe@kernel.dk
Subject: =?utf-8?b?4p2M?= FAIL: Test report for kernel 5.11.0 (block)
Date:   Tue, 23 Feb 2021 13:30:14 -0000
CC:     Memory Management <mm-qe@redhat.com>,
        Jianhong Yin <jiyin@redhat.com>, Zorro Lang <zlang@redhat.com>,
        Yi Zhang <yizhan@redhat.com>, Fine Fan <ffan@redhat.com>,
        Jeff Bastian <jbastian@redhat.com>,
        Xiong Zhou <xzhou@redhat.com>,
        Jan Stancek <jstancek@redhat.com>, Al Stone <ahs3@redhat.com>,
        Guangwu Zhang <guazhang@redhat.com>, Lin Li <lilin@redhat.com>,
        Marco Patalano <mpatalan@redhat.com>
Message-ID: <cki.1891A5313F.9U2FASPBG7@redhat.com>
X-Gitlab-Pipeline-ID: 624525
X-Gitlab-Url: https://xci32.lab.eng.rdu2.redhat.com
X-Gitlab-Path: /cki-project/cki-pipeline/pipelines/624525
X-DataWarehouse-Revision-IID: 10294
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hello,

We ran automated tests on a recent commit from this kernel tree:

       Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/lin=
ux-block.git
            Commit: 5c351b75f71a - Merge branch 'io_uring-worker.v3' into for=
-next

The results of these automated tests are provided below.

    Overall result: FAILED (see details below)
             Merge: OK
           Compile: OK
             Tests: FAILED

All kernel binaries, config files, and logs are available for download here:

  https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?prefi=
x=3Ddatawarehouse-public/2021/02/23/624525

One or more kernel tests failed:

    s390x:
     =E2=9D=8C Memory function: memfd_create
     =E2=9D=8C AMTU (Abstract Machine Test Utility)

    ppc64le:
     =E2=9D=8C storage: software RAID testing
     =E2=9D=8C LTP
     =E2=9D=8C Memory function: memfd_create
     =E2=9D=8C AMTU (Abstract Machine Test Utility)

    aarch64:
     =E2=9D=8C ACPI table test
     =E2=9D=8C Memory function: memfd_create
     =E2=9D=8C storage: SCSI VPD
     =E2=9D=8C storage: software RAID testing

    x86_64:
     =E2=9D=8C Storage SAN device stress - mpt3sas_gen1
     =E2=9D=8C storage: software RAID testing
     =E2=9D=8C Storage SAN device stress - lpfc driver
     =E2=9D=8C Storage SAN device stress - qedf driver
     =E2=9D=8C ACPI table test
     =E2=9D=8C Memory function: memfd_create
     =E2=9D=8C storage: SCSI VPD
     =E2=9D=8C Storage SAN device stress - qla2xxx driver

We hope that these logs can help you find the problem quickly. For the full
detail on our testing procedures, please scroll to the bottom of this message.

Please reply to this email if you have any questions about the tests that we
ran or if you have any suggestions on how to make future tests more effective.

        ,-.   ,-.
       ( C ) ( K )  Continuous
        `-',-.`-'   Kernel
          ( I )     Integration
           `-'
______________________________________________________________________________

Compile testing
---------------

We compiled the kernel for 4 architectures:

    aarch64:
      make options: make -j30 INSTALL_MOD_STRIP=3D1 targz-pkg

    ppc64le:
      make options: make -j30 INSTALL_MOD_STRIP=3D1 targz-pkg

    s390x:
      make options: make -j30 INSTALL_MOD_STRIP=3D1 targz-pkg

    x86_64:
      make options: make -j30 INSTALL_MOD_STRIP=3D1 targz-pkg



Hardware testing
----------------
We booted each kernel and ran the following tests:

  aarch64:
    Host 1:
       =E2=9C=85 Boot test
       =E2=9D=8C ACPI table test
       =E2=9C=85 LTP
       =E2=9C=85 Loopdev Sanity
       =E2=9C=85 Memory: fork_mem
       =E2=9D=8C Memory function: memfd_create
       =E2=9C=85 AMTU (Abstract Machine Test Utility)
       =E2=9D=8C storage: SCSI VPD
       =F0=9F=9A=A7 =E2=9D=8C CIFS Connectathon
       =F0=9F=9A=A7 =E2=9D=8C POSIX pjd-fstest suites
       =F0=9F=9A=A7 =E2=9C=85 Ethernet drivers sanity

    Host 2:
       =E2=9C=85 Boot test
       =E2=9D=8C storage: software RAID testing
       =F0=9F=9A=A7 =E2=9D=8C xfstests - ext4
       =F0=9F=9A=A7 =E2=9C=85 xfstests - xfs
       =F0=9F=9A=A7 =E2=9C=85 xfstests - btrfs
       =F0=9F=9A=A7 =E2=9D=8C Storage blktests
       =F0=9F=9A=A7 =E2=9C=85 Storage block - filesystem fio test
       =F0=9F=9A=A7 =E2=9C=85 Storage block - queue scheduler test
       =F0=9F=9A=A7 =E2=9C=85 Storage nvme - tcp
       =F0=9F=9A=A7 =E2=9C=85 Storage: swraid mdadm raid_module test
       =F0=9F=9A=A7 =E2=9D=8C stress: stress-ng

  ppc64le:
    Host 1:
       =E2=9C=85 Boot test
       =E2=9D=8C storage: software RAID testing
       =F0=9F=9A=A7 =E2=9D=8C xfstests - ext4
       =F0=9F=9A=A7 =E2=9C=85 xfstests - xfs
       =F0=9F=9A=A7 =E2=9C=85 xfstests - btrfs
       =F0=9F=9A=A7 =E2=9D=8C Storage blktests
       =F0=9F=9A=A7 =E2=9C=85 Storage block - filesystem fio test
       =F0=9F=9A=A7 =E2=9C=85 Storage block - queue scheduler test
       =F0=9F=9A=A7 =E2=9C=85 Storage nvme - tcp
       =F0=9F=9A=A7 =E2=9C=85 Storage: swraid mdadm raid_module test

    Host 2:
       =E2=9C=85 Boot test
       =E2=9D=8C LTP
       =E2=9C=85 Loopdev Sanity
       =E2=9C=85 Memory: fork_mem
       =E2=9D=8C Memory function: memfd_create
       =E2=9D=8C AMTU (Abstract Machine Test Utility)
       =F0=9F=9A=A7 =E2=9D=8C CIFS Connectathon
       =F0=9F=9A=A7 =E2=9D=8C POSIX pjd-fstest suites
       =F0=9F=9A=A7 =E2=9C=85 Ethernet drivers sanity

  s390x:
    Host 1:
       =E2=9C=85 Boot test
       =E2=9C=85 LTP
       =E2=9C=85 Loopdev Sanity
       =E2=9C=85 Memory: fork_mem
       =E2=9D=8C Memory function: memfd_create
       =E2=9D=8C AMTU (Abstract Machine Test Utility)
       =F0=9F=9A=A7 =E2=9D=8C CIFS Connectathon
       =F0=9F=9A=A7 =E2=9D=8C POSIX pjd-fstest suites
       =F0=9F=9A=A7 =E2=9C=85 Ethernet drivers sanity

    Host 2:
       =E2=9C=85 Boot test
       =F0=9F=9A=A7 =E2=9D=8C Storage blktests
       =F0=9F=9A=A7 =E2=9C=85 Storage nvme - tcp
       =F0=9F=9A=A7 =E2=9D=8C Storage: swraid mdadm raid_module test
       =F0=9F=9A=A7 =E2=9D=8C stress: stress-ng

  x86_64:
    Host 1:
       =E2=9C=85 Boot test
       =E2=9D=8C Storage SAN device stress - mpt3sas_gen1

    Host 2:
       =E2=9C=85 Boot test
       =E2=9D=8C storage: software RAID testing
       =F0=9F=9A=A7 =E2=9D=8C xfstests - ext4
       =F0=9F=9A=A7 =E2=9C=85 xfstests - xfs
       =F0=9F=9A=A7 =E2=9C=85 xfstests - btrfs
       =F0=9F=9A=A7 =E2=9C=85 xfstests - nfsv4.2
       =F0=9F=9A=A7 =E2=9C=85 xfstests - cifsv3.11
       =F0=9F=9A=A7 =E2=9D=8C Storage blktests
       =F0=9F=9A=A7 =E2=9C=85 Storage block - filesystem fio test
       =F0=9F=9A=A7 =E2=9C=85 Storage block - queue scheduler test
       =F0=9F=9A=A7 =E2=9C=85 Storage nvme - tcp
       =F0=9F=9A=A7 =E2=9C=85 Storage: swraid mdadm raid_module test
       =F0=9F=9A=A7 =E2=9D=8C stress: stress-ng

    Host 3:
       =E2=9C=85 Boot test
       =E2=9D=8C Storage SAN device stress - lpfc driver

    Host 4:
       =E2=9C=85 Boot test
       =E2=9D=8C Storage SAN device stress - qedf driver

    Host 5:
       =E2=9C=85 Boot test
       =E2=9D=8C ACPI table test
       =E2=9C=85 LTP
       =E2=9C=85 Loopdev Sanity
       =E2=9C=85 Memory: fork_mem
       =E2=9D=8C Memory function: memfd_create
       =E2=9C=85 AMTU (Abstract Machine Test Utility)
       =E2=9D=8C storage: SCSI VPD
       =F0=9F=9A=A7 =E2=9D=8C CIFS Connectathon
       =F0=9F=9A=A7 =E2=9D=8C POSIX pjd-fstest suites
       =F0=9F=9A=A7 =E2=9C=85 Ethernet drivers sanity

    Host 6:
       =E2=9C=85 Boot test
       =E2=9D=8C Storage SAN device stress - qla2xxx driver

  Test sources: https://gitlab.com/cki-project/kernel-tests
    =F0=9F=92=9A Pull requests are welcome for new tests or improvements to e=
xisting tests!

Aborted tests
-------------
Tests that didn't complete running successfully are marked with =E2=9A=A1=E2=
=9A=A1=E2=9A=A1.
If this was caused by an infrastructure issue, we try to mark that
explicitly in the report.

Waived tests
------------
If the test run included waived tests, they are marked with =F0=9F=9A=A7. Suc=
h tests are
executed but their results are not taken into account. Tests are waived when
their results are not reliable enough, e.g. when they're just introduced or a=
re
being fixed.

Testing timeout
---------------
We aim to provide a report within reasonable timeframe. Tests that haven't
finished running yet are marked with =E2=8F=B1.

