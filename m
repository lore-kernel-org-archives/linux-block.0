Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2663093DF
	for <linux-block@vger.kernel.org>; Tue,  5 May 2026 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777972803; cv=none; b=pzH7h0F7O2Wj5eRwbTstptKg7heU9KzJPpXerfUBq3NFjXOQqEkOUA55Ikgl31OGtIc47evskh3WwqXRLdac5IMbVDygXGW0uOlQSAzndXsRt4qLJB+3EoPqVnuUxkt9Mjjl9skWQEpDdrkckDVIdyp+LsAM1L7DjekeiMaSvFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777972803; c=relaxed/simple;
	bh=w735SAosskY0lneyTF/N6eHJ+JYB4aKQ6FyORfKtj3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNNqGClaU2gOe8lnbYWslTc7CiEZkpm8NMAa1f0X8/MdhdmIaD2WmzPkJPHpYGViplUREIXMLNOkT4cqzhDF0WpA05nxynwcrFQCAbbamF4ZznbvcFjJQ+72rW1vcRGrmMEybmFHVGjBq0eCk8NeytLReogMzlBhYvtNInnfTok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=xSDtT0Q1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="xSDtT0Q1"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so33434245e9.1
        for <linux-block@vger.kernel.org>; Tue, 05 May 2026 02:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1777972800; x=1778577600; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g/XskZrJZlyhcSv2Bh7vKAobPna7NRs2qWovNRghzDM=;
        b=xSDtT0Q1Pc29VaJGJod+NR/F+8qbRpfWHyaQN8rW5wyS71nET/MU7mJXvKxZDZtMxt
         sRiGyNdU7Xt2LKHHKXCs0KdgDjNMcQ0My2ikzKnPvYTou4JWZDszzTGWDce/VSIwVJ0M
         CAykduzdMUCNA0h2pQ1fkJq7PNKWf+Jr2gYjBFkcODcdXk2JG6TZaxw9OfKnZIfgIw3i
         vY0kX8MG7AeNC41O+fds00GugEEb5yRV5iifmrI8YQ+e0dvkhefNzqrUh40YezFp3HMQ
         /RIDeebfQ34u7OOsvioPY0rXxiXkf5NuzDhfZJj5zzABOgP53GeGwri5G+1hg7puUxwD
         KGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777972800; x=1778577600;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/XskZrJZlyhcSv2Bh7vKAobPna7NRs2qWovNRghzDM=;
        b=fAgqMWgrRy0V8V+0BvGN9l6nAMnydyUVVVnLjuKxvhNRxoNbAUrXtm1x+CQUSkNCSU
         wBLbTcyKeBc4Ea1QBGgtxhNrOPwmrcoecgCMSvA8Ppp6nYqx1kCMIaJh+q1JHtoGH7ao
         HN6vq2fz4agBARRFLISltaLrP4QYL9pJ2qQCoN6b/CClORW5sxaAl+vNOf4q5WtQRJ9Q
         V4MwMS7o0IWRmTfmDbPBVqmRxe0oZZWcpZMb7frFZEfsTI1LN+e0RcaOplJG2EvpaL/x
         7pgFXEcOSIcN8KI2jY/EZvA4m9Lrz1gii0f8okTN5AWi/STmO0zWtx6Es9K4ZZ43lYeR
         Nv1A==
X-Forwarded-Encrypted: i=1; AFNElJ9ujtMaKTjG7DswMwTCZsn1Rz0JG6d55qNm4jleBO745fWmHQ5Q/dygSkA8Ms20EBVA2d6XFCeazwTyfA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0jof5DiZL6h1rMc1zxWziC1dqzUzMJsZVubdCq47pC9jNLSAd
	CfzEFuW3huN3PV9LbHzzdX7pgLsyBlR46PXNG88gQ6oTOtp5nmZQml/uoUMgkZUm8IA=
