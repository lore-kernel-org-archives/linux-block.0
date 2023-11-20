Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="eOR9pe1w"
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65079CB
	for <linux-block@vger.kernel.org>; Mon, 20 Nov 2023 10:51:10 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7a9541c9b2aso42786039f.0
        for <linux-block@vger.kernel.org>; Mon, 20 Nov 2023 10:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700506269; x=1701111069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgBz+9lOvWgTjuEWFiCpX+jEWBQ0c3FrxgqjHEJ5als=;
        b=eOR9pe1wfFmK42QQXiY/0JsaUCl+zv+bnyQOLy5aU1l3P+Rb6WtE9pKgM3EveQJPdC
         bI9x0M8+BjOApuUjqlyek/RIXvJnA6b37Zfo27K1Z92aQj5SBiD0xhoXMLIYU66vOtRt
         cXq9LdKrz6GHOiHt8BlaOcno7Uda5qOkBv3603m5nKEdk6y4i9HkvRR4MZS3WKHu7cZp
         WZOubTEPlSl/r7OXdEF2vJtx+E+r58yAzLuAECw++N/PMjNIl1yWndpb48++jfT/ghLa
         9iHbKTAIt8QJZu2fIfq124i1e2O8OENv18azoj/UvkGACRsXvloGktgT9ffq3vlhvifO
         BA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700506269; x=1701111069;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgBz+9lOvWgTjuEWFiCpX+jEWBQ0c3FrxgqjHEJ5als=;
        b=NfI1ar5AVT08N0MVhJSxWbZ2yzR9RYuqOq4UZRTQVq8PeiBfioHFyAIUIrF1vVUY/d
         Oei1lAnarKtCMM58wN8ge7wgKETwl/S4/8leSHXKsE3kDE7EvySTfR+epBkHtsJVarDV
         4LPNORiVK/MsasSqeD5wr41s+sQLqxtF/r+0a/VN9MeoeOnPH3K3MJ7cHRpJQf0YF9NL
         IUKnvuxChdgjJarWAkkSTTo237ks79sxEPRpAmBricYUoP6VEIDEarJMQGLODU9tJ4r/
         EpqvULPRyVaRk0iSqnas3SVcYRzy5OhnQBAzDqELVwJcRnnCngk5rHDFGdAt6iAnOn/U
         j45Q==
X-Gm-Message-State: AOJu0YzRe3/MsrU5vC/UPTrTlbfHyPNAZjWxxjyrZe9uU+PBLniZUXUD
	I17RFFT0r+whYiwXVB6O2xv1zT+6RUHxbLbHx/nE3A==
X-Google-Smtp-Source: AGHT+IG8pW4htJu1faPOYKJrWvR3odnVJY2TGdz06DbYUoSRpQPfTO/ZcDTxFcmgIKs45hnVrysQGQ==
X-Received: by 2002:a05:6e02:3893:b0:34f:a4f0:4fc4 with SMTP id cn19-20020a056e02389300b0034fa4f04fc4mr8626584ilb.2.1700506269194;
        Mon, 20 Nov 2023 10:51:09 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u7-20020a02b1c7000000b00466522ff5a9sm1145668jah.62.2023.11.20.10.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 10:51:08 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, 
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Muhammad Muzammil <m.muzzammilashraf@gmail.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20231025132437.1223363-1-sth@linux.ibm.com>
References: <20231025132437.1223363-1-sth@linux.ibm.com>
Subject: Re: [PATCH 0/2] s390/dasd: fix kernel panic with statistics
Message-Id: <170050626833.126051.9250977201596854566.b4-ty@kernel.dk>
Date: Mon, 20 Nov 2023 11:51:08 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-26615


On Wed, 25 Oct 2023 15:24:35 +0200, Stefan Haberland wrote:
> please apply the following patch for the upcomming merge window that
> fixes a kernel panic that can be triggered by using dasd statistics.
> Also there is a typo fix for a comment.
> 
> Thanks.
> 
> Jan Höppner (1):
>   s390/dasd: protect device queue against concurrent access
> 
> [...]

Applied, thanks!

[1/2] s390/dasd: resolve spelling mistake
      commit: 5029c5e4f20d8d6b41cefbde4b3eeadaec4662c6
[2/2] s390/dasd: protect device queue against concurrent access
      commit: db46cd1e0426f52999d50fa72cfa97fa39952885

Best regards,
-- 
Jens Axboe



