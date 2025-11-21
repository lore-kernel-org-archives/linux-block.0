Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62262E8B67;
	Fri, 21 Nov 2025 08:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713451; cv=none; b=pZ4Z56I2XHS5wGObjqP7AwUmQpXsFO3T15aYvtD/cWjqz2zikm7D6pWcP6Q8jAluZtDXdQNwAK7xan//+jPH1PCOGBL9+QMqB/bm9I83zMHc205UlgE9sPQlbG/5pO/E8+4+eBIy2PiVJJiwdFOKF3eEj6P/glZC8MgQ0VU6Sd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713451; c=relaxed/simple;
	bh=TStxGiNgvL1+ngJwiGzkfkd49VJAD8GIA924LTHuLR8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=GnCU4+BU953WDUG4jg52OeUYn9kyNUqrGgL3fRkalIeQQ4RMKGzqivcBOiUejOThZokXZ6z/puVsqi3faHIx+gyseFVzmn8c6wteWM/TlhYFdK1WsXqhyrUA8KU5rsnwrPlofLFUkiwcBHfltcsf7a5CQw6JkWCA/Ac2o8HGVeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=RKQrA+iO; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="RKQrA+iO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1763713441;
	bh=pQLrOq0QQR+4eVsM8YUr1bTz3EqZ74x8PaNds/2DexI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RKQrA+iOdCisookcvk14Z5yjxEmikMT3jFLMqCKPt4+GHVxIt5S81rrwrH0uEdnP6
	 pDuFjHcaURvWaok1m5L3XzTvVTbpvbEvZ6LSer899JgzfGRrZiMZyuDCGg1DptHrcJ
	 1emf01+1NNBEZcRVMxpDFc9fvAw2dIPjOm2CIyv4=
Received: from meizu-Precision-3660.meizu.com ([112.91.84.72])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 5FB1F4E2; Fri, 21 Nov 2025 16:23:59 +0800
X-QQ-mid: xmsmtpt1763713439tj8u89r6n
Message-ID: <tencent_865DD78A73BC3C9CAFCBAEBE222B6EA5F107@qq.com>
X-QQ-XMAILINFO: OeJ9zRfntlNP/nfJC+X1lO5CmizeW4R30yyEPSi+ZAOnF15s818bIUMKTLMFn2
	 7DXMfvxYVYiae95vc2wW1xWCDIMZzPkAgZlIkb5rzh2/JGLDZF9XSWHj5j/M1qaCu1AtVTFFjDIF
	 O28CWP1CSOQ3k8Jb8COVsS4Ig3DDTERdRt2/Ooy4mEVwg4o2vzZOBTxQnzS0+PkBjMa+85rnHstk
	 kVjmZTiAWY+JySl7u68j+maZDOOS9JCmQGBiHlTYvMlh801ypfiEnV8cCDz4o7BbB5ZHLuyk7ziH
	 hooCTHufT1M0D23oQCvYW0jh6xGfPp1oP+8dFZ7F+KdTpaNkCWicrCVzrT3k6n92IO0Nyq+r8Q8Z
	 C07AirQ3Z3pe5uoOO/zFXnWr3gr9tz3HqBdxPeaKTlW1y4oAzgOckWNpmx8jGy36K/Q+XrquUp21
	 UfOJHH6ykFXaOrEj0DmR2ySRx9m4hPCuOzMqewHyzbWPj2G6uRQ3St7Fort4UT7sfyYUKayEfxiN
	 0uDLFsRcQhyCSsCtpAry6fMfTuyAvvpBQZyeuMZs2ICo1TeMkzHdiSNUPziNQq99c3MrP8WUcOJd
	 As5txDvdJrKaBNh1FF7XBPPtKktzN1ubcgQukzFcmtP8HuRa7UgBRDOc+IcHe6+gXXW5LXtfO7tk
	 O4yJUHvRGGxulFxHQwIpgs3sgZekQ14hyo0XLoMeoWl1WuB8gobQqE3/9bGCVG6rVFpbjNkca5Q+
	 DDK4aKbojVkDKK2bYl2DiU24R4nZCZwNfeAyOyvys/YQrGKWhJdk4rnoaYgTjXnnNGLfG2XoNaCr
	 K+1c/9puY8rEb5KEBACZqDdWzjbJCZw+f8I/WmmfGCWbPD7pKyhKAKtaHLh3sikZayCIIZGK1fXb
	 TjQFw/+kWWqPvErQJZG/MpsmOEnTvT1YNDrGEvABOfxuZ9hhchRee+NWMiOYpI4mm/i+wwZ9S4aW
	 FLDQYud6juRugTSEfB/9XFn6qJ6QtMG/nXwK2DOWbV7a4A5SUyL+RgdyVhWEx92TxI7FZRpQiwqu
	 4Q+TYgH0moYERRYOHs5vn6bv9BVzPPPpXMXVog3oh723JmWumNdWK5gWfHQKYeCt2fSGc2H89str
	 bb/bdA9A28WRci2xS0TBKpQCkNcgRt5wjdfe+AmkfyWvYdaDGpEM7WBBUtig==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: senozhatsky@chromium.org
