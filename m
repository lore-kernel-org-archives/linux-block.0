Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B0A192590
	for <linux-block@vger.kernel.org>; Sat, 21 Mar 2026 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774103267; cv=none; b=DZiqd40HyVz02YmVjWcg++7Y0YeOPxPESpD7npIDxxjZjfAmppiHVGrhT96v9O2fr2XzZYrw50rv25qKqZSemFI+THjwdWgfS3xO233W5jardNCUNFAs7ZsqkzOpnGLH4YNJN9EwfSrj6QvCiWVYUBzAchzkCxWHw0b7NOlSjEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774103267; c=relaxed/simple;
	bh=XbJvTOd1ukwPGu2B9QSbSkII0ybcEyvvDNPe4pFXwFw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F32zrugBVKxTuMY2DDFYTH9zDfO7C2tZFooo7U/V5PJ0O0HO1/jZ5PLDm23t/+AJx2kdtIcDqm/wMUdprO4ljDzLm5Epc5MlE2dw0AJ3JDjlc4pMQTOtwZ7P2+NvYowvvla8lp/wu2K/VYAoNMGlgk4tDCEaHyZ7ZPEnDdhbS2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mGBersy6; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mGBersy6"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4670676ba03so951857b6e.1
        for <linux-block@vger.kernel.org>; Sat, 21 Mar 2026 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774103265; x=1774708065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=By+r1Fe/YcOBcCg/TUP/Rfl3T3jnspwWgDUfbTqj4k4=;
        b=mGBersy6NNuVGCzzex1I7u3IC6ckORW3S5x3pPRjUsQgq2WNIPS1fUUxi7klBu309v
         LuFeUd4PEbb0fnTBDEoPwTB4pacYiXus2ZdD4Lr1lh2EhRqfHkwi/CqYnDTRxAkt1YvO
         +fHEGoE07oTYSeZxZxxqZD62Lgz5PbJb6NSQN4R0OOkZWLNuP8IgpBx2VHjO+Uppy6fp
         Np2aLa/9fUgEhHQ69KbRK0TabRl2oeu5QnBYQ57RgKQRd0/pnDuzDaKwDqDkVTrMgSiV
         GpNZzXpxFwgkD7gkifWSSKFVUkDKDkC4zh08w6uerFTjhdjdklJnKU6CI+eTl0ua1ln/
         wu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774103265; x=1774708065;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=By+r1Fe/YcOBcCg/TUP/Rfl3T3jnspwWgDUfbTqj4k4=;
        b=aRHNuYpWhli2WldaFUQPGGVWijul4JLj3kjdILSHE1tgPf2F0gEDKF+8Vq5EVNbDDj
         ASB47PYCRBaM2exB5ThXLUc3PxHnu41THEAbnYncAHyRyupugY+q0filI/uU0NvumJBi
         59cU170OS3m5gl9oj35dyveKredqHdnsYZNoiM0IgWJQ28zoZpzb4u+XaOBzw5PIdEtT
         JxGGfeoyJsFh2FkaOsFmA/9qM9UyE0g9wF7J6wUBNkuqlhkpZhBZZK9pg8dfqj5F0oxd
         rzcpiOpZDtOXEPjIUF32WG7t2QvkmTFN5/UjEBye8ddOiZ4DEaPA4KFk7oR0Ji5a3/al
         LeXg==
X-Forwarded-Encrypted: i=1; AJvYcCV8cAFkZVjCaaRV/O1UQV+4bSYZ2Ui7J0UFH8kpmBPrneU6bUEc9gKokc+Ljl2JL1ggEe5wHyRoLo1rhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSBbmn56O/kklAASThnOTlljErQEYENap2jOhiFKJpnTCk51Mm
	MEttrlajXTxe13/ZwV1SaKT/pYBPxdlR+wDPlRC1nRWmPtgZ0cgkogFfpZIopDVKR2I=
X-Gm-Gg: ATEYQzxDx27UGu1z7ODpipLVHFeliFT1wnBcfjg08EbYc9+GldL8k5Tub+xVBDIy5iI
	ipInXfgSaTiMYkN79uDvalhZOVF/xRa5eN0fzLyaFMYQDdI7IAaIWt3+AyJr7ODvUWKch4zLdEN
	L9hheSlwHM5L+Vqh3UO0Cev3BjI5vJ16HDCN/M2UW20fsNnDVHsnJ4BpAn89kQOA7o/CdcXr0Kh
	cZ279HcUCBJIr11uihEvyJ+GjdgJYsIStWj4T6r0saPTj++xEHzhjOM7JkjXVXVKFbijWNuaZUZ
	jmZSqwh2TqffLyCJPd8DBur5BhfVEihxGvdNoRLeKVeCTPewgSCVlim0xuoyKnNR1HqMSjCgUhC
	WZOzgSWF+CjyrZx3mhjafFgvhbtErEMbT9oz+4LrWHpnLYecfwhW5q7qWI0dFHBOZRydAj+Wjfn
	USasb9WebmZCne/4LkzPoTZQPYcYCinORc2sKsHP/ZQ5ZNQys3E3CLOy7RqV14GF4pLgCOxipRI
	w6h
X-Received: by 2002:a05:6808:1392:b0:467:255a:7453 with SMTP id 5614622812f47-467e5d9638fmr3487371b6e.14.1774103264871;
        Sat, 21 Mar 2026 07:27:44 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467e7f131b2sm3215075b6e.15.2026.03.21.07.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 07:27:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Kees Cook <kees@kernel.org>
Cc: Josh Law <objecting@objecting.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, 
 "Richard Russon (FlatCap)" <ldm@flatcap.org>, 
 Thorsten Blum <thorsten.blum@linux.dev>, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-efi@vger.kernel.org, 
 linux-s390@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20260321004840.work.670-kees@kernel.org>
References: <20260321004840.work.670-kees@kernel.org>
Subject: Re: [PATCH] block: partitions: Replace pp_buf with struct seq_buf
Message-Id: <177410326319.185838.7918397412644396915.b4-ty@b4>
Date: Sat, 21 Mar 2026 08:27:43 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0


On Fri, 20 Mar 2026 17:48:44 -0700, Kees Cook wrote:
> In preparation for removing the strlcat API[1], replace the char *pp_buf
> with a struct seq_buf, which tracks the current write position and
> remaining space internally. This allows for:
> 
> - Direct use of seq_buf_printf() in place of snprintf()+strlcat()
>   pairs, eliminating local tmp buffers throughout.
> - Adjacent strlcat() calls that build strings piece-by-piece
>   (e.g., strlcat("["); strlcat(name); strlcat("]")) to be collapsed
>   into single seq_buf_printf() calls.
> - Simpler call sites: seq_buf_puts() takes only the buffer and string,
>   with no need to pass PAGE_SIZE at every call.
> 
> [...]

Applied, thanks!

[1/1] block: partitions: Replace pp_buf with struct seq_buf
      commit: c2d466b9fe1913f8dbe2701156c38719c94188f7

Best regards,
-- 
Jens Axboe



