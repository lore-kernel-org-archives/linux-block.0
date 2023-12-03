Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mVOzcIvV"
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A62AED
	for <linux-block@vger.kernel.org>; Sun,  3 Dec 2023 07:22:22 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2867ea3abedso216838a91.1
        for <linux-block@vger.kernel.org>; Sun, 03 Dec 2023 07:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701616942; x=1702221742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRJ/T4VcXg2PrnX953egP1xy8Q6JFZ3ojEvgYTkSknQ=;
        b=mVOzcIvV1osJu7KCFTwVkCBx/gHviq0zMeU3zTPAVF9F3uo5Ku/fY8WRrhvQ7C9Wox
         hv5Hp7zvZEEGmmB8Z2RWyZkxzMf21PLxJjp1OCnSKE4zdJnMYZBP19Svi0xP1CoQF47p
         Gl/hjYQ+qptZMmDzfwfXWsCj7u8ttAdT+4YhIenmZaXwMsjddF+jhsGo0AgRCqXgbpuG
         gHbu+o7c/KNaXNh+tdJGmqA2q5PeRwmAK8MSpXQoalew3j8dtXkNPqojdDHMebYhFC1z
         nlL3w2vaAc00q7g7d9oigwbMY0/K0mR5yDyLg02kgzS7lnpkIyRPWhS87CSGlZQ2aBgB
         kheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701616942; x=1702221742;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRJ/T4VcXg2PrnX953egP1xy8Q6JFZ3ojEvgYTkSknQ=;
        b=G3hrtMTIP5BQJChSrERlUo8x5P8FOBuinCPP/ZUp0rqr5fbM4TWCRLrgaMRZ/coB87
         po1fX1f8YtpQO7cKVX0B07/TPtW1YU9TeN51Y/DHjGsB0mk4edLoExDMHJoU1h1OEYgQ
         D9YFkPnHaoQ96mDFifMvn56iVE7RFhwN0ZLoYWzNkoSZaaLst81lMlNUMrjIm7YqImWI
         oExsFSBepdGPVqgxDEv/1cSdBNaFFbDOXdEuzcGTTwJsyarWBA+iMDDyXhQ86tRn4Qsu
         JHdVSyeVYzLb/p6tDbDNCSOc3WWh1t4BOdRemCnfRUKN0UWFsGl0j5hvk7SuJXW5FXWm
         Xs3Q==
X-Gm-Message-State: AOJu0Yxkdb7gDQGTKBXgMFLzslWGbl3euQZtlrsTJ7dQnA04GbubcLkI
	Yr9kFTqlvR1n4dX+KlN967jJnw==
X-Google-Smtp-Source: AGHT+IF1l9xtUh9/r3aR9wOxWNIDw/EK0jgfdjjKFaDX8tWRew3/P+NV80+88zsVWbs8QOvLJoNbMg==
X-Received: by 2002:a05:6a00:3904:b0:68e:2fd4:288a with SMTP id fh4-20020a056a00390400b0068e2fd4288amr36562020pfb.3.1701616941832;
        Sun, 03 Dec 2023 07:22:21 -0800 (PST)
Received: from [127.0.0.1] (50-255-6-74-static.hfc.comcastbusiness.net. [50.255.6.74])
        by smtp.gmail.com with ESMTPSA id p19-20020a637f53000000b005c66a7d70fdsm2111854pgn.61.2023.12.03.07.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 07:22:21 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, joshi.k@samsung.com, 
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
 Paul Moore <paul@paul-moore.com>
In-Reply-To: <cover.1701391955.git.asml.silence@gmail.com>
References: <cover.1701391955.git.asml.silence@gmail.com>
Subject: Re: [PATCH v2 0/3] clean up io_uring cmd header structure
Message-Id: <170161694061.938645.776262768452153331.b4-ty@kernel.dk>
Date: Sun, 03 Dec 2023 08:22:20 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Fri, 01 Dec 2023 00:57:34 +0000, Pavel Begunkov wrote:
> Looking at the zc rfc, and how we tend to stuff everything into
> linux/io_uring, start splitting the file before it becomes even more
> monstrous.
> 
> V2: fix up includes for security/
>     Add new files to MAINTAINERS
> 
> [...]

Applied, thanks!

[1/3] io_uring: split out cmd api into a separate header
      (no commit info)
[2/3] io_uring/cmd: inline io_uring_cmd_do_in_task_lazy
      (no commit info)
[3/3] io_uring/cmd: inline io_uring_cmd_get_task
      (no commit info)

Best regards,
-- 
Jens Axboe



