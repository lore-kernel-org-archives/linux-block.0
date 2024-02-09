Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6074666B4D
	for <linux-block@vger.kernel.org>; Fri,  9 Feb 2024 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707489214; cv=none; b=XsSpnsWTg2ReR6V9IfQKhX4f7Zrcm+d5ikiKcT9WTyb9dtEOLsZNcHb7/YR4+r/XuXT2PqapJoAWIOrlSbzfca8p6cGC8S6yfD4OZTFgniM4n2fVhWx3p1PhjfpXi7Fazjecff4jB9Vw5D4n162KD+3X6b6qt717gxcUykLS4fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707489214; c=relaxed/simple;
	bh=SjpiHYMiN7o4SN7WUyGlvg2LmukCSiKd6iLytN3gO8c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QfvimcWyairIFmLKUOB5Dvc74bz4EvZIqfDnSkHeShXMsZDXBgBVqfD8ta4eV/DctdaGzArxKqzbXTGKEAx66NOzRJX1Qt/OAH6Xc5XkVkDJKAsx1AHuz70jnuokDDO0ntMoQrpHkPHjfnHhDtjwhEuBJ5/Hfo1J7qBwWIi5XIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lDGx6p9G; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lDGx6p9G"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bf3283c18dso7343239f.0
        for <linux-block@vger.kernel.org>; Fri, 09 Feb 2024 06:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707489210; x=1708094010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVgFKAYhfQn+nElwnbqj47hUJTVhtfwCN1H+BTLsvpU=;
        b=lDGx6p9GHOB2RCLurtRipI9oNG1QHOocXinNbW5GwfMO+dVvIY6XfD1XH+fvZkDtjS
         N0cEzoJAzrmzsum2Ial1Bj+DbCfqlaHk6zFlrsOY8QF80Mv843D/8HmZtwHbN4bS3zQj
         Tau5vgGDiIG35oLzpGL3+4NZ0SZzg6sIFNHoT6mqXjIwerkMexDDuP4rrepQoLt4i8KZ
         YkBIk4jgWS/979gkqMZ+0MG1S6lrvvvurz08zrVuRyU2vx8/Z94atn5yZulljb50RIMz
         KHvdCK0/lL3UNwmkkfhjqsw5zdS+gC0Q3R54CQqz3Locy4kEPdumTXDJN95SoqFHq//k
         b4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707489210; x=1708094010;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVgFKAYhfQn+nElwnbqj47hUJTVhtfwCN1H+BTLsvpU=;
        b=Kk4ZxM7K9w4nLn99BhdX4c6zc5jtUpxzcfCXJk4X9aEsUp87K5b+RYTBbWN01VsIZW
         o/9ppx0R1RwB7EG/ZPmutwVmeYDT55c9SR7/8FYITYECpWjso1V9Q6pDj4av0OYZNcgN
         tRZMov5yZcoSHKfC9xf3QT8eYW0LpVVZ1bPHK2hXVc1y/uKO3R6dZZ4EgOcbsfg/+T9B
         G6i8/qYqxZ4U9zXgA0Ht02DpRg1RXTj+u2bteVC00GrJaSzenDhJ14ij98Z4QRk/aVfY
         +JrKsOs5BkEoPAaywEkVbY7o/5KGuqEqiP/LlXcOejF1DPONXPVwMpShSsSlTfHiWSAn
         cxDQ==
X-Gm-Message-State: AOJu0YzQIxJJYY/LCYLPmZ1ImAC7kvgQbtj1EcuVcsJHdptT6MzbLVGc
	ooxy8QU6QNFrXaopIzFg9tphZAlyig/RvhODliXQeUhjez9kU2D1l7CoowSXf0h+vOxXDNTOAHP
	dF6A=
X-Google-Smtp-Source: AGHT+IHz55nNkJNsbOp4/Q69jhvAB1qTFWFIBag13ent39Fzo8/uGE2VRanRwaUOQ8DPZNl3KHW4ug==
X-Received: by 2002:a6b:e413:0:b0:7c4:3a7e:ccc with SMTP id u19-20020a6be413000000b007c43a7e0cccmr2103676iog.0.1707489209881;
        Fri, 09 Feb 2024 06:33:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXMKe/hl5bEOrnSrYvP2WKEA4g66yDslPmViuOKEL6UA7pkDCwK7TDhnXHVutwzrTOU8sYgU1itj4Z66AsRo3J9rnuRAvTtkciEXgMM7Am6S2iyyJloY6V4XvjAwNhYzW04HPCsXPjSgs+5/HRrDP9f32vn8wSzswDK+fW3i8lGGk0k3SA9QNPMvEqQViwYcWboPZZaXtc6OJmqc0POMNQiFirgSuTuDLp4M0z9sODs8hmdAA==
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x20-20020a02ac94000000b0047147018e96sm423579jan.11.2024.02.09.06.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 06:33:29 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, 
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, Miroslav Franc <mfranc@suse.cz>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20240209124522.3697827-1-sth@linux.ibm.com>
References: <20240209124522.3697827-1-sth@linux.ibm.com>
Subject: Re: [PATCH RESEND 0/2] two missing patches
Message-Id: <170748920879.1612996.819975947367482362.b4-ty@kernel.dk>
Date: Fri, 09 Feb 2024 07:33:28 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 09 Feb 2024 13:45:20 +0100, Stefan Haberland wrote:
> somehow two of the patches have not been sent with the patchset yesterday.
> Sorry for this.
> 
> Here are the two missing patches.
> Please apply for the upcomming merge window.
> 
> Jan Höppner (1):
>   s390/dasd: Improve ERP error messages
> 
> [...]

Applied, thanks!

[1/2] s390/dasd: Improve ERP error messages
      commit: 1df0f512faa71f1e106f36529ceff52f48209e30
[2/2] s390/dasd: fix double module refcount decrement
      commit: c3116e62ddeff79cae342147753ce596f01fcf06

Best regards,
-- 
Jens Axboe



