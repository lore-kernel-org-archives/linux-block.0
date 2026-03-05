Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FE72EB87E
	for <linux-block@vger.kernel.org>; Thu,  5 Mar 2026 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772700064; cv=pass; b=m6NaLkzqSjYKpgR9sDb3A0d5mD4VJ2xyG4TujVOTt20IPYBS1mpnIgBuV/GC8YTPWxb5PulJd7a2vs+WWW8dpqv2/IAMtbkwLHS6tOEUQrDmAEqMn/soZPxKceQolIAcHOpJ4ZZRjq2K7tpppTs5m26b8Ydjzu0oDcKIc3Hn5RE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772700064; c=relaxed/simple;
	bh=/fPzmjukNdIA39PT9q533jz5hvnPj2a94frU4suS68c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eL/yYHjdExZEi6kWD9O7UPvZJxruZdMIX8WOD00ibK4w85JlPMKrY9moGsp8UZABdzd5wWxvecBcIOz6xcFyQGE0ouEa+naBwCX8gpvcFy3GpK/cDBWVnggLN+usOnn5khbG3tSUm81OwbtW58sbS5uiAKXLQ7PbVKuysaSX23s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GL7fnd16; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q3lOKDan; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GL7fnd16";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3lOKDan"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772700062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WjwlZJsGgBP2MJ4Y+BlwbKQrifDwhQpRgaUp782Acxw=;
	b=GL7fnd162lxpqXCNjUeLHXCB0wIqMs6W+O5Z+/5jcIk4ltCofdbrjHQT3pxOE48C2k+AdM
	biCFxJjMXFBTY8F8Eupt1cDk/0dHp/SW8ocO7iz5Jl5c510bIgakR0K0cbFRs+Wb80Rfmf
	ldwDzgya1VNBleOCV7+aULjmJGPHC+I=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-V5mSWCpUOqiIeb1cKkM7qg-1; Thu, 05 Mar 2026 03:41:00 -0500
