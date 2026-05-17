Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FC678F39
	for <linux-block@vger.kernel.org>; Sun, 17 May 2026 03:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778990049; cv=pass; b=U6F8SkzV0QvHm6UPvYYV7qdunOjWiMoXrRQJqRbEVUjWNOvBbLeK1HjNiyvjkUBkidOhJnPF5FpbLWnf88rHcnRiuFHnz0qzcNsTTMujgG/M1z/nPbbDCWxm/UGw/bjONfuEG9pieGDmqeROnGMGK+U8Pyowaf8MDg1uLUHkZPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778990049; c=relaxed/simple;
	bh=0NPDHNqdgcIDz6Gx/ZUqY0eJv+FfZrFY0Vl548bG4CU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEtNU2yqE621ypqlPecBhTNDEefDZW4jzr5g5FCMG2ykYcd4O9GtBXLu3QqqQIF72OIEa8+rklUUdcl9aMORNXvLq0gTXJo0JyDRm8ob0nPiYofgQEd4R93Y82uvZ9ePeY8OeEtejh2VaIvE5Vl2UknRBI1JjQoZQ/6SgI2CKtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ke7vau3B; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ke7vau3B"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bd5047a2a4cso216653866b.3
        for <linux-block@vger.kernel.org>; Sat, 16 May 2026 20:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778990046; cv=none;
        d=google.com; s=arc-20240605;
        b=jAbZ/JU5xgidIq8CHX0sUbu+kCKi9/37EXMeqDztS9bTd52kjN7biQ4QbI/tmIqglk
         /zfojEO75R1UGU9yxvxwVCGFtPYfi73k0FywJyZgpMGrBI0ea4OHWXUfMQlJvupqHvUW
         uyZrVybcvRFeFUJNuGDsB/uceLef/Ljv2Ri8vp7qmJcCuGsK+fNdbUtKXpueSZLbkTWW
         wbjJhvVg+c2tz7sNt0EqyEXIg6DYPErhPtCC9w2NevKdmAtKGglshEX7MgyqPZd7D0+u
         /k1tw4OqZsn9bUOucVZJyDLYZiY6LRuySKwmELdYrx+yDkZJeKHYPsigmmfiaSiGfa4D
         KTJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7RMMlpFqVvmvtzBmpLVq7DRJ/Q6MC30z0aqZkBqE7po=;
        fh=jGgeZ9MlvATB6TlauKMSfVG+g11j5vm0SenwiMQu+k4=;
        b=S1yuvM1i1uQFLnYraGeTChvLwmscFjHVRLBMfDWqnSdNS+E0u2JwoulV14I1YRsuy0
         59iex+MfNUbYMsy5aANv+t6v4ZMIeVVChs/j2VlnbkPWZxI67DpWs6t/HsIv2p54WLjq
         Syr1fNFiph2wN7uORkjQyxpByQH3vxKWlwpysj5WK5ZGdga9Q8PGyifSEmtjsR6/cVkO
         uKiCw4PxudtkPrg1zYxx9tmW3sxnFUJj34qPMx+FAKzvimKybL7yoJ7AtSu6wQ2ik34E
         alt1dUWr9SN5qzB4ppHdSXDO1UmfjGANcTOFnFBvAsQQsLPStkRe1neb6SQaRGI6XxWZ
         4Kvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778990046; x=1779594846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RMMlpFqVvmvtzBmpLVq7DRJ/Q6MC30z0aqZkBqE7po=;
        b=Ke7vau3BCSwcPsojR273/VvEVxG1mMPYsDrkNJZAl9tRRBgTFHKULgZ4yjASzx3ezx
         0rh9ZyqYj/pJNXlZZKDRmga6tyd2xQlZijAQUe6BYmFuFFNOuy17CpOo154fEVkYxmv/
         o+njhVhUegoKzHPWNQlg/Rr+Mx4GvNbPpMgf18VlUhNKB6Kms7fWX4UBlvxKR119+uQR
         NDS4swoRjdU6jGGZt2bhRLNjQPLoNTDxWkFOlakMW9rO7FUSaheucaEKpkrYN0cs5jEP
         psYMvQtvJcBoIBO0N6gBykaqDdTwM49TEwlGveluCaLxD4YvQXLV3tWzxKiew0ZU7S1u
         250w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778990046; x=1779594846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7RMMlpFqVvmvtzBmpLVq7DRJ/Q6MC30z0aqZkBqE7po=;
        b=QT82cjFRl3ROR5LLrKYCKocj6OXDhUFLdvih6aZgEJ5ZPJBtvw3DfcbTLjF2IYlqnX
         0AI8nWkRxFxMGsJ1VqOVY84E22ol5eqpl7pBBYXmwFf1lBOkJuqwxl4xQvcniBGGgJMo
         VtzxzbTh1jpuigA7I1coz0g+0Ql+VYcTC7uEuYzDUNqsgJQOu0hlKpHF2QCYZ05rmn/6
         5S1JfXH3pJpIyq+VPX51GtRGtUFCm08VKGxCYnjuzZSmPMagWU8xdMFfWWrmL0boTYeG
         30wjrZFDvrP1F/CK/IIrWx+lVpbze6rEihZ/2lIze7qcEaJKImKbivPK8tNKK9HI9W8O
         RjQg==
