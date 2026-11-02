Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606449;
	b=G1a5zpqKyUg6LlP++Wfjh3mxMK/1H/ebv7r9nFn5von5sMER8mNOsK94+aVSJDd7UOaE
	 lVivZ8sgpbyrBqZYW1kcq/r74tE7dqd+dvrvIKi0tMUAsbO4BBXuZ/RE0U1wtSN9ygRZN
	 L0tzH38mVVtx0CntE32AgdTZvkkz3qjgmX5tyEmCz5z2WM1xfVjBWF8x1iubhYU72Mngg
	 Dl4MgM90WElgGtID77hNEhU0eNjK0lF4OEgToYj0kNyS7+dcOzPwga33cXDIlp8qycJOD
	 L3Tic3+yhbVA/HrCfOzzQLMqrfSmpLbGrP2S5u1m1Ie2pJPv8S/twm1U47dVpf7VW+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606449;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8kqF3ntzYW3hP6K+8Zi1mBskB8D2QgCHbNZ8Jdf9/+4=;
	b=CYTqYTtiI3zd6+mBIbZ5Nhm68bkgsPGm+E+sWl2vGJWhIaRkH8zaRam301fGL+hk1onS
	 vX3mW+rrAj5/Mu7x07CdiULCgocFPokFf5NffQ73wFvdVa92FWnNzqgSWa4NYAFII6f85
	 2r8nCW10Lr50NwgMuN9QZSCZ8f2RC7IclnJuzKF8i3bJKjFC5aKE+H+PSMvJtVfaeg+DT
	 ylGA1UdmKIGdKKrjCBJxHOQjUj2jHe9Im4CvCO8Due5wnEbG7BFco9M/AYfWXlUri6JHf
	 bDbI9JCOf8N2M7yFg+V2YKoTxBHCI72X7rr1UEmifyt9I8iViZddpw8NMpmgfKsmOrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WlSZwWCi;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AE7606A327
	for <linux-block@vger.kernel.org>; Mon,  2 Nov 2026 08:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5AE7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WlSZwWCi
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3514b90bb89so5550351eec.1
        for <linux-block@vger.kernel.org>; Mon, 02 Nov 2026 00:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793606448; x=1794211248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8kqF3ntzYW3hP6K+8Zi1mBskB8D2QgCHbNZ8Jdf9/+4=;
        b=WlSZwWCiq2PAF+H6oZ4EkhdoOGWWeYu7f56c319sIi8m2ToY7CTu8Y1DrLbRw5nAMi
         L/5UoU6Ivu2LXjt4JX5Ig+TwCrsCPKYiDYhYqCEA0pmOubyaR5IDeoSVVqZWWkXXErSE
         SdCJnanp2UU9nHttCa77WOscrVnwFOW2Dep+EqPNgDolIWhnjfHb5vj7ad/Sz0T6wMjH
         Zwhr6BJQBoovDKodO/hmXJfFwliqpS3zeEdgRItceAgDjcb8mjTIwza1U6Spp1L3UvEg
         o2RTw7QhM0mx0SWZPyJhv0SRjAGB4x/QqicIe62ASgt9nFNEnYTSFHRxjq6v525KWzBn
         CPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793606448; x=1794211248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8kqF3ntzYW3hP6K+8Zi1mBskB8D2QgCHbNZ8Jdf9/+4=;
        b=NG+Nl67Dp75PURUM7WTwBHET0KRDUQByKP9FqzcDXPyF0K8vKpw0N9vaHHGGl2CG3H
         h9hqtj9yIyMPRnsUHnojrq/kqhhqFIfYMqcxZWi/vq4rfPB9v9CkQieBNQiPJYTFPwAj
         /qeDzTjDOulP7GbuAtZSYL6fatGKGqAgUmsGPK9k++Y+LNOAEXT7vw4/PpulUxzxSq87
         mgj/vdDpVPgxbctGZMQ18lYJRAB6fQGksgBjSOmFPu5n5iJbtjHWzgwLRR+qBTPSiCMA
         uc+dczjxns4QI/MOxLp3WHuQkQT11FJ6AUuzNq3pth5TMRKFcW9wt/fW95a7awy8exO3
         rKAA==
