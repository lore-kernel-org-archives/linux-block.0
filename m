Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7E71898F2
	for <linux-block@vger.kernel.org>; Thu, 30 Jan 2025 06:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738217301; cv=none; b=uJHgFPAihR5KdqxV2z+k1L7hYUanRXUm2Iy+RyOkCL9nXREFzEa2/EZkvK0C/uWhf0sdWSGGOM7qLj4EIBrbb1Ij4yTfwXvaaDjuNgeHx54tw9xR5RsCX/xFYsEE9gw3/Hes6iS3pCTgI+rj214mkA6yXQZmbATknWWgYdzOEtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738217301; c=relaxed/simple;
	bh=rIUEtHsF+Rf7Be2Cmtwagb1kz2Ar0hRSUfOK8gjHuAo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OndGjw1braOchbY2u/4sn6xsLqt8TA0ywdfd8QyjB4IE8uFkCSTdG8gSQkHPJlNAIRWG3RweyXBG5ds42Aou/MVF/Wd2ohdGOJ+xYTlOeZ2ISsOdoHnMpk8QJResWbEJRaBJ4sS3MEyyCbcpuYBgXbx0JnF6e/VtPq3i7Qs5eQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=puM8oIjd; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="puM8oIjd"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43675b1155bso4176515e9.2
        for <linux-block@vger.kernel.org>; Wed, 29 Jan 2025 22:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738217297; x=1738822097; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N0L6lfPTMVt0z7hl1leQ2NHL5VM4dYEW6zgZXPvMDtU=;
        b=puM8oIjdJPpEBk+6db2ckXFZlAkgt7FmiceBh5ZJYlFmsoYCphIbuw0KUOIChd1bM8
         ADx/ghos8yB6iiMq/p4rR/WiH4Yiho3pjX6yZsHQ1g1wGpBkfSm/XY9CPGmW2sfifGhX
         H82+SCnb16zTJXE43CMLzXIeBHqHhRmogHUZ8xhzl3YbCl+69Tvq+YwX1kvYkrpx+shw
         T+a5NhqYM/VQOudDoUQS3bgbc/XATZxxwaQjxVrU0GL8w8sJc0L6PcqkNt4GV63JhIWP
         NEEucbYL4NH1zS8EqwizBAOFf4n2wB6AuBGA/kVmsv6CPDoGj9dG16fx8KwUKLqTLITj
         35xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738217297; x=1738822097;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N0L6lfPTMVt0z7hl1leQ2NHL5VM4dYEW6zgZXPvMDtU=;
        b=dkU88mLgRFlngyxjk8cZfB0c6GRPKInRt0BkxzBembYxRzOZ6nfzEjIUAvPR4cl+KJ
         VWYBZk+dQ8M+8UAtUNUDAD6NUj2GyEYrEdSznli4IhKxqBL1ddmSwcRzI3s6MbBFVcEI
         WKfaMRekFCq8MA98W9uTU696nFlmaHXUjv7ktyAILDscxYdx66dFo9WVi7z8AOpLYlzo
         rQLX6CVdA34rf6MokvDUYLxrc0qa+EpSAwCFrBJUJIYURWkNTGR95Uy1xu1T4Nq1XZRI
         sdgYKpGIEoL4nJZ6EfJroVpFTwTsIpen/rRLO637BHJEBJcbkJz5PYArrsTgtvETYudb
         7VKA==
X-Gm-Message-State: AOJu0Yxyc46YofPNavVLbOBaDPRGsuWGvO6stttGuixCMN/VEdnqaKR1
	yktZbh+RHpFxFpbmp/nGWnBjZtiYCEesPqSEpdX+EaecMlb5HPd8ERmT/roXV/ggbA+PTYKJ7oX
	s
X-Gm-Gg: ASbGncu33Sut+OVrH3WZNOo4OWbmdBKg4/gTlT/eLXvUsJw9jEEr7BHgopBo8XstGH8
	RdAcKe//K19hQrjhZWVSSUbh6ijADBuHUdfskZtOwTnM6Z9ujaDaLzZN/JE1nbTcGe7tm7DVogL
	AMh1mubs5RytIWL0jr7w9m6Q+TAbNcq/z0CwSQEmhAIUEkOjlBH9TnDZhfvy6rRkqKjIL5pWCTc
	nOOlGj95E2Q8Y5WvJDjsGJt4z92a/Drxzt0V0S+bz33UPXUqB47nfd41MKVJUD/HHqC7neIUzCU
	d0xVT2YgO7eN6fBqbLlr
X-Google-Smtp-Source: AGHT+IH7AmC0xRGUOQTqZffuDYiXkgSQLzSxbbbLJMeutmLuAZhAL2CnsLz6NUt/WfCxfO914W0LUQ==
X-Received: by 2002:a05:6000:1565:b0:385:f220:f779 with SMTP id ffacd0b85a97d-38c52095991mr5255371f8f.49.1738217297488;
        Wed, 29 Jan 2025 22:08:17 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc6df51sm47339025e9.30.2025.01.29.22.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 22:08:17 -0800 (PST)
