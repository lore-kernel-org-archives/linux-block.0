Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CBE3FD132
	for <linux-block@vger.kernel.org>; Mon,  2 Mar 2026 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460785; cv=pass; b=D688jqvk5j7Qywp16a+doGCe0yG77oBuzhav68+lW5LezPUoc5RRVbhc1eXsBtsMzlcPxzB5uP2SLLl3JSdq7jcxbaVZYTo7Bx/sOgKPZQW3SrXv2bnt8wpcm/JJ06m6MtNXHY8AULDkNohsNsWnimCcIwbDOBrsL8EhLmRNpbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460785; c=relaxed/simple;
	bh=NQSboOUCE1MZRdwtnGgUrTO3ZFv4uMpDjqNi+XdsG84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFsWaRodTo3mS1EFlq2TB0+nQL0BTsS5nctWUoa2+/p7neEEYDUuluZCgywwzQWcp/LfbuGN001GNQ1c3kgOkfr/NXMpKpWNErQnkHAfZ3AELE67MOBQ4TGfYLCyHUtLdMSGH0kC+3U+VtNO1+CHcSg7j5+r5yu2TcQ+C62r1hA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LqPAvZxl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NlJyoS3C; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqPAvZxl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NlJyoS3C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772460783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NQSboOUCE1MZRdwtnGgUrTO3ZFv4uMpDjqNi+XdsG84=;
	b=LqPAvZxlv8+OAgA6m5Vo4kWryKVnPLD4cJmEdi0OCkRxWAyiA9FwD491G1ofSDZDwsQgrv
	duKvl4QmFLVuGFDbpDZXwIuSiTH5xaqjWFs5BPZENX7KYJMvy3Kyo8I7vnRQC40Zgd2Oqq
	B1nxBrqyK1ME7YQdEkGCD3SjY8rG6Oo=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-lYQbkfcuP-aSUsMVwXvyIA-1; Mon, 02 Mar 2026 09:13:01 -0500
X-MC-Unique: lYQbkfcuP-aSUsMVwXvyIA-1
X-Mimecast-MFC-AGG-ID: lYQbkfcuP-aSUsMVwXvyIA_1772460781
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5ff14fe6275so36198125137.2
        for <linux-block@vger.kernel.org>; Mon, 02 Mar 2026 06:13:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772460781; cv=none;
        d=google.com; s=arc-20240605;
        b=UtjuC6yoy06VcjNE7V/1k+uw12/gkFV6+99fb5fVdS9gIJ+RReZPDFOKvQkWzvKfYy
         +PB/vE5ItbBE0JqVB6ty9eK7Z4RsoCSMRTXTeGC+Z4nxmuQBXmIfeRnG+vaDLmy8eZu5
         4XMtiBTKrApON/uoEhOxMOHzi2TaoQg0aXs+dg5yUGUjtUFGW4k3Osmff5mBzKj2PkN6
         pcQQ3sPmE5S0nGrq3eDSaNz3S0FLjssfiCv3xNifDCIvUzLKyScC9ylE5Jze8Hsddi1E
         mzcDX9zLmj+dNO29yZDC4bZ9/m/Q3y+g2W2001tY0DSVDP+EH/XK2fznPUfMtd6jlFnH
         Xkpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NQSboOUCE1MZRdwtnGgUrTO3ZFv4uMpDjqNi+XdsG84=;
        fh=tMaWNsSh9yuMC8HufUAkjqEc2QNbREJK9ro44SIKCoI=;
        b=GxL092BSQhml0E84zX1remGGrOQc+85nL0qGAyCMC2l5WGWOGp+vyuSIzLUEYef7fJ
         F/R8XQ2XY2+6vyNZb5tFN42bAI5cCQildDih1XxiY+fZO3NTYh1/DTzB2zF+J+Xmq/Oz
         PjRwc+luHkrluo8HXXO5//P5CNaTJ+Rgd2mKNxpQGHjh8spCdsPIdUsciZ8uIKUf5nV3
         DJ8joeoiAvkseY1E6BzBkN3+vrjsnLGji2wuqgLV0wXOon7iiOisS2/1dmK9ePhQXut8
         IMZBZ91z4rWMPGGm+U5as7OTeAC414t1H2SAHOOXxt6JcTCMecPpxio+U576panGUIB9
         NqJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772460781; x=1773065581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQSboOUCE1MZRdwtnGgUrTO3ZFv4uMpDjqNi+XdsG84=;
        b=NlJyoS3CNBPQ37Uj5CWolxsstyFtxskQ3N5DNNvpRvUNYF3pKxL94kHMkaxY0vGSIv
         jyqEtTYEobPUouf+3tUrrevxTkDMLKuYRd/PDKL/cgn5+0TRMt/Fmz8wkUumBnk5/mq9
         BjD0CQVG/7GMg7GgyzJWYE6t3/mfvu88lCprVKJ2k//UGxAw6BFh9kznORiergjgky0u
         itaa+Yh8w0ZMUe+RWMmqmrt++bF5HDFhhcx/b6/QL4ewwtZ02n4hghlsYFZAaJLoh9cM
         TrrDqBjgen8hQI7Gma6REAtEX3AeOLRU/6/g+mRJ6S+26AJovGugND+54SDRhCMeskrV
         VkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772460781; x=1773065581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NQSboOUCE1MZRdwtnGgUrTO3ZFv4uMpDjqNi+XdsG84=;
        b=uLfoIYE7uzzc4SDrytMremUNJmkTuO/0Cy3iTK4l+hjiw7VbUuf4+RCyhoisG7EZD/
         sADsNqKHG1fYaqMw2VIvlA0pfyfBJEsERtEMDDTqG0wGx82sqd4Ige2WWrPqhWKQrFEr
         aUQtW88dIy0J1LV53RzIXZLWPfn5wUDCWZ9VTurNOVlfr16XXVGZwkOWqlWAq6GRVBYg
         BtTTYJoi7AJFRr7J+4xLPu5kmWayXwWnquagezB/CJU/lLw6rwQKLQUIbOQIPcYEWtJF
         eDxYKUSUw1ZCt0NchUj97svAAQ+VnQtm6p/JeyaIFnH1wnzMBn8o2dBYdrRQ3faqoPeB
         qaWg==
