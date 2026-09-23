Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA6335E1AF
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182578; cv=none; b=brxaqGoqSV1a+Gv5BQIqravuWVhMNN0/cPgiI3VYXtN7ImwizW5twmhYRxI9YxAa7aTipEfFsIZ1ohYlKhytk66tvo96gBUDuvlQw1rBW9eW4GEwbotpwkRmJtbdva+F/JFXieHxtJjzi4aGXsmRGdRyhSn9qYWbPVWOHwYIUpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182578; c=relaxed/simple;
	bh=XbOiw2pmZ5xhtDDQ7MlRYt/PwLWmzdSI1818TRNlHUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uw5U/K0hEaH+LlaJtGuXqnf0uEprpnXOa5iLrcVBjfM9zeuz6evGJ1bw3ggmjeMG54kABp8N7rJmPOW9IQMvImSaZsWTZbOaqhRUy2x3eVbP+xjLATfwGjpr6sOX8ZC0ImKAOn69Uwc5apH5ILJyMUzV/s+HuhOTlLSD6Dgpac4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AqrXghZU; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AqrXghZU"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144e32aaa1cso711288c88.2
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 09:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1790182575; x=1790787375; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RnRXJjqFu493nRYesWPx7yxiLT97y0Yaul73jGm8VGs=;
        b=AqrXghZUoXuGRUZrXa1YX8EK+vZG5SJnGDsTgTf+6B+7uyO679BN+QGfMtfiKaNQ98
         3E02crLr42Mq/lqrUXyCpw8rmfYzUR/DzSy7NkZUZwtQWDJ1pBcTYfmqQc60lsibZzPe
         woqAg4qJZeuUvCF7MTrJOWglHB30h2k0tabfWEsIsAJG0RWODO/wT2Kmh7zyPxhUH+Ye
         rIJridoZBS7sr9HvhsxzUIAIAr3CLOpJ4i7leEOyxkcSjJtr+lZwfhFzg4LwaHxWs16M
         HjAtbwWSBQCSiACk+Xx0WykdixQgDHSaSbRq45wFEtO5ZGEafEOR+1FlODvTGS1JH4lr
         VWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790182575; x=1790787375;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RnRXJjqFu493nRYesWPx7yxiLT97y0Yaul73jGm8VGs=;
        b=lS2b97LCLwyUZy+eZWdzqdoE6sCaaWOR9lkK9LO38sp4ZO/UPP/4QVw/JEwG4BApCz
         0ytEpLzRNm31tjDild3QusM+LwnTMWuL4yotA8NrZKJoGZEvCpcK33H+MHe67JDf2jlK
         frqxthUJTP9vo8YIC+E+NE2XXR5bH5GVO02dNDcBLAKSEYK0VNOqkFSTl20QlZrvUofH
         +BxjZSVe5Xwn1MowiCZC7FNIzxfj+8XxM2+5f7jKAGQg1EElJhUMHMltWjp862aZxfd4
         Rje1c5IWbFUzqKnickW8jxYYLbYySBXW14V1gJjrP53YizaprViuPkYkqvhXxhsuF+R3
         FuaQ==
X-Gm-Message-State: AFuF++mCTwNGc45drPpUA6opNp//b6DuQvbMmGRjh9VV9bLwH4B+uGdf
	IYjVNn0f6dspDr19Vsz1DhegWXqrSQaXawl0AwSHuF7r9wOhbrznGqlM0BeebXAjfbc=
X-Gm-Gg: AYBFou20ZHap+90/ZlSa/keHgnrCpn2ztgYImjmgXyT714teZKQUkJvN+dmHnHsq6LE
	dHBjWY/mwtx+utIi9s6iTQDebeycDzWlsE4iLq+JikeOhCrXJ+A/CWr8fZifWy/S9ceKHNJcVF+
	HCMbLtLb5NGVssU7bK67+AdWCPuhUYUQeyizHWpxGEIoDNY551TSXCLsEl9cZxIrwyOT6jbzMmO
	fUa6qfMigi0WH27fbxylL9hlCwxdCWwm2ZupihZbDvXDUuAf1ia4eOTux/CGl9EKUSt1s6WGUli
	JKpcpdDTfC6VoMyUzfiPWVutMNFqXumsqfV2/QW5cx3uhdUvW+Txt48M2z/d5KW6Mx8xwVuIxu5
	Ta4ja1A6QzJoM7ZHH+kW3MeMupIO70rgYinZmIXmTTf8AaAyFZmGbtHJ1IkR1Uc824BwzCCvN9i
	+7FbLLQoT/seXCNRwPGNjrAPmdZYaqUKOxBhFQ6W6hyCFFgOMd9YON0rp9bFUWoZ8Bh4XzcH9By
	4LNZsv42//VAv9YfOI=
