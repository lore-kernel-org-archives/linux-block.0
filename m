Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8046224679C
	for <linux-block@vger.kernel.org>; Tue, 18 Aug 2026 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068025; cv=pass; b=CbFNPfk/X5qHBf2nw8mG7BQK65aEwELfAbaHkt3n2SrQd/3gemi2O6TVAOFc3AFQ1/xFlXbU566ChW9lmeLUCAoXWXnjGPKdef1yOcsejRzN1+VYteeaChZJB9NopHUErYkntsI5lG1TNhVL8e6af7uMIAig0b5PkazmQA79sM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068025; c=relaxed/simple;
	bh=c5szyuFMJHopzrGjnFlX5tjR67hJ6uVkkyOybn++L0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmxvRpwxozKB+3x0KtSwf8EQbVEusU4UrLPXziD9oWjOabfL3ovNYetDQ5hDX7sT1hot4Mq9s9eWtAbPOxpF0tDn3WQbKcFPXTQ4evgLUSDPP68c9dKUtOOwum4mON64VgJNSRD94CdyGFTzrK2cpY2cKGqeMz8AtJV0/lSGI0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aK+awCLJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dTKAllIo; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aK+awCLJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTKAllIo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787068023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AsCSNGPzbndZ95SIcRx5D7YwOIyG5mzlVNBUva1QMck=;
	b=aK+awCLJ4/kUgptnN+H2wU9vmao2UvpDZz2O5maBMGmAI4Nb1daVejMAU6KvqYjgStcCwQ
	dd/BKtWurduzjo+SZ9f4jBuaPgVp5sc/KoxWa7nhy+mTfqVAcfxjG38iJ5DX472vxodzHr
	j/GJd7nEZm1Hq8ieu3az3aHXBHkDVco=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-B4HHPXKYNDOvEeug6N3_aw-1; Tue, 18 Aug 2026 11:46:55 -0400
X-MC-Unique: B4HHPXKYNDOvEeug6N3_aw-1
X-Mimecast-MFC-AGG-ID: B4HHPXKYNDOvEeug6N3_aw_1787068014
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f6e658363so3033202f8f.3
        for <linux-block@vger.kernel.org>; Tue, 18 Aug 2026 08:46:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787068014; cv=none;
        d=google.com; s=arc-20260327;
        b=KdVmmvv4zPAEgLi2aeouRGXb7khdFv39/wGyq2edfUPeUF8oVLaIp/C4xv8+E/mJ1O
         NEoPVwsM8hagd2G5glMBfx7WzKYZHJm2CapretCscTEi2aIxue8XOqBZJqoE19mSUhvw
         kE8t1C8ka/UutzL62ovfU2vuqgPCn7uXXu7CBgBiHPsJ+khNktIPxs7ZJjkkBQcBfyCS
         uwRDnsk7QpUSPdgOlHoFXgSWD8nrPSgjOq23ymseSDY3H5pwOYuxUjA7aUpQ4f/Z9M3K
         Co0+0AbP550JA7dNxNhOQc78A/v+BU0E7PqzivOR1JEh2NCjldUec5S+K/IRFggEtl8S
         NCCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AsCSNGPzbndZ95SIcRx5D7YwOIyG5mzlVNBUva1QMck=;
        fh=Pw/ychRNAooBzKui/Jk9ssFo29jUtMBp3hgqp66ulHw=;
        b=BhfibyGjq9NKbnpY+dp8tATmSwot2qMFPCK9JblmUDq5BuiEDQpE78v0nm8JBrDMc/
         VXlF3CUiL7bJ1BrhkEFJKw6RGNjGgNT51/paCbHFG4rYpgpg1EZF+b/YhYpl20hnSTAr
         LObnCWIQKZdWBiIxAP1s9DIoBGcg4WVVtr3HcjbuB21Fye08OjCUUc48vpVBJN8EUvDg
         lZw1Dx4g++42dJWJ/LSrHpIEJm8ypJAvkw8dAdXZGgHEHVhiwIBbjHDPuIbwmV26zzqe
         FdLGvZyZQNLQm51lIIDvxmYctWIGoVlZtRiM5V6tJ7JAeI6xPd2CYmByZP405Q6cDFAI
         tTvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787068014; x=1787672814; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AsCSNGPzbndZ95SIcRx5D7YwOIyG5mzlVNBUva1QMck=;
        b=dTKAllIoXmNY0aWdVtnUvx1WmvYcYHfCAWArEZDHaNfdWuFEhQ0zsLJaAXAL9awoAB
         EnPAMnPUUL+N+DwqtrKvD/cM9ZQklBEetTCa9bj6Sfr8JwR4hXRri3vwFIwuJsOGBkig
         p+dtHy2UauP7SaoVwOe9TsVs9OWS1eDImVHKRnkT01WBRQ170doLjJPh/j+KnfYLu30T
         GHhj+pArbQKTGvQ/p/eYiGXZaazmXE0PS+cVQMlCbwqFmatgfxTek8ugJt3eIHl+0061
         zZqIXlFD+poCruc+LaQVCB5FTLXvWfSx6KlfReMebqjI64R51gKO2gVe5O4FYZpfi26s
         xBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787068014; x=1787672814;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AsCSNGPzbndZ95SIcRx5D7YwOIyG5mzlVNBUva1QMck=;
        b=T6SUQVf/fUk2ZvUWX2D+dVRCuFv1u9lvPa1eBXy5HRHY3uTaQw6VfcF97SojEZcqqH
         016Tvb1sdxnCrOm/4jdpMjPdXtfYn7yTd4JldCv7TnoWW7Uy7PBXileUJbRKY3+RWQqP
         tNTq0s4f52kyb0rcRM2pl3s9bx7bES+J6JocsIBHu3YnX/Lw/zLznea6+jaCz+iqu5I5
         ZTyUAgOa3hJ1u8v6BlbhzzmuIvFskpAG6gB0bpm/bQmXrKL5By02bvJP9peDoLqU5lqU
         cbt8xy91qySBb3ZDnxFMjvOYgtyhA2uujTqE9uLw4kSB3G01yAgGampQ2J27vOG1Mq46
         Zeww==
