Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793696691;
	b=2GSpK20luecuHqztADpY3HIK2vi9aI9eImg3RoCLX7sOHNQGVNw6pxP/6kytLKsTReOJ
	 dhiQqYej6Rfb+JZhtM2VsoslsLPlKYQy7gscfE3sPy5lvdKHBE/YQIs9cmTamY66wAQlv
	 SORgEitUueTnYyRyyc7MaTGqoPjb/7PrHehQfRplPpdJ2PWVf2VGBCbinfWtnHVtkP1tn
	 H7/TZ5BKbJopgVo3IwkDJKZrBXs97ucFZAAV8iaktX2n4qcqvF2jY57SumEF92zwI02W+
	 FcLx1Jf66rkmFvkbUb7ZGfRsWS0mMvficakgdMDLo2l3gKZ9AtQCvefydSO1YM+wM8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696691;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=QibTS3hRHWBtrderPfFItxtuJrimy/UpjW7x7VnYyXc=;
	b=b5j+KSdpYaHYuNANIUDOr2EWvjDAFBRK5Vdrfqa7xPTawcTcojo5vZjEqVzS5yoVve2s
	 EzKRwxfidpazvtQ9J0B/lVTPmjisANk1VBSD7SYD6lJQEzLYS9mJ2vMdfu+ZpTSmUHj67
	 MWUrtNAu3Vt4hWVf8IIWiFf8OXNikRqZUhDGFt+gPKVkJJTt+fg/m7KW9i7uxhQO7759P
	 XOlHHxeQyZUnPiTQaB8DShpZMeOsSBU9ySniGRmPtuQfRHXYKR5kKiHE7r6xeH5C0w0KT
	 K59qqDECCzwalUWdATFep0DjiILcTgmyyDgX9qbIz1ZpxVR4p4W8r5Rh2rtHvuzAqcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smartx.com;
	spf=pass smtp.mailfrom=smartx.com;
	dkim=pass header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=NoUTn0BX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.176
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6C7606A334
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 09:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E6C7606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=NoUTn0BX
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3ab3dd9681fso35113691fa.1
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 01:04:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793696684; cv=none;
        d=google.com; s=arc-20260327;
        b=PEacM5+sjf+FvZeLopGGVnNCZ8ILOfReMz3PhvKrQlkZlFWst4iVEvlN2//3p5eDFW
         nx5Yda9+yvMRdysD9IrgiSpi+Ahy5dp4HQlBSBisREYjOwbNDqBzOU51LBy2bBTefX4p
         ogCB3AYWeFLhq4H9mMJfGMAU56eWxITGBk/cnCEoIniITeyUWTNUmN+7rgDVs2L7Cj9T
         ZzHYZb3Wu/tWUxglVCcIRhjxomHfNjgDeQEitjnktziERNlCzsNjC7JPWKAYuGKnF0mB
         Xl0QOB3Yfn2Wu4S1Mxa9NKURCkty79vY7+tAnXvJ6UJwaZtNjVquPWDaNReCofYQtlEM
         d4vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QibTS3hRHWBtrderPfFItxtuJrimy/UpjW7x7VnYyXc=;
        fh=LzlZIwhvdY89t0woKD+Oj+0Rak9FYPo2BUyTECiwXYI=;
        b=enN7NcMn94Kynqhrqf7nnHrwUgdtvrOGkiMaXmOhlaCsn81C17Qsh9GgLPVZ0y9px1
         Sqel1uDvIbi+lXaw5fj2YmK2pXuJfszNMZKBHPe4zXyMCxTEPQBI4szobhfuEAUhbjwj
         UTkrmZM6zUKiE6hexCOWMCLUcYBf7EvUgtuzwK0iFUuJhjFJxhK0eB6lKF926n9gmIjt
         +ZWOtULOPIGlUC456IxrmVwm9ypDi673v2Vz4JVvWYHOK7nUN8WscAMrimGSMeZZNuUZ
         3XyhKba3tvQ87Q0qANOWIEEROl1cmvDPGMhCwVb2pGAktfnWyyNr3IYsIK8cAPuDJPi4
         NmJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20260707.gappssmtp.com; s=20260707; t=1793696684; x=1794301484; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QibTS3hRHWBtrderPfFItxtuJrimy/UpjW7x7VnYyXc=;
        b=NoUTn0BXtDsnFq1HpMu0aGhl74vF6CKggAagce7kXJrkwzVVNgCdmEOWGPBVK+PZUa
         Etp/6wMflgBrUvrlEbhJpj0KHK68dO1qsnej/4oCGRTNlUyllk2VSFvBpJ/oijFF3u3x
         9J7sfZNzCPkN+6LxdDMXV4hIOZkEBaf3HaU4+2CBLg0mihokJbbiFUqVJzbJaTNByS4+
         4bwRXeFn4TXwNvbD4p0mIan+1sD8jxz8AOSqBvN1PF1sLCAYyvm9keSfuvDve6ExsbVy
         OWUJdr2MoaeK7kTi52hhSzF5qPFiLX2qRwDITel32YzXCyD09x8KdVs+QeOv8U+ffg3J
         qngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793696684; x=1794301484;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QibTS3hRHWBtrderPfFItxtuJrimy/UpjW7x7VnYyXc=;
        b=2GWYbvZFiETmRXLWRzQhcuDrfswvo/5u/3eiY/mPoasJ1TfXq3MCIwE143LwyQz8RX
         k3EWP3wnbYVl7GuvWdxOItDair6YYJYqC5lef9v8eEx2s56wwQEeN3Mdu9Orp9p5/Pve
         zFYkaPNG9nLtXErohhfrVt6RdSFXWermD7f/LpHltKb6na9+jt6/LRFK9F1VgsTiaumU
         CxVmDDa0fRHS6W2xic7OhQretqteEPsxmNrUjPOOALuFqROha3QjS6uezjRGHw18TKBE
         U0G1/rjBXwLuGrFvoOkHLkIQS7p+kYhObRMy+YrtFhLaKku7q+NyjRg7dmx5y4V/SIPC
         vALw==
