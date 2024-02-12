Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929E33CF60
	for <linux-block@vger.kernel.org>; Mon, 12 Feb 2024 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752878; cv=none; b=cCgQ+ha6gOcaedJXlJ66wRgVIflFYoz9OCH5hDsypIzQtkZlcgGnTj4KzFjOW7iJaSLALu1ihey4mK8LldZpxlpc8vbfQFIKExf0YAJ3K3ffNxN8sVr4xfIj4N3mary8BNDsOFrfuBlFro6AZO7VqhohB3dujyEq59iHtz9WMqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752878; c=relaxed/simple;
	bh=M/DDkogYtMEaImN4LKqvo1x/3+1RTNwbeacY2yMcVoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0ioWJfCK6q/349dX9EBHi6ZKYqx623hVOQSdDxkLBi/hK+Drfe6BCGaqw5E3BAnt35Z/htw3RbxDxoz5ZAdMTNIS0pO9F4w/mNfQifeQt8QxPA59Vfdf4RWEkHwih2hniltHuNyGyLGxH6h+BMN1BbVttS/MePlK36ywbCXaL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8aLN3ml; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8aLN3ml"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4114e0a2936so4329225e9.3
        for <linux-block@vger.kernel.org>; Mon, 12 Feb 2024 07:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707752875; x=1708357675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/DDkogYtMEaImN4LKqvo1x/3+1RTNwbeacY2yMcVoA=;
        b=j8aLN3mlfU6le5zXBMVIaJAZNDYsfa5McOZKngNfqhZaCiqvSio0axBwDMXxXJILMq
         10Cac73geLp/tXsOBCLA/8qwCAkpngEzUR621pV7BqXXtV5rXyTGG8h7AxX7TmcQTzLZ
         1ruS6Luj4cNGV7dkS46NqvGEaHY9Uv9HudWnkuNS+QGYOzr+OHRf8PuYnM3DC04f757P
         Htni/iAlwpuYPL51RtvoGiDcQlbBR4gmUNsAF4aGIYis2iurnlWiAfIfzRaRzzk3+d6+
         tBji0l16P1j5e30+yoMADL1Arggp/u1VpBUCw3MxEe37K0mq/yg7IATFexCp4WDSPGAI
         1p6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707752875; x=1708357675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/DDkogYtMEaImN4LKqvo1x/3+1RTNwbeacY2yMcVoA=;
        b=fjvgMNmtYmvQ3wKIthhYCTqKR9EaX0n96nzbT9cXABrZvAlIhFciv+QoQ6Gx1dSiuw
         XEGkhbztifYQK8GouGUPjd8ZrcL2jXD6UevBqsiZIZxgkiTc0Db5Aa9zNbqoomVHMsZo
         3VwSktiH6w0sKQcxtbwiXrvMnAOlV3i08k/HJSYSbpT4vEvA/UNJNd4ultn+A/boXaAA
         zcHTzTPByaKDuQ09mg4yGk82BTjJDUv08gXNzJjzXj3t7I7HVBNE1AhAdFM3hmmt0mRA
         EZWW4uG0PVzRf83/CGofVN2Walczu6ljgB8uGTidiGpLP945NPG1vnqgK3lr3r1xyUSz
         L/yA==
X-Forwarded-Encrypted: i=1; AJvYcCVNmw+zW5Oizh0Tu82fW1mtNsgn9zQQFwZqjuIiSj7/tY9v1NK5VxCP5kVyyBWvF491BxkU1NbfitvjlzHS29xlWIkViB9BE4pKMmE=
X-Gm-Message-State: AOJu0YwmfADetZ1SujWVNWOlw5mi0n7/dyHz6MXPxc01EZ2Zm5hwDRRF
	7P9xEFk5p45V+CO8YZNQOeOcVgkBh6FaV9wNpklblaJZARgd45wvHN2+1OSUNwX8KgF1FC6jeng
	Ck73tfhinmHA0NfFSA3sCZmWsynU=
X-Google-Smtp-Source: AGHT+IEUWTXAM49cUgKgHiedCs5fv11Ii+BR9KeDc28nS1BeCbfCLQgXMXuqH0Z5zD2nBsVFI67ZdYiYvl5aKmlfsaM=
X-Received: by 2002:adf:eac9:0:b0:33b:7947:d22 with SMTP id
 o9-20020adfeac9000000b0033b79470d22mr3100446wrn.57.1707752874459; Mon, 12 Feb
 2024 07:47:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240201130828epcas5p10bd98bcb6b8e9444603e347c2a910c44@epcas5p1.samsung.com>
 <20240201130126.211402-1-joshi.k@samsung.com>
In-Reply-To: <20240201130126.211402-1-joshi.k@samsung.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Mon, 12 Feb 2024 21:17:27 +0530
Message-ID: <CA+1E3rJKw67damynQbi0L61+D--oC3BBUF_KSEOKWJpUd7Dhdg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Block integrity with flexible-offset PI
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, martin.petersen@oracle.com, 
	sagi@grimberg.me, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 6:39=E2=80=AFPM Kanchan Joshi <joshi.k@samsung.com> =
wrote:
>
> The block integrity subsystem can only work with PI placed in the first
> bytes of the metadata buffer.
>
> The series makes block-integrity support the flexible placement of PI.
> And changes NVMe driver to make use of the new capability.

Hi Jens,

This has got the necessary reviews. Can this be picked up?
Or do you see anything missing?
