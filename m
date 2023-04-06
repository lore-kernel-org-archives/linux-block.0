Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB84C76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 10:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbjDFKaw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 06:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237265AbjDFKag (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 06:30:36 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD249000
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 03:30:12 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9AFE8582147;
        Thu,  6 Apr 2023 06:30:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 06 Apr 2023 06:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680777010; x=1680777610; bh=v3
        adLEUkmHzpa/+31E15ky0ON9PbkYEHPpncYGjhfwo=; b=ed34SO1+wavF2+UMC6
        ym0J1OI1ROZudag894CirtjX2uzU2CAiuSeunItfKtSZmkpXtcDO2+aISbQGpPXK
        BDLmS8ZO2LPd48WACRAAbYjVb4C6XeBsm7QrGgoyizgbMv23r6lSoiQ8bUAXqadb
        tjXY0CxGejF+wcuMIwt+BwNjcfiSdmx38OjUK/uN28mgsqjgwU/XroAYv1BiSev/
        l/P/tWGYE0bfcJ0EnWD5TrPy0UDtJDX2FEQjiM4j2MZBqcQWKebm/6kICcwwfFHQ
        NzMG/396xy/J02WIL5GTGgpceHqZjFjsqi0JhTe6lyaKI0mc0Cum4wWUGMhK4kNW
        1gHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=ie1e949a3.fm2; t=1680777010; x=1680777610; bh=v3a
        dLEUkmHzpa/+31E15ky0ON9PbkYEHPpncYGjhfwo=; b=EldqOZoIUebrWOEdrPB
        Hj7el7e3m8K7MW6jC3SPWW3RMUo/oAnxJgPAtgR1QMvheKkG/nYixgjpNTApQ3S1
        Nbx/uvEuzUZ3OIkkgCAUNw0lFqRN9eeyUBAzaOD4gzYPhnolR3e/hquVfNWN7Mzl
        DrkTXnMRey6cXWaTrslVibcFzNNZZl2prnnP6NMiuVSyK8f7J7JIAv6Dkv0atqkU
        /ZzMt9LFLyY/CMr29mpsU3O9MidkqSr/LVV62oKog6GeSc9KPgorfD/RY6SCbwTr
        v+IvAGIT1mhTF3R/s+7LXHCUBp69il2rDSiNA4AcYdzqOJ9jv0l8OAIj/l3lMSHN
        A0g==
X-ME-Sender: <xms:MZ8uZEVp1fTYW8otM3RwoVcyF1aTgryFQV-t1xsyWvsmPCXdZUF3TQ>
    <xme:MZ8uZInsAyU-kQbz3C84L2uGojQW-VoT_z7YZKXoCSJmPAlwKAkS9_Ihxoxi0acgJ
    LTHWGlp2JAIpSU10C8>
X-ME-Received: <xmr:MZ8uZIYk2xxtEAQ0t5GnfxXuNOaSfjGQY8gLmfwlQTNI6YiQ04S7NrV7cVtPR8Ph6NdfULZkSHHSnQUvDNf65A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejfedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefuhhhinhdkihgthhhirhhoucfmrgifrghsrghkihcuoehs
    hhhinhhitghhihhrohesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpe
    ekteelteevveejtdfhieevjeffgfduveehheegtdelieelleehueelueeutdelvdenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshhhihhnihgthhhirhhosehfrghsthhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:MZ8uZDVdilBftex-EXfCOBbIRcfj578u9De6J3mDfn0v3PeE6EHyFw>
    <xmx:MZ8uZOkRx7mh_iWXCLnVE5EU3XSTnAqGl_Fk4OzQD46R07ZUTWgn5Q>
    <xmx:MZ8uZIeSjAUPvXph2vmH4JisGv-3LvBKNSjFhjY6Nj99NS9bd69hbA>
    <xmx:Mp8uZPBM8bilWHpYzTooghhWQ_YblbihMmnfPOxzp_hGvn1GSwkNLNUNWuo>
Feedback-ID: ie1e949a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Apr 2023 06:30:07 -0400 (EDT)
Date:   Thu, 6 Apr 2023 19:30:03 +0900
From:   Shin'ichiro Kawasaki <shinichiro@fastmail.com>
To:     Alyssa Ross <hi@alyssa.is>
Cc:     chaitanyak@nvidia.com,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] loop/009: add test for loop partition uvents
Message-ID: <20230406103003.u5j7m6xqflcli7y2@shinhome>
References: <21c2861f-9b7d-636e-74e1-27bd7bbb1a4f@nvidia.com>
 <20230330160247.16030-1-hi@alyssa.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330160247.16030-1-hi@alyssa.is>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Alyssa, thanks for the patch and sorry for this late response.

