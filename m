Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278605;
	b=PDXf7qzv9nZFn/PAOT/3jqYGKUyKkI8oOWWXTVslOMBVuBYqbcsHAsyEVO/6ynHJjhMo
	 Pu7mHQi+x9L4XvssDIIf7swfshhHCxDL6pfPZT9UV2S3TXzv6JXzmANtrf9EeGqd1I2+H
	 iDKk9u2t2UvkD/Xj3ouTAINfc3tRcFXG/MzGMSvLQlPZnkwDq95FjlStADgzssgtU7RBV
	 ay+xgEXOcfIyzkh12gPCxhAzBlvK5TmKdXNGP5Gmjj0qqmXx5MK7IDj2GSq9Wn2UFXx11
	 MqhiK26HoVWgLe3pKZ20nP3rYVzVRTuz3PiyZ4dzFVvJpT0MxSdHGNHVH97W2H7Ai3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278605;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=wbgwxLxbqHUtIvxBG9CCwSuzwtZB4jvydCU5zVJ0F5U=;
	b=cIxa3KhEdDwUfCdiUcQT9aD/g5cVT1OxS0q/jRhmbJeTsrN4l86kr597iWQ00lfTg+A7
	 OP+PH7Bem2SmyjJYOkbntQAetWg3A6+Z7nLOgJgT0eQn8rCyx7Wnenzvvw+DS4rupppBg
	 oarA3jm9c8ZGKAyA4YfwdZCFAFqoIyu+UdJgsxSHEHeGi2Ha0mJOG0yfN4y0G6XnzDCZJ
	 U6C9dVOS97peTB4tPGZrpQzK88ZoDs7FfTqfHzs74dtYT9CgiUYgqJpRVh9QLdLXHcjhF
	 nxwW9NhH8uGjzH1WeDbVX448aJJbTLbPNZlwcAwcvadz0PaSYAefGRoCIQKJPuQKMxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=5HRrsNqD;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06766606A31C;
	Tue, 10 Nov 2026 02:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06766606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=5HRrsNqD
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jNrYj5k69z5HKfx;
	Tue, 10 Nov 2026 10:43:21 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794278601;
	bh=AN7wcGjU/OIqMlYgzCI+b3bup9gXpzPNbBvprbzC3PY=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=5HRrsNqDrfmgpKAZ2VUDB0+AU5l3bpGFnxNZ3vcvxoyrQmuDp5JTWnYFkRH/qyEnB
	 OhVckpnFWiVSW9iHfnXGMtKS5+RFCK55jY6VVIgEDgcXtOf6DLeVSl3jvtURaaFLt9
	 3oxMHK0/rEu8DnVL+QFZOSjO0YRvy73TFXCk8/0aEca7GgQ0JQAPUkeCRyo9nk5ynq
	 152RVtrNQAsjGqnzDL/ShwFNv7F8cOc3FyyVeyG58jVbgqnhlClWxQJjD5AEF8ZlKJ
	 BDX2Aw1+zzC17WG+B/yVK0nipbJIzpR7oiUy86X03Gihnzs15ncRNO+N8qFtLOYVN8
	 oOzl3R1nLcJWA==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6AA2h9bV059154;
	Tue, 10 Nov 2026 10:43:09 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 10:43:10 +0800 (CST)
X-Zmail-TransId: 2afc6af284bee99-77963
X-Mailer: Zmail v1.0
Message-ID: <20261110104310919omj-YtucOjgfh-lZS19Ha@zte.com.cn>
In-Reply-To: <avJ0Vn9G7XhZv-XL@fedora-laptop>
References: 202611092358134332uegNg75loROSwL53Em6A@zte.com.cn,avJ0Vn9G7XhZv-XL@fedora-laptop
Date: Tue, 10 Nov 2026 10:43:10 +0800 (CST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <tom.leiming@gmail.com>
Cc: <shuah@kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gc2VsZnRlc3RzOiB1YmxrOiBwcm9wYWdhdGUgcmVjb3Zlcnkgd29ya2VyIGZhaWx1cmVz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AA2h9bV059154
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 10 Nov 2026 10:43:21 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF284C9.001/4jNrYj5k69z5HKfx

> Please run the real tests next time, it just needs one kernel with
> ublk enabled, and stubs can't cover what the tests are supposed to
> verify.

Agreed, and sorry for sending it that way.  The stubs only exercised the
ERR_CODE aggregation in the shell: they can show that the parent now sees a
worker's status, not that a real failed recovery reaches the final result.
The note should not have claimed more than that.  The follow-up for
test_stress_*.sh will be run on a kernel built with CONFIG_BLK_DEV_UBLK,
and I'll do the same for any future revision of this patch.

> Nit: the above can be simplified as:
>
> 		wait "$pid" && continue
> 		ret=$?
>
> Not a big deal.

I'd rather not make you re-review a v2 just for this, so I'll leave it for
now; if something else forces a revision I'll fold it in.  Say the word if
you'd prefer a v2 with it either way.

> BTW, test_stress_*.sh have the same issue (ERR_CODE set in background
> worker + bare 'wait'), which may be handled in a follow-up.

Yes, they set ERR_CODE in a worker and call a bare 'wait' the same way.  I
will send that as a separate patch on top of this one, and make the helper
in test_common.sh generic (_wait_test_pids) there, so this patch stays as
reviewed.

Thanks for the review and the R-b.
