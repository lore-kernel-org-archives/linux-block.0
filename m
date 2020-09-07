Return-Path: <SRS0=p3ox=CQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FDDC43461
	for <linux-block@archiver.kernel.org>; Mon,  7 Sep 2020 18:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D014321532
	for <linux-block@archiver.kernel.org>; Mon,  7 Sep 2020 18:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMrUmzEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgIGSuH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:50:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58838 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729289AbgIGSuG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Sep 2020 14:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599504603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1tIQjhIHoyYwt6/u/EeCEEvma/4vUXylFvb2lYH0GEc=;
        b=XMrUmzEQANsrjZ4TYcoAnRPHNv9hgxUrmz+WBQlLCpXHlHkQ8+Af+YMWoagDtmzfqFOYju
        cu/0r+cIK3eAEAaPmeozoeQEQ70/DWxbwX5/oEZRNHcDDwy61Ti4FVQ3JTAHwlugZHfASj
        dMw0f1fvNz6faQiZ54mm3r3k9jGOw30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-HahjjazCPTq_hTvbmPBp4A-1; Mon, 07 Sep 2020 14:50:00 -0400
X-MC-Unique: HahjjazCPTq_hTvbmPBp4A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DF6E1007461;
        Mon,  7 Sep 2020 18:49:59 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 16DF9277D3;
        Mon,  7 Sep 2020 18:49:59 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 04D7879A16;
        Mon,  7 Sep 2020 18:49:58 +0000 (UTC)
Date:   Mon, 7 Sep 2020 14:49:58 -0400 (EDT)
From:   Veronika Kabatova <vkabatov@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        CKI Project <cki-project@redhat.com>,
        Changhui Zhong <czhong@redhat.com>
Message-ID: <1786554325.10322949.1599504598742.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200906031908.GB894392@T590>
References: <cki.538AE6A321.BMB0X5ZYG5@redhat.com> <20200904010233.GA817918@T590> <491751.10128377.1599217585366.JavaMail.zimbra@redhat.com> <20200906031908.GB894392@T590>
Subject: =?utf-8?Q?Re:_=F0=9F=92=A5_PANICKED:_Test_report=09for_k?=
 =?utf-8?Q?ernel_5.9.0-rc3-020ad03.cki_(block)?=
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.40.192.148, 10.4.195.1]
Thread-Topic: ? PANICKED: Test report for kernel 5.9.0-rc3-020ad03.cki (block)
Thread-Index: Fnr66l2E8Tg6swWB6RPCcD1HF1IxBg==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



