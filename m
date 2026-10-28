Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205863;
	b=CRr4bg5I54t4OcX68/+jqcQxFtbKeg69/08+E4X//pSxZ+d257Mm2Mg5fL9HbZFHMp4o
	 idnZFrcIwBovbhO6XjiEGo4dvCjCCWqydq1VbkndNiosvVUA1NkU2XdS+/vyp/lyrKAmv
	 oVFFqKffdJwtfk7n66eD8MP+3RL2I83b2ln6gC/M5O5RoK2JEfRea8+BOFUmCcExiAaAQ
	 RkszFe/L/mZ2HqBYcaWZvONH1uFL9QbUsEwbIXP2rsGixgADdBSpPz7/3UXruIlEOz1Er
	 8udAneYObQDDAN3V5IwnEQq9lfqPl6oi++mvQoh0PC1Yg9I1abADRnlXxQ1HOS8HyKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MtoAFkUARZ6sctfHtcZ/2HGK6Ul7c57ilohnFA/OsG4=;
	b=k6BJnyCdl66TMN23CGdMXlUYT09nuoJAwcGyPd8d+C3wD2hgF54+xFeEXDbmFsvxFOvD
	 ze8PoaXtco4OBH12manjCmz3vD+sJEv7hRYhfXGqnHtR+kfY0JK3oEwr1O48itggenLNF
	 JnOWodGCUJeEBqA0lifE76KClTXVlEqQA8W7GnyaUr3K4n8K8R7813BlFHJcxvpxz9Sr9
	 lp0vhm9KIS0PevTgz3Mhmmys93JLMFu9gJ5gMfahEqfv0FSiUmtT0pmwjMRpioyIb+Wyg
	 Px5AGDxQWpsDBe3jxizTgHTNq34zsxNZGY07RmcV1R8tQlAmDOOav7nOsEzCgor22uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=eTAMOHeu;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5000B606A329
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5000B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=eTAMOHeu
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-823b938464fso825080a34.2
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205862; x=1793810662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MtoAFkUARZ6sctfHtcZ/2HGK6Ul7c57ilohnFA/OsG4=;
        b=eTAMOHeuYaK4WuHcbJbBBlpY0c474K2TAIw3kCs3OrVwSkl/IvLpOdTzr8LlnTQMOt
         sEskkXYdTSx/d+eBWv/ZtpsQFnVHQQdtRPKr0eelLaxaOWy9KLwjCH5mr6pksnuWStbZ
         iJiIWvb/AlJ56SfQrDmeWnpKViiMY511QYCRKLg9XKEZITnwyrzFT7SSKkD3kmMOBhYp
         qBnNa6MNF+qAAwj7BzgGgrm4g7sPNfV12QpRIHtB+aKpkVlt5zmXt0+eBJS9Z3A488/w
         CpG9BKT6P0U5eEKN+7QUJ7uTdLYJzx2wdMUV5OSV80IcPb+E+hFfAQ3nuEjHYPVIU59Q
         e4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205862; x=1793810662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MtoAFkUARZ6sctfHtcZ/2HGK6Ul7c57ilohnFA/OsG4=;
        b=L2LsMbMN1KoTCGbXTYlBj0UFJ6Y5JKeTrvvakqMw6Dzp+7v/OFxVEwIXEKsDosoo0g
         lbC91yjySQ2jV4yUMdNulsLUriXFUEN9kvnHxw71Prg9Ij1JexcBlSa72x5v8j88vEXZ
         eECrLmOFSHIYDKY32bd4pIUZr7PFsRu5XGeC2QnxDyMTr+m8IeltJWF7Ey1uLrojc15N
         uTAwRX7obt/zL6Ma1IIrwt1ZPdXuBHsEcvWRt4o8O1mKU5WS3hOXof8hvuWMNSP/9JSw
         fAui1/nVIuVF0iPY+ANlhOfIjeL/po8oARS3oxDBeHw1eftgSTsr77XaBF/ID5U1l/6H
         xRpA==
X-Gm-Message-State: AFq9FYLO4vavNNarqi41eW/snE0mu8EvgDmmqQDUuXFEt1QFY1Zro90k
	L2+0S8MM1YdWlfJdyjAboXkl1VBtEcAYxDwU5NK2bKIxBVhQwNfX4GMZIyxHkzenqhKkdSo5JSr
	oNbR7zxA=
X-Gm-Gg: AYBFou2zBS6vZ0HpdJWet6gehQHEd7dqFQwqtRx0JXGgM8uHrfpm4gkcfQk0MODmfW2
	ugnYxI7WAF2ncB2V+mfw6FroFeVhty/LgXjAp37uf0nIMDYeM4R8Utmi3I8yQsUnskRYJ5i//b0
	xxUaqZseGlvW0GdFGlR6dp8KgBqZhiemYvP0cu12rvVe/jT3RAeQjg4vxCEVCIemlaqses+GebP
	s2e99InPBarUVELI8giczwWkpezmkr8WseO5N1xaHEogyVe0k8gXmlFH7VOnPfcpbfXHxiIiksO
	MELujgno56S+L1soI3U/wtUuT1gZwUnIVsZMwqDEoTqjY2bCLPSppHhtirBo3+29+k+xGrJSebR
	xcTDBgSnU+O1juIxFe4nk6j6YWqEYEs5fQtoEkK6RsZY6C1cvJwz+3/cI7aionKva7mUmCjXrW4
	AUb+AC4u0TinmhDrPOtMR0Tf+J0Ou06CK+0Z/289tmfTCEeYTkIv/2LS/ir5IdTNLFk00/mV0br
	eqv6IMC530NNg5lWGJGzkMgTZDlw81sL79eQzSKeE0LFCgs/NfdHAyouh/T06IsbHfnjbxEPP+w
	ISaD43Lo08DHIw6yJROfrXDRNh3yKAAT0hwYRckj9s19N8wa4Ebx+XtjplLGoQhybPKs9Ql8bw=
	=
X-Received: by 2002:a05:6830:4116:b0:823:e626:27c1 with SMTP id 46e09a7af769-85ab87cc78fmr2647712a34.10.1793205862314;
        Wed, 28 Oct 2026 09:44:22 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/98] blk-throttle: don't truncate the cgroup v1 iops limits
Date: Wed, 28 Oct 2026 10:41:06 -0600
Message-ID: <20261028164415.1262013-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
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

From: Josef Bacik <josef@toxicpanda.com>

tg_set_conf() parses the limit into a u64 and stores the iops ones
through an unsigned int, so anything above UINT_MAX is truncated and a
multiple of 2^32 becomes a limit of 0. The next IO of the group then
divides by it in tg_within_iops_limit().

Clamp to UINT_MAX, which means no limit, like tg_set_limit() does on the
default hierarchy.

Fixes: af133ceb2610 ("blkcg: move blkio_group_conf->iops and ->bps to blk-throttle")
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-throttle.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index ffc3b70065d4..4f10fe05744b 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1386,7 +1386,8 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
 	if (is_u64)
 		*(u64 *)((void *)tg + of_cft(of)->private) = v;
 	else
-		*(unsigned int *)((void *)tg + of_cft(of)->private) = v;
+		*(unsigned int *)((void *)tg + of_cft(of)->private) =
+			min_t(u64, v, UINT_MAX);
 
 	tg_conf_updated(tg, false);
 	ret = 0;
-- 
2.56.0

