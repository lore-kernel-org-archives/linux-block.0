Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QH/PX5K2"
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369CABC
	for <linux-block@vger.kernel.org>; Wed, 29 Nov 2023 09:19:11 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-35d374bebe3so277185ab.1
        for <linux-block@vger.kernel.org>; Wed, 29 Nov 2023 09:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701278350; x=1701883150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rX+wtYtPta3oXeWCwEJEOmP+qDKR6E6aDd9h5WouQEk=;
        b=QH/PX5K2WJbulKUe0+46ieUY13DC0UxgLF7eNqHs6X8mCmbvo0sQqaJNqWSZ6MuZxo
         nFuJz6QyWyQ/eaY4mLH5BDpz1eW1zRKIvxwdEMRUTMtoMs/903gwFCBp2dCZIObRBsUC
         7jIjNNxgWNz/9+VadYzOauk0KCuPcIQCCFIMgOSrMqHLIyD6RYMT9Dr5or/P23ZE/3Bx
         0dNraD0B98hZJR8byvnl7NRAsRujTmmsYWdvfarkZBEyK/gSmXdkmNv0jO6h1lgr55gr
         dzd0F3y32b7Us/NIlUIfkx83QRJs9bgVqUfnXkLwj2qIfdxon4jNM+sFJqwbYyN3qbdI
         O95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701278350; x=1701883150;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rX+wtYtPta3oXeWCwEJEOmP+qDKR6E6aDd9h5WouQEk=;
        b=jqvTjXdAraBLDxuNJbUn6DjPSr9oRZQhRwHTeOdsXQaCNf+LwdGNJ7VodWuHafGBXL
         z74uit1JJ+qo1nRmtzJKAySsWaW+EYGbd+1hWfMTZGqQCY9ducJioAqzDF1AX/dDBHgU
         +2IsVFE7sMqDVEW1v2S6CIBuXH4VGZ7acz1rcHyHmdw1WFPxkZYH8PojTml89GfvXwpV
         a8QfAKA2khZTbQwPVKiTpot8b6Am9yjrxWChXFeqhDqZHe9UHhYsr258l32OkD+OAJP+
         kGBiUbPbXgKlygtqN/qe0AfGRx92oCD5zPElqAhajQCBgOs2B2nz3ZxX54Ht3Kua2Rmp
         l+iw==
X-Gm-Message-State: AOJu0Yy1fbg+32bz98Sxn0MTfuFtR8MA/QXec/u2QKrbNtNSpSqjzGup
	aKUG1qj8J4FIkAAAx4LrqscMPg==
X-Google-Smtp-Source: AGHT+IGKUW5Kf5huYpcBd0ZkiaHfeXwUhgWt2RwVk9YnqKAfChmcj3HeKB0ZKX9TXF6XTFoZB4nxEg==
X-Received: by 2002:a05:6e02:1191:b0:35d:2269:a220 with SMTP id y17-20020a056e02119100b0035d2269a220mr4226591ili.0.1701278350450;
        Wed, 29 Nov 2023 09:19:10 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id d15-20020a056e021c4f00b0035d249ed77csm867320ilg.35.2023.11.29.09.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 09:19:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 Yu Kuai <yukuai3@huawei.com>
In-Reply-To: <20231128194019.72762-1-bvanassche@acm.org>
References: <20231128194019.72762-1-bvanassche@acm.org>
Subject: Re: [PATCH] block: Document the role of the two attribute groups
Message-Id: <170127834975.396633.6682647687149583957.b4-ty@kernel.dk>
Date: Wed, 29 Nov 2023 10:19:09 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Tue, 28 Nov 2023 11:40:19 -0800, Bart Van Assche wrote:
> It is nontrivial to derive the role of the two attribute groups in source
> file block/blk-sysfs.c. Hence add a comment that explains their roles. See
> also commit 6d85ebf95c44 ("blk-sysfs: add a new attr_group for blk_mq").
> 
> 

Applied, thanks!

[1/1] block: Document the role of the two attribute groups
      commit: 3649ff0a0b152b5f00e8f56a5ce0da0945aae278

Best regards,
-- 
Jens Axboe



