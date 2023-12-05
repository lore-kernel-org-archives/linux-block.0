Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OivaFkQA"
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF4319AF
	for <linux-block@vger.kernel.org>; Tue,  5 Dec 2023 01:35:37 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c09dfd82aso28531285e9.0
        for <linux-block@vger.kernel.org>; Tue, 05 Dec 2023 01:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701768936; x=1702373736; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kCbe3t47nJGvI+NllMimQk/ULTowP8yb+w49kxQeXZo=;
        b=OivaFkQAh/ofqIgXsvKYdtS/4qfC0qjGi5IaDtsteB4aw8oXIrCEbugB/l4smu7H9M
         Qzdi/n775WA+vdHF5GZIpLtUOHXgVeiut1ApJ/x3cWL/ySZRpXxBgsBio2qR+eJ1WlJ1
         9VVc3Q1cMRKmRYK/ieXWNWOxE/y8ujzkRmIE4iDFOqCyh8YRsIqvfjCkLAnkm94AiWOf
         lJxBObG/C0lbou1PmHM+JHUNubjgzkLUn+KG7qZ52FEeDdM5TeEEPsDiHHijidR3SRPI
         +WVL0Vt4GrEeBAZoJ27dIePuEnE+yUtWNvdlMsNgSig3CIwTulos2ZbDRRFgkwi9rYzG
         KlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701768936; x=1702373736;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kCbe3t47nJGvI+NllMimQk/ULTowP8yb+w49kxQeXZo=;
        b=FDJhUQeifTglEji/CfQZn1WRKKmH6XShrQdQgQcgCUy0iyPoU+zamar18ZryOtY6aK
         BY/hg6o6CitNpv0x8jmD3rF2Jb6v6zMHqEemxV0GtQY8faRoMZSnU4v/3vGci5+EsG8D
         dBDtWip8IZsv617Mqhk+l3RodWpC6cK+M6sE15xDUsuh4u8V2kBTlhVFElpxJidDMZv5
         GqAo3M22tBnFszv+N86yawu7NdrdvfApQbozEeUqquoHJ1HVFpkbPcYCH8bRyaAV00Ah
         4xymeFmiGnFxNONGGQhKFmvuSluO+mceBIJ3+b9T42pokHUiPBwfNIKeRNB2z4PYBhPC
         l8rg==
X-Gm-Message-State: AOJu0YxZPNhcYr9pRFO6/2HVPAdp4qIl6zizX3I1iqv7b1JNy6c4D+as
	RCcUKKDiJ41yl9lkoYaCA2WWWQ==
X-Google-Smtp-Source: AGHT+IFHAdJAz0gmvOQG+HkSNoN9L71kSuFlI7o4am0P/B+/pgsvqGXFon3hErW43lTBYo749ob8Dw==
X-Received: by 2002:a05:600c:458b:b0:405:3dbc:8823 with SMTP id r11-20020a05600c458b00b004053dbc8823mr332944wmo.12.1701768935749;
        Tue, 05 Dec 2023 01:35:35 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f17-20020a05600c155100b004083729fc14sm21736332wmg.20.2023.12.05.01.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 01:35:35 -0800 (PST)
Date: Tue, 5 Dec 2023 12:35:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: kbusch@kernel.org
Cc: linux-block@vger.kernel.org
Subject: [bug report] block: bio-integrity: directly map user buffers
Message-ID: <1177558a-9dcd-432f-89b1-4ac9cbd9cd25@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Keith Busch,

The patch 492c5d455969: "block: bio-integrity: directly map user
buffers" from Nov 30, 2023 (linux-next), leads to the following
Smatch static checker warning:

	block/bio-integrity.c:350 bio_integrity_map_user()
	error: uninitialized symbol 'offset'.

block/bio-integrity.c
    340                 if (!bvec)
    341                         return -ENOMEM;
    342                 pages = NULL;
    343         }
    344 
    345         copy = !iov_iter_is_aligned(&iter, align, align);
    346         ret = iov_iter_extract_pages(&iter, &pages, bytes, nr_vecs, 0, &offset);

Smatch is concerned about the first "return 0;" if bytes or iter.count
is zero.  In that situation then offset is uninitialized.

    347         if (unlikely(ret < 0))
    348                 goto free_bvec;
    349 
--> 350         nr_bvecs = bvec_from_pages(bvec, pages, nr_vecs, bytes, offset);
                                                                        ^^^^^^

    351         if (pages != stack_pages)
    352                 kvfree(pages);
    353         if (nr_bvecs > queue_max_integrity_segments(q))
    354                 copy = true;
    355 
    356         if (copy)
    357                 ret = bio_integrity_copy_user(bio, bvec, nr_bvecs, bytes,
    358                                               direction, seed);
    359         else

regards,
dan carpenter