X-Gm-Gg: AeBDievR1SU2ZrdwxA3NkXq+V5SIV/PBQiDwoLJjOPjDR/qifrN9pMjMuOxi5G4b/1Q
	jIkZb78y7W99ZTY5fSl1bzzjBL1oXzij2ZIyweBo3ysPzGvxLD3D9FQdjeXIIXfhXDEZzbC9oil
	dUFs3IM0FdUjv4UvI3vdRLz0mcqprOUBuT8w6vUou/9XYraZZcNSxLZHeaRiZXXyGWWfNpGpyci
	1MfC4FDtmvYpjUou04GQvDcuEdnRlYno0O73/AR8gzoXTzge/BzKie6Wjmraz3SsUcIgdSIdg3m
	sZpOIw++ahPaowtB/crUJHbJuI3niea3qIZFKoMImwtxpGDoIcA4sWUOB6LJuQSSi/l7CGcmIY9
	he90tBamyhX4AxaTzkRi8bkD+4A7c2fIM+A717vowdbK8CuNEd4PyyZPTX2uFxdsRmG32DD0WKp
	yMAoRgSK+p7AHB4r+aY4z2QVDs0sv5UvL6yRbUK4cc0COq8KXZXkYSmfZoNzNEr5J6masOrLifd
	0C8opSoUw==
X-Received: by 2002:a05:600c:3152:b0:489:1d7a:4537 with SMTP id 5b1f17b1804b1-48d1422bafamr46477035e9.3.1777972799979;
        Tue, 05 May 2026 02:19:59 -0700 (PDT)
Received: from ryzen9 (192-164-131-220.hdsl.highway.telekom.at. [192.164.131.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d184e09eesm12562715e9.29.2026.05.05.02.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 02:19:59 -0700 (PDT)
Date: Tue, 5 May 2026 11:19:57 +0200
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Haris Iqbal <haris.iqbal@ionos.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
	Jia Li <jia.li@ionos.com>
Subject: Re: [LSF/MM/BPF TOPIC] A block level, active-active replication
 solution
Message-ID: <afm2PewS5Gi5QU61@ryzen9>
References: <CAJpMwyiVqqbR3ni+URv0uPnE0Bgt_+d+-_+_t6E3wzfiUOT-cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJpMwyiVqqbR3ni+URv0uPnE0Bgt_+d+-_+_t6E3wzfiUOT-cg@mail.gmail.com>

Am Tue, Feb 03, 2026 at 04:09:59PM +0100 schrieb Haris Iqbal:
> Hi Haris,
> 
> We are working on a pair of kernel modules which would offer a new
> replication solution in the Linux kernel. It would be a block level,
> active-active replication solution for RDMA transport.
> 
> The existing block level replication solution in the Linux kernel is
> DRBD, which is an active-passive solution. The data replication in
> DRBD happens through 2 network hops.
>
>
> An active-active solution which one can build is by exporting block
> devices, either through NVMeOF or RNBD/RTRS, over the network, and
> then creating a raid1 device over it. It would provide a single hop
> replication solution, but the synchronization during a degraded state
> goes through 2 hops.
> 
> The proposed solution would provide an active-active single hop
> replication, and a single hop synchronization (directly between
> storage nodes) in case of a degraded state.
[...]


I stumbled across this post because of the newer replies.

I want to point out that we have significantly developed DRBD over the
last 15 Years as an out-of-tree module. In the past months, we began
the process of getting all those improvements back into Linux
upstream.

With that, DRBD9 became multi-node. It does the “active-active single
hop replication” as it is. The networking part is now abstracted into
transport modules. We have one for TCP, one for load balancing across
multiple TCP connections, and one for RDMA.

What you are doing here, in DRBD lingo, is a diskless primary
connected to multiple storage nodes.

Find everything here https://github.com/LINBIT.
The latest edition of what we bring to the upstreaming discussion:
https://github.com/LINBIT/linux-drbd/tree/drbd-next

Philipp