Please find one comment in line. Other than that, this patch looks good to me.
I also ran the test case in my environment and confirmed that it passes with
the kernel fix. Good.

On Mar 30, 2023 / 16:02, Alyssa Ross wrote:
> Link: https://lore.kernel.org/r/20230320125430.55367-1-hch@lst.de/
> Suggested-by: Chaitanya Kulkarni <chaitanyak@nvidia.com>
> Signed-off-by: Alyssa Ross <hi@alyssa.is>
> ---
>  tests/loop/009     | 62 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/loop/009.out |  3 +++
>  2 files changed, 65 insertions(+)
>  create mode 100755 tests/loop/009
>  create mode 100644 tests/loop/009.out
> 
> diff --git a/tests/loop/009 b/tests/loop/009
> new file mode 100755
> index 0000000..dfa9de3
> --- /dev/null
> +++ b/tests/loop/009
> @@ -0,0 +1,62 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright 2023 Alyssa Ross
> +#
> +# Regression test for patch "loop: LOOP_CONFIGURE: send uevents for partitions".
> +
> +. tests/loop/rc
> +
> +DESCRIPTION="check that LOOP_CONFIGURE sends uevents for partitions"
> +
> +QUICK=1
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	# Make a disk image with a partition.
> +	truncate -s 3MiB "$TMPDIR/img"
> +	sfdisk "$TMPDIR/img" >"$FULL" <<EOF
> +label: gpt
> +size=1MiB
> +EOF
> +
> +	mkfifo "$TMPDIR/mon"
> +	timeout 5 udevadm monitor -ks block/partition >"$TMPDIR/mon" &
> +
> +	# Open the fifo for reading, and wait for udevadm monitor to start.
> +	exec 3< "$TMPDIR/mon"
> +	read -r _ <&3
> +	read -r _ <&3
> +	read -r _ <&3
> +
> +	dev="$(losetup -f)"
> +
> +	# The default udev behavior is to watch loop devices, which means that
> +	# udevd will explicitly prompt the kernel to rescan the partitions with
> +	# ioctl(BLKRRPART).  We want to make sure we're getting uevents from
> +	# ioctl(LOOP_CONFIGURE), so disable this udev behavior for our device to
> +	# avoid false positives.
> +	echo "ACTION!=\"remove\", KERNEL==\"${dev#/dev/}\", OPTIONS+=\"nowatch\"" \
> +		>/run/udev/rules.d/99-blktests-$$.rules

On Fedora Server 37, the line above prints a failure message because the
directory /run/udev/rules.d/ does not exist. To avoid it, I needed the change
below. I suggest to apply this change.

diff --git a/tests/loop/009 b/tests/loop/009
index dfa9de3..2b7a042 100755
--- a/tests/loop/009
+++ b/tests/loop/009
@@ -36,6 +36,7 @@ EOF
        # ioctl(BLKRRPART).  We want to make sure we're getting uevents from
        # ioctl(LOOP_CONFIGURE), so disable this udev behavior for our device to
        # avoid false positives.
+       [[ ! -d /run/udev/rules.d ]] && mkdir -p /run/udev/rules.d
        echo "ACTION!=\"remove\", KERNEL==\"${dev#/dev/}\", OPTIONS+=\"nowatch\"" \
                >/run/udev/rules.d/99-blktests-$$.rules
        udevadm control -R

> +	udevadm control -R
> +
> +	# Open and close the loop device for writing, to trigger the inotify
> +	# event udevd had already started listening for.
> +	: > "$dev"
> +
> +	# Wait for udev to have processed the inotify event.
> +	udevadm control --ping
> +
> +	losetup -P "$dev" "$TMPDIR/img"
> +
> +	# Wait for at most 1 add event so we don't need to wait for timeout if
> +	# we get what we're looking for.
> +	<&3 grep -m 1 '^KERNEL\[.*\] add' |
> +		sed -e 's/\[.*\]//' -e 's/loop[0-9]\+/loop_/g'
> +
> +	rm /run/udev/rules.d/99-blktests-$$.rules
> +	udevadm control -R
> +	losetup -d "$dev"
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/loop/009.out b/tests/loop/009.out
> new file mode 100644
> index 0000000..658dcff
> --- /dev/null
> +++ b/tests/loop/009.out
> @@ -0,0 +1,3 @@
> +Running loop/009
> +KERNEL add      /devices/virtual/block/loop_/loop_p1 (block)
> +Test complete
> -- 
> 2.37.1
> 