X-MC-Unique: V5mSWCpUOqiIeb1cKkM7qg-1
X-Mimecast-MFC-AGG-ID: V5mSWCpUOqiIeb1cKkM7qg_1772700059
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3870692ea5cso78348321fa.0
        for <linux-block@vger.kernel.org>; Thu, 05 Mar 2026 00:41:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772700057; cv=none;
        d=google.com; s=arc-20240605;
        b=G4dlkY+rcU4zR9PvK1/hSzxmiMfOR8TY/ZL85k/5lGjfRRJcXIqaWnDBXbfZwnnI5S
         89Zx2EVupbA1IURFNXcIG7j4fKvrxcGeF/WlnDZ2SnpYCaTx/vkDyMqgJHur6Z/T8/Db
         +Sw9On6cQj1Nx7P4QBt2cTWDb/k30lb5Xev+llEW+DudF4SG9kR3nNR1UGaaYmDuTG8I
         kXRBPu9aPQ52EosV6cDVfJ+HQkq9ezzrdhs+2V91vKd8kX8CQa3UbavhsvmDELcUfWMx
         1ZmJNEMyQqcrKjXUofv8P2h5YWoCh9idGpRQf96HBRz1UUWjBkdG4kGbQNkEhBhCt7K8
         46Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WjwlZJsGgBP2MJ4Y+BlwbKQrifDwhQpRgaUp782Acxw=;
        fh=mf3vlN6wXsnQI9gK68zj3/Utq7i7eIcledF2yvQLusM=;
        b=bf0SW7FkNsRpDECQBJaF9fAKBO0O2/LqZa3T8Q9r4s3FsaFe0T7C94KIniTvFoHd4F
         opW6L/o5CrFQGzMRUJOIMeXb0deL8IfCnL4yab8kO3UpUV9EO6CA8aXZnUuhC+Mu17qR
         ZhIbqEh1b5sA6UP2Yfm4glywlyvyOGCbQJQ4ZDcxQHa3ASXVDNBsfRRc9OHCy2DDZLxz
         r+cSEay7cZWoWYWNczR7H+DUd4AOmZYe24H8htfYnu36mZl6XEfY5HxpzqdfYDaOK+Rn
         2kfhBj/zrN6CSsEru6i6cncVUtNFzuGhHaWlrSkWfBRpecsAR02D/YMmdO+BTEvJMvLH
         B+nA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772700057; x=1773304857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjwlZJsGgBP2MJ4Y+BlwbKQrifDwhQpRgaUp782Acxw=;
        b=Q3lOKDanGTiEerK+5yOcmJ7wL1HTA4XAXwKaZ0ndQiyBAk6XmUVVcWInFgzMsfBrbK
         AT68n2WN5CbP2bZB7XrzVlIPEAaGTiN+95CncscbuMnlaWLGIgvuQs86qF/XLwG6dxGn
         rrSTWZb+kXkcNLyBtvgAvbQAJys/cETw77sKk1FW0w1rH91fwPAOFRD0fl+zw6twY5Ry
         IxZxAUfgI6vHBlJXZqzzTSoMDlFIV7o9xJJGmmQrhlkEjY0MOZ2GunDjXx117+4mgThM
         76vqy9NOYrgHXQ/CmQ8ZZCdWOzEo3jyPOIpWuiMt4SYayHQX9sd9aac1+a001SrGiOhN
         1egQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772700057; x=1773304857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WjwlZJsGgBP2MJ4Y+BlwbKQrifDwhQpRgaUp782Acxw=;
        b=wHeNsLbMZSkc+oQFhtrIzXzGaJhVRjsA3IH36rA1Ywotpz2PRoID/VJK19kbeuzDNL
         8/QiRjOdr5xV1z+PvOsshDZW4lRwQV7NHAuGtBNixVJ+0eksYhg7AnbjtH/f6/gESZcW
         LN4tqXxbqCIlOFUYQgLK2EoHdXMAGsaLMcQtisUj96qWI3b60ESFEUhg4fq5mJhudHJ3
         gLsFhL3kCM7pzE8uTw3unM/cy17OfIQmeTIRejkDhQTNOj7UuEN5XpFnMGmQkZZTnIQJ
         I0M2kP8E6IUtIxum2RDSGZwOg4k9gx7bJgund00t/eRHfx6MrcB5+/mMQQP79qXiSvHT
         ApUQ==
X-Gm-Message-State: AOJu0YyQWlk5ucHV7j2r+jzRdurjl46JkG/ko8DgOVZfSvN2ooQWMvgE
	TpbUUkv4tQOVuXHM9AMjwwG8BP+aYuk1Yq4G/C6fc2jWTICgHvymtvZyn+AzGcU1E3gA8XqmaEh
	t6eWwckCwKKSyZyfvQabnFTOC6UjPIuPewwSxOoavmIDYk632Zlm9FFVlImDC6O/V+c6AIvcyte
	2QIdW9Q/RC8KPoEwgmmFBpPGHE7M6w8axOQyh4vD7q+4YB2FXT7wID
X-Gm-Gg: ATEYQzyD4y2bXV5115On/EDkFcCQkBBoLwLO0gakId15wPrQxBpu7GJp0jTFqeT2T2T
	Xhht+Il7hxTvDsIK9V2QsCPWPuWGNe18dzxDE75H1n9lOXFF0KsvQ/xiF2C0D5fz2uFbH7w38kj
	hVBpOT0HPhXXdn+inaT8d82Tx8uk2aTCoBb+Z41Xa4TSyKVKexKJVT0xirWJgbAINlubFP/4Wy6
	dKzFN2yYRkrMH4lGgh8Bcl15/5HBNvBF4gzkGEiXKKG/AEEOxE=
X-Received: by 2002:a05:651c:981:b0:386:46ac:835b with SMTP id 38308e7fff4ca-38a2c580f26mr35280141fa.16.1772700057364;
        Thu, 05 Mar 2026 00:40:57 -0800 (PST)
X-Received: by 2002:a05:651c:981:b0:386:46ac:835b with SMTP id
 38308e7fff4ca-38a2c580f26mr35280041fa.16.1772700056768; Thu, 05 Mar 2026
 00:40:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs9qsvcii+KuDWkRPMF6XdDfUwmnjn2Ox6TmGV1u4PpTJA@mail.gmail.com>
