Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D1B41746
	for <linux-block@vger.kernel.org>; Sat, 27 Jul 2024 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722098047; cv=none; b=CHTo2UgiMvFobTNjFIjSZ27vwhUGyXR0E9K6KVQpE+gi7mmvhTE7eB68u1dwAnoNIioPHAA8XAIExR9nwZdMPLbutpWvaVQf+HAgWdk4AAfHTKoeGwifTGHdj1S+OMzuWbquZdWwLFZviOgtB2ule5SwAFXywhh893KuPNiU1K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722098047; c=relaxed/simple;
	bh=tYDcFLi5DC53BcRnZ20ipJUQdFy4ozwidqFJQUZSMrg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z2yenVeZDjQs24gVUIkb47jQqAAji9eYCpWP/EFiLrVTmWdNZDhktMqJWptXNmuIPqxBO8j5TbFDbqyPDuwcWN113M7VgOg4hQ24c19HuEd7m+hLqOiUSHKWe0xUeFa4J3HQQcnAsRuRMzN/TsrBbLD2/Asx/kP/FiZbWEuqPxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xkiQX+7F; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xkiQX+7F"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-25075f3f472so552189fac.2
        for <linux-block@vger.kernel.org>; Sat, 27 Jul 2024 09:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1722098044; x=1722702844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PQUXj/we6PnQROMy3jytsmFgfmtKin4VhNZzgFedts=;
        b=xkiQX+7Fw3QvRaXk6qj0spGvfhPJ2cu7bXxoNiWrF+KB95uqYPCKsPEeOOkI2LpyC2
         Tx2e92Ibgp8DfIm6kNKBPip0wijbysvfsqbwqrwF0z+ntwZSQPaqdC0DBTZrXIBSWEiX
         7XtkkqVK/tmhYryhZ3uyAP6g2j5154CKp2FYkRXrgCLF3hrUGdlthH3lfg1cYcBfvzJk
         FfTykZo8mWhz0WXUXdNjBdNz3C/KJFrjkvTB7Fw5YenB/frlQ8dGKL1ngIGjPyylPxen
         mpzszBwsZfiN5PDg6kcFHDCZbUpabrnko+U0O8ZfRc1SQoolHw245sGjvDRt5RBUpgew
         JdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722098044; x=1722702844;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PQUXj/we6PnQROMy3jytsmFgfmtKin4VhNZzgFedts=;
        b=OkVWlbeWO/DDXSHYR/ATjIg/AtjmUoz+m3xQzst7PBJH9WisT+g/5Nv2kU2Awid786
         G3b74bQGcS39ilDa0C+bDXM+6zqyhbXl35vO52a7Sz29azvesZpY64UUfem6bg+tETsW
         CjGfC6thcYexeap6NI5Q3dGFoNpkY60WzDY6ZlD788ngwFXfopQJlIYe7ZDAxsW6OczJ
         WXi2SG40D0bMMmE5pPnQ+JUh4iI2JbmgOw7I/Cd+kq02I54MLWGBgqUfP24vrqizjKDj
         DHTctPRr27PB3yPUfmq+Y0Kzfq3CJaclRKBsrWbvInJnrnwDa/5/VK3ONkMKYCxxwPEM
         K+/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrncDb4sqKUrGNd1vfy4Z1QSbpVCMSx9qe9Wg9jJ18TQlKYqPzTXF2imveedaiR0FbVlr7T5r8kxVz1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFpwb2YWBE4zF5JycGECIZiKrG71Gjgkyjn7TwVVdh9vPX5AjS
	1/P74S+ketw8gIpKtIU0PEqCmsmQAFl6e4zFXutTtUc+k9xmEMeMx+nTn9T1iv4=
X-Google-Smtp-Source: AGHT+IFsAHHIfDcXfkali36ULU16u+D1XOW7r7zhohNlD8LFT+yEuff4pV7agcskLMPCFAzo9/8Nhw==
X-Received: by 2002:a05:6871:710:b0:25f:4ab7:5324 with SMTP id 586e51a60fabf-264a3536c9cmr5858111fac.2.1722098044330;
        Sat, 27 Jul 2024 09:34:04 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead86ffabsm4503172b3a.143.2024.07.27.09.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 09:34:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, josef@toxicpanda.com, linux@treblig.org
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240727155824.1000042-1-linux@treblig.org>
References: <20240727155824.1000042-1-linux@treblig.org>
Subject: Re: [PATCH] blk-throttle: remove more latency dead-code
Message-Id: <172209804317.3204.11809829429859213146.b4-ty@kernel.dk>
Date: Sat, 27 Jul 2024 10:34:03 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Sat, 27 Jul 2024 16:58:24 +0100, linux@treblig.org wrote:
> The struct 'latency_bucket' and the #define 'request_bucket_index'
> are unused since
> commit bf20ab538c81 ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW")
> 
> and the 'LATENCY_BUCKET_SIZE' #define was only used by the
> 'request_bucket_index' define.
> 
> [...]

Applied, thanks!

[1/1] blk-throttle: remove more latency dead-code
      commit: 01aa8c869d0cdaf603f42dc1d2302b164c25353a

Best regards,
-- 
Jens Axboe