X-Gm-Message-State: AOJu0YzOBOE6no/8sPREfatLDf3YH8da2vAjn/kb4/Z4+9hGA1ppwpf0
	dWgrBW6mX2IwpigFNiWvtGnRmqWimeXQyjdK+kyKTO+1Gqhqc42GVNfZiOvaGeBBKyw0Zu7k+nV
	CH8jW8kb80fAywPoL5VPDAIBR17hPysW4UCaYYv8D6fQpGcESWWR8wHCcK95KdCqHUOw81TXQdc
	GNezdyORFmx9cXxqrxWVNWqwHgP8sYmvY/gcF8DLw=
X-Gm-Gg: AR+sD11XLeX9r75Hep2bVDr5yuLWRKxgSCZknRbthSy9AzF3dNbRGlIA0lAMfWlQxnX
	NjECe8cdIqAG8ScRX6DCm2EcyZXtM76hWOCY3ECW6ffgvwLleDClIcV7DCbLjwtPDQqrCDrADFE
	kBK7RvszXMnlwMQJA47iE+ePbWJ3gk+wae9gn5wbKa4dUz2j0qgiG9WrdMR+luIlUzXVtqFROTw
	L95EUiHvcAhKuW66A==
X-Received: by 2002:a05:6000:40c5:b0:482:aa0b:db55 with SMTP id ffacd0b85a97d-482aa0bdc7cmr15069111f8f.16.1787068013668;
        Tue, 18 Aug 2026 08:46:53 -0700 (PDT)
X-Received: by 2002:a05:6000:40c5:b0:482:aa0b:db55 with SMTP id
 ffacd0b85a97d-482aa0bdc7cmr15069018f8f.16.1787068013317; Tue, 18 Aug 2026
 08:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812174503.3705830-1-jtaubepe@redhat.com> <an75bRJc8J6NexeH@shinmob>
 <CADRr4beUeZo9ZA9TZVmWQ9Vegm2LvTXkW0wGNxYA6_7z_njMEA@mail.gmail.com>
 <aoK5sfNpxIUz7C02@shinhome> <CADRr4bfXLi_EbQzL_Z-a1VfZmr61H2pbGcLtc8A0Huigd0sOfw@mail.gmail.com>
 <aoRXbzorRVt0Ri4O@shinhome>