X-Gm-Message-State: APuU4Z/rxQ7olOMJRZQsJSMDRh8/rlrESzz7tDAmOf9a0sjn5Da8Qo7l
	fEJyHcicacuNJAyxYUlFoUJUUEMswHc2wmJMDgSER8Ji5V63ggxjFs0sz7nhYCBDSeC6mbbvmGt
	p0Ry1XeSepJBDLaNMuPa6a/xqxdC+o9ucIJUIv2KYZrDXLUpzeExXu9fng7lk1xtc5L06nqq8Lc
	DPq1OmROipaWj1vGvMcaN/eX312xOtVIz38WBSSNl12xGwgWHZ
X-Gm-Gg: AYBFou3Ts/Qjt4aFNAiIg4YSPFCImMjfasQxMdPXBH5tTehNGSTtZCMTETSp7Sn0rb/
	zItIl29bjmUfk/0k0aZXLhpHUUEKbOWu63RGc6ywDrFPOD0h4MPxWrSuEa4S9aaGN14UX0+cHgW
	CC52HOV2MTXR3N5bQCyfHeegq8lwUxI4H1z3Sk1d7ORzu+ndtF166xBIOj6ATpulyEU2XD0GKL0
	xOUogvdBa03gDwyGSbCUpr2hmjFH2ukDOc70Lb4mgalSKcCLv4/qPMaWCT088otjO0+owFLvDJl
	eaNZeiKhi0cXCjiZ29ZRBI7ReIxgnWUzldswWkDq6ZI06d60DC/vzr3/CvJAdCVs5iMNRkzhLSV
	TSEV822H8UMD2hyuYk8sANH+R8h1rR/kBqiprJWAvvgXKw0JIss++WL+/ah5RXtR3wLdgG5w=