----- Original Message -----
> From: "Ming Lei" <ming.lei@redhat.com>
> To: "Veronika Kabatova" <vkabatov@redhat.com>
> Cc: linux-block@vger.kernel.org, axboe@kernel.dk, "CKI Project" <cki-proj=
ect@redhat.com>, "Changhui Zhong"
> <czhong@redhat.com>
> Sent: Sunday, September 6, 2020 5:19:08 AM
> Subject: Re: =F0=9F=92=A5 PANICKED: Test report=09for?kernel 5.9.0-rc3-02=
0ad03.cki (block)
>=20
> Hi Veronika,
>=20
> On Fri, Sep 04, 2020 at 07:06:25AM -0400, Veronika Kabatova wrote:
> >=20
> >=20
> > ----- Original Message -----
> > > From: "Ming Lei" <ming.lei@redhat.com>
> > > To: "CKI Project" <cki-project@redhat.com>
> > > Cc: linux-block@vger.kernel.org, axboe@kernel.dk, "Changhui Zhong"
> > > <czhong@redhat.com>
> > > Sent: Friday, September 4, 2020 3:02:33 AM
> > > Subject: Re: =F0=9F=92=A5 PANICKED: Test report for=09kernel 5.9.0-rc=
3-020ad03.cki
> > > (block)
> > >=20
> > > On Thu, Sep 03, 2020 at 05:07:57PM -0000, CKI Project wrote:
> > > >=20
> > > > Hello,
> > > >=20
> > > > We ran automated tests on a recent commit from this kernel tree:
> > > >=20
> > > >        Kernel repo:
> > > >        https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-=
block.git
> > > >             Commit: 020ad0333b03 - Merge branch 'for-5.10/block' in=
to
> > > >             for-next
> > > >=20
> > > > The results of these automated tests are provided below.
> > > >=20
> > > >     Overall result: FAILED (see details below)
> > > >              Merge: OK
> > > >            Compile: OK
> > > >              Tests: PANICKED
> > > >=20
> > > > All kernel binaries, config files, and logs are available for downl=
oad
> > > > here:
> > > >=20
> > > >   https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefi=
x=3Ddatawarehouse/2020/09/02/613166
> > > >=20
> > > > One or more kernel tests failed:
> > > >=20
> > > >     ppc64le:
> > > >      =F0=9F=92=A5 storage: software RAID testing
> > > >=20
> > > >     aarch64:
> > > >      =F0=9F=92=A5 storage: software RAID testing
> > > >=20
> > > >     x86_64:
> > > >      =F0=9F=92=A5 storage: software RAID testing
> > > >=20
> > > > We hope that these logs can help you find the problem quickly. For =
the
> > > > full
> > > > detail on our testing procedures, please scroll to the bottom of th=
is
> > > > message.
> > > >=20
> > > > Please reply to this email if you have any questions about the test=
s
> > > > that
> > > > we
> > > > ran or if you have any suggestions on how to make future tests more
> > > > effective.
> > > >=20
> > > >         ,-.   ,-.
> > > >        ( C ) ( K )  Continuous
> > > >         `-',-.`-'   Kernel
> > > >           ( I )     Integration
> > > >            `-'
> > > > ___________________________________________________________________=
___________
> > > >=20
> > > > Compile testing
> > > > ---------------
> > > >=20
> > > > We compiled the kernel for 4 architectures:
> > > >=20
> > > >     aarch64:
> > > >       make options: make -j30 INSTALL_MOD_STRIP=3D1 targz-pkg
> > > >=20
> > > >     ppc64le:
> > > >       make options: make -j30 INSTALL_MOD_STRIP=3D1 targz-pkg
> > > >=20
> > > >     s390x:
> > > >       make options: make -j30 INSTALL_MOD_STRIP=3D1 targz-pkg
> > > >=20
> > > >     x86_64:
> > > >       make options: make -j30 INSTALL_MOD_STRIP=3D1 targz-pkg
> > > >=20
> > > >=20
> > > >=20
> > > > Hardware testing
> > > > ----------------
> > > > We booted each kernel and ran the following tests:
> > > >=20
> > > >   aarch64:
> > > >     Host 1:
> > > >        =E2=9C=85 Boot test
> > > >        =E2=9C=85 ACPI table test
> > > >        =E2=9C=85 LTP
> > > >        =E2=9C=85 Loopdev Sanity
> > > >        =E2=9C=85 Memory function: memfd_create
> > > >        =E2=9C=85 AMTU (Abstract Machine Test Utility)
> > > >        =E2=9C=85 Ethernet drivers sanity
> > > >        =E2=9C=85 storage: SCSI VPD
> > > >        =F0=9F=9A=A7 =E2=9C=85 CIFS Connectathon
> > > >        =F0=9F=9A=A7 =E2=9C=85 POSIX pjd-fstest suites
> > > >=20
> > > >     Host 2:
> > > >=20
> > > >        =E2=9A=A1 Internal infrastructure issues prevented one or mo=
re tests
> > > >        (marked
> > > >        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this archi=
tecture.
> > > >        This is not the fault of the kernel that was tested.
> > > >=20
> > > >        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Boot test
> > > >        =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - ext4
> > > >        =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - xfs
> > > >        =E2=9A=A1=E2=9A=A1=E2=9A=A1 storage: software RAID testing
> > > >        =E2=9A=A1=E2=9A=A1=E2=9A=A1 stress: stress-ng
> > > >        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - btrfs
> > > >        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage blktests
> > > >=20
> > > >     Host 3:
> > > >        =E2=9C=85 Boot test
> > > >        =E2=9C=85 xfstests - ext4
> > > >        =E2=9C=85 xfstests - xfs
> > > >        =F0=9F=92=A5 storage: software RAID testing
> > > >        =E2=9A=A1=E2=9A=A1=E2=9A=A1 stress: stress-ng
> > > >        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - btrfs
> > > >        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage blktests
> > > >=20
> > > >   ppc64le:
> > > >     Host 1:
> > > >        =E2=9C=85 Boot test
> > > >        =F0=9F=9A=A7 =E2=9C=85 kdump - sysrq-c
> > > >=20
> > > >     Host 2:
> > > >        =E2=9C=85 Boot test
> > > >        =E2=9C=85 xfstests - ext4
> > > >        =E2=9C=85 xfstests - xfs
> > > >        =F0=9F=92=A5 storage: software RAID testing
> > > >        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - btrfs
> > > >        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage blktests
> > > >=20
> > > >     Host 3:
> > > >=20
> > > >        =E2=9A=A1 Internal infrastructure issues prevented one or mo=
re tests
> > > >        (marked
> > > >        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this archi=
tecture.
> > > >        This is not the fault of the kernel that was tested.
> > > >=20
> > > >        =E2=9C=85 Boot test
> > > >        =E2=9A=A1=E2=9A=A1=E2=9A=A1 LTP
> > > >        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Loopdev Sanity
> > > >        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory function: memfd_create
> > > >        =E2=9A=A1=E2=9A=A1=E2=9A=A1 AMTU (Abstract Machine Test Util=
ity)
> > > >        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Ethernet drivers sanity
> > > >        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 CIFS Connectathon
> > > >        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 POSIX pjd-fstest su=
ites
> > > >=20
> > > >   s390x:
> > > >     Host 1:
> > > >        =E2=9C=85 Boot test
> > > >        =E2=9C=85 stress: stress-ng
> > > >        =F0=9F=9A=A7 =E2=9C=85 Storage blktests
> > > >=20
> > > >     Host 2:
> > > >        =E2=9C=85 Boot test
> > > >        =E2=9C=85 LTP
> > > >        =E2=9C=85 Loopdev Sanity
> > > >        =E2=9C=85 Memory function: memfd_create
> > > >        =E2=9C=85 AMTU (Abstract Machine Test Utility)
> > > >        =E2=9C=85 Ethernet drivers sanity
> > > >        =F0=9F=9A=A7 =E2=9C=85 CIFS Connectathon
> > > >        =F0=9F=9A=A7 =E2=9C=85 POSIX pjd-fstest suites
> > > >=20
> > > >   x86_64:
> > > >     Host 1:
> > > >        =E2=9C=85 Boot test
> > > >        =E2=9C=85 Storage SAN device stress - qedf driver
> > > >=20
> > > >     Host 2:
> > > >        =E2=8F=B1  Boot test
> > > >        =E2=8F=B1  Storage SAN device stress - mpt3sas_gen1
> > > >=20
> > > >     Host 3:
> > > >        =E2=9C=85 Boot test
> > > >        =E2=9C=85 xfstests - ext4
> > > >        =E2=9C=85 xfstests - xfs
> > > >        =F0=9F=92=A5 storage: software RAID testing
> > > >        =E2=9A=A1=E2=9A=A1=E2=9A=A1 stress: stress-ng
> > > >        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - btrfs
> > > >        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage blktests
> > > >=20
> > > >     Host 4:
> > > >        =E2=9C=85 Boot test
> > > >        =E2=9C=85 Storage SAN device stress - lpfc driver
> > > >=20
> > > >     Host 5:
> > > >        =E2=9C=85 Boot test
> > > >        =F0=9F=9A=A7 =E2=9C=85 kdump - sysrq-c
> > > >=20
> > > >     Host 6:
> > > >        =E2=9C=85 Boot test
> > > >        =E2=9C=85 ACPI table test
> > > >        =E2=9C=85 LTP
> > > >        =E2=9C=85 Loopdev Sanity
> > > >        =E2=9C=85 Memory function: memfd_create
> > > >        =E2=9C=85 AMTU (Abstract Machine Test Utility)
> > > >        =E2=9C=85 Ethernet drivers sanity
> > > >        =E2=9C=85 kernel-rt: rt_migrate_test
> > > >        =E2=9C=85 kernel-rt: rteval
> > > >        =E2=9C=85 kernel-rt: sched_deadline
> > > >        =E2=9C=85 kernel-rt: smidetect
> > > >        =E2=9C=85 storage: SCSI VPD
> > > >        =F0=9F=9A=A7 =E2=9C=85 CIFS Connectathon
> > > >        =F0=9F=9A=A7 =E2=9C=85 POSIX pjd-fstest suites
> > > >=20
> > > >     Host 7:
> > > >        =E2=9C=85 Boot test
> > > >        =E2=9C=85 kdump - sysrq-c - megaraid_sas
> > > >=20
> > > >     Host 8:
> > > >        =E2=9C=85 Boot test
> > > >        =E2=9C=85 Storage SAN device stress - qla2xxx driver
> > > >=20
> > > >     Host 9:
> > > >        =E2=8F=B1  Boot test
> > > >        =E2=8F=B1  kdump - sysrq-c - mpt3sas_gen1
> > > >=20
> > > >   Test sources: https://gitlab.com/cki-project/kernel-tests
> > >=20
> > > Hello,
> > >=20
> >=20
> > Hi Ming,
> >=20
> > first the good news: Both issues detected by LTP and RAID test are
> > officially gone after the revert. There's some x86_64 testing still
> > running but the results look good so far!
> >=20
> > > Can you share us the exact commands for setting up xfstests over
> > > 'software RAID testing' from the above tree?
> > >=20
> >=20
> > It's this test (which seeing your @redhat email, you can also trigger
> > via internal Brew testing if you use the "stor" test set):
> >=20
> > https://gitlab.com/cki-project/kernel-tests/-/tree/master/storage/swrai=
d/trim
> >=20
> > The important part of the test is:
> >=20
> > https://gitlab.com/cki-project/kernel-tests/-/blob/master/storage/swrai=
d/trim/main.sh#L27
> >=20
> > The test maintainer (Changhui) is cced on this thread in case you need
> > any help or have questions about the test.
> >=20
> >=20
> >=20
> > I'll just quickly mention, please be careful if you're planning on
> > testing LTP/msgstress04 on ppc64le in Beaker, as the conserver overload
> > is causing issues to lab owners.
> >=20
> >=20
> > Let us know if we can help you with something else,
>=20
> I have verified the revised patches does fix kernel oops in 'software
> RAID storage test'. However, I can't reproduce the OOM in LTP/msgstress04=
.
>=20
> Could you help to check if LTP/msgstress04 can pass with the following
> tree(top three patches) which is against the latest for-5.10/block:
>=20
> =09https://github.com/ming1/linux/commits/v5.9-rc-block-test
>=20

Hi,

I ran the affected ppc64le testing with your new patches and it gives the
expected results.


We also got in touch with the LTP test maintainers. It looks like there are
some issues with the msgstress tests as well. These got amplified by the
patch and the combination caused the conserver overload. The tests
themselves need to be fixed too.

Veronika

> Thanks,
> Ming
>=20
>=20

