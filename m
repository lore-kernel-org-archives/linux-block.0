Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F721DE2A5
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 02:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764556907; cv=none; b=L+hiKApbQHtCDiLcs5xedFJfstUIyX/Cd33qY1HkDAN+CGwFlZFPVC4k06qhiWPqkruK9uQAmyGI+PLu2b20xIU1FbrFMAYor5SQ+QEC4Ks6w/elL5RVPGMLT27Ku8FVI8TqDORZ0BcV322bZl3ZvSUpEYRyg0numrxXnyoaOUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764556907; c=relaxed/simple;
	bh=bVTMBZipQSey4Fgvkem7K+oGHQCM1N5D+geGZc1LQG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPsXoDvjj3UM8d8NdOaPblVv/ggC/8P1kwu4BmHISj6wgcvpeUi87vzStsrgItJFfELXvEWoc06KeW+aXgHq0OlJ54iPjy/3aV5sv2XaE4Bfx/yWFMDNJYfYSQ0Gby0NRCscpXA5xqzoCqBX/bI1Kb0ypPwxmHYmbgi0XhT0aCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMU8ccvF; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMU8ccvF"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4edf1be4434so24865171cf.1
        for <linux-block@vger.kernel.org>; Sun, 30 Nov 2025 18:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764556904; x=1765161704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4ueRZDGEmZN3pKdDV+VUbfm/GEWq1+GkEBdKVjZOtc=;
        b=HMU8ccvFVJ+OWkPxTVDXXZ6/nVErhPiyzCUNotBWsByIDtbO/TuA0uGn6ReZxP4REe
         v9GHH6zsGJFhNIYb/mVB8VRkwIZi6ZVfu4pjyBZMER8ccKdNOtAxHHlIQdfF6odjWErl
         hWwbr++SWpIOCVcI3tNEhwYqICh8V26iezv8dshZBjwp26C2WXWK1udu1hTwYwbg5fNQ
         KJJE16qROMWMY7Krr0zgBXe3RX2VKnOlY5mhYFfq4XOh702JA7ZuPawaQx1Gd98yCvNv
         nF5vuUVPNA7SzGvpKDNbvta2gMfbkVI7e/dSXDHnRL0/4LCUI1Mv7TCccGj1Puu72hMw
         sYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764556904; x=1765161704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z4ueRZDGEmZN3pKdDV+VUbfm/GEWq1+GkEBdKVjZOtc=;
        b=pqer2RfZhb2PBdLaI3us3DgAMY9MzfHLFPU5jLp1Rrw47I0qeXYJuSFdlM/I/7mNo1
         5FqUk1H/T+Qddpw5aBQW+nJby5Xgzl5V84d9CcjcECrz+bz85XFk1yI+0xjRGIMKh/jT
         txwrWA5PzQdsC+BsVD5hklpmzrB0aQctihlMe1GhmhgAzqFeD4ywv2Y3EAV1waUxmYzS
         GfVOx0PNK8JpqIcWPfqKH1+mT8aasmXAvXrPQjW5yt2gDf+86iK0OgAexeAVDMQ4XTk/
         DX9+0UBX8lpuC5+/MoZNHeTN9WvfDsWW1Z1sDZxB9BFHzJ+/P6GHiTUX6JkDvydKDf9Q
         QMHw==
X-Forwarded-Encrypted: i=1; AJvYcCXF2eXx3g01Oczej1rOI7JAnuzipz74jhgOYs97dqm+jwufPuWcmUTP9qPWGSx0weq598h0akTb5S7JBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yykro2gaPrUhgwR6oY2Up3UIcr1wFecucf6KHLUrCCpUspGSyhN
	PwuGW8FyZDZATcxOSpw0uDHU64qidg/v0clsm5oPV0FMIRfPiJ2XVwoUwS3DVwC1QHKnVW/lme7
	zrJGKfmqqJOQvKbhF4zSymnU45L8fZkY=
X-Gm-Gg: ASbGnct5bTXxiYDW3aHrPcgevo4jxdCF8I/07h32ZKEWXL8lLC1MZnrQsQw7ubLARLE
	ABx+6KQttsySgG6/T8XD858vxZ/fEHaxlKHQe6zh++ILcSXn5Ock6R/nPruyyS4JzM5CD5lf4Pk
	5TPgknGhissk94VFTcdOsDQzNqrRDKzzpbhD4frb5DUM5VBs8+hN80KszEuSOq4MHoybc8CehX3
	pBCrf4yUhdfW3QaueJy0Ok4DR0A4gY+49Wu4yJ6hIMUqBa12uW4vYO2FVIrHPveENzfy7Y=
X-Google-Smtp-Source: AGHT+IEmvBJytrUYv3PRff54NTqLEiIVWOTOdu8c+jgIKKnb+TW+2xLZqLXPCQhWGcR80rf7EC5pZtRoolK6Jl03Lrg=
X-Received: by 2002:a05:622a:14ce:b0:4ee:ce1:ed8a with SMTP id
 d75a77b69052e-4efbd91573emr353928791cf.16.1764556903722; Sun, 30 Nov 2025
 18:41:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-13-zhangshida@kylinos.cn> <b33b3587-edb0-4f30-a8ee-baaa2b631ed9@grimberg.me>
In-Reply-To: <b33b3587-edb0-4f30-a8ee-baaa2b631ed9@grimberg.me>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Mon, 1 Dec 2025 10:41:06 +0800
X-Gm-Features: AWmQ_blj_C1mdvu7tNb0hVlGGZGM9DWXbWPpg6J4BwD_02XuZ0ipoM_caXqdy_E
Message-ID: <CANubcdWAk2Mh5b9stjTh8N84jq+XAgaR3n2-VYRinU9ERtJLUw@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] nvmet: use bio_chain_and_submit to simplify bio chaining
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, ming.lei@redhat.com, 
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhangshida@kylinos.cn, Andreas Gruenbacher <agruenba@redhat.com>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sagi Grimberg <sagi@grimberg.me> =E4=BA=8E2025=E5=B9=B412=E6=9C=881=E6=97=
=A5=E5=91=A8=E4=B8=80 07:03=E5=86=99=E9=81=93=EF=BC=9A
>
> Acked-by: Sagi Grimberg <sagi@grimberg.me>

Hello,

I already dropped this patch in v3:
https://lore.kernel.org/all/20251129090122.2457896-1-zhangshida@kylinos.cn/
The reason is that the order of operations is critical. In the original cod=
e::
----------------
...
bio->bi_end_io =3D nvmet_bio_done;

for_each_sg(req->sg, sg, req->sg_cnt, i) {
...
          struct bio *prev =3D bio;
....
          bio_chain(bio, prev);
          submit_bio(prev);
}
----------------

the oldest bio (i.e., prev) retains the real bi_end_io function:

bio -> bio -> ... -> prev
However, using bio_chain_and_submit(prev, bio) would create the reverse cha=
in:

prev -> prev -> ... -> bio

where the newest bio would hold the real bi_end_io function, which does not
match the required behavior in this context.

Thanks,
Shida
