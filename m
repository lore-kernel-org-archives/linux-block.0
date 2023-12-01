Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pV3PV+LR"
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9EE10FF
	for <linux-block@vger.kernel.org>; Fri,  1 Dec 2023 06:34:59 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6ce037af327so35478b3a.0
        for <linux-block@vger.kernel.org>; Fri, 01 Dec 2023 06:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701441299; x=1702046099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbJpDoBB1YSZeZRKQ7gAVaLgs3+K+IIQdlIzl9D7qtw=;
        b=pV3PV+LRCE+E3Io9zbp4kJAvW/W1gFNnkJ7mWNyIXVgSjRAKz7YE1aF3ZicTHZEZO4
         U1UhWLh1lPD7Y7rPiF2nuPkOY+lZlK2lf84UR8jsbM8bkoecomBSGnf4XRNxqR8zBEm4
         QvC6U+VZ+PnPqFYDEuKiwPwUpn6ZqN2HuyIWlGG0hqQ3ehWaqA9wyYarYeUri3u1wAjl
         aBp3rqYKJgpbVsk0ln2BovGQ6OS8v1gL5I6e2JZT/wENkeiiDDIKE8ZelCTJQCAm1Zce
         /217FTbzgmtKvycjBgWHx6ZINF0vwzsFx9AqdvNSBxsM9npBDbM0aEZGk2zdi7f8mt9A
         ErSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701441299; x=1702046099;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbJpDoBB1YSZeZRKQ7gAVaLgs3+K+IIQdlIzl9D7qtw=;
        b=wka7tZWqWJh2bJzMVZA+PvEXOi1rZXaIYwjP4teLi3hHsPEbs7ni8pNm5Q/TTdGKxH
         KKx+XPdX8O7MWTFmLkZmT6CfLj4R0tr8zWR/FnISv978tQTzpcLgCX2IuDWbZZOjtqXV
         QgkNjyThENuhYYKB9TQWJEBbgxNcnmeSpLNYEkKIRz+bdQR4nXpdHpXX6bgxgoLKTcI9
         +nu8DYy0nU8G/5XEiNKdYQmlwWtruGubQoIY+jIoJChCc9L58JMyY73nIPtBPnC0577T
         K//23yxrrCXh0X1vHvytvFwA7Yc+ipvv8O91rRv9/4V26fRBzwK/1fhxsLmxCepkUaWW
         5uyw==
X-Gm-Message-State: AOJu0YyLnSdvA/nPDV1KhqnS/TaJdflyhPcu6x7SLQDBMnlta7GkdJxB
	ADg/YbSVndC6lyism6XiS5MRPupQcn//EFaacsWKmA==
X-Google-Smtp-Source: AGHT+IGPA+vjWMJV0lb3qP137t6y30XImSiVbKGf/9cHj2+7UGoB8WgATPlgYuBDINzy4sw58zgDiw==
X-Received: by 2002:a05:6a21:3387:b0:18b:a1d7:a736 with SMTP id yy7-20020a056a21338700b0018ba1d7a736mr5637721pzb.6.1701441298816;
        Fri, 01 Dec 2023 06:34:58 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id u14-20020a63df0e000000b005b4b70738e5sm3161215pgg.8.2023.12.01.06.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 06:34:58 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>, 
 David Jeffery <djeffery@redhat.com>, John Pittman <jpittman@redhat.com>
In-Reply-To: <20231201085605.577730-1-ming.lei@redhat.com>
References: <20231201085605.577730-1-ming.lei@redhat.com>
Subject: Re: [PATCH] blk-mq: don't count completed flush data request as
 inflight in case of quiesce
Message-Id: <170144129765.800823.7707457820938578139.b4-ty@kernel.dk>
Date: Fri, 01 Dec 2023 07:34:57 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Fri, 01 Dec 2023 16:56:05 +0800, Ming Lei wrote:
> Request queue quiesce may interrupt flush sequence, and the original request
> may have been marked as COMPLETE, but can't get finished because of
> queue quiesce.
> 
> This way is fine from driver viewpoint, because flush sequence is block
> layer concept, and it isn't related with driver.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: don't count completed flush data request as inflight in case of quiesce
      commit: 0e4237ae8d159e3d28f3cd83146a46f576ffb586

Best regards,
-- 
Jens Axboe