X-Forwarded-Encrypted: i=1; AKwUvByQdbvc3cCp0Faa9UDIsA9kpJ5jYc7kp++cfk5AUJzQWcBD4u8sJmUmi9cZrVy8x1utdiJA57parv6A/Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Id0hdAULfC8sh+rTtKVJ2lu1T20B2j5vVkjdbpNuILeOxCCwR
	NdWcbYpCqxK5fXDI9tp7iwUOo21/T2R1Zx0PaFw2wQUdHgxaJcUV+X2ivGGVGl0+tR8=
X-Gm-Gg: AYBFou3rbJZZc9HiUB6T9m+S0yKKUMtIPBbxlXi58E6Z9wwMiXbK3+TlA9d+xbhyHPf
	y/13Uco6twXT8+VCizqZqvx26OPNdisxFJbc1o+7kfgmrP+5ZgKv6ieFreRADk0KfRRwCZCQEee
	zyf4WfOLRo1SZ+xltSBiutmWhJ8Z3VrisuUaK7OP7exVNooFH7WEh4ao3euC+0ifn16uyXRBEf2
	NGVYs910L3C1LyuqK8F2Kf+/3VxXDPmSv1h7+l4XSQZIRXiAe7KPDo1vd/WwVVk6oDm36DsKNOv
	m+g54ERdQ62bMwY/dNPh9zcsUr5IeJDwe9HavmpNRkpsDtaxZ+6nOnLs8W8YCd0IYjZSN0/ElhJ
	hWZou0zt1BT7QW47ZgtRIze9N7aIKSXKrO2IrVAIX8Aaey29ZDWgYKCaHtrXXFMORE66kLCj1w9
	huT7s94SdgAr9lDqAzirA2Rj773rVZ3cv6++kd104VYJKWzpVvPBvNi9F/q6ShLlJ1Yf/nCcr3v
	3C47eaqboA0GVBB4D9yurlISJTOut+yK510/hTlk/7wAak4eBNSyNl8qdc31LW+UJjPIXCfeekS
	EMpbVjLbYURlwyu5Bmaq
X-Received: by 2002:a05:693c:4152:20b0:36a:1807:75a4 with SMTP id 5a478bee46e88-36a423cacb4mr16532556eec.20.1793606447377;
        Mon, 02 Nov 2026 00:00:47 -0800 (PST)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428aed76sm36371585eec.9.2026.11.02.00.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 00:00:46 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Ming Lei <tom.leiming@gmail.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH 1/2] nvme: remove namespaces in parallel
Date: Mon,  2 Nov 2026 03:00:41 -0500
Message-ID: <20261102080041.1269654-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6e9e6f78-4bd7-46f0-bf57-5c227a65a69e@suse.de>
References: <20261102-bug-nvme-remove-ns-async-v1-0-61780fee111c@gmail.com> <20261102-bug-nvme-remove-ns-async-v1-1-61780fee111c@gmail.com> <6e9e6f78-4bd7-46f0-bf57-5c227a65a69e@suse.de>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2 Nov 2026 08:26:57 +0100, Hannes Reinecke wrote:
> On 11/2/26 7:14 AM, Qiliang Yuan wrote:
>> nvme_remove_namespaces() removes the namespaces of a controller one
>> after another. Each removal waits for RCU grace periods in
>> del_gendisk() for the namespace and for its multipath head, about
>> 20 ms in all.
>>
> But that isn't changed by calling async_schedule_domain, isn't it?

Right, each removal still waits about 20 ms. What changes is that the
waits overlap. A grace period is system-wide, so removals that wait at
the same time are released by the same grace periods instead of each
needing its own. Disconnect time over tcp, from the table in the
patch:

  namespaces  before              after
           8   170 /  171 ms       85 /  91 ms
          32   628 /  628 ms      294 / 293 ms
          64  1201 / 1308 ms      533 / 550 ms

> Other than that it looks fine.

Thanks for the review.

Qiliang
