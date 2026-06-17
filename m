Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255B4399036
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 05:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781675100; cv=pass; b=Rj+gpshxtj5PcIVzyMksL/0VrDZLo30nuXpRc5O7vEx1d1+zOc0sQcca7uX0VVD+0N/jVp9wiRaPN5TGrOgsP+srCG3OqGxVgKjWPASmefFvXoKwhRcvsKVRnkmXifPRqxhpf01rXsQE7ihVU+wx5UQiUYHxNYPUP3FsF/gXFlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781675100; c=relaxed/simple;
	bh=lKRmpKmonuyhtIYX9JXaoktO3MKvyjTBa6sH4cggBwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1mumN9oouBOQ67jFfjHmSonfUB/wOXY/zdcV18qxTt7OPWFuyo84HL+QXyDgtqkeAq1ayOSqwMrIF7O0++mBgqrBBYnfdmbMaDKPqqviw4mBSRzHG18cCfpF6GwZ0mqsY/4WF6zqSuF5E67jbk2GNHu4vEb0+4nlOZZRT0uyg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbPwuP9l; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbPwuP9l"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e701435806so4717805a34.0
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 22:44:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781675098; cv=none;
        d=google.com; s=arc-20240605;
        b=lJBFBXfBGFIWQATco3pdRwUqn5BDji+aXsH1chYiEMSKc64RCpqdKeRZ1l6yEtP9Jt
         ZCtduI2ugIS6+gvWjI7QLFCPS1ltsS+/Io1/3SUVn/17Y/6YXsvQTn3HfZqQmjRfvq/O
         5VD3ctaBD0due+Zo3MzTOHbSRk4OzDXeJYMsbFaNoOvc9gb9PGhzclPHpTifVnBGKN3L
         hFYUdjbH/LPZWbrN60xgOL4/09HHCJjBzHimhvAS8CenXsfiHN8MneO/Mah2zvkNS4NR
         OyQESJohBhB2lql+u8Q/ukeRyVBOIH/+z6sNwbQWnVJRf7/Kyt/FN7C/DaSsKE837T7V
         d9Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lKRmpKmonuyhtIYX9JXaoktO3MKvyjTBa6sH4cggBwI=;
        fh=BMASTcKYvxZKJpE8OoirEEGmpc2O8AKZ1lbArUs3FAc=;
        b=CMx9rzhLRgy4NM8MiWNlx3R8hvEXFjB6Fml1ZE4dyqBU0soI7UIXpaKaaKcK4xrG+i
         69hc2MS9/kMW+wxTtfjVqqN5d7qUA3vb3yndi4bLAkPhk320vrKQXLbWXCR739J2QaCH
         22oDImr/u19KPV0G189r4YcGr35/6ANAXt9GHNudH2BAdGzrvhWAooMI2e6lav+pZNzZ
         XqFUoW1u8VUeR2ybYaMNB/9TBVtIOdJkpfpdeEE6MtC+rbQkZK+/hstXdbac3U+1+nzV
         kdgROanqRbibDBu58xzq0GRpCLvCPNNqJGoNm7UbZ9vxPcimgIBs9VAt/HckfKEefsFg
         j9Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781675098; x=1782279898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKRmpKmonuyhtIYX9JXaoktO3MKvyjTBa6sH4cggBwI=;
        b=LbPwuP9lPYxZsmdj3DX1p8EBqjVDjRlCSXkNXwAUENBK2aM7CgWwVi91pLZ693qRGo
         1Msavsh8bxYtAIC4v2owOC0LB5mpe22FT+c63h0Yay1+fIRQcLGgu5eXUdp55jmKGdyI
         qdDZ1iE87k36gVYP7fpVpszElTjQX4L7lhwXLELAOKVFlJMiiJEHgazOtIUHYiBxxo5F
         i8fPXT2x1ee7VozZdanJRyRKPsMfZTUPd7FufhZZ9Vvbs3Oog7jS+MN7TLj4BYll4nYc
         PE0IrXui/JktuSCzavWu4E8wBdMERDFLJ/6D+QRwBkSg62YQsF9zF8T5djyHviUPTW29
         LctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781675098; x=1782279898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lKRmpKmonuyhtIYX9JXaoktO3MKvyjTBa6sH4cggBwI=;
        b=UyANX0z6Q9zW6Z54GY0QQcgyFWv6WimErlxh4dIbZkmWXTmTCZ+feDmedyatrAnNb9
         ys2oLOZShJYspw1MxYtpDy0XiS3XFNVLWrJmhSix12/+59KfUtO/SdUD8aAhpQO623sY
         WwLySqf3LM5nCQgNr9LJpHFeIljH6MwYebRdbCLnECqtQETpduZt8gkbDXwz0aiDDPxW
         jL7nxn3LaaDbzzTrdKh8/g/C0GXRQlVC7jVc+SZhzejejO/ri27Wa/VR0vLUyOe7//ck
         izSIFQdqUVDyiq6kSJLp68qqUdonUAcm4xNPj+1Qjy+/QcRjWskhAtK16XG19ybVy95O
         IgHA==