In-Reply-To: <CAHj4cs9qsvcii+KuDWkRPMF6XdDfUwmnjn2Ox6TmGV1u4PpTJA@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 5 Mar 2026 16:40:42 +0800
X-Gm-Features: AaiRm51KTpiaHe8VGzN-UzejJJvgL-FUSghPsQVWJnSZXHIjzTTw2a0kPgoLdzE
Message-ID: <CAHj4cs8URj2fJ7KyP9ViAm6npVOaMiAErnw2uFyPYEU2wb7G_w@mail.gmail.com>
Subject: Re: [bug report] Most blktests block/ failed with "Timed out while
 waiting for udev queue to empty."
To: linux-block <linux-block@vger.kernel.org>, linux-nfs@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Ming Lei <ming.lei@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, Steved <steved@redhat.com>, atomlin@atomlin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC linux-nfs
After analyzing the systemd-udevd logs I found that the udev rule
/usr/lib/udev/rules.d/99-nfs.rules triggers /usr/libexec/nfsrahead for
every new block device. In the current version, this binary takes
exactly 10 seconds to return an exit code 2 for non-NFS devices[2].
This latency, multiplied by thousands of test-generated events,
exhausts udev worker threads and blocks the event queue, leading to
the system-wide "Timed out while waiting for udev queue to empty"
error. In the previous version [1], the binary
/usr/libexec/nfsraheadprevious returns exit code 2 in 1 second.
After checking the changelog for the latest nfs-utils, seems it was
introduced from commit[3].

