Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23611C5D5E
	for <linux-block@vger.kernel.org>; Tue, 10 Feb 2026 13:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770728778; cv=pass; b=P0gGNqHL4iDLiqXK4yhbKnyRZk/DH2JV2Ug9yRSqKtxS4tyCNC58TBsODlO1Ym3Z0H88EHZkwPao9+DhzqV8W/pz9krt+HWTVgXqx58a1NMdGcPyoa/OAOjyDG6XFsPj0qbvGr3eM6npQ4IFB8RmR9NKYJ0vAXUfYfAAjt6ctzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770728778; c=relaxed/simple;
	bh=tKKflX7Rz4JWnv5PjiBbOzo/+w+GPNfiDr34Wg4t8es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghRtRxWnK7qoySR/kDRZupZ6qwq1zsaxpH9/31h3r/oDwggaM4uHnl0wxtxjXlpBkYdOT0Q2s4EvDeORSlxrjZj/qc706BDvbjtek6arjbPDPIaqYxRmeMyLHw93On5dxDAEVwVADu0cXASCZr57BAttITSLvn86yHzFE5A124Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=FsVHw0uh; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="FsVHw0uh"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59dcdf60427so833399e87.3
        for <linux-block@vger.kernel.org>; Tue, 10 Feb 2026 05:06:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770728775; cv=none;
        d=google.com; s=arc-20240605;
        b=eAH13f4Xx1/cnVlmsI9BolAnIx67KwMSmMPSgZqkixr1xzXIMl8R+VpmzEgWsSBagG
         3JpnWI+y/cWu3wOIyvUYYWGh2NPOy+ieVOECTTUUbP06f+q3cMnosjblDDG1nZ52+uJ9
         LsBznUWJU6bwLEwAer5z1tPREdjQKtpCMU4QQ+YN5QNTyKlTzfijAxYKLzSXSEmwbah9
         yqcE44HzP93N//fs67xDsVLdMlDgROk7W8TjSiisUWtDvW7dn5mPOrfU6+xncHt01CT1
         yvGbfFCNj2kk1UFZwCtOX4oYSzqsPmWWiQnYYVPk9CoABcfjmpQaU6LkKDhZFTQeBP6C
         awnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=plVXPWjzCMqeqx/6f6uf+ojw3XX37djb3js/Sz/RBAM=;
        fh=7CHz1ubEjdy7SOEGP8ZmanLs21QWXepcLCmM2KmcNp4=;
        b=jnHIJmJZwSW7nngNmzJ5mO0ZvlqnDQs/Y2L2nKruo/IdBiQa88IVdZRfcTh6qr6Pf3
         3jqXqEN3Ns6wWKBUguiA1eZ2FzoldgKHu9gDAnEhzAayckqcXvYDGAohU4TdNC4wgjNv
         bzlmbju2DN5vjTQtQoqLjb1YmoJNpgkL/5RVhYbG3r9sKW6E9NGYG83Esn/usCuHjg/Q
         +0lSULgVvRGEsAvbVkbIyp8+Enbwpe5FGkkCmK+hEX7rMEHWfZFkFa6MWrGWNlx84JUi
         uT6zUnNsrsvmGw3S/ZCYumi1fqGx8dimEAX/IjutkkJGhSWsIxrN4kPK5eylAjVIZljB
         K1xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1770728775; x=1771333575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plVXPWjzCMqeqx/6f6uf+ojw3XX37djb3js/Sz/RBAM=;
        b=FsVHw0uhdtQ7zE7ffQwWlGQTTGzHUajHJZM9tCW+v/v+p1mqushoNVM5u7y7wANchW
         XutV4XErnKqrFpXEVADYTCQqlnOPHGAVYzFiVdhMFHH52THTELPrxRJeSFh6evcNNqbT
         cyIeCCu0Wtnyqz2gIiHtlEhB4H4GRnDkz8hCP2ElKwdUKX7ml1ANM+ALEBMsCnVuGAgB
         bnkmzlhWr5WP7IsBJq1r7nYxSCTvu9pwfvZYnxNzuE7izTUkrK/nNjQv4QSCZ1+oHHdq
         AwUdD4Dl3pwwCFNYNNCd+k7aVKXjG6NtMDWOc7QveGgDusPcdQZwW9LIjJ+jWbvvuelG
         qS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770728775; x=1771333575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=plVXPWjzCMqeqx/6f6uf+ojw3XX37djb3js/Sz/RBAM=;
        b=UrAsTddLv14QidnZ3quWnU02PPZBWN1AQuC2LcCkh/UEtBPDcAFc6ZBjhwUG4UbzPm
         buVnROmrU9hPqzaj63LdsMlRwgopw0+XuUc1WqGebCkE+WjbEE3UeUc/HguSUCT/Aitx
         USvKMz99QX1ZPfAM/oZOE/Htb/Vl+DT6hVkLgH+QTrzPukNVeTkzEwVZ6sgjkTGf8xr7
         WRnKnWefk/8kfrpfhBIAIAMNFkI10pNGwAUjs1VORiEgHBUnO2Sk4VnAhUV40rYV+hwl
         4cPtIz3cXG7Urnom2mn+iYRg39MJO0Ein9qI2tPvRPsLr9JHJHhqrlZJcoCvRGMtRfEZ
         g+og==