X-Received: by 2002:a05:701b:428b:20b0:143:4710:a88d with SMTP id a92af1059eb24-144f90a7013mr3686612c88.14.1790182574033;
        Wed, 23 Sep 2026 09:56:14 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-144f949e51asm7405955c88.1.2026.09.23.09.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 09:56:13 -0700 (PDT)
Date: Wed, 23 Sep 2026 09:56:12 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Jesse Taube <jtaubepe@redhat.com>
Cc: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	John Meneghini <jmeneghi@redhat.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>
Subject: Re: [PATCH blktests 5/5] nvme/070: test for ABA ghost writes on a
 multipath fabrics namespace
Message-ID: <20260923165612.GF2931-mkhalfella@purestorage.com>
References: <20260917020752.1672578-1-mkhalfella@purestorage.com>
 <20260917020752.1672578-6-mkhalfella@purestorage.com>
 <CADRr4bffEXo-0sjyCWYsBmH01miQ9uURqLYXuBHPk0bnV2Apkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADRr4bffEXo-0sjyCWYsBmH01miQ9uURqLYXuBHPk0bnV2Apkg@mail.gmail.com>

On Tue 2026-09-22 13:07:04 -0400, Jesse Taube wrote:
> On Wed, Sep 16, 2026 at 10:09 PM Mohamed Khalfella
> <mkhalfella@purestorage.com> wrote:
> >
> > An unacknowledged write that is retried on another path can still be
> > alive in the fabric. If it reaches the target after a later write to the
> > same LBA has landed, it overwrites it, and a read returns stale data.
> > Nothing in the tree exercises that window.
> >
> > Add a test that builds it deliberately. A ublk loop device backs an
> > nvmet namespace exported through two ports, and the host connects to
> > both, so nvme-multipath has a second path to fail over to. io_timeout on
> > the subsystem drops to 2 seconds, then miniublk's inject command holds
> > one write in the backstore for 4 seconds. The host times that write out,
> > retries it on the other path, and the held write completes at the target
> > afterwards.
> >
> > nvme-ghost-write-detector then writes distinct patterns to a single LBA
> > and reads the block back, so a resurfaced write shows up as the wrong
> > pattern.
> >
> > The test requires nvme_core.multipath=Y and a fabrics transport. As of
> > today it passes on loop, which defines no timeout callback and so never
> > times the write out and never retries it, and fails on tcp, rdma and fc.
> 
> Can you share a tcp or fc variant of this test that demonstrates failure?

Okay, will do that in next revision.

> 
> >
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> 
> Reviewed-by: Jesse Taube <jtaubepe@redhat.com>
> Tested-by: Jesse Taube <jtaubepe@redhat.com>

Thanks for testing and reviewing the change.

> 
> > ---
> >  tests/nvme/070     | 98 ++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/nvme/070.out | 35 +++++++++++++++++
> >  2 files changed, 133 insertions(+)
> >  create mode 100755 tests/nvme/070
> >  create mode 100644 tests/nvme/070.out
> 
> btw this needs to be bumped to 071 as 070 got added recently.

Noted.