[1]
nfs-common-utils-2.8.4-4.rc3.fc44.x86_64    nfs-utils-2-8-5-rc3
Mar 04 10:27:39 (udev-worker)[53692]: 250:0: Starting
'/usr/libexec/nfsrahead 250:0'
Mar 04 10:27:39 (udev-worker)[53652]: 250:1: Processing device
(SEQNUM=3D120442, ACTION=3Dadd)
Mar 04 10:27:39 (udev-worker)[53652]: 250:1:
/usr/lib/udev/rules.d/99-nfs.rules:1 PROGRAM=3D"/usr/libexec/nfsrahead
%k": Running command "/usr/libexec/nfsrahead 250:1"
Mar 04 10:27:39 (udev-worker)[53652]: 250:1: Found callout binary:
"/usr/libexec/nfsrahead".
Mar 04 10:27:39 (udev-worker)[53652]: 250:1: Starting
'/usr/libexec/nfsrahead 250:1'
Mar 04 10:27:39 (udev-worker)[53692]: Successfully forked off
'(spawn)' as PID 67181.
Mar 04 10:27:39 (udev-worker)[53652]: Successfully forked off
'(spawn)' as PID 67182.
Mar 04 10:27:39 (udev-worker)[53692]: 250:0: Process
'/usr/libexec/nfsrahead 250:0' failed with exit code 2.
Mar 04 10:27:39 (udev-worker)[53692]: 250:0:
/usr/lib/udev/rules.d/99-nfs.rules:1 PROGRAM=3D"/usr/libexec/nfsrahead
%k": Command "/usr/libexec/nfsrahead 250:0" returned 2 (error)
Mar 04 10:27:39 (udev-worker)[53652]: 250:1: Process
'/usr/libexec/nfsrahead 250:1' failed with exit code 2.
Mar 04 10:27:39 (udev-worker)[53652]: 250:1:
/usr/lib/udev/rules.d/99-nfs.rules:1 PROGRAM=3D"/usr/libexec/nfsrahead
%k": Command "/usr/libexec/nfsrahead 250:1" returned 2 (error)
[2]
nfs-common-utils-2.8.5-0.rc3.fc44.x86_64  nfs-utils-2-8-6-rc3
Mar 04 06:07:14 (udev-worker)[2019]: 250:0:
/usr/lib/udev/rules.d/99-nfs.rules:1 PROGRAM=3D"/usr/libexec/nfsrahead
%k": Running command "/usr/libexec/nfsrahead 250:0"
Mar 04 06:07:14 (udev-worker)[2019]: 250:0: Found callout binary:
"/usr/libexec/nfsrahead".
Mar 04 06:07:14 (udev-worker)[2019]: 250:0: Starting
'/usr/libexec/nfsrahead 250:0'
Mar 04 06:07:14 (udev-worker)[2020]: nullb0:
/usr/lib/udev/rules.d/50-udev-default.rules:93 GROUP=3D"disk": Set group
ID: 6
Mar 04 06:07:14 (udev-worker)[2021]: null_blk: Device processed
(SEQNUM=3D10585, ACTION=3Dadd)
Mar 04 06:07:14 (udev-worker)[2021]: null_blk:
sd-device-monitor(worker): Passed 157 byte to netlink monitor.
Mar 04 06:07:14 (udev-worker)[2021]: Notify message sent to
'@18092807967873750410': "PROCESSED=3D1"
Mar 04 06:07:14 (udev-worker)[2019]: Successfully forked off '(spawn)'
as PID 2023.
Mar 04 06:07:14 (udev-worker)[2020]: nullb0: Setting permissions
/dev/nullb0, uid=3D0, gid=3D6, mode=3D0660
Mar 04 06:07:14 (udev-worker)[2020]: nullb0: Successfully created
symlink '/dev/block/250:0' to '/dev/nullb0'
Mar 04 06:07:14 (udev-worker)[2020]: nullb0: sd-device: Created
database file '/run/udev/data/b250:0' for
'/devices/virtual/block/nullb0'.
Mar 04 06:07:14 (udev-worker)[2020]: nullb0: sd-device: Created
database file '/run/udev/data/b250:0' for
'/devices/virtual/block/nullb0'.
Mar 04 06:07:14 (udev-worker)[2020]: nullb0: Device processed
(SEQNUM=3D10584, ACTION=3Dadd)
Mar 04 06:07:14 (udev-worker)[2020]: nullb0:
sd-device-monitor(worker): Passed 268 byte to netlink monitor.
Mar 04 06:07:14 (udev-worker)[2020]: Notify message sent to
'@18092807967873750410': "PROCESSED=3D1"
Mar 04 06:07:14 systemd-udevd[1300]: 250:0: Device is queued
(SEQNUM=3D10586, ACTION=3Dremove)
Mar 04 06:07:14 systemd-udevd[1300]: 250:0: SEQNUM=3D10586 blocked by SEQNU=
M=3D10583
Mar 04 06:07:14 systemd-udevd[1300]: nullb0: Device is queued
(SEQNUM=3D10587, ACTION=3Dremove)
Mar 04 06:07:14 systemd-udevd[1300]: nullb0: Device ready for
processing (SEQNUM=3D10587, ACTION=3Dremove)
Mar 04 06:07:14 systemd-udevd[1300]: nullb0:
sd-device-monitor(manager): Passed 233 byte to netlink monitor.
Mar 04 06:07:14 (udev-worker)[2021]: nullb0: Processing device
(SEQNUM=3D10587, ACTION=3Dremove)
Mar 04 06:07:14 (udev-worker)[2021]: Notify message sent to
'@18092807967873750410': "INOTIFY_WATCH_REMOVE=3D1"
Mar 04 06:07:14 (udev-worker)[2021]: nullb0: Device processed
(SEQNUM=3D10587, ACTION=3Dremove)
Mar 04 06:07:14 (udev-worker)[2021]: nullb0:
sd-device-monitor(worker): Passed 271 byte to netlink monitor.
Mar 04 06:07:14 (udev-worker)[2021]: Notify message sent to
'@18092807967873750410': "PROCESSED=3D1"
Mar 04 06:07:14 systemd-udevd[1300]: null_blk: Device is queued
(SEQNUM=3D10588, ACTION=3Dremove)
Mar 04 06:07:14 systemd-udevd[1300]: null_blk: Device ready for
processing (SEQNUM=3D10588, ACTION=3Dremove)
Mar 04 06:07:14 systemd-udevd[1300]: null_blk:
sd-device-monitor(manager): Passed 160 byte to netlink monitor.
Mar 04 06:07:14 (udev-worker)[2021]: null_blk: Processing device
(SEQNUM=3D10588, ACTION=3Dremove)
Mar 04 06:07:14 (udev-worker)[2021]: null_blk: Device processed
(SEQNUM=3D10588, ACTION=3Dremove)
Mar 04 06:07:14 (udev-worker)[2021]: null_blk:
sd-device-monitor(worker): Passed 160 byte to netlink monitor.
Mar 04 06:07:14 (udev-worker)[2021]: Notify message sent to
'@18092807967873750410': "PROCESSED=3D1"
Mar 04 06:07:14 systemd-udevd[1300]: null_blk: Device is queued
(SEQNUM=3D10589, ACTION=3Dadd)
Mar 04 06:07:14 systemd-udevd[1300]: null_blk: Device ready for
processing (SEQNUM=3D10589, ACTION=3Dadd)
Mar 04 06:07:14 systemd-udevd[1300]: null_blk:
sd-device-monitor(manager): Passed 157 byte to netlink monitor.
Mar 04 06:07:14 (udev-worker)[2021]: null_blk: Processing device
(SEQNUM=3D10589, ACTION=3Dadd)
Mar 04 06:07:14 (udev-worker)[2021]: null_blk: Device processed
(SEQNUM=3D10589, ACTION=3Dadd)
Mar 04 06:07:14 (udev-worker)[2021]: null_blk:
sd-device-monitor(worker): Passed 157 byte to netlink monitor.
Mar 04 06:07:14 (udev-worker)[2021]: Notify message sent to
'@18092807967873750410': "PROCESSED=3D1"
Mar 04 06:07:14 systemd-udevd[1300]: varlink: New incoming connection.
Mar 04 06:07:14 systemd-udevd[1300]: varlink-15-15: Setting state idle-serv=
er
Mar 04 06:07:14 systemd-udevd[1300]: varlink-15-15: Received message:
{"method":"io.systemd.service.Ping"}
Mar 04 06:07:14 systemd-udevd[1300]: varlink-15-15: Changing state
idle-server =E2=86=92 processing-method
Mar 04 06:07:14 systemd-udevd[1300]: Received io.systemd.service.Ping
Mar 04 06:07:14 systemd-udevd[1300]: varlink-15-15: Sending message: {}
Mar 04 06:07:14 systemd-udevd[1300]: varlink-15-15: Changing state
processing-method =E2=86=92 processed-method
Mar 04 06:07:14 systemd-udevd[1300]: varlink-15-15: Changing state
processed-method =E2=86=92 idle-server
Mar 04 06:07:14 systemd-udevd[1300]: varlink-15-15: Got POLLHUP from socket=
.
Mar 04 06:07:14 systemd-udevd[1300]: varlink-15-15: Changing state
idle-server =E2=86=92 pending-disconnect
Mar 04 06:07:14 systemd-udevd[1300]: varlink-15-15: Got POLLHUP from socket=
.
Mar 04 06:07:14 systemd-udevd[1300]: varlink-15-15: Changing state
pending-disconnect =E2=86=92 processing-disconnect
Mar 04 06:07:14 systemd-udevd[1300]: varlink-15-15: Changing state
processing-disconnect =E2=86=92 disconnected
Mar 04 06:07:24 (udev-worker)[2019]: 250:0: Process
'/usr/libexec/nfsrahead 250:0' failed with exit code 2.