Cc: akpm@linux-foundation.org,
	bgeffon@google.com,
	licayy@outlook.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	minchan@kernel.org,
	richardycc@google.com,
	ywen.chen@foxmail.com
Subject: Re: [RFC PATCHv5 0/6] zram: introduce writeback bio batching
Date: Fri, 21 Nov 2025 16:23:58 +0800
X-OQ-MSGID: <20251121082358.3003848-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ts32xzxrpxmwf3okxo4bu2ynbgnfe6mehf5h6eibp7dp3r6jp7@4f7oz6tzqwxn>
References: <ts32xzxrpxmwf3okxo4bu2ynbgnfe6mehf5h6eibp7dp3r6jp7@4f7oz6tzqwxn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 21 Nov 2025 16:58:41 +0900, Sergey Senozhatsky wrote:
> No problem.  I wonder if the effect is more visible on larger data sets.
> 0.3 second sounds like a very short write.  In my VM tests I couldn't get
> more than 2 inflight requests at a time, I guess because decompression
> was much slower than IO.  I wonder how many inflight requests you had in
> your tests.

I used the following code for testing here, and the result was 32.

code:
@@ -983,6 +983,7 @@ static int zram_writeback_slots(struct zram *zram,
        struct zram_pp_slot *pps;
        int ret = 0, err = 0;
        u32 index = 0;
+       int inflight = 0;
 
        while ((pps = select_pp_slot(ctl))) {
                spin_lock(&zram->wb_limit_lock);
@@ -993,6 +994,9 @@ static int zram_writeback_slots(struct zram *zram,
                }
                spin_unlock(&zram->wb_limit_lock);
 
+               if (inflight < atomic_read(&wb_ctl->num_inflight))
+                       inflight = atomic_read(&wb_ctl->num_inflight);
+
                while (!req) {
                        req = zram_select_idle_req(wb_ctl);
                        if (req)
@@ -1074,6 +1078,7 @@ next:
                        ret = err;
        }
 
+       pr_err("%s: inflight max: %d\n", __func__, inflight);
        return ret;
 }

log: 
[3741949.842927] zram: zram_writeback_slots: inflight max: 32

Changing ZRAM_WB_REQ_CNT to 64 didn't shorten the overall time.

> I think page-fault latency of a written-back page is expected to be
> higher, that's a trade-off that we agree on.  Off the top of my head,
> I don't think we can do anything about it.
>
> Is loop device always used as for writeback targets?

On the Android platform, currently only the loop device is supported as
the backend for writeback, possibly for security reasons. I noticed that
EROFS has implemented a CONFIG_EROFS_FS_BACKED_BY_FILE to reduce this
latency. I think ZRAM might also be able to do this.

