Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C61356E05E
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096841; cv=pass; b=s0w+HUT/AKBTIrokipYyxTbZpTJoLGFBoFH/VfpCV77q8QIkd8FsiqSBsZmQRY9kO3Ojd9eAZfjGGMo4fkiG7RJVDCpMr+dip1nHBn1enb+vbJtgel90F0SkDhOaEaZkP4lPjpBEWroiZWseSO8NG/rHIguDc4a+HrW/j6QCtmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096841; c=relaxed/simple;
	bh=QcqZs0CfngnGUFnb9M1HXobtyUqW7390zC2QZAYupKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6m1Q3sP7JvleDFZ4gfxC33Gd6JzEvdLsBVXKt131P6wv0+j2bd4mOGPNpcVUSrUyK4mTGjdRSy0niLUClIee7vv3uruKfOLLhQYN87l2Lbik/qGkb8OB7dfHvy7XHwMLUFSMMtSsxF+vfUHf1lI7aGKQBpFJasuhZYrkEYMJ9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PjDxyzUZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OYCJ6gc2; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PjDxyzUZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OYCJ6gc2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790096838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ubro+jIAFnsWakSS77gHsPvo6tKKqzbfUk+fLBAP3g0=;
	b=PjDxyzUZ7ifHChGLiPEYaX1o5Sg7QweVOcNyf820j/5acHJDr8gOsKTF0461S0hJnfX//l
	ELV2emQYCWtiB7wKcnGc7c95UnXBzDhyihFspDOJm+UUgKk89C127l4/BBkgzWC6X/G1UB
	TlI309uJDi1Y8Fvbcf0bslsulVn9UOs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-SRpidsJYOeqYwQKV2MVGcQ-1; Tue, 22 Sep 2026 13:07:16 -0400
X-MC-Unique: SRpidsJYOeqYwQKV2MVGcQ-1
X-Mimecast-MFC-AGG-ID: SRpidsJYOeqYwQKV2MVGcQ_1790096835
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4886448d257so122068f8f.1
        for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 10:07:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790096835; cv=none;
        d=google.com; s=arc-20260327;
        b=g9qS+bUJaNHNcphubSA3ka/0Zb6CGRHKjNq7C2MXiftyF3WhS4mSc8himAoohI9ANZ
         u4b3GMk3TltAi6zKKBkM/6G0pgsvlsiJkTyOmD5VQ9s+WsR6DJe8y/XVYSaGmKKsRkd8
         hq4SoW4JhvCh5MlyYMPj6RmZNRfQlGaQRiCokM4MsGGWfva6yEyVwdZjTEhiXyGHyAF+
         bb2xuq7ZZx1/IPDyyAxCB73/UIwBu33YUyTmjzDvPjWmq+p6y30rlHwRtnjY7mUavRF2
         tCN3q9bvZEmQp6Zfv/MM2dC7EG/KPDQlP6IvPjFS9Sxn0EZOdmR3tYNAY/bjjL9MbvOu
         wpHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ubro+jIAFnsWakSS77gHsPvo6tKKqzbfUk+fLBAP3g0=;
        fh=uT0i16xmV8Z4H7vOfdiGNazh+ksHCbGw+anAkg2zjyM=;
        b=R6AV9HkGo53x6uPsT0N3msb7A15gnIg3FiEPYsCECHPls+KY2ULMATLDjfVGsTX5jc
         QTjwRKhscl5H+N50wtktaBliFFLSh6nxuiqHYPgdZbU7+y+rna2GOIDvbGDyHsyjZr0k
         8SqB1IPxIZW8dkmaNvcUYInxMno16E1RampAbfi2BlWgLCN7RTRKXGwidoH1SK5JLFps
         DIwd9yxBlzuVtVL3X6BoFHTXWQtomf9tY08xZTdsNIavwzhFnlg+eX2l6qq/mFmOPSu+
         FzsPSvhgsBKY+7dpeljNYcjQL/CUDGubXJ/CoQcm0sLygPTzj5S/iFWLorNIX2JVHNin
         LqqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790096835; x=1790701635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ubro+jIAFnsWakSS77gHsPvo6tKKqzbfUk+fLBAP3g0=;
        b=OYCJ6gc2c4WenFYoR1oEADlzyDozCHx4nD/vRKbDNSnn1no5Ir/nyYKbQ+j4tBqnBd
         OQTd/uTN6wvW9VnzPzNXUtLvpMM4UfAscJL25GI+RN7goyDrcC17AjX70HocZDnyGJAX
         onkZpBMJXz8X8Vhqb7nMbHXT5VDNpB/D6Z5cc0xwjkmp0RgSLiVQ2nurkyKhaOmzG83z
         VFzUXUwDIG2doMFQ6NGfkqGkpZpCB+/xr6SsoQJbkR21Ryx1xQwrgF8nTo0Itr/aFBUl
         8leTa/GsT8ALxuVjHQ1gxfnTgnEyEmE6i4/TfK/PY6l3kae8HhqzpGeE2XmxPMvQKMhU
         nGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790096835; x=1790701635;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ubro+jIAFnsWakSS77gHsPvo6tKKqzbfUk+fLBAP3g0=;
        b=Fq+DMCjFHiXziWYtQ4zNsMYPPDUN0nXxnkOWXGYj5n+bNq7EG4JedFeA3B0E2NDZ98
         mV+zwkA6yv72ZHoVQuWWEOlNRuLaK9yEPmsnrkFW0TvdGhfG0BdBJheQ8bv04wnYDPtA
         Ei2G69rI/TVS65ZXMp6ACE1e/bEBtQ17JJWbSNBGWhcvDsSdq7JwIXDxxSLQYxaqDXV/
         Je/q5w31R8fAaSl8HmO9Yk9dqswCjJjOb8oUXPk466fjMasudFSNvVn5jM/fsfGjmh/R
         WdEc0jUY5HJCOwGIrplitsJ+qGBBeX3xkj+ok2vsQIDcUNrp3YqIufcyf54BGMZ38ENc
         8KZg==