> 
> Thanks,
> Jesse Taube
> 
> >
> > diff --git a/tests/nvme/070 b/tests/nvme/070
> > new file mode 100755
> > index 0000000..e9a4690
> > --- /dev/null
> > +++ b/tests/nvme/070
> > @@ -0,0 +1,98 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-3.0+
> > +# Copyright (C) 2026 Mohamed Khalfella
> > +
> > +. tests/nvme/rc
> > +. common/ublk
> > +
> > +DESCRIPTION="Test injecting delay on nvme-target backstore and expect no corruption"
> > +
> > +requires() {
> > +       _nvme_requires
> > +       _have_loop
> > +       _have_ublk
> > +       _have_module_param_value nvme_core multipath Y
> > +       _require_nvme_trtype_is_fabrics
> > +       _have_src_program nvme-ghost-write-detector
> > +}
> > +
> > +set_conditions() {
> > +       _set_nvme_trtype "$@"
> > +}
> > +
> > +count_paths_to_subsystem() {
> > +       local subsysnqn="$1"
> > +       local dev count
> > +
> > +       count=0
> > +       for dev in /sys/class/nvme/nvme*; do
> > +               [[ -e "${dev}/subsysnqn" ]] || continue
> > +               [[ "$(cat "${dev}/subsysnqn")" == "${subsysnqn}" ]] || continue
> > +               count=$(( count + 1 ))
> > +       done
> > +       echo "${count}"
> > +}
> > +
> > +set_io_timeout_of_subsystem() {
> > +       local subsysnqn="$1"
> > +       local timeout="$2"
> > +       local dev
> > +
> > +       for dev in /sys/class/nvme/nvme*; do
> > +               [[ -e "${dev}/subsysnqn" ]] || continue
> > +               [[ "$(cat "${dev}/subsysnqn")" == "${subsysnqn}" ]] || continue
> > +               if ! echo "${timeout}" > "${dev}/io_timeout" 2> /dev/null; then
> > +                       echo "FAIL: can not set io_timeout on ${dev##*/}"
> > +                       return 1
> > +               fi
> > +       done
> > +}
> > +
> > +test() {
> > +       echo "Running ${TEST_NAME}"
> > +
> > +       local ns port nr_paths
> > +       local -a ports
> > +
> > +       if ! _init_ublk; then
> > +               return 1
> > +       fi
> > +
> > +       truncate -s "${NVME_IMG_SIZE}" "${TMPDIR}/ublk-img"
> > +       if ! ${UBLK_PROG} add -t loop -f "${TMPDIR}/ublk-img" -n 0 > "$FULL" 2>&1; then
> > +               echo "fail to add ublk device"
> > +               _exit_ublk
> > +               return 1
> > +       fi
> > +       udevadm settle
> > +
> > +       _setup_nvmet
> > +       _nvmet_target_setup --ports 2 --blkdev none
> > +       _create_nvmet_ns --blkdev /dev/ublkb0 \
> > +               --uuid "${def_subsys_uuid}" > /dev/null
> > +
> > +       _get_nvmet_ports "${def_subsysnqn}" ports
> > +       echo "Target ports: ${#ports[@]}"
> > +       for port in "${ports[@]}"; do
> > +               _nvme_connect_subsys --port "${port}"
> > +       done
> > +
> > +       nr_paths=$(count_paths_to_subsystem "${def_subsysnqn}")
> > +       if ((  nr_paths != 2 )); then
> > +               echo "FAIL: expected 2 paths, found ${nr_paths}"
> > +       fi
> > +
> > +       set_io_timeout_of_subsystem "${def_subsysnqn}" 2000
> > +
> > +       if ! ${UBLK_PROG} inject -n 0 -o write -d 4 -c 1 >> "$FULL" 2>&1; then
> > +               echo "FAIL: can not inject write delay"
> > +       fi
> > +
> > +       ns=$(_find_nvme_ns "${def_subsys_uuid}")
> > +       "$SRCDIR/nvme-ghost-write-detector" "/dev/${ns}"
> > +
> > +       _nvme_disconnect_subsys
> > +       _nvmet_target_cleanup
> > +       _exit_ublk
> > +       echo "Test complete"
> > +}
> > diff --git a/tests/nvme/070.out b/tests/nvme/070.out
> > new file mode 100644
> > index 0000000..b43fec7
> > --- /dev/null
> > +++ b/tests/nvme/070.out
> > @@ -0,0 +1,35 @@
> > +Running nvme/070
> > +Target ports: 2
> > +starting nvme-ghost-write-detector test program
> > +iteration number 0, writing data
> > +validating written data
> > +successfully validated
> > +iteration number 1, writing data
> > +validating written data
> > +successfully validated
> > +iteration number 2, writing data
> > +validating written data
> > +successfully validated
> > +iteration number 3, writing data
> > +validating written data
> > +successfully validated
> > +iteration number 4, writing data
> > +validating written data
> > +successfully validated
> > +iteration number 5, writing data
> > +validating written data
> > +successfully validated
> > +iteration number 6, writing data
> > +validating written data
> > +successfully validated
> > +iteration number 7, writing data
> > +validating written data
> > +successfully validated
> > +iteration number 8, writing data
> > +validating written data
> > +successfully validated
> > +iteration number 9, writing data
> > +validating written data
> > +successfully validated
> > +finished nvme-ghost-write-detector test program
> > +Test complete
> > --
> > 2.55.0
> >
> 
