Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E041CD07
	for <linux-block@vger.kernel.org>; Wed, 20 Mar 2024 06:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710915157; cv=none; b=VZvaiAF9cHaL4XImQPc0l+OvH5sknMr4PDAUqinhVYRJUED9rbGZlPU9Ay6axjqPxY06nOHkLtAHKU394Vr+xvu5XB3/IkorY5MDWAq6fjqPhis0zqcwzknn3TASQD4NnYDPEmEaPWZYWSkHFnoxpY3pAU/S5cKQSV8dW9EZMV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710915157; c=relaxed/simple;
	bh=PAlzpOmPHhJQkzIkjyKQW2X0ghWZHjtukXp/5NQquI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMkpMB3hDQXxm9TwHv89VnUN+H9HziZGz1Cz7WdvcMUNhbErL3einp6GR7RFM/09btyOX6Qk72KePR+eFX31wCxsxq3g5RemzKeEG/jI+wuj8b9m7RBL7u3rFdNYefLCZ4Htksg6ZvoL8CmRQ9gRSqVoMhZrMDb343bbdUzAe8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jBOhE101; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBOhE101"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710915154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tOt1VMPLZYO5tSSJqFsSyTEHCMG43Tcfx3+OESpeYlg=;
	b=jBOhE101J5AaeEYuYa6JZvKF/MQgDnOO/ZCa7w8oHRA5+Sj1RFKBGoTpgSfiH7FmrtdRSh
	XKbkYFHsmKBCfxSiFmTkVdILozHCCjBT1fUo2DEwdSH64wBNvobXCyTwqgcm7TKttdM5NQ
	7MjgTxN80VJsEoduU4piR8LTP7YcPSg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-2y5s5kfaMXmw2iguWDy3IQ-1; Wed, 20 Mar 2024 02:12:31 -0400
X-MC-Unique: 2y5s5kfaMXmw2iguWDy3IQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29df180bedcso4186257a91.3
        for <linux-block@vger.kernel.org>; Tue, 19 Mar 2024 23:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710915150; x=1711519950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOt1VMPLZYO5tSSJqFsSyTEHCMG43Tcfx3+OESpeYlg=;
        b=AibzoBL1c4mrDPkFt0qzoTAqIs7+k8+taXLfLzS7SivE+43QX4dDdHXzfwvg5x8j7j
         wQY3ptehrWlGvrNnAg7HJT63zQzg/Y2KLrIBoxlaXQlsSSKLetDOipuyeHGEnGiA0tCP
         s/S8xMnyKrp/AAos5qKM21BEUaiuXxwCJWjpQQFWdbG2R2dJVok3awqets9vuMARxA8s
         gUOggeWRvaSRaG6+U8Pk4lqcMtHoip1sIxJGTieiK18fkt/K/NGBwxdUGM83q6xTpk2s
         xjm71yjItd+rMQXmBaZiYDbvq84vuRIBM6UrpLJuc3T4lCdEoj1rOX1abjG694UyTKj6
         sdnw==
X-Gm-Message-State: AOJu0YyHplsWJSdDDtcv92EQkFSbumq3RIP1k3HOtIqRBeFcs27hus2i
	y5yCfYnKxg6RhDGfpp6B6I0gNLbQFVA6a6fFLdOg7Vf2NDKQMglzZfe9mQfSR9Mh7LkGHvXdMSb
	0TUNxzJgKEoUTQpp5X37oJ5C6eUFA0XmjBa+5Ac8/QKVU4/tMXJhqSSx4CeZOL0CnkehYjBVLwl
	DvpgOsXK7XCSmWiLjQZdtJh3q/wiG55/EF3dcAhh8hTm9sbl0HHjs=
X-Received: by 2002:a17:90b:314:b0:29d:fefa:258d with SMTP id ay20-20020a17090b031400b0029dfefa258dmr1063207pjb.2.1710915149815;
        Tue, 19 Mar 2024 23:12:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWeQ01gLM51NigHHGFW1PDJ7PILlwZy435IzaruK18tTgVs16+TKPhFyh55Q8DGjMSQthHtUL/+A9PEMamVxo=
