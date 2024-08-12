Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6192F1898EE
	for <linux-block@vger.kernel.org>; Mon, 12 Aug 2024 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486336; cv=none; b=iLqVaJkV5dRzYADssQfi+Xe1n3DN2W2/7J231VHU8QKOe7MOgCrffGZciC74H5XPJkJVHOFnUSh1vSGrkE4ZXGQwDoCkLuFMUbQl22Xp1J/dqUOcxr98F5JKbYwH8iafBpAWfBWNo3T/khVaGHTJ/q5padF7gHr0xfHqRYkaB7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486336; c=relaxed/simple;
	bh=/5/9gosb5zmxs39DKJbLLak38PcGclBNOqbqEK1N75o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c8cOyWXMx3ct/5x3mmULHfttElrp1v45wPAVzu411luQ8UusYOd7owHpE21XkPER6rtmm8O1Rm2fiGOIfaf4ma3aMb44IWqT7vawqoRv9hbcP+elL1dmvYaq4GrfuSOt+4NtAMKi0/9gfJ9b4T5MSE+r/MA3h6RFgQzBR1vF/oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHzirUX8; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHzirUX8"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f04b4abdcso6543775e87.2
        for <linux-block@vger.kernel.org>; Mon, 12 Aug 2024 11:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723486332; x=1724091132; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HIItPptJ1KhH0/q82JiEt/cMVNjs7oVmyfNn1i6xmxE=;
        b=NHzirUX89FFEx+E4rH1+IoII/vVRVztFi7hWQEoK3vWJMseWBk+YhFs8qgiLJqOmil
         +hQuHjokJ/LWDfjWG8FzhzW7xoixE2/gstex9s6n8g3cwEIxUoHRH4RdG3tqdiByrMmo
         j/0DNubC5zl/QuMy0Jl0WA85jMxgimzihVP5AKY66f9ByErgZ13B2WaEgtKLVPM8PBkB
         J7c4hLHmdlc50C2tuKozvAVcBxasAULLnW/wyVm+Z84sAJO/LM//Nky/CgGHbdQkq+jf
         4mYnyc8h7b+lABjl3NQbZk8Z0N02v4toB3eRM486cyb4j07D/jxNVspETp7YU/ZgRLTN
         lX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723486332; x=1724091132;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIItPptJ1KhH0/q82JiEt/cMVNjs7oVmyfNn1i6xmxE=;
        b=o3efRwXQC9XsyCx8rlfJ0asGBr/pXjtmDOCr+3a5noExlAeFaLrm16m2VIn+lzqMNA
         O7bKAl7bgJrO6jTenIU17l4/fDdQlYEk6Ee0knibYt4kMTpDPw5gKpFmNHi4GMkKKD1T
         F05SuRizAzwms+D0bPlEhBndd7NHZ3wLkwAcKJBiy7xM0Tc6000GNaGTee7Nl0Tjqh8D
         8qaEhUTvrVDG2saVuo70r4zcpGlFLe9Oi2wPubbGPAFCx9NW7Ew4PI8WkZyO9K2cGfem
         z1unaAxKDYQEOhpcGuNUbz8Ku1fpT0PFUDIqMhp151lISSfaHp9LNI0Xqh4RPDyZaERq
         Xs7A==
X-Gm-Message-State: AOJu0YxTTI5tW3RswpH95as4n1/xFGXf1+TijufxIdXoVp/QVswRfNH3
	v4lBHvF+ZSi6Qb10UCYPiOTrhLaV9QiHUwp2hjXcUL7KoXNXlIcfC8aI
X-Google-Smtp-Source: AGHT+IFSZcBZRRhxKrvU/TXpEcpNZNw387ex87cn9PTOPBzBz5ZFo4etPthdA2iFn/6Tu+0cGRQPkQ==
X-Received: by 2002:a05:6512:1241:b0:52f:d090:6dae with SMTP id 2adb3069b0e04-532136a4a2dmr770794e87.52.1723486331952;
        Mon, 12 Aug 2024 11:12:11 -0700 (PDT)
Received: from p183 ([46.53.254.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb119ab0sm250653666b.91.2024.08.12.11.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 11:12:11 -0700 (PDT)
Date: Mon, 12 Aug 2024 21:12:10 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: constify ext_pi_ref_escape()
Message-ID: <d24611b3-dddf-473a-903d-39290db03b11@p183>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This function doesn't mutate data.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 block/t10-pi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -239,9 +239,9 @@ static void ext_pi_crc64_generate(struct blk_integrity_iter *iter,
 	}
 }
 
-static bool ext_pi_ref_escape(u8 *ref_tag)
+static bool ext_pi_ref_escape(const u8 ref_tag[6])
 {
-	static u8 ref_escape[6] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
+	static const u8 ref_escape[6] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 
 	return memcmp(ref_tag, ref_escape, sizeof(ref_escape)) == 0;
 }