X-Forwarded-Encrypted: i=1; AJvYcCW/tdKlkf+LaHN2eS8EPuiYomCs7xob+nfGf3LE1on17vlbChoAw4tcf9LGZt+uPKhkiOQmRrCOe6yWuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOMfdAWjmxCVzqlxzj0x/zOrRSfZNVbIT6g50eluSVDmr9eZeK
	ZPX/BGAubwGYz0AX6ROSmMxx4zgsqyEobO4roOvWuSKP6iq5F5UhT7a+OngtANuBs6bfvta4aiC
	74+TQXADWnRz3RFawo0qB2HrecfO6nPvHqbQCTmq/Cw==
X-Gm-Gg: AZuq6aJKa+D/v8hVRrMEGC7dt8QHMmB2wU0iODaIVtipzGv16wzlygWaryiT2S9ZQXa
	8cB2SifF0Rtw3kVBfSKHLBwl+FKINtMLqNzoTJc7Pz23BC0pkdaCLeati4t1ywWo8J2hJsfkd0f
	nUM//IWODkKzmaPtCwmBoc2PrvLZ0CXuJW1RMt8QRstwH8ynNHDEXKV9TCRx3UQokOzrp9e4USD
	D+2l3YGkSxq+vLHZIrvXi2Pg9aTDHYF6Kw5a8ChTp/afCrns5y/W+EShezyWQkzABLbsfyq4YET
	6zEj/lDpes6TjxEW1mL+BtPbtxJuqUPJw9/oFxZh/vT181G98RjJUwzDrKueWl7TvITD
X-Received: by 2002:a05:6512:1593:b0:598:faf6:1009 with SMTP id
 2adb3069b0e04-59e451834f9mr4376857e87.53.1770728774664; Tue, 10 Feb 2026
 05:06:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJpMwyiVqqbR3ni+URv0uPnE0Bgt_+d+-_+_t6E3wzfiUOT-cg@mail.gmail.com>
 <0ea1530f-31d0-43b6-b35b-1286fc58fd19@acm.org> <CAJpMwygcLdvWNSwj0uy=FBwZyu+DhQSPCvc=CJfiLRvmbfwsKw@mail.gmail.com>
In-Reply-To: <CAJpMwygcLdvWNSwj0uy=FBwZyu+DhQSPCvc=CJfiLRvmbfwsKw@mail.gmail.com>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Tue, 10 Feb 2026 14:06:03 +0100
X-Gm-Features: AZwV_Qh0-0jd8bpAl5v_bQHkjn5fXJcTylXLWTy8BTzG22PitTqyFVids1AXICI
Message-ID: <CAJpMwyhe-UmSkv2vzFPS-o5JRRz==kw-nNbY8RiyQKQykpumrg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] A block level, active-active replication solution
To: Bart Van Assche <bvanassche@acm.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org, 
	Jia Li <jia.li@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 7:04=E2=80=AFPM Haris Iqbal <haris.iqbal@ionos.com> =