X-Gm-Message-State: AFuF++m2v2HxSlt0NKLexBtdlUQgGgpSRea+nqwcpznuw3JNZa+SM0ZD
	V+d5rj+4ONH2Hru0dZVKK/zHtwWHpmWWhd8E0oGJOP2ybHHsfu3uHPHfyg0G/aXdXp3jSDFpktq
	KrZyNWDxy0ba8FiAsueLrc+iCQBoZhBTqD58ZUu2AWaspPIdfUl8UitQuGs/EzHJeB2QmHtoLzK
	SYRkXQCumOOpDmjxkVW7LaekMNW1vZqNvu/4xscXQ=
X-Gm-Gg: AYBFou35ByqfpBxRpGdA7S0utnhSKuAPzAVZxJHANYm8Z5j9o/F+bK0m4S6Cr5DlGDB
	p0tNr+e8l4n3YOkH1Z6tv99qAd0VoehPM4EalybkXYpsJrFx9GxQ0WY2y2ymB1ccvztnHYhsZD5
	HJBBQUz3YwDfMsfONzWhmkjAMW3zeW3VImEiwI46MM2s30ZQJFrupMLdaQNcCcg7dQm77CwzFbn
	m6S+Er5Y6gU+RtfAg==
X-Received: by 2002:a05:6000:603:b0:487:106f:ee31 with SMTP id ffacd0b85a97d-4886708f075mr403701f8f.27.1790096835255;
        Tue, 22 Sep 2026 10:07:15 -0700 (PDT)
X-Received: by 2002:a05:6000:603:b0:487:106f:ee31 with SMTP id
 ffacd0b85a97d-4886708f075mr403667f8f.27.1790096834831; Tue, 22 Sep 2026
 10:07:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917020752.1672578-1-mkhalfella@purestorage.com> <20260917020752.1672578-6-mkhalfella@purestorage.com>
In-Reply-To: <20260917020752.1672578-6-mkhalfella@purestorage.com>
From: Jesse Taube <jtaubepe@redhat.com>
Date: Tue, 22 Sep 2026 13:07:04 -0400
X-Gm-Features: AclHuK_wSBiAnimxjVdRYj8rwEq2tUFRTzRomng-cGL662ILXA_dUsdeVzx8o5k
Message-ID: <CADRr4bffEXo-0sjyCWYsBmH01miQ9uURqLYXuBHPk0bnV2Apkg@mail.gmail.com>
Subject: Re: [PATCH blktests 5/5] nvme/070: test for ABA ghost writes on a
 multipath fabrics namespace
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, John Meneghini <jmeneghi@redhat.com>, 
	Randy Jennings <randyj@purestorage.com>, Dhaval Giani <dgiani@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 10:09=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> An unacknowledged write that is retried on another path can still be
> alive in the fabric. If it reaches the target after a later write to the
> same LBA has landed, it overwrites it, and a read returns stale data.
> Nothing in the tree exercises that window.
>
> Add a test that builds it deliberately. A ublk loop device backs an
> nvmet namespace exported through two ports, and the host connects to
> both, so nvme-multipath has a second path to fail over to. io_timeout on
> the subsystem drops to 2 seconds, then miniublk's inject command holds
> one write in the backstore for 4 seconds. The host times that write out,
> retries it on the other path, and the held write completes at the target
> afterwards.
>
> nvme-ghost-write-detector then writes distinct patterns to a single LBA
> and reads the block back, so a resurfaced write shows up as the wrong
> pattern.
>
> The test requires nvme_core.multipath=3DY and a fabrics transport. As of
> today it passes on loop, which defines no timeout callback and so never
> times the write out and never retries it, and fails on tcp, rdma and fc.

Can you share a tcp or fc variant of this test that demonstrates failure?

>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>

Reviewed-by: Jesse Taube <jtaubepe@redhat.com>
Tested-by: Jesse Taube <jtaubepe@redhat.com>

> ---
>  tests/nvme/070     | 98 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/070.out | 35 +++++++++++++++++
>  2 files changed, 133 insertions(+)
>  create mode 100755 tests/nvme/070
>  create mode 100644 tests/nvme/070.out

btw this needs to be bumped to 071 as 070 got added recently.

