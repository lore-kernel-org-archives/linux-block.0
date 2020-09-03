Return-Path: <SRS0=kdGS=CM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFE9C433E2
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 19:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A5D920897
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 19:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWR6XW3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgICT6b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Sep 2020 15:58:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60042 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728129AbgICT6a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Sep 2020 15:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599163108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KZLQloMCiho35IE/rpdZkmCn9jqQox9aBR3Qnu827JE=;
        b=AWR6XW3zdnz+XBE3/b3dacZOhHiM1aDAeoE9tHClAULoowYJDazJkz3pRJ0oj2hPHBz87E
        rfYJvn9ZX2lv/cFG/ONOdmw2n0IlTINCegUec1PikKXqgKeK5oez2/DW+5tA3RCXnCNs0L
        HxpjqyQYT35GNU3CerB8lvfD0lZkTwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-AOeP7mUlNiuJMLsCPqAZgg-1; Thu, 03 Sep 2020 15:58:11 -0400
X-MC-Unique: AOeP7mUlNiuJMLsCPqAZgg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 660A984E246;
        Thu,  3 Sep 2020 19:58:10 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EB041002D40;
        Thu,  3 Sep 2020 19:58:10 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 4DC261826D29;
        Thu,  3 Sep 2020 19:58:10 +0000 (UTC)
Date:   Thu, 3 Sep 2020 15:58:10 -0400 (EDT)
From:   Veronika Kabatova <vkabatov@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     CKI Project <cki-project@redhat.com>, linux-block@vger.kernel.org,
        Changhui Zhong <czhong@redhat.com>,
        Rachel Sibley <rasibley@redhat.com>
Message-ID: <1300213431.10047993.1599163090152.JavaMail.zimbra@redhat.com>
In-Reply-To: <ad1bf306-6f23-9b7c-842f-766a6efbda3e@redhat.com>
References: <cki.538AE6A321.BMB0X5ZYG5@redhat.com> <0f92c40e-b234-896c-0810-af36ee95e259@redhat.com> <18db2772-3f37-55a7-d92e-dbcbe92d2cc4@kernel.dk> <ad1bf306-6f23-9b7c-842f-766a6efbda3e@redhat.com>
Subject: =?utf-8?Q?Re:_=F0=9F=92=A5_PANICKED:_Test_report_for_k?=
 =?utf-8?Q?ernel_5.9.0-rc3-020ad03.cki_(block)?=
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.40.194.246, 10.4.195.18]
Thread-Topic: ? PANICKED: Test report for kernel 5.9.0-rc3-020ad03.cki (block)
Thread-Index: iumSQUXhmSuE2KdptaE90DdTUnu8jQ==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



