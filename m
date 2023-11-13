Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DD82031B
	for <linux-block@vger.kernel.org>; Mon, 13 Nov 2023 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oAGkwWbW"
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D420393
	for <linux-block@vger.kernel.org>; Mon, 13 Nov 2023 07:55:48 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-67182a5300eso3052916d6.0
        for <linux-block@vger.kernel.org>; Mon, 13 Nov 2023 07:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1699890947; x=1700495747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04GUi2zkAWokffLd2ocoqOlbz5uHMRuUfc3jxVyp9dU=;
        b=oAGkwWbWwRLRQGBmA4ti8f7kqSD4v60R4QM6JJb+hteLzccw2srti2gQcGdHj+9FlB
         6ZOczVnTPSfRzL6NkgHXDfQOU1yQ/xX2FUogYqtZMB/vz0mICwawf26a/6vsZJJC97J5
         cmPNJlajEPN/3imKUY3isMOBU/GCDGHy008Wt4kCBrJn1G/Zukkgfy1//G6M8E+Hfsvz
         yvwxWm5K0URBeuHN7xf6AG3g6jILAOf0iby0gk9pVR+IAwnZ+yoMW5h70FtQIG2V5r8Y
         2ORN5AryYCt0T/B3GkGq6RbuDgAA6i5rIOyYRzYGFqnnu6xwNERSp0ZP7H/L8Ueq43i+
         Pivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699890947; x=1700495747;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04GUi2zkAWokffLd2ocoqOlbz5uHMRuUfc3jxVyp9dU=;
        b=Cx4RfRcZ8taOY5XmEocQyakr4yonnO5O7TjMRO6wZX1UJvqdoJiwsL4qQuWy4GDBVS
         O3rYX85RzSdOz+C/APh/ADWFf+lvWgpfDGChfYogBjDUhGn0xT8/ZtVW2qfmoQ6IIZn7
         oEnraO7645v/s+qOJ2MW3DqmlF9reymONYbXcJ1mkFP7WwmOzKBVFG6A7BnNwLAFniAK
         uj2f84XSiaAKvTLZR58rUXaFpp3gj4Gsc7mPv/rzEB8A+LkyjLy0By5eG16a3+q4ZSCa
         80hDr0zs6W0nMAZIlWcWaJ6Dg9P9uida/GZjFd8f+8/VqnQqC4VUZDpri+Gl6WRyiPAU
         uocg==
X-Gm-Message-State: AOJu0Yxyn65K/lZePDpMzrNscnQyLIRBmar2PoOjJZPRlZf81tx1xVje
	PSnzM2FB/fO0/j27Q6pR8bjRv0h8L5qgG1VdF5eQqw==
X-Google-Smtp-Source: AGHT+IFTvgOz9ORS2zVcRy33bye48Q/En1T2XAzROYWVQoDVHYcU1USKNl/BnwgEAUHQRS5PsAO/Hg==
X-Received: by 2002:a0c:c78f:0:b0:66d:b23:a62e with SMTP id k15-20020a0cc78f000000b0066d0b23a62emr7477901qvj.6.1699890947504;
        Mon, 13 Nov 2023 07:55:47 -0800 (PST)
Received: from [127.0.0.1] ([2620:10d:c091:400::5:c833])
        by smtp.gmail.com with ESMTPSA id r6-20020ad45226000000b0065d0dcc28e3sm2141705qvq.73.2023.11.13.07.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 07:55:46 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, 
 Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20231113035231.2708053-1-ming.lei@redhat.com>
References: <20231113035231.2708053-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2] blk-mq: make sure active queue usage is held for
 bio_integrity_prep()
Message-Id: <169989094645.203181.12120359349761180875.b4-ty@kernel.dk>
Date: Mon, 13 Nov 2023 08:55:46 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-26615


On Mon, 13 Nov 2023 11:52:31 +0800, Ming Lei wrote:
> blk_integrity_unregister() can come if queue usage counter isn't held
> for one bio with integrity prepared, so this request may be completed with
> calling profile->complete_fn, then kernel panic.
> 
> Another constraint is that bio_integrity_prep() needs to be called
> before bio merge.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: make sure active queue usage is held for bio_integrity_prep()
      commit: b0077e269f6c152e807fdac90b58caf012cdbaab

Best regards,
-- 
Jens Axboe



