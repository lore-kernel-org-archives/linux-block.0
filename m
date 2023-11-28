Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Rjh2Nw7D"
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EE41735
	for <linux-block@vger.kernel.org>; Tue, 28 Nov 2023 11:11:35 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7b37846373eso42991539f.0
        for <linux-block@vger.kernel.org>; Tue, 28 Nov 2023 11:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701198695; x=1701803495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ds2wGK5h8NrsZ7RSJzlWmRs/SKkhVnx+D5T3iR0H8Ug=;
        b=Rjh2Nw7DM8VD9Yo8VC3swR78YGlDv44QgTblrVrS+duL4xPFq4iMPrr1L2Sl4bDIRn
         DQs9cAxqg8kNrmB75cwiA3dhBWMt7ua4uUpnYYIV8GAzSlFpWebHSQnhUqfQMMKFGryc
         yPEHc+eTevyJs14J8X4uycqEpx1/7d+cgf3UWKjRlA215XuzOfdqGTE642ge1iQQcWTk
         S+/TNqNGHu3W/WBAG42UeMat2vJLe9HBI3PVud6KeuVxDYe8/qzaiIncGjXkXZccxzTB
         RZnVprDwc35pJsQdzjiIIFXlUneYHPlgt+nX+ltEiBwtCKm91Ogl47RLvOKa3DdQtfd7
         URvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198695; x=1701803495;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ds2wGK5h8NrsZ7RSJzlWmRs/SKkhVnx+D5T3iR0H8Ug=;
        b=EU/EZfbjKLtj802a8mC1KFyuL0OmTSCFk2Oe4OucmqYRRJiUUH87SnCKLoCUtTdwJe
         /ww46SJyFSOAbTNw8nkO9ZogFXfPwHGpKFAZo/TFE0eo6Nudj7hw5wYnNDOR5c88XWUB
         /na+h5FvlJpOwxegCm0RjxYDJ1MTHo+MXwU/vrp+XdVPs98Zf1em4/xT/TM44CpNHjkN
         SWll5ArlIAoBLBwrSOAeWEEUe4GITXFmzW8Wmy9naizNAsdn8kGXZzTWKTlPDYdQS7FA
         HaaN0kZcxvsUKvZZCygfOqtimNtOUll2dtXcInH58/pTs6+++rSi7rDCg9peamwz3Q9B
         hDug==
X-Gm-Message-State: AOJu0YxmIWiEZxOgeBYFuInpa4VdtQXVtvEjV/X0PYJmu3oZ299o82U8
	xWxwdAIwob+r+lN3akoIrzH0Xw==
X-Google-Smtp-Source: AGHT+IF1BOc8MkYX8tWD2hPJso5aCqm41fjDN5hQnPcZHPba5SBp9zRSDqx0HiJq36dyOlA5Bxxbtg==
X-Received: by 2002:a92:503:0:b0:35c:acbd:3d3e with SMTP id q3-20020a920503000000b0035cacbd3d3emr9388102ile.3.1701198694797;
        Tue, 28 Nov 2023 11:11:34 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a23-20020a056638005700b00466a2a9e5b0sm2366823jap.32.2023.11.28.11.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:11:34 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, ming.lei@redhat.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20231128123027.971610-1-yukuai1@huaweicloud.com>
References: <20231128123027.971610-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v4 0/2] block: warn once for each partition in
 bio_check_ro()
Message-Id: <170119869379.128043.13576945712245414307.b4-ty@kernel.dk>
Date: Tue, 28 Nov 2023 12:11:33 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Tue, 28 Nov 2023 20:30:25 +0800, Yu Kuai wrote:
> Changes in v4:
>  - remove the patch to add 'bd_flags', and add a new field 'bool
>  bd_ro_warned' in patch 2. 'bd_flags' will be added once 'bd_inode' is
>  removed from other thread.
> 
> Changes in v3:
>  - add patch 1 from Ming, swap bd_inode layout with bd_openers and
>  bd_size_lock;
>  - change bd_flags from u32 to u16 in patch 2, prevent to affect layout of
>  other fields;
> 
> [...]

Applied, thanks!

[1/2] block: move .bd_inode into 1st cacheline of block_device
      commit: fad907cffd4bde7384812cf32fcf69becab805cc
[2/2] block: warn once for each partition in bio_check_ro()
      commit: 67d995e069535c32829f5d368d919063492cec6e

Best regards,
-- 
Jens Axboe