X-Forwarded-Encrypted: i=1; AJvYcCW26oQVhQAuhmr5TrMn0VMBFB8w2gyn0nBgcGO62rSuVsZEYpEQ6vsRnJnGDb9QYm6ObfBv8rhMDncrjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+GM/bbbgwn9n8Y4TQvp/TJocngVtOWnS3vSjVGMnmWPKLR+41
	jf43QFjI5DDzv8SaNSPDGCbZ9aiKVDcE/bQuF7ZdFblRCkxr1hR0ST1a0lTZrwJ8Gcx+j88WKCe
	H+3WiGWa5M4TanXVW5uIEXT4EYSGDfoxzdkMENZ9zIntjxc7FWQKe62OiTd7Hkh2OuqxrQmsvbf
	u9kh5TadX3irXFW6b7PvrLFdwUQCPno3Vw4LYK90M=
X-Gm-Gg: ATEYQzy0mgWoBmHVLdwkNsQ71FqnKlKcb9wOiltNxEoIRZLcVPCVHFJatfep9ydsdPf
	+YKfcY2wUzvkt1s1JYfqNhVC1nkPUpMkpzlUaHfSOeJ8dqR4ejKie7nWt0V7z/7xuvMl7I5JNcw
	T3LDy4H61YRaEq7PLbqW2uMeifNvKNL/uPYECEVtI51G2fGqOAie+iBNOyYdGGizFdz+zvO3XlE
	aJBkCY=
X-Received: by 2002:a05:6102:3ec7:b0:5ef:8ae:85a5 with SMTP id ada2fe7eead31-5ff32324fa6mr6167081137.16.1772460781319;
        Mon, 02 Mar 2026 06:13:01 -0800 (PST)
X-Received: by 2002:a05:6102:3ec7:b0:5ef:8ae:85a5 with SMTP id
 ada2fe7eead31-5ff32324fa6mr6167053137.16.1772460780942; Mon, 02 Mar 2026
 06:13:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226-revert-cpu-read-lock-v1-0-eb005072566e@kernel.org>
 <20260226-revert-cpu-read-lock-v1-3-eb005072566e@kernel.org>
 <aaBS4pvtiFHL1LSz@fedora> <eb461226-1b64-4b67-a419-5b5886792d68@flourine.local>
In-Reply-To: <eb461226-1b64-4b67-a419-5b5886792d68@flourine.local>
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 2 Mar 2026 22:12:49 +0800
X-Gm-Features: AaiRm51lhpC0NTqv2yO4th0zDsCHXsoRknyKS3DuJC9igXC7axPFJ7GZOoGtWQ4
Message-ID: <CAFj5m9LQ6KOhu0CsqYgW_9xZGDAj5KdUfX2gXAy_HODba-0GnA@mail.gmail.com>
Subject: Re: [PATCH 3/3] Revert "lib/group_cpus.c: avoid acquiring cpu hotplug
 lock in group_cpus_evenly"
To: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Guangwu Zhang <guazhang@redhat.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Thomas Gleixner <tglx@kernel.org>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 10:05=E2=80=AFPM Daniel Wagner <dwagner@suse.de> wro=
te:
>
> Hi Ming,
>
> Sorry for the late response. Last week the mail server did take a break..=
.
>
> On Thu, Feb 26, 2026 at 10:04:18PM +0800, Ming Lei wrote:
> > On Thu, Feb 26, 2026 at 02:40:37PM +0100, Daniel Wagner wrote:
> > > This reverts commit 0263f92fadbb9d294d5971ac57743f882c93b2b3.
> > >
> > > The reason the lock was removed was that the nvme-pci driver reset
> > > handler attempted to acquire the CPU read lock during CPU hotplug
> > > offlining (holds the CPU write lock). Consequently, the block layer
> > > offline notifier callback could not progress because in-flight reques=
ts
> > > were detected.
> > >
> > > Since then, in-flight detection has been improved, and the nvme-pci
> > > driver now explicitly updates the hctx state when it is safe to ignor=
e
> > > detected in-flight requests. As a result, it's possible to reintroduc=
e
> > > the CPU read lock in group_cpus_evenly.
> >
> > Can you explain your motivation a bit? Especially adding back the lock
> > causes the API hard to use. Any benefit?
>
> Sure, I would like to add the lock back to group_cpus_evenly so it's
> possible to add support for the isolcpu use case. For the isolcpus case,
> it's necessary to access the cpu_online_mask when creating a
> housekeeping cpu mask. I failed to find a good solution which doesn't
> introduce horrible hacks (see Thomas' feedback on this [1]).
>
> Anyway, I am not totally set on this solution, but I having a proper
> lock in this code path would make the isolcpu extension way cleaner I
> think.

Then please include this patch with an explanation in your isolcpus patch s=
et.

>
> What do you exactly mean with 'API hard to use'? The problem that the
> caller/driver has to make sure it doesn't do anything like the nvme-pci
> driver?

This API is usually called in slow path, in which subsystem locks are often
required, then lock dependency against cpus_read_lock is added.

Thanks,
Ming