[3]
https://git.linux-nfs.org/?p=3Dsteved/nfs-utils.git;a=3Dcommit;h=3D2b62ac4c=
273a647df07400dc1126fceb76ad96c0


On Tue, Mar 3, 2026 at 11:55=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wrot=
e:
>
> Hi
>
> CKI reported that most blktests block/ failed at "udevadm settle"[2]
> on the latest linux-block/for-next[1] today.
> Seems it's one regression issue and I will try to bisect it tomorrow.
>
> [1]
> commit: for-next (7.0.0-rc2, upstream-block, b82c5e4f)
> [2]
> block/001 (stress device hotplugging)                        [failed]
>     runtime    ...  531.793s
>     --- tests/block/001.out 2026-03-02 23:17:54.816626772 +0000
>     +++ /mnt/tests/s3.amazonaws.com/arr-cki-prod-lookaside/lookaside/kern=
el-tests-public/kernel-tests-production.tar.gz/storage/blktests/blk/blktest=
s/results/nodev/block/001.out.bad
> 2026-03-02 23:26:52.842946157 +0000
>     @@ -1,4 +1,8 @@
>      Running block/001
>      Stressing sd
>     +Timed out while waiting for udev queue to empty.
>      Stressing sr
>     +Timed out while waiting for udev queue to empty.
>     +Timed out while waiting for udev queue to empty.
>     +Timed out while waiting for udev queue to empty.
>     ...
>     (Run 'diff -u tests/block/001.out
> /mnt/tests/s3.amazonaws.com/arr-cki-prod-lookaside/lookaside/kernel-tests=
-public/kernel-tests-production.tar.gz/storage/blktests/blk/blktests/result=
s/nodev/block/001.out.bad'
> to see the entire diff)
> >>> 2026-03-02 23:26:52 | End /mnt/tests/s3.amazonaws.com/arr-cki-prod-lo=
okaside/lookaside/kernel-tests-public/kernel-tests-production.tar.gz/storag=
e/blktests/blk/blktests/tests/block/001
> ** storage/blktests/tests/block/001 FAIL Score:1
> Uploading resultoutputfile.log .done
> >>> 2026-03-02 23:26:53 | Start to run test case  /mnt/tests/s3.amazonaws=
.com/arr-cki-prod-lookaside/lookaside/kernel-tests-public/kernel-tests-prod=
uction.tar.gz/storage/blktests/blk/blktests/tests/block/002 ...
> block/002 (remove a device while running blktrace)
> block/002 (remove a device while running blktrace)           [failed]
>     runtime    ...  361.751s
>     --- tests/block/002.out 2026-03-02 23:17:54.816626772 +0000
>     +++ /mnt/tests/s3.amazonaws.com/arr-cki-prod-lookaside/lookaside/kern=
el-tests-public/kernel-tests-production.tar.gz/storage/blktests/blk/blktest=
s/results/nodev/block/002.out.bad
> 2026-03-02 23:32:55.837327191 +0000
>     @@ -1,2 +1,5 @@
>      Running block/002
>     +Timed out while waiting for udev queue to empty.
>     +Timed out while waiting for udev queue to empty.
>     +Timed out while waiting for udev queue to empty.
>      Test complete
> >>> 2026-03-02 23:32:55 | End /mnt/tests/s3.amazonaws.com/arr-cki-prod-lo=
okaside/lookaside/kernel-tests-public/kernel-tests-production.tar.gz/storag=
e/blktests/blk/blktests/tests/block/002
> ** storage/blktests/tests/block/002 FAIL Score:1
> Uploading resultoutputfile.log .done
> >>> 2026-03-02 23:32:56 | Start to run test case  /mnt/tests/s3.amazonaws=
.com/arr-cki-prod-lookaside/lookaside/kernel-tests-public/kernel-tests-prod=
uction.tar.gz/storage/blktests/blk/blktests/tests/block/006 ...
> block/006 (run null-blk in blocking mode)
> block/006 (run null-blk in blocking mode)                    [failed]
>     runtime    ...  120.067s
>     --- tests/block/006.out 2026-03-02 23:17:54.817585748 +0000
>     +++ /mnt/tests/s3.amazonaws.com/arr-cki-prod-lookaside/lookaside/kern=
el-tests-public/kernel-tests-production.tar.gz/storage/blktests/blk/blktest=
s/results/nodev/block/006.out.bad
> 2026-03-02 23:34:57.275131017 +0000
>     @@ -1,2 +1,2 @@
>      Running block/006
>     -Test complete
>     +Timed out while waiting for udev queue to empty.
> modprobe with --wait option succeeded but still null_blk has references
>
>
>
>
> --
> Best Regards,
>   Yi Zhang



--=20
Best Regards,
  Yi Zhang