wrote:
>
> On Tue, Feb 3, 2026 at 7:01=E2=80=AFPM Bart Van Assche <bvanassche@acm.or=
g> wrote:
> >
> > On 2/3/26 7:09 AM, Haris Iqbal wrote:
> > > We would like to present the idea and internal workings of the
> > > solution, and also discuss design and some benchmarking results
> > > (comparison with RAID1 over RNBD/NVMeOF devices, or DRBD) during
> > > LSF/MM/BPF. We also want to get feedback, and potentially get more
> > > people involved in the project.
> >
> > Please include data about the time needed to recover after a network
> > disconnect. Is this time proportional to the size of the replicated
> > volumes or is this time proportional to the amount of data that has
> > to be resynchronized?

Hi Bart,

We did some quick runs to get the sync time and performance numbers
during syncing.

Descriptions of labels used below,
"fio initial": Numbers for fio run with single leg. This was used to
dirty the data.
"fio during sync": Numbers for fio when the broken leg was
reconnected, and data was syncing.
Data size: Amount of data dirtied during the initial fio run.
Sync time: The amount of time taken by the sync thread to complete the
sync (fio was also running in parallel)
RMR can sync data through a dedicated sync thread, which runs on
storage nodes. The thread syncs only a fixed number of chunks at a
time (set to 256 for the below run), which can be configured if one
wants to prioritize IOs from client.
And it can sync chunks when an IO arrives for a sector in that chunk
to the storage node which is degraded.
Both of these syncing methods can run in parallel.

--
SUMMARY for 10GB:
fio initial: bandwidth=3D1923MB/s, avg latency=3D1049.59 usec
fio during sync: bandwidth=3D442MB/s, avg latency=3D4707.29 usec
  Data Size: 10 GB
  Sync Time: 25 seconds

--
SUMMARY for 20GB:
fio initial: bandwidth=3D1936MB/s, avg latency=3D1045.68 usec
fio during sync: bandwidth=3D447MB/s, avg latency=3D4624.09 usec
  Data Size: 20 GB
  Sync Time: 48 seconds

--
SUMMARY for 50GB:
fio initial: bandwidth=3D1736MB/s, avg latency=3D1176.04 usec
fio during sync: bandwidth=3D433MB/s, avg latency=3D4799.21 usec
  Data Size: 50 GB
  Sync Time: 124 seconds

--
SUMMARY for 75GB:
fio initial: bandwidth=3D1726MB/s, avg latency=3D1184.49 usec
fio during sync: bandwidth=3D452MB/s, avg latency=3D4579.66 usec
  Data Size: 75 GB
  Sync Time: 178 seconds

--
SUMMARY for 100GB:
fio initial: bandwidth=3D1777MB/s, avg latency=3D1148.89 usec
fio during sync: bandwidth=3D442MB/s, avg latency=3D4708.82 usec
  Data Size: 100 GB
  Sync Time: 243 seconds

fio profile used for dirtying the data and for running IOs for sync
sudo fio --name=3D${test_name} \
        --filename=3D${brmr_device} \
        --direct=3D1 \
        --rw=3Dwrite \
        --bs=3D4k \
        --size=3D${size_mb}M \
        --numjobs=3D1 \
        --ioengine=3Dlibaio \
        --iodepth=3D512 \
        --iodepth_batch_submit=3D128 \
        --iodepth_batch_complete_min=3D1 \
        --iodepth_batch_complete_max=3D128 \
        --time_based=3D0 \
        --group_reporting \
        --output-format=3Dnormal"

Server configurations,
Client
CPU(s):                      128
  On-line CPU(s) list:       0-127
Vendor ID:                   GenuineIntel
  Model name:                Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz

Storage servers 1
CPU(s):                      56
  On-line CPU(s) list:       0-55
Vendor ID:                   GenuineIntel
  Model name:                Intel(R) Xeon(R) CPU E5-2690 v4 @ 2.60GHz

Storage server 2
CPU(s):                      40
  On-line CPU(s) list:       0-39
Vendor ID:                   GenuineIntel
  Model name:                Intel(R) Xeon(R) CPU E5-2650 v3 @ 2.30GHz

NICs (for all machines)
2x Mellanox Technologies MT27800 Family [ConnectX-5]


>
> It is proportional to the amount of data to be resynchronized.
> RMR divides the disk space into chunks, which are then tracked through
> a dirty map in case write IOs are missed for a particular leg during
> an outage.
>
> >
> > Thanks,
> >
> > Bart.
