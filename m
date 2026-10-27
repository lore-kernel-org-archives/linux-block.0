Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793068517;
	b=fkjkVHjrBHw4a52uOUqCfjiaILXF39DOHyrR+xDaS92qdiPL2EKLNaVLuB113fm908Qe
	 RPtAafn1VNr3KCIB396YJia33JIbe/d7MZeJhegkbOJ3EXbgSOK898XrYHpzSFrbVrGw5
	 QwKTEIZZ0zERbWuFmEicvJ5rK4FdVJw+vfweyn4MPCKsCr3LjP8llBXL35DdYb6U/Xd57
	 ftYI8yuGOntxdMLTYlrJL2MRmmXlmJ2NWkZ52EqP18gwSwqmdXEgy4ZDoUedYFnQGXhBH
	 EoeCRFWxsACbhuISYrUF06HGpDfeLVFzv0gJWipb6nkUVLFSdb5yqsdrGx0yBKhPaEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793068517;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=vp12/wxQVup3rbtTj1wwKYewDy2prW/GKseBgRKL+Eo=;
	b=oHaGcG0NZdAq/Hy+8zGmKhbH2IqU/1RvGXgXwErMRiSflkK7ElP5Yaizxx5vOBD8XiMn
	 QCJIiy9SO+bTcfqWwu2mkJrbolAICqLo69iCemIS5OmpqI/pP3hqohLWuPw7J7wP/KdV1
	 GRPiKMS8SDDWqcwMDPe6XKZhcpb99WVxUbFXeWBUNishO3Ju7lOr7tXwWhMVV8a8ORrss
	 YPnFioQLNOu+j/QwxFL4Hf2E2rbsH/xOCQZGTm+ikNiyC67tGQhUIme/NelZMvrQMZxru
	 qCmZl4iBLrviWj8WGkaLQxdhnqjQ1Jv5UoAf7coPCztQJpDIiOgWbj6XQ3QSsJ7yDJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=MFaQhAZW;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA4C606A31D
	for <linux-block@vger.kernel.org>; Tue, 27 Oct 2026 02:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DA4C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=MFaQhAZW
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-181516de561so342699c88.1
        for <linux-block@vger.kernel.org>; Mon, 26 Oct 2026 19:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1793068516; x=1793673316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vp12/wxQVup3rbtTj1wwKYewDy2prW/GKseBgRKL+Eo=;
        b=MFaQhAZWtfM+ooLaDXqjKZafCpM/iPi+blZlc6w8E6NpgS/azVNx55lElSKqvaRCkM
         aYFe9Wri2U4edHilYou7KGxY9d+L50NWLiDnlG2mIobpdxRkU/6A5B4qNR5pUdC9HveE
         DuCxvxvjNvDvn/crfGR5HDXLTDQBG1C9ZR5y1FB1nSZXUYdrrPTy6LiOQjWIkwBw6gQO
         81/hrssz5cyJqspmfkIyE9ZqlNlKNl1zvOl4M26eFr5Wq3oBfz3BpjPVPyfIzESzILca
         dbRy/4HgCHpB8DP5kNhQdvwDqQMNHZtXYx2Bfs1BEhgf9fpDv/fTRFn3EbddbHpR5uqh
         oduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793068516; x=1793673316;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vp12/wxQVup3rbtTj1wwKYewDy2prW/GKseBgRKL+Eo=;
        b=0F3EQOMIb/yYGY15+cGTuYsFaMSBkFKKqG5bDFSr4mPM2TdlqCHl8aMUGF/kmmn1Xt
         v9937K2MKELKIs/lBVA/m4105qRoskwjPKtBSZFrRAefEdxM/FBvqLGVWSbXhoCUCxP/
         rzbzqkuRP1weaHyHhUVl1kdwqEAgNu05tsMuKjF6M+LZzkSfhSg+mjv4m/2oXviaT3L3
         i4o11hlED7GeE0RqAnaBZgsBOMCeDQ/WktKUx4uzCDj4xveM9b1zdxqHZAg9Z5l7dC4e
         oEL6N0ysFehyYL++OUUlr4L0cW35pfGUw4aH/pAwguqYa0BZKlZl2t6JYNpqOxfqGwy8
         CwNw==