----- Original Message -----
> From: "Rachel Sibley" <rasibley@redhat.com>
> To: "Jens Axboe" <axboe@kernel.dk>, "CKI Project" <cki-project@redhat.com=
>, linux-block@vger.kernel.org
> Cc: "Changhui Zhong" <czhong@redhat.com>
> Sent: Thursday, September 3, 2020 8:59:48 PM
> Subject: Re: =F0=9F=92=A5 PANICKED: Test report for kernel 5.9.0-rc3-020a=
d03.cki (block)
>=20
>=20
>=20
> On 9/3/20 1:46 PM, Jens Axboe wrote:
> > On 9/3/20 11:10 AM, Rachel Sibley wrote:
> >>
> >> On 9/3/20 1:07 PM, CKI Project wrote:
> >>>
> >>> Hello,
> >>>
> >>> We ran automated tests on a recent commit from this kernel tree:
> >>>
> >>>          Kernel repo:
> >>>          https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-=
block.git
> >>>               Commit: 020ad0333b03 - Merge branch 'for-5.10/block' in=
to
> >>>               for-next
> >>>
> >>> The results of these automated tests are provided below.
> >>>
> >>>       Overall result: FAILED (see details below)
> >>>                Merge: OK
> >>>              Compile: OK
> >>>                Tests: PANICKED
> >>>
> >>> All kernel binaries, config files, and logs are available for downloa=
d
> >>> here:
> >>>
> >>>     https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefi=
x=3Ddatawarehouse/2020/09/02/613166
> >>>
> >>> One or more kernel tests failed:
> >>>
> >>>       ppc64le:
> >>>        =F0=9F=92=A5 storage: software RAID testing
> >>>
> >>>       aarch64:
> >>>        =F0=9F=92=A5 storage: software RAID testing
> >>>
> >>>       x86_64:
> >>>        =F0=9F=92=A5 storage: software RAID testing
> >>
> >> Hello,
> >>
> >> We're seeing a panic for all non s390x arches triggered by swraid test=
.
> >> Seems to be reproducible
> >> for all succeeding pipelines after this one, and we haven't yet seen i=
t in
> >> mainline or yesterday's
> >> block tree results.
> >>
> >> Thank you,
> >> Rachel
> >>
> >> https://cki-artifacts.s3.us-east-2.amazonaws.com/datawarehouse/2020/09=
/02/613166/build_aarch64_redhat%3A968098/tests/8757835_aarch64_3_console.lo=
g
> >>
> >> [ 8394.609219] Internal error: Oops: 96000004 [#1] SMP
> >> [ 8394.614070] Modules linked in: raid0 loop raid456 async_raid6_recov
> >> async_memcpy async_pq async_xor async_tx dm_log_writes dm_flakey
> >> rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache
> >> rfkill sunrpc vfat fat xgene_hwmon xgene_enet at803x mdio_xgene xgene_=
rng
> >> xgene_edac mailbox_xgene_slimpro drm ip_tables xfs sdhci_of_arasan
> >> sdhci_pltfm i2c_xgene_slimpro crct10dif_ce sdhci gpio_dwapb cqhci
> >> xhci_plat_hcd
> >> gpio_xgene_sb gpio_keys aes_neon_bs
> >> [ 8394.654298] CPU: 3 PID: 471427 Comm: kworker/3:2 Kdump: loaded Not
> >> tainted 5.9.0-rc3-020ad03.cki #1
> >> [ 8394.663299] Hardware name: AppliedMicro X-Gene Mustang Board/X-Gene
> >> Mustang Board, BIOS 3.06.25 Oct 17 2016
> >> [ 8394.672999] Workqueue: md_misc mddev_delayed_delete
> >> [ 8394.677853] pstate: 40400085 (nZcv daIf +PAN -UAO BTYPE=3D--)
> >> [ 8394.683399] pc : percpu_ref_exit+0x5c/0xc8
> >> [ 8394.687473] lr : percpu_ref_exit+0x20/0xc8
> >> [ 8394.691547] sp : ffff800019f33d00
> >> [ 8394.694843] x29: ffff800019f33d00 x28: 0000000000000000
> >> [ 8394.700129] x27: ffff0003c63ae000 x26: ffff8000120b6228
> >> [ 8394.705414] x25: 0000000000000001 x24: ffff0003d8322a80
> >> [ 8394.710698] x23: 0000000000000000 x22: 0000000000000000
> >> [ 8394.715983] x21: 0000000000000000 x20: ffff8000121d2000
> >> [ 8394.721266] x19: ffff0003d8322af0 x18: 0000000000000000
> >> [ 8394.726550] x17: 0000000000000000 x16: 0000000000000000
> >> [ 8394.731834] x15: 0000000000000007 x14: 0000000000000003
> >> [ 8394.737119] x13: 0000000000000000 x12: ffff0003888a1978
> >> [ 8394.742403] x11: ffff0003888a1918 x10: 0000000000000001
> >> [ 8394.747688] x9 : 0000000000000000 x8 : 0000000000000000
> >> [ 8394.752972] x7 : 0000000000000400 x6 : 0000000000000001
> >> [ 8394.758257] x5 : ffff800010423030 x4 : ffff8000121d2e40
> >> [ 8394.763540] x3 : 0000000000000000 x2 : 0000000000000000
> >> [ 8394.768825] x1 : 0000000000000000 x0 : 0000000000000000
> >> [ 8394.774110] Call trace:
> >> [ 8394.776544]  percpu_ref_exit+0x5c/0xc8
> >> [ 8394.780273]  md_free+0x64/0xa0
> >> [ 8394.783311]  kobject_put+0x7c/0x218
> >> [ 8394.786781]  mddev_delayed_delete+0x3c/0x50
> >> [ 8394.790944]  process_one_work+0x1c4/0x450
> >> [ 8394.794932]  worker_thread+0x164/0x4a8
> >> [ 8394.798662]  kthread+0xf4/0x120
> >> [ 8394.801787]  ret_from_fork+0x10/0x18
> >> [ 8394.805344] Code: 2a0403e0 350002c0 a9400262 52800001 (f9400000)
> >> [ 8394.811407] ---[ end trace 481cab6e1ad73da1 ]---
> >=20
> > Ming, I wonder if this is:
> >=20
> > commit d0c567d60f3730b97050347ea806e1ee06445c78
> > Author: Ming Lei <ming.lei@redhat.com>
> > Date:   Wed Sep 2 20:26:42 2020 +0800
> >=20
> >      percpu_ref: reduce memory footprint of percpu_ref in fast path
> >=20
> > Rachel, any chance you can do a run with that commit reverted?
>=20
> Hi Jens, yes we're working on it and will share our findings as soon as t=
he
> job finishes.
>=20

Hi Jens, we can confirm that there are no panics and the test passes
with the patch reverted.


We also realized that this patch is a likely cause of serious problems
on ppc64le during LTP testing as well, specifically msgstress04. Both
issues started occurring at the same time, we just didn't notice as the
test was crashing.


[ 5682.999169] msgstress04 invoked oom-killer: gfp_mask=3D0x40cc0(GFP_KERNE=
L|__GFP_COMP), order=3D0, oom_score_adj=3D0=20
[ 5682.999981] CPU: 1 PID: 170909 Comm: msgstress04 Kdump: loaded Not taint=
ed 5.9.0-rc3-020ad03.cki #1=20
[ 5683.000048] Call Trace:=20
[ 5683.000098] [c00000023de972e0] [c000000000927e00] dump_stack+0xc4/0x114 =
(unreliable)=20
[ 5683.000161] [c00000023de97330] [c000000000386958] dump_header+0x64/0x274=
=20
[ 5683.000205] [c00000023de973c0] [c000000000385534] oom_kill_process+0x284=
/0x290=20
[ 5683.000259] [c00000023de97400] [c0000000003862b0] out_of_memory+0x220/0x=
790=20
[ 5683.000307] [c00000023de974a0] [c000000000408890] __alloc_pages_slowpath=
.constprop.0+0xd60/0xeb0=20
[ 5683.000370] [c00000023de97670] [c000000000408d20] __alloc_pages_nodemask=
+0x340/0x400=20
[ 5683.000426] [c00000023de97700] [c000000000434dec] alloc_pages_current+0x=
ac/0x130=20
[ 5683.000479] [c00000023de97750] [c000000000442fc4] allocate_slab+0x584/0x=
810=20
[ 5683.000525] [c00000023de977c0] [c000000000447e7c] ___slab_alloc+0x44c/0x=
a30=20
[ 5683.000571] [c00000023de978b0] [c000000000448494] __slab_alloc+0x34/0x60=
=20
[ 5683.000615] [c00000023de978e0] [c000000000448b48] kmem_cache_alloc+0x688=
/0x700=20
[ 5683.000671] [c00000023de97940] [c0000000003d9c80] __pud_alloc+0x70/0x1e0=
=20
[ 5683.000717] [c00000023de97990] [c0000000003ddbb4] copy_page_range+0x1204=
/0x1490=20
[ 5683.000779] [c00000023de97b20] [c00000000013b7c0] dup_mm+0x370/0x6e0=20
[ 5683.000826] [c00000023de97bd0] [c00000000013ce10] copy_process+0xd20/0x1=
950=20
[ 5683.000870] [c00000023de97c90] [c00000000013dc64] _do_fork+0xa4/0x560=20
[ 5683.000915] [c00000023de97d00] [c00000000013e24c] __do_sys_clone+0x7c/0x=
a0=20
[ 5683.000965] [c00000023de97dc0] [c00000000002f9a4] system_call_exception+=
0xe4/0x1c0=20
[ 5683.001019] [c00000023de97e20] [c00000000000d140] system_call_common+0xf=
0/0x27c=20

The test then manages the fill the console log with good 4G of dump...
this is actually visible in the ppc64le console log from the linked
artifacts (warnings, it's a huge file!):

https://cki-artifacts.s3.us-east-2.amazonaws.com/datawarehouse/2020/09/02/6=
13166/build_ppc64le_redhat%3A968099/tests/8757368_ppc64le_3_console.log


There are also more ppc64le traces in the other log (of reasonable size):
https://cki-artifacts.s3.us-east-2.amazonaws.com/datawarehouse/2020/09/02/6=
13166/build_ppc64le_redhat%3A968099/tests/8757337_ppc64le_2_console.log


Veronika

> >=20
>=20
>=20