X-Forwarded-Encrypted: i=1; AFNElJ+ScfvavLbhB+d/LNrt193m2YOgLFMvATOCh7US4uZRJsdUNgD7u4nnD2MkahYOjSPfWncwRQ4Z4152DA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSobsa2c5+VcZjBKPXSg/m8AxA8D8tR05Vr7Cf0RoaynZ+DsSU
	UOhHZKjgluf7LVIgq6W63So2kcX3Iji61qevR/wLhhAVXI2G8SKw5eNQKSUOutsw0G1Kplhy5LQ
	DnuoC7M13P8Qhty1gIg/nonvxBx3KpPRu/5Ye/YEXdIFjnBk=
X-Gm-Gg: Acq92OEVNDnXffQMbdCQb704KIEixuqIvmN5aIwOXfoB+00qVv0ZKFYqQHmlTzAt1DR
	nd/AkjQ/wLBkTH01uPCHtEzNLkEo8Wo/d2Q+j+29q9PIFDlYtaQn3FxnyxaCJ+mHWZlpIv4TyWr
	X311LXw6O2wgGRH32vSTrQNlHVPgOVgMNs4uGPJfjU3RxnNSTTj1ULEehO7Avb/Qd0MeJoAn8kE
	qwIjse/kYPAuBbfh+CGzemr2qBCT2+t6mMH1V/yXwDQnNQUOGrQPkITQ+FtMFpvAkIAnpYZSLrj
	8Op6LLbMuH6KgBDZ51JQ/PVoIw==
X-Received: by 2002:a05:6809:392:20b0:486:a606:c6b5 with SMTP id
 5614622812f47-489429be925mr1512679b6e.23.1781675098075; Tue, 16 Jun 2026
 22:44:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614-zram-swap-ops-block-register-v1-0-6c1a6639c222@gmail.com>
 <20260616123646.GB21024@lst.de> <CAJxJ_jhK+zkpjhs3YsQ9RoasKYh+E0NweQci0sPAEY1ne5LmBA@mail.gmail.com>
 <ajIYFtADxQDq8q1P@google.com>
In-Reply-To: <ajIYFtADxQDq8q1P@google.com>
From: Jianyue Wu <wujianyue000@gmail.com>
Date: Wed, 17 Jun 2026 13:44:45 +0800
X-Gm-Features: AVVi8CezmHOQc6ccEaHRKEOgVGFkbymHQDWys_oD7V4L8KIfGzy5Bi0-OqnliFw
Message-ID: <CAJxJ_jiM_-a52EOm896FXkdH+wRxjSHJx+MW6b-ewNLVkp4uSw@mail.gmail.com>
Subject: Re: [PATCH 0/3] mm/zram: route block swap I/O through swap_ops
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Youngjun Park <youngjun.park@lge.com>, Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-doc@vger.kernel.org, Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Sergey,

On Wed, Jun 17, 2026 at 11:46=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
> Can we elaborate on zram being a "legacy interface"?
My previous wording was ambiguous. Actually I didn't mean it is a
legacy interface.
Previously I just compared the new compressed swap implementation.
AFAIK, zram is widely used in many products like Android, automotive and Io=
T.
Its usage and interface should remain unchanged, as the impact would
be significant.

Thanks,
Jianyue
