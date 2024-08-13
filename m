Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37761CF9A
	for <linux-block@vger.kernel.org>; Tue, 13 Aug 2024 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723551630; cv=none; b=s4zyxhQStb0MIHiLpf86lAgaHA9TVygM3dJlkrO1IQtxTw/wZrcrc61xZ7lQ/igoCDwBJbV7PFhIFxXWTrkCeY2Jq0pCj5ZZbcmZvLe8y+IBBTeXRMYVOHpER6GIOcBGJcbGWYMG73In3NJ474i0ottIEcpH7c4jo5ZUoNQ3vRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723551630; c=relaxed/simple;
	bh=69TP6k/wN+8t/3+lMjnruQPRaSvnK9MqG1aV25x4zEE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pgRaRFCc4ho3TnEbGLDTW4hP2/Ol68sFep1+r7EGzQP2oGaPXb2IBDac949sqtZ9CIOBMIvAEQxJKiRZpmoEF92zLyBsMLTapsvO6uiNvfx9Bk8T48uJdqIFKl3ypKRaPtE3n1lpXrlSeotXFHzx2CfA9RevguIo7PQ8JdFLj7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iiVCN4DL; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iiVCN4DL"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5d5cba31939so428632eaf.0
        for <linux-block@vger.kernel.org>; Tue, 13 Aug 2024 05:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723551628; x=1724156428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObEcd6xw3cUX/niPEVwIv6YvKgD2642IVU+esIZOsts=;
        b=iiVCN4DL/MpycMJ71+g3WwMfMes2sNjnRoUDoFOekDjqbyZcjio35bZY54owdaFpLC
         6Tto4ptzPDHf/okgHP/2JSALjbyurRpJYNR7fnM4MkzRCsm69glwPkVxp1wvtS1wB/EK
         w2bH59gDlLp9mIr1bL53XUjdMhj6XPRE0udAZsPbOmmBPGKN/Byu4DVCW4vC1YCv14jo
         b+M5Ne+lbP6Rso8CTCdMfzA+8ITgbJw6u5IHq6l3o0O+ZzYHt2Q8vmgkyQv7k29HBAbx
         KlJ+e0UTzIg9fgkwPrtMonuHM3z6l3C31m3YqY1U0WAT1r+T7ZkW6KhQs1DYtM173dwd
         8nXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723551628; x=1724156428;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObEcd6xw3cUX/niPEVwIv6YvKgD2642IVU+esIZOsts=;
        b=qoupGRls0DCUHqWKP2RW7x/h9+EI5rAG/1fFAJ9DJazE4ipIlmtKefNCvUFx6uq4UM
         LTtSLGciFaSH/dSKOHNFrz2SxBt7qShNrz3tE+JkzwYLlojoWpLA28BUb76rGWk/N9mQ
         WoHFllb7SMuoFf7oxOmiKqpWDo9fLs8ZyX0RDVEFIKJSDBJbX1cMSss/7wolA7zNv85I
         OxW5n2kQdIIRBRjCbaGYNEXSAlA9kMh7X8dsmuV4RybsQ2TxvF6IoQU7tQ/WGbGbxXmY
         TRX9RaKmSgMcK5lXhrhyXf4rJpR/3LU5slA7OgQsw+/mJ6AqH1OVlfe/oAXfpa27HQcM
         +qOQ==
X-Gm-Message-State: AOJu0YxK4Hzvbh5hizp9/h4JJ0Z7rZX39V6ZfywSt0Cnq4VuxLiHOw/q
	zaoyDm4AtemNcr4K7Sffhgq7MkeXutXc9nLWnh+S91M7YZn/k2DQp6v2OFMUHnA=
X-Google-Smtp-Source: AGHT+IEETOhKqZT3egHjpgLvaZdVcE22QZNBuME5oBL+3b1Bd/WGpCSHtVJgB8eP4RgxaWwV05ltpA==
X-Received: by 2002:a05:6870:c34b:b0:254:a7df:721b with SMTP id 586e51a60fabf-26fd1b1b2a7mr1046295fac.5.1723551627761;
        Tue, 13 Aug 2024 05:20:27 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a4357asm5609663b3a.133.2024.08.13.05.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:20:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-block@vger.kernel.org
In-Reply-To: <216ccc79-5b80-47b2-b507-990951aa810c@p183>
References: <216ccc79-5b80-47b2-b507-990951aa810c@p183>
Subject: Re: [PATCH] block: delete module stuff from t10-pi
Message-Id: <172355162691.7496.16643366669093783436.b4-ty@kernel.dk>
Date: Tue, 13 Aug 2024 06:20:26 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Mon, 12 Aug 2024 21:10:33 +0300, Alexey Dobriyan wrote:
> It is not possible to build t10-pi.ko anymore.
> 
> This file doesn't even export functions.
> 
> 

Applied, thanks!

[1/1] block: delete module stuff from t10-pi
      commit: 49923a0dff59fa6b34aa6cc16dc9eefdbbcd3846

Best regards,
-- 
Jens Axboe