X-Received: by 2002:a2e:bc11:0:b0:3ab:34b7:2535 with SMTP id
 38308e7fff4ca-3acb7a29983mr29493411fa.9.1793696683509; Tue, 03 Nov 2026
 01:04:43 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261009030111.57784-1-lei.chen@smartx.com>
In-Reply-To: <20261009030111.57784-1-lei.chen@smartx.com>
From: Lei Chen <lei.chen@smartx.com>
Date: Tue, 3 Nov 2026 17:04:38 +0800
X-Gm-Features: AclHuK_pmOLLTESyZi7anXUIO5GW4TaRMlcQcRNW9nXAneDiHkZvFfsScA0IpS8
Message-ID: <CAKcXpBxKzWgez34rmpqEmV9hw2JiKBtjJsJqVnKk=ySytxkU2Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Expose blk-mq tag sets through debugfs
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

A gentle ping on this series.

It adds a tag-set-level debugfs view to inspect CPU mappings and
driver tags, with links from request queues to their shared tag set.

I'd appreciate feedback on the overall approach, particularly the
driver tag lifetime changes in patch 2 that support the debugfs view.

Thanks,
Lei

On Fri, Oct 9, 2026 at 11:01=E2=80=AFAM Lei Chen <lei.chen@smartx.com> wrot=
e:
>
> Block debugfs provides views of request queues and hardware contexts, but
> not the tag set they share. This series adds a tag set view for inspectin=
g
> configuration, CPU mappings and driver tags, with links from request queu=
e
> directories to identify queues using the same tag set.
>
> The series first removes a stale CPU mapping comment and moves driver tag
> allocation and reclamation from individual request queue initialization t=
o
> the tag set level. This gives the debugfs tag files a lifetime that can b=
e
> coordinated with tag allocation and release. It then adds tagset/<id>
> directories under the debugfs root and links each request queue to its ta=
g
> set directory.
>
> Tag reads hold a debugfs active reference only while copying tag fields t=
o
> local variables. Releasing it before copying to userspace lets tag file
> removal complete even if a reader faults on its user buffer and needs I/O
> to a frozen queue.
>
> Based on Linux v7.3-rc2.
>
> Testing on a 192-CPU x86_64 host with KASAN and lockdep enabled included:
>
>   - null_blk queue growth and shrink under concurrent direct I/O and
>     debugfs reads, including 100 cycles between 1 and 192 queues.
>   - Shared tag sets, shared tag bitmaps, three-map configurations, and
>     repeated device teardown and recreation with old file descriptors.
>   - Unmapped tag reclamation with 256 poll queues: tracing confirmed
>     allocation, reclamation, reallocation and reclamation again for
>     indices that became unmapped as the queue count changed.
>   - Task-local allocation fault injection, including hctx allocation
>     failures that rolled the hardware queue count back.
>   - NVMe loop with two namespaces, 50 controller resets and data-checked
>     direct I/O. These resets retained the same hardware queue count.
>   - userfaultfd-controlled stalls in tag reads: null_blk queue resizing
>     and NVMe loop controller deletion completed while copying to the
>     user buffer was blocked.
>
> No KASAN or lockdep reports were observed in these tests. A hardware queu=
e
> count change with NVMe queues already frozen has not been tested.
>
> Lei Chen (4):
>   blk-mq: remove stale comment about non-present CPU mapping
>   blk-mq: manage driver tags at the tag set level
>   block: expose blk-mq tag sets through debugfs
>   block: link request queue debugfs directories to tag sets
>
>  block/blk-mq-debugfs.c | 298 +++++++++++++++++++++++++++++++++++++++++
>  block/blk-mq-debugfs.h |  22 +++
>  block/blk-mq.c         | 143 +++++++++++++++-----
>  include/linux/blk-mq.h |  13 ++
>  4 files changed, 445 insertions(+), 31 deletions(-)
>
> --
> 2.43.0
>