X-Forwarded-Encrypted: i=1; AFNElJ+qqWvIEtcSxM78vDIa5SsDoMCqoLG4BUjp+2JSW2UbBcO9HlbTZ4tUknWMkopf9mqO6F4bcTSpEXm+4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnOe6+HvD4BqpTHSW/t/h8xV9S/uoSg5BEjkPWXmlA8Q1XCr0n
	vXIxmjrFxIpPh/B9R+bPPiX+fXXELK89piXqqWoZebVU7rbuo/+92vur+SDgq4DUIO1WR6eb3JE
	xd0kRe0Oc4zQUQ4fWcM3qnmvoJfYqwjE=
X-Gm-Gg: Acq92OE2YXx5pssxFATS3wuxzcjHynRtBTmJOFxlWJQjlZKZpPJGx7bMkqZocMwziOa
	yXKkxdyVIk++4qhcBVHF+tudwATgAVauxUpwLZqSI1/++QoNbktYNLiIXfUtdOLjXDoVaLqXiAZ
	MdLOibBmJanZrhg57AgWeiWoDKjpPegkla/ICfbgw00QNuJ+vWe5kZ7vyHrX+zdbhtNg/vf2V9Y
	olSTkjM5TCGy5VfsfVgffTvaDTnu7oyRXYpRjN/yuGkpx8nU2UtOU9rS5T2BCA0Dr/6Gg1EHY+c
	c/hPz4mD
X-Received: by 2002:a17:907:c986:b0:bd4:4593:33b9 with SMTP id
 a640c23a62f3a-bd517906724mr423581766b.29.1778990046237; Sat, 16 May 2026
 20:54:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427003457.1264511-1-coshi036@gmail.com> <afzWCpJSqvjnTgpF@kbusch-mbp>
In-Reply-To: <afzWCpJSqvjnTgpF@kbusch-mbp>
From: Chao S <coshi036@gmail.com>
Date: Sat, 16 May 2026 23:53:54 -0400
X-Gm-Features: AVHnY4L4Duvx-nXwPTEWE0E2GcE0_-GkwRySgFerna8-h2xgKx1Do0-p3kYWJr4
Message-ID: <CACd_6n29MeACfWpqK5jaSPOVK+q5yop+eeuO_Wk0M0E5Wr7ujw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] nvme: downgrade WARN in nvme_setup_rw to pr_debug
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de, 
	sagi@grimberg.me, axboe@kernel.dk, Sungwoo Kim <iam@sung-woo.kim>, 
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2026 at 07:12:26PM +0100, Keith Busch wrote:
> [...] how that was defeated [...]

Hi Keith,

Not the freeze.  The WARN does not depend on q->limits, but on
ns->head->ms (read live at dispatch, set inside the freeze window) and
on REQ_INTEGRITY, never set for EXT_LBAS-non-PI.  capacity=3D=3D0 only
gates submission (bio_check_eod()), not dispatch: a writeback bio that
passed bio_check_eod() under the old capacity sits on the task plug
holding no q_usage_counter ref, so it does not block the freeze;
blk_finish_plug() flushes it after the update committed head->ms !=3D 0
(dmesg: the capacity-change line prints before the WARN).

So it is reachable -- the host-unaware geometry change you described,
unrelated to your block fix.  The deeper fencing gap is the separate
TP-level issue; v2 does not attempt it, it only stops a
device-reachable, already-safely-rejected dispatch from being a WARN
(a panic under panic_on_warn).

Thanks,
Chao

On Thu, May 7, 2026 at 2:12=E2=80=AFPM Keith Busch <kbusch@kernel.org> wrot=
e:
>
> On Sun, Apr 26, 2026 at 08:34:56PM -0400, Chao Shi wrote:
> > In both cases the bio was submitted without REQ_INTEGRITY (because
> > blk_get_integrity() returned NULL at dispatch time, so
> > bio_integrity_action() returned 0 and bio_integrity_prep() was not
> > called), and it reaches nvme_setup_rw() for a namespace where
> > head->ms !=3D 0.  The existing BLK_STS_NOTSUPP return correctly handles
> > this dispatch; the WARN_ON_ONCE is a false positive.
>
> This is what I'm not really following. The cached request holds a
> reference on the queue that prevents the queue freeze from proceeding.
> This driver freezes the queue along with the queue limits update. As I
> mentioned in the other patch, that was supposed to ensure the block
> layer had the updated limits before it could allocate a request, so I
> think we need to understand how that was defeated to get to a real
> solution.