X-Received: by 2002:a17:90b:314:b0:29d:fefa:258d with SMTP id
 ay20-20020a17090b031400b0029dfefa258dmr1063200pjb.2.1710915149439; Tue, 19
 Mar 2024 23:12:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319085015.3901051-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240319085015.3901051-1-shinichiro.kawasaki@wdc.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 20 Mar 2024 14:12:17 +0800
Message-ID: <CAHj4cs_Z_qsiAtDgX9ZK=tXmF9CJXCtXYL5qMWWhQvrAdmTRXg@mail.gmail.com>
Subject: Re: [PATCH blktests] nbd/rc: check nbd connection with nbd-client
 -check command
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shinichiro

Thanks for the fix, with this change, the issue still can be
reproduced, here is the log:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D98
nbd/002 (tests on partition handling for an nbd device)      [failed]
    runtime  1.436s  ...  0.917s
    --- tests/nbd/002.out 2024-03-19 04:51:34.051614893 +0100
    +++ /root/blktests/results/nodev/nbd/002.out.bad 2024-03-20
07:01:28.769392087 +0100
    @@ -1,4 +1,4 @@
     Running nbd/002
     Testing IOCTL path
     Testing the netlink path
    -Test complete
    +Didn't have partition on the netlink path

dmesg:
[  737.405376] run blktests nbd/002 at 2024-03-20 07:01:27
[  738.102997] nbd0: detected capacity change from 0 to 20971520
[  738.122439]  nbd0:
[  738.157483] block nbd0: NBD_DISCONNECT
[  738.157742] block nbd0: Disconnected due to user request.
[  738.158094] block nbd0: shutting down sockets
[  738.206999] nbd0: detected capacity change from 0 to 20971520
[  738.208587]  nbd0: p1
[  738.246641] block nbd0: NBD_DISCONNECT
[  738.246893] block nbd0: Disconnected due to user request.
[  738.247217] block nbd0: shutting down sockets
[  738.313979] nbd0: detected capacity change from 0 to 20971520
[  738.315450]  nbd0: p1
[  738.319949] block nbd0: NBD_DISCONNECT
[  738.320244] block nbd0: Disconnected due to user request.
[  738.320535] block nbd0: shutting down sockets
[  738.321276] blk_print_req_error: 4 callbacks suppressed
[  738.321280] I/O error, dev nbd0, sector 272 op 0x0:(READ) flags
0x80700 phys_seg 30 prio class 0
[  738.322466] I/O error, dev nbd0, sector 272 op 0x0:(READ) flags 0x0
phys_seg 1 prio class 0
[  738.322901] buffer_io_error: 4 callbacks suppressed
[  738.322903] Buffer I/O error on dev nbd0, logical block 34, async page r=
ead
[  738.326007] I/O error, dev nbd0, sector 16 op 0x0:(READ) flags
0x80700 phys_seg 1 prio class 0
[  738.326916] I/O error, dev nbd0, sector 16 op 0x0:(READ) flags 0x0
phys_seg 1 prio class 0
[  738.327381] Buffer I/O error on dev nbd0, logical block 2, async page re=
ad

On Tue, Mar 19, 2024 at 4:50=E2=80=AFPM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> _wait_for_nbd_connect() checks nbd connections by checking the existence
> of a debugfs attribute file. However, even when the file exists, nbd
> connections are not fully ready, and the stat command for the nbd device
> file in the test case nbd/002 may fail with unexpected I/O errors.
>
> To avoid the failure, check the nbd connections not only by the debugfs
> attribute file, but also by "nbd-client -check" command.
>
> Link: https://github.com/osandov/blktests/pull/134
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  tests/nbd/rc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tests/nbd/rc b/tests/nbd/rc
> index 9c1c15b..266befd 100644
> --- a/tests/nbd/rc
> +++ b/tests/nbd/rc
> @@ -43,7 +43,8 @@ _have_nbd_netlink() {
>
>  _wait_for_nbd_connect() {
>         for ((i =3D 0; i < 3; i++)); do
> -               if [[ -e /sys/kernel/debug/nbd/nbd0/tasks ]]; then
> +               if [[ -e /sys/kernel/debug/nbd/nbd0/tasks ]] && \
> +                          nbd-client -check /dev/nbd0 &> /dev/null; then
>                         return 0
>                 fi
>                 sleep 1
> --
> 2.44.0
>


--=20
Best Regards,
  Yi Zhang

