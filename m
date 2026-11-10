Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279662;
	b=z0oRKXuGIG9V/ldkSD5tXPnaH3ZuWw9YyWknGFDlYts/XGr/k72pjN61avr3Dz6OFzkf
	 RDenfG2Dh4ybnAmLkArDPa66sL7oqrp4lPjcOh9fDsLjPBamAzW0O0x+ms8MieAblQXMS
	 5bSLXo0cQGgKWD+e0JglNjrVpPnciO9z+l5eyjH1j+D9TtUEF+7v4RE8kPxQBXsRBl63v
	 ZQnuFCWb1EHiPvAfYknha7/jNwUWykxizKJzinIO2SJ18VkOELnEOnGURIGdlx0YuNEr5
	 S37ccty+L63CPpYoSmIXpJLIRN6w92+yrPb3U9qn3ONZ6dtXnOoz7MolJhf0VVsqBmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279662;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=yGWga/PRmgaqeI86sUEYeH3d58XyISoUNquFZtxciwA=;
	b=2ORgPmQ1HNKX5TjD+vcCU3dQW5e5iTDLBzCsuQo8Hsw87wmsPN0CdcgFbhjGLjv585xy
	 GBORbynIWeZACdgmDG7FpdRxEhlEi66hOeb6mgsTFl+CYVTOAf/sQzPUFmV9Uv9Q1RTr+
	 oSHrm7zz8deRbeCfDztkhP1QN0J5vEv68VTZwOdsePyplbnjSRsUm7Yp5R3vg/8r77633
	 CYBeEpd1nZnLg4L3kLeWt9wbF5jiBX9yXyEdf6tqSxqldbejkL8DM4EhUjJTcd5KaD9gn
	 q1qYCg92N5ONxup9Thr/yOjkWHRVAg+myltO6i33TIoOoOFgaU9CuBroT6cJXkXtWWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=NZFKfraq;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81209606A321;
	Tue, 10 Nov 2026 03:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81209606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=NZFKfraq
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jNry35vDxz5HKfq;
	Tue, 10 Nov 2026 11:00:59 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794279659;
	bh=Pe3VDVBKRC5rqdIrXvmE06r5cGqALeOctJfTLsspngE=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=NZFKfraqdyessPUutuOxSonpjzRNlMKPE6o4JQxmw/BFe0pIU+y/5K8Hj8uRoclj1
	 QbIejPO968AnedbofHe9QpiNbdLJ87xdrVJvcIoJS08nmTDFMygc7yWdFPFHDtQUcm
	 N53LZXNuGTdt/aOtOIU+W8U7jVv+QXEjR5L5Gw56aA+8CmgF7cgVQbIjZ31t17YTEp
	 cXB4NtbG+YtniW+rcGiy7/hnNcQpuMcbHJV6awDDVjDtX0ytKJG2DYZ8aCcx3COVmt
	 Z3QfL/C11kJQfgnY34J/maOhSVhKeglfQU69QKk8vurojXsglInDr3aVJNDplzy/uY
	 mIYjL6ts6olvA==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 6AA30rjR084423;
	Tue, 10 Nov 2026 11:00:54 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 11:00:55 +0800 (CST)
X-Zmail-TransId: 2afc6af288e7189-9ac2f
X-Mailer: Zmail v1.0
Message-ID: <20261110110055098II4wpWozLDjv3_Wa9W47C@zte.com.cn>
In-Reply-To: <avJzGIqp5ZUehCGx@fedora-laptop>
References: 20261109225110056QQJAEflTHzwYHzwXlMBb_@zte.com.cn,avJzGIqp5ZUehCGx@fedora-laptop
Date: Tue, 10 Nov 2026 11:00:55 +0800 (CST)
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
Cc: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gdWJsazogc3RvcCByZXBvcnRpbmcgem9uZXMgb24gYW4gZW1wdHkgcmVzcG9uc2U=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AA30rjR084423
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 10 Nov 2026 11:00:59 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF288EB.001/4jNry35vDxz5HKfq

On Mon, Nov 09, 2026 at 07:27:52PM -0600, Ming Lei wrote:
> The issue is real, I can reproduce it with one ublk server which
> completes UBLK_IO_OP_REPORT_ZONES without filling any zone: both
> BLKREPORTZONE and START_DEV(blk_revalidate_disk_zones()) loop forever,
> and the task can't be killed.

Thanks for reproducing it against a real server.

> But this terminates the whole report on any zero-length zone, not only
> on an empty response.

You're right, that is a regression I introduced.  The zero-length entry
marks the end of this response, and the driver is supposed to ask for the
rest from the advanced sector.  The UAPI says as much: "nr_zones" is an
upper bound, and reporting fewer zones is done by zeroing the last entry.
For BLKREPORTZONE the truncation is silent too: the ioctl still returns 0
and just reports 128 of the 256 requested zones, while START_DEV fails in
the last-zone/capacity check.

> How about stopping only if the response doesn't carry any zone? That is
> what sd_zbc and virtio_blk do too.

Taking that shape.  v2 keeps the loop index outside the inner for and
stops the outer loop only when the response carried no zone at all, so a
short but non-empty response is still followed up as before.  I'll keep
the Fixes: and stable tags and add your Suggested-by.

v2 will follow as a separate thread.

Thanks,
Shao Mingyin