In-Reply-To: <aoRXbzorRVt0Ri4O@shinhome>
From: Jesse Taube <jtaubepe@redhat.com>
Date: Tue, 18 Aug 2026 11:46:42 -0400
X-Gm-Features: AcwNN1U-b8KYhh-RUCFS1X-HcFAQYZp79oKv4tW56WCr1i3jbw1Xqz0yDpdZFx8
Message-ID: <CADRr4bcab+iaS614Z6eL0kmiJefinU0X+6TzyThGYtmLfaezAw@mail.gmail.com>
Subject: Re: [PATCH blktests 0/2] Test multipath and marginal ports
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	John Meneghini <jmeneghi@redhat.com>, Daniel Wagner <dwagner@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 9:05=E2=80=AFAM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Aug 17, 2026 / 15:33, Jesse Taube wrote:
> > On Mon, Aug 17, 2026 at 3:39=E2=80=AFAM Shin'ichiro Kawasaki
> > <shinichiro.kawasaki@wdc.com> wrote:
> ...
> > > After I rebased to v7.2 kernel, it shows a bit different message:
> > >
> > > nvme/070 (tr=3Dfc) (test nvme-fc marginal path handling)       [faile=
d]
> > >     runtime  37.200s  ...  38.926s
> > >     --- tests/nvme/070.out      2026-08-17 11:13:53.073000000 +0900
> > >     +++ /home/shin/Blktests/blktests/results/nodev_tr_fc/nvme/070.out=
.bad       2026-08-17 16:34:17.997000000 +0900
> > >     @@ -3,10 +3,14 @@
> > >      Testing iopolicy: numa
> > >      Changing FC links to online
> > >      Set all online: pass
> > >     -One host marginal: pass
> > >     +FC port on (/sys/class/nvme-subsystem/nvme-subsys6/nvme6) is bei=
ng used, expected no use.
> > >     +One host marginal: fail
> > >      All marginal: pass
> > >     ...
> > >     (Run 'diff -u tests/nvme/070.out /home/shin/Blktests/blktests/res=
ults/nodev_tr_fc/nvme/070.out.bad' to see the entire diff)
> > >
> > > > Maybe the links are still connecting?
> > >
> > > Should I try to add some sleeps in the test script? If so, could you =
suggest
> > > where to put the sleeps?
> >
> > maybe add a delay before the cat command in _rport_in_use it might take=
 a second
> > for the io to move paths
>
> Thanks. I tried the patch below.
>
> diff --git a/tests/nvme/070 b/tests/nvme/070
> index 0672667..085ba70 100755
> --- a/tests/nvme/070
> +++ b/tests/nvme/070
> @@ -73,10 +73,16 @@ _rport_is_marginal() {
>
>  _rport_in_use() {
>         local SUBSYS_PATH=3D$1 # /sys/devices/virtual/nvme-subsystem/nvme=
-subsys3/nvme9
> +       local ret
>
>         # there should only be one "nvme3c9n1" afaik
>         [[ "$(cat "$SUBSYS_PATH"/nvme*/stat | awk '{print $9}')" !=3D "0"=
 ]]
>         # Returns exit code 0 if in use, 1 if not in use
> +       ret=3D$?
> +
> +       sleep 3
> +
> +       return $ret
>  }
>
>
> And I got this result:
>
> nvme/070 (tr=3Dfc) (test nvme-fc marginal path handling)       [failed]
>     runtime  34.657s  ...  224.569s
>     --- tests/nvme/070.out      2026-08-18 21:38:49.298000000 +0900
>     +++ /home/shin/Blktests/blktests/results/nodev_tr_fc/nvme/070.out.bad=
       2026-08-18 21:49:55.655000000 +0900
>     @@ -5,39 +5,66 @@
>      Set all online: pass
>      One host marginal: pass
>      All marginal: pass
>     -One remote non-optimized online: pass
>     -Two remote non-optimized online: pass
>     +FC port on (/sys/class/nvme-subsystem/nvme-subsys5/nvme7) is not bei=
ng used, expected use.
>     +One remote non-optimized online: fail
>     ...
>     (Run 'diff -u tests/nvme/070.out /home/shin/Blktests/blktests/results=
/nodev_tr_fc/nvme/070.out.bad' to see the entire diff)
>
>
> The result look a bit better (One host marginal: pass), but still I see o=
ther
> items fail.
>
> >
> > > If it helps, I will share the kernel config I use. If you want it, pl=
ease let
> > > me know.
> >
> > That would be good.
>
> Okay, please find the kernel config attached.
>
> > Im using the base centos10 config with
> > https://github.com/Mr-Bossman/linux/tree/dev/jesse/fpin_v11k
>
> Thanks, will try it out later.

No need to test i figured out the issue, it is a timeing thing. I will
send changes soon

Thanks,
Jesse Taube