Thanks,
Jesse Taube

>
> diff --git a/tests/nvme/070 b/tests/nvme/070
> new file mode 100755
> index 0000000..e9a4690
> --- /dev/null
> +++ b/tests/nvme/070
> @@ -0,0 +1,98 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2026 Mohamed Khalfella
> +
> +. tests/nvme/rc
> +. common/ublk
> +
> +DESCRIPTION=3D"Test injecting delay on nvme-target backstore and expect =
no corruption"
> +
> +requires() {
> +       _nvme_requires
> +       _have_loop
> +       _have_ublk
> +       _have_module_param_value nvme_core multipath Y
> +       _require_nvme_trtype_is_fabrics
> +       _have_src_program nvme-ghost-write-detector
> +}
> +
> +set_conditions() {
> +       _set_nvme_trtype "$@"
> +}
> +
> +count_paths_to_subsystem() {
> +       local subsysnqn=3D"$1"
> +       local dev count
> +
> +       count=3D0
> +       for dev in /sys/class/nvme/nvme*; do
> +               [[ -e "${dev}/subsysnqn" ]] || continue
> +               [[ "$(cat "${dev}/subsysnqn")" =3D=3D "${subsysnqn}" ]] |=
| continue
> +               count=3D$(( count + 1 ))
> +       done
> +       echo "${count}"
> +}
> +
> +set_io_timeout_of_subsystem() {
> +       local subsysnqn=3D"$1"
> +       local timeout=3D"$2"
> +       local dev
> +
> +       for dev in /sys/class/nvme/nvme*; do
> +               [[ -e "${dev}/subsysnqn" ]] || continue
> +               [[ "$(cat "${dev}/subsysnqn")" =3D=3D "${subsysnqn}" ]] |=
| continue
> +               if ! echo "${timeout}" > "${dev}/io_timeout" 2> /dev/null=
; then
> +                       echo "FAIL: can not set io_timeout on ${dev##*/}"
> +                       return 1
> +               fi
> +       done
> +}
> +
> +test() {
> +       echo "Running ${TEST_NAME}"
> +
> +       local ns port nr_paths
> +       local -a ports
> +
> +       if ! _init_ublk; then
> +               return 1
> +       fi
> +
> +       truncate -s "${NVME_IMG_SIZE}" "${TMPDIR}/ublk-img"
> +       if ! ${UBLK_PROG} add -t loop -f "${TMPDIR}/ublk-img" -n 0 > "$FU=
LL" 2>&1; then
> +               echo "fail to add ublk device"
> +               _exit_ublk
> +               return 1
> +       fi
> +       udevadm settle
> +
> +       _setup_nvmet
> +       _nvmet_target_setup --ports 2 --blkdev none
> +       _create_nvmet_ns --blkdev /dev/ublkb0 \
> +               --uuid "${def_subsys_uuid}" > /dev/null
> +
> +       _get_nvmet_ports "${def_subsysnqn}" ports
> +       echo "Target ports: ${#ports[@]}"
> +       for port in "${ports[@]}"; do
> +               _nvme_connect_subsys --port "${port}"
> +       done
> +
> +       nr_paths=3D$(count_paths_to_subsystem "${def_subsysnqn}")
> +       if ((  nr_paths !=3D 2 )); then
> +               echo "FAIL: expected 2 paths, found ${nr_paths}"
> +       fi
> +
> +       set_io_timeout_of_subsystem "${def_subsysnqn}" 2000
> +
> +       if ! ${UBLK_PROG} inject -n 0 -o write -d 4 -c 1 >> "$FULL" 2>&1;=
 then
> +               echo "FAIL: can not inject write delay"
> +       fi
> +
> +       ns=3D$(_find_nvme_ns "${def_subsys_uuid}")
> +       "$SRCDIR/nvme-ghost-write-detector" "/dev/${ns}"
> +
> +       _nvme_disconnect_subsys
> +       _nvmet_target_cleanup
> +       _exit_ublk
> +       echo "Test complete"
> +}
> diff --git a/tests/nvme/070.out b/tests/nvme/070.out
> new file mode 100644
> index 0000000..b43fec7
> --- /dev/null
> +++ b/tests/nvme/070.out
> @@ -0,0 +1,35 @@
> +Running nvme/070
> +Target ports: 2
> +starting nvme-ghost-write-detector test program
> +iteration number 0, writing data
> +validating written data
> +successfully validated
> +iteration number 1, writing data
> +validating written data
> +successfully validated
> +iteration number 2, writing data
> +validating written data
> +successfully validated
> +iteration number 3, writing data
> +validating written data
> +successfully validated
> +iteration number 4, writing data
> +validating written data
> +successfully validated
> +iteration number 5, writing data
> +validating written data
> +successfully validated
> +iteration number 6, writing data
> +validating written data
> +successfully validated
> +iteration number 7, writing data
> +validating written data
> +successfully validated
> +iteration number 8, writing data
> +validating written data
> +successfully validated
> +iteration number 9, writing data
> +validating written data
> +successfully validated
> +finished nvme-ghost-write-detector test program
> +Test complete
> --
> 2.55.0
>

