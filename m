Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2439F9443
	for <linux-block@vger.kernel.org>; Sun, 19 Apr 2026 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776634559; cv=none; b=s7jITvOt5zKo5v3h3x60sxT1FdSjawEMo/XYdjISSezIUUGjVLzC9aut5uAL0uemEa1lOwJHOzQCYKYNzhTMRsJbmRJ3k2rZfI+xgVyYxo/QJhCk/biFQ0wyoxlJqEPuyFr02TVJGJKwpr6oUYS2amrf30DkV1sIXB3qN9AUZU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776634559; c=relaxed/simple;
	bh=IDBG0Tx2qhEbmiaoQgRUl605w3K/SNfVuGM+OVcU3EY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=exkT4jojpQpiXLWXY5yPK6Lc705f3beq3/Vm/rRMXOn5gghvxDpFKMVVL9HdTRehoQ3GnzHr8cz+kEqgIhmKI7pvC3ThwiDyA/Tq0w5t7qD8O2T5dC/VRd/0bSrkOoypk7Lf71SC1JIA+dQNdJ3N37WYnQT9eNJ5Ht9T1+rG12M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qs6mUNAS; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qs6mUNAS"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-60fbbac2938so1000022137.1
        for <linux-block@vger.kernel.org>; Sun, 19 Apr 2026 14:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776634557; x=1777239357; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crRQmQHyg4MxT/wLW9vc4SYD3U+N/wKd83cupDhzFY0=;
        b=Qs6mUNASNoOocOBj7IS86OLPnbAFUIdNzkpCXwIQRNW0+9BDgNxhY4DltunEgOhKG1
         9+tLrrXWRXmyz8OVOuP0TqevNqfdhGO+XAzhuoQRVxPSrbII+rN4xpehn46ejwiJCmFR
         58QEU37fJiBklhPxgIDDAN1sRbe+GlHFBQQGCnmdlSGK+MQqGXdvYMMsbPgfq6ont3Tz
         StnrZAppNoydIFAQ49rYyxOV3jFwATQP+slWUsKOB3zAIy34s32nnSkLIJgdI3/aytzM
         c20+ewWGhEg7mIMh4w/PVakhcy5uy8ucgm4RwacUOx7Nuedcb5pqMPQw6gGitgyiqmV+
         mV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776634557; x=1777239357;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=crRQmQHyg4MxT/wLW9vc4SYD3U+N/wKd83cupDhzFY0=;
        b=jmQ3Wl8YacB9mCIB98CEK3XU+ubeXjNDOb8gJO4bVZCjhO6kgTQC5t6qOX8CaB8dU2
         CohL2bpNpcMTrwyXGfjcPH0yHkMZWzSpqEpRn9bkpATDPS+a7CJUsbXt9IW3dd8KUgDg
         KPQI/mbdKocJV5X0nV6Br2pOl7RhUkCBiKZEQognSSDGP7vXeA8aQWTrkkBIHKxEsKrN
         wuEjngSJAV7zbfIj1HNfcbJdYYDbZnfgWA8T6k4ITydbeh/vzuW8wXFP7aM0jVU5ZUNp
         /Q7Dukz5ptrvQkvuZDBOYfXwm0R26md78fKmuc0bRUlRawaztOn/+k1j++FI/U8AGSWa
         GCXg==
X-Gm-Message-State: AOJu0Yxlw9oengf84iiZqUHO/nQ2zw8I6l+6SrksNsyR9INI8FhpDQD8
	ehIbSpPXmJ5m5rKNLhfGsbbc4p9S264C18Gr8DhfQNQxsdQh5LcrstuF41eRlRM/
X-Gm-Gg: AeBDievA33BaZm3uto6Hmzis2WcgtLLU8qvFUKsY9hkto2QKHoLO4wI7KVrH9rreoi2
	ukVsCYfZumIEmzlSN5d0AAEehh07o4EBSAi80CH1pd0MqYAtcfpVAFfeomdcPWXryDzUroniveE
	8EQywMzjK/REg3iFFIaATKYGVP0QiO8h0xr8JqoMKyjnmiMLai7ySezKEiz7+UxjlkER7sU8GLA
	+1R8HmlQQFOWbveqvX+hMKwp1D3WvRP0BZXB9/yiXiLDnlMDSAKGDj/oVh+hobXNqMtJnCz25wV
	HxJlFqPp1qauYzdMEmqdmMPDiZVMfQ1L8X21p9Fz3a++pbAIzhuUlEnNLEjXrJll8FZ+WlLCQsv
	ioIX4CwV32i4YPu/fWa8kFeTKkYCnevwiJ9Rnub6KDe+0bGzRyPJwUHRRBCXxMxLXVnhwrZdmsi
	x6V1BQrfNTo+Gp3SCPhTswHxsbdhPSrflDwVY8AmJ0cC5NrYGVlV07q6a1zzUr80P1Anf7kLMYV
	ZJbUyKoYK8fg004S9H/otccPpB/RMGnZq2o5xAym8KF1tBbC9hn8MspQwiOy7Q=
X-Received: by 2002:a05:6102:3f86:b0:607:7991:f02e with SMTP id ada2fe7eead31-616f8392189mr3715182137.26.1776634556986;
        Sun, 19 Apr 2026 14:35:56 -0700 (PDT)
Received: from localhost (host63.190-224-190.telecom.net.ar. [190.224.190.63])
        by smtp.gmail.com with UTF8SMTPSA id ada2fe7eead31-617455b52bcsm3948901137.3.2026.04.19.14.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 14:35:56 -0700 (PDT)
Date: Sun, 19 Apr 2026 18:35:53 -0300
From: Esteban Cerutti <esteban.cerutti@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [RFC] block/nvme: exploring asynchronous durability notification
 semantics
Message-ID: <aeVKuVLhpjkNxLtg@yanara>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Hannes, Christoph,

thank you both for the detailed replies. They were very helpful and
corrected several misconceptions on my side.

In particular, I now understand that:

- reliance on synchronous flushes is not universal and largely depends
  on filesystem design (e.g. ext4 vs btrfs),
- FUA already provides a per-request durability guarantee when needed,
- and that power-backed guarantees at the system level are much harder
  to make reliable than they may appear.

Based on your feedback, I took some time to read more about how this
problem is handled in practice, especially at the filesystem and
database level (e.g. journaling, WAL, group commit, batching of fsync).

It seems that the cost of durability in fsync-heavy workloads is indeed
well known, but is typically addressed at higher layers rather than in
the block layer or device interface.

So rather than defending my original idea, I would like to refine the
question.

Is there a fundamental reason why these optimizations are handled
exclusively at the filesystem / application level, instead of being
exposed (or assisted) at a lower level such as the block layer or
device interface?

For example, is it due to:

  - lack of reliable visibility into device-internal persistence state,
  - difficulty in defining correct semantics across different hardware,
  - or simply that higher layers already have enough information to
    optimize safely (making lower-level support unnecessary)?

I realize that my earlier proposal likely underestimated the complexity
involved, but I am still trying to understand whether there is a
meaningful limitation at the lower layers, or if this is primarily a
question of where the problem is best solved.

Thanks again for your time and for the insights — this has already been
very useful for understanding how these pieces fit together.

Best regards,
Esteban