X-Forwarded-Encrypted: i=1; AKwUvBw04p7m2c0uU7WkLw3ny+MuYKGWKnxVpvmEllh+k2fUIiIpwe9zrY94FOcry5Pux9FtWJCvTAmytWubXA==@vger.kernel.org
X-Gm-Message-State: AFq9FYL/fHfqkU+1YXH4rBuPTWO/pYbZk5vJhP8q0CMmMlxBOR8/u4lj
	4KROQvwfpETVecjB92E0VltoIaf/WIMtrN3Zp/v1V4JHBM40Afe0wHUAgfSRn27DnLG61e1ZRb9
	j/O7y0Tk=
X-Gm-Gg: AYBFou0h4IZjVDQ1dQZsPj88E7Cq11lw+vcN9l3xtyLCengZ0B9ZgzO7epJuiU8ne9n
	7o3/ap/G8fsa+T2h6iNZpP9Zq7bJH2tYLFl1Sfyf2ygNLip6LXlzLt3z2O6RB9Esv0mXlz7JIC+
	1irjmuqZQA/hpVMXxY/A1SNf2QP7lwRXTWpaHXTg/DbdmpFjuPjUfeCvr1wMjARiAMRmBEhS1Lc
	lnGvmUTxk8wp4OH4SMK80SY9ckdOwa9d2B20Oe7i1qHI8vYmM6e9f2aD4UWZgFf15rh2OUkJIWu
	/Om820VM4nXWTsln4b5rlDS/6q/CejqOzW7fb0KtPPqcaRmCX7Ilw4lwUGglwYcgeAH1NmxfWPw
	XCJ0PmXVU3/IJFjTY6NNMpriNqgcTI50ydkqbyrAUuuADbphj9i24CrWOB47ZJEKWyAJxoST50P
	QG5X5cBpQ/JzTTEH33+fm3U4ej/muRPUpUbk/TctFgDckwai3u4VMC3CDrJc8WmaFYlMYg4gncv
	cyghXnq/1jx5/CyyQFzmQa5peNet2HLiUIlijbPP6CkDPyfAfWCIqPn1c6Gi8cIHclrTwQTA3H3
	GCjZ0g1Lxl7JuWwcWC9qm2p2cn4cjggvUs+qyvY=
X-Received: by 2002:a05:701b:204a:10b0:195:8fa1:b447 with SMTP id a92af1059eb24-1a3c84c2907mr1914030c88.12.1793068516057;
        Mon, 26 Oct 2026 19:35:16 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2a5937dsm28512618c88.20.2026.10.26.19.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 19:35:15 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Dominik Maier <dmnk@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org, 
 dmnk+artist@google.com
In-Reply-To: <20261025200740.2064379-1-dmnk@google.com>
References: <20261025200740.2064379-1-dmnk@google.com>
Subject: Re: [PATCH v2] loop: check for read-write open mode on
 LOOP_SET_STATUS in lo_compat_ioctl()
Message-Id: <179306851514.868427.4658247207276763835.b4-ty@b4>
Date: Mon, 26 Oct 2026 20:35:15 -0600
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 25 Oct 2026 21:07:40 +0100, Dominik Maier wrote:
> lo_ioctl() checks for (mode & BLK_OPEN_WRITE) || capable(CAP_SYS_ADMIN)
> before allowing LOOP_SET_STATUS or LOOP_SET_STATUS64, but not
> lo_compat_ioctl(), the handler used by 32-bit user space on 64-bit
> kernels.
> 
> As a result, on 64-bit kernels with CONFIG_COMPAT=y, a 32-bit
> unprivileged user-space process holding a read-only (O_RDONLY) file
> descriptor to an active /dev/loopN device can issue a compat
> LOOP_SET_STATUS ioctl to modify lo_offset, clear lo_sizelimit to 0
> (exposing backing-file data past the configured limit), or alter
> lo_flags.
> 
> [...]

Applied, thanks!

[1/1] loop: check for read-write open mode on LOOP_SET_STATUS in lo_compat_ioctl()
      commit: 87409eedc543d288cdd49c2174f7d61eca7b8db5

Best regards,
-- 
Jens Axboe



