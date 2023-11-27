Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VBHzK5H2"
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F3EA7
	for <linux-block@vger.kernel.org>; Mon, 27 Nov 2023 08:12:35 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-35cfd975a53so299615ab.1
        for <linux-block@vger.kernel.org>; Mon, 27 Nov 2023 08:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701101554; x=1701706354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrhvBbCxr121d2mKtvut38TnQp1wJ7S3En+rnDUx+1o=;
        b=VBHzK5H2KKM6QKfu9ak6DbBDW40lW78WsTufDJwGqbRK0gz1mtNF/YZPk8Kx7AFpnV
         SYKuoCzYENXjRjPVxD5gL6FKwoQlcoLrGGGKU4HOO8V1VsOPBme/Bv2U8Z9BHMFOiShQ
         745KsIjCe/iAjHAYs7E7ggCbGblQqy7RFW5n3bldnHlSpXZbLa9R4DPxqU9J+nv06g0X
         b8D0r6JC92lqvV6cYpSAXxehW6l9JtRNYi7+cd4thmDfgoK0XMboQzCG5T5eD81Rghyj
         3AgZQGxXEt4OBVcUXcucDK03IWYPdYf+CarfXRCxnTkjjGn3Ih7AhFBcI0DL90IBbVoe
         ntGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701101554; x=1701706354;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrhvBbCxr121d2mKtvut38TnQp1wJ7S3En+rnDUx+1o=;
        b=TBE0tVsdvLszDl10JRnXwIVS32k0V1yK5nI+CmMrO7hKK1Vu3GzFqD06+A13ttInk/
         /sZ/Po5Ov6PQUrPsYxwcmcxxliTZaAzHb56CJrWeaeRNs4WQRP3r9nrO1l3g4o2ytZWQ
         3rLfCZqg+Z+zPlMzY/I7+HcJfXzf2CD4BDiuClcN2Bw+s67byK2mAfpNz8DJIGndVC6B
         kfsRfXrn0R4i2iR8hSWuADhdkOQjFsJKeRU8uAGNEZqWGFstg1ZcONoBlYd8fGjfCiAH
         Y/HUB69XxUfEG986YTk+5d0NWmLpHx4zTbw2TuAy/Avk5ak8EQ2pALby+/0vNwxlmpFL
         Ehzg==
X-Gm-Message-State: AOJu0Ywx36JDM+gA0M7vRVoVl1gfa1dBYIMK14KHF1nJJMGrdXJghR3s
	Rkiy8lqKC8t3L8SGS2i6u8mJB1/CLCvzPuPpulLV0g==
X-Google-Smtp-Source: AGHT+IFE7iz00XvIprkF+j8FMEBdgrnnRWjsA5sUyEHm77c7oUeUpzq8y64FJ/Pwsm/D1fxfiB6LHA==
X-Received: by 2002:a05:6e02:1bc5:b0:35c:7b32:2423 with SMTP id x5-20020a056e021bc500b0035c7b322423mr10481125ilv.0.1701101554020;
        Mon, 27 Nov 2023 08:12:34 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id r15-20020a92c5af000000b0035ca20fc741sm1338589ilt.70.2023.11.27.08.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 08:12:32 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20231127072002.1332685-1-hch@lst.de>
References: <20231127072002.1332685-1-hch@lst.de>
Subject: Re: [PATCH] block: move a few definitions out of
 CONFIG_BLK_DEV_ZONED
Message-Id: <170110155216.44993.13539411658277892269.b4-ty@kernel.dk>
Date: Mon, 27 Nov 2023 09:12:32 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-26615


On Mon, 27 Nov 2023 08:20:02 +0100, Christoph Hellwig wrote:
> Allow using a few symbols with IS_ENABLED instead of #idef by moving
> the declarations out of #idef CONFIG_BLK_DEV_ZONED, and move
> bdev_nr_zones into the remaining  #idef CONFIG_BLK_DEV_ZONED, #else
> block below.
> 
> 

Applied, thanks!

[1/1] block: move a few definitions out of CONFIG_BLK_DEV_ZONED
      commit: 668bfeeabb5e402e3b36992f7859c284cc6e594d

Best regards,
-- 
Jens Axboe