Date: Thu, 30 Jan 2025 09:08:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-block@vger.kernel.org
Subject: [bug report] zram: unlock slot during recompression
Message-ID: <7694cba5-d9ea-4f73-9962-ea67637d1f2c@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Sergey Senozhatsky,

Commit 7ec2cb65ef0d ("zram: unlock slot during recompression") from
Jan 27, 2025 (linux-next), leads to the following Smatch static
checker warning:

	drivers/block/zram/zram_drv.c:1960 recompress_slot()
	warn: passing freed memory 'zstrm' (line 1943)

drivers/block/zram/zram_drv.c
    1873 static int recompress_slot(struct zram *zram, u32 index, struct page *page,
    1874                            u64 *num_recomp_pages, u32 threshold, u32 prio,
    1875                            u32 prio_max)
    1876 {
    1877         struct zcomp_strm *zstrm = NULL;
    1878         unsigned long handle_old;
    1879         unsigned long handle_new;
    1880         unsigned int comp_len_old;
    1881         unsigned int comp_len_new;
    1882         unsigned int class_index_old;
    1883         unsigned int class_index_new;
    1884         u32 num_recomps = 0;
    1885         void *src, *dst;
    1886         int ret;
    1887 
    1888         handle_old = zram_get_handle(zram, index);
    1889         if (!handle_old)
    1890                 return -EINVAL;
    1891 
    1892         comp_len_old = zram_get_obj_size(zram, index);
    1893         /*
    1894          * Do not recompress objects that are already "small enough".
    1895          */
    1896         if (comp_len_old < threshold)
    1897                 return 0;
    1898 
    1899         ret = zram_read_from_zspool(zram, page, index);
    1900         if (ret)
    1901                 return ret;
    1902 
    1903         /*
    1904          * We touched this entry so mark it as non-IDLE. This makes sure that
    1905          * we don't preserve IDLE flag and don't incorrectly pick this entry
    1906          * for different post-processing type (e.g. writeback).
    1907          */
    1908         zram_clear_flag(zram, index, ZRAM_IDLE);
    1909 
    1910         class_index_old = zs_lookup_class_index(zram->mem_pool, comp_len_old);
    1911 
    1912         /*
    1913          * Set prio to one past current slot's compression prio, so that
    1914          * we automatically skip lower priority algorithms.
    1915          */
    1916         prio = zram_get_priority(zram, index) + 1;
    1917         /* Slot data copied out - unlock its bucket */
    1918         zram_slot_write_unlock(zram, index);
    1919         /*
    1920          * Iterate the secondary comp algorithms list (in order of priority)
    1921          * and try to recompress the page.
    1922          */
    1923         for (; prio < prio_max; prio++) {
    1924                 if (!zram->comps[prio])
    1925                         continue;
    1926 
    1927                 num_recomps++;
    1928                 zstrm = zcomp_stream_get(zram->comps[prio]);
    1929                 src = kmap_local_page(page);
    1930                 ret = zcomp_compress(zram->comps[prio], zstrm,
    1931                                      src, &comp_len_new);
    1932                 kunmap_local(src);
    1933 
    1934                 if (ret)
    1935                         break;
    1936 
    1937                 class_index_new = zs_lookup_class_index(zram->mem_pool,
    1938                                                         comp_len_new);
    1939 
    1940                 /* Continue until we make progress */
    1941                 if (class_index_new >= class_index_old ||
    1942                     (threshold && comp_len_new >= threshold)) {
    1943                         zcomp_stream_put(zram->comps[prio], zstrm);

Imagine we hit this continue path.  The right thing is probably to set
zstrm = NULL before the continue or it might be to set ret = -EINVAL.

    1944                         continue;
    1945                 }
    1946 
    1947                 /* Recompression was successful so break out */
    1948                 break;
    1949         }
    1950 
    1951         zram_slot_write_lock(zram, index);
    1952         /* Compression error */
    1953         if (ret) {
    1954                 zcomp_stream_put(zram->comps[prio], zstrm);
    1955                 return ret;
    1956         }
    1957 
    1958         /* Slot has been modified concurrently */
    1959         if (!zram_test_flag(zram, index, ZRAM_PP_SLOT)) {
--> 1960                 zcomp_stream_put(zram->comps[prio], zstrm);
                                                             ^^^^^
Use after free

    1961                 return 0;
    1962         }
    1963 
    1964         /*
    1965          * We did not try to recompress, e.g. when we have only one
    1966          * secondary algorithm and the page is already recompressed
    1967          * using that algorithm
    1968          */
    1969         if (!zstrm)
                      ^^^^^^
Could be a non-NULL freed pointer.

    1970                 return 0;

regards,
dan carpenter
