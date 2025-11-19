Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFE6537E9
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 07:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538745; cv=none; b=AMGlwFvTDFhOPt7Slbm14gEMtAQx6S+Y964jAYf/jnZrBhj5qI0by/63OIX+TDStUIBoaO8FUtiE2BGOrOQcOffNTgxVLZSASU6wXnUf3bQVI62VCg1t+l8wcu1OjITWqo1DQil91QBTlpvt2vBuLbjhU4/Gx1GeuZtHVtsUw8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538745; c=relaxed/simple;
	bh=ZClN6Xz44AR1oj+MkQ9yHVWlob5caPKzOEopuIQciMk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jpZwx+YOD3RvjC8Iz0FY/Z2kzUJV1Hos3icu3aXbct8BKh/+bv5pMqmmjBCOWez2x7/aBm8BbMUVYskejB63NSSE5NarWJKLr3881QKvi6vSrTshspHRAE5CGrtE0laBBtZe0o6z8T07juO0S/1NQP9ZOz3iYza1WZktkIl9cfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yYM+k1lM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yYM+k1lM"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779a637712so27396055e9.1
        for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 23:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763538741; x=1764143541; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YNgPnJegfbBM1R0OxD00ZxLYsFJ2T5xFsaSC1Zt/hjE=;
        b=yYM+k1lM9haIYhvIf9+B9LIlIlZy/vfdXK5+Q8Zh3CtOZdCgGKuK4EgDUC7S65BIdp
         9jF4l6uNhAULQBRynrtXD3gVqKz+2YRpu2lR0uWSumyVsrL3JjzXIYaChoTZqPcD5h4x
         DG278ac124Eqjsj5YtujzI3HFwiV+bCI1UmT8qDnkmpgPH9oaGJyA5wrQvbEMOnYIqgK
         5hYxCTX1HxN4EhU2PkzSt6I5TEKzDO1nCLCQYOZhy4iqwctoxlMuABm3GOxA+GANmZZq
         wK+qlp9+D3KKpA5w3HuG80+ZDp2UZlQDlLPa+kHrYyUbgbiur6Xlnyz5rypDoJu8Fhsn
         Colg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763538741; x=1764143541;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YNgPnJegfbBM1R0OxD00ZxLYsFJ2T5xFsaSC1Zt/hjE=;
        b=LEKlqEE3k6g8219JY74YWl0TuXF36uW5YEe2h/LEO22kqFgYK3V29v2uNwxHD4a8Ep
         4a/fZyfdVqwtK2lCUNHNa1exXf3qcGtPfQ/D153dnsX7BUwmVnXfWaaaa62P26cCx1ur
         r6ljNYA6jzPChsf/3uvKD6oKYOR0pKTstN5Cdsyd/AGcyxH9lz3Psa1vcyUiqFvjEWkF
         TwL7i5ssE7XGNbjYxSPfszgYxOGNgdPH3XwouGLMksMrbBmk63HftMvZkfprag8BQVz1
         gZiNVKvmZ7n4BvSUdmaU6zoyag5btPClw82czTJ6ItPKQR0U3JBPTOq1Cq7Qw7krsQQF
         3Jgg==
X-Gm-Message-State: AOJu0YxTcL99/HogqgAcGl+1gX5rH30c21L4FjJGaGRBw92/HmbouH8T
	ho1+tbh8YC3sK46viTnwYXWdCrHwl+wpecbn0T3sAy1h7aOLGsg6nVMCmOpqH4yaxjs=
X-Gm-Gg: ASbGnctrrRXtFd9bwG/3KDeeFwlL85fmQgSXgGXZsC62HmXbFQnC5o97uCJ6njww8Py
	/Dwu2YgUnzh3rLAFoMLGMyhTXUQ7BOftzxVe/l1IbC7VTFf7vyo/T/VxkhaAVTz/1eb5ZAZsgMR
	INvk/HA3bt+5LiI5GOYsB/5Vbq0fU0aZ+Akr5lTR/ZQ/5zBmu+ds919vFsJ1AJHQ+SfPDdhuOBg
	yhfinxuqES367stvarwWlZS6pFN+m87K8jl45FZdLOpjfnPFsx5BkbMCBGZnifRT557ZNRUJnkY
	EPg+2tQuGVPw1XI05fZz4IL2E5j0JiiXAJcIAlnVc49Fftx27h7J8B0nHqzCAELHATGRn7XnbxP
	6A3UKrjz+znX+tzO42eqoOSqapc3x1VoDXfnMBrfpYAmwBdRVTOI6/1DqNxpZbiOKyGslSxTSmv
	gxR1HJrR2h+du36FgmqdXMbfYJ7n8=
X-Google-Smtp-Source: AGHT+IF4/drEwAVK1TrntzQuWNj9FeuWFT8RM9rP3JkekS/n+4BI+9g9JqVfVUQen4EenRtzBCpHHQ==
X-Received: by 2002:a05:600c:474b:b0:477:a21c:2066 with SMTP id 5b1f17b1804b1-477a21c2122mr97165555e9.5.1763538740871;
        Tue, 18 Nov 2025 23:52:20 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42b53e7ae47sm35292243f8f.4.2025.11.18.23.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:52:20 -0800 (PST)
Date: Wed, 19 Nov 2025 10:52:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: linux-block@vger.kernel.org
Subject: [bug report] zram: introduce writeback bio batching support
Message-ID: <aR13MX98YwyyvUlH@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Yuwen Chen,

Commit 01516d2d32bf ("zram: introduce writeback bio batching
support") from Nov 13, 2025 (linux-next), leads to the following
Smatch static checker warning:

	drivers/block/zram/zram_drv.c:1284 writeback_store()
	error: we previously assumed 'wb_ctl' could be null (see line 1211)

drivers/block/zram/zram_drv.c
    1174 static ssize_t writeback_store(struct device *dev,
    1175                                struct device_attribute *attr,
    1176                                const char *buf, size_t len)
    1177 {
    1178         struct zram *zram = dev_to_zram(dev);
    1179         u64 nr_pages = zram->disksize >> PAGE_SHIFT;
    1180         unsigned long lo = 0, hi = nr_pages;
    1181         struct zram_pp_ctl *pp_ctl = NULL;
    1182         struct zram_wb_ctl *wb_ctl = NULL;
    1183         char *args, *param, *val;
    1184         ssize_t ret = len;
    1185         int err, mode = 0;
    1186 
    1187         down_read(&zram->init_lock);
    1188         if (!init_done(zram)) {
    1189                 up_read(&zram->init_lock);
    1190                 return -EINVAL;
    1191         }
    1192 
    1193         /* Do not permit concurrent post-processing actions. */
    1194         if (atomic_xchg(&zram->pp_in_progress, 1)) {
    1195                 up_read(&zram->init_lock);
    1196                 return -EAGAIN;
    1197         }
    1198 
    1199         if (!zram->backing_dev) {
    1200                 ret = -ENODEV;
    1201                 goto release_init_lock;

wb_ctl is NULL.

    1202         }
    1203 
    1204         pp_ctl = init_pp_ctl();
    1205         if (!pp_ctl) {
    1206                 ret = -ENOMEM;
    1207                 goto release_init_lock;
    1208         }
    1209 
    1210         wb_ctl = init_wb_ctl(zram);
    1211         if (!wb_ctl) {
    1212                 ret = -ENOMEM;
    1213                 goto release_init_lock;
    1214         }
    1215 
    1216         args = skip_spaces(buf);
    1217         while (*args) {
    1218                 args = next_arg(args, &param, &val);
    1219 
    1220                 /*
    1221                  * Workaround to support the old writeback interface.
    1222                  *
    1223                  * The old writeback interface has a minor inconsistency and
    1224                  * requires key=value only for page_index parameter, while the
    1225                  * writeback mode is a valueless parameter.
    1226                  *
    1227                  * This is not the case anymore and now all parameters are
    1228                  * required to have values, however, we need to support the
    1229                  * legacy writeback interface format so we check if we can
    1230                  * recognize a valueless parameter as the (legacy) writeback
    1231                  * mode.
    1232                  */
    1233                 if (!val || !*val) {
    1234                         err = parse_mode(param, &mode);
    1235                         if (err) {
    1236                                 ret = err;
    1237                                 goto release_init_lock;
    1238                         }
    1239 
    1240                         scan_slots_for_writeback(zram, mode, lo, hi, pp_ctl);
    1241                         break;
    1242                 }
    1243 
    1244                 if (!strcmp(param, "type")) {
    1245                         err = parse_mode(val, &mode);
    1246                         if (err) {
    1247                                 ret = err;
    1248                                 goto release_init_lock;
    1249                         }
    1250 
    1251                         scan_slots_for_writeback(zram, mode, lo, hi, pp_ctl);
    1252                         break;
    1253                 }
    1254 
    1255                 if (!strcmp(param, "page_index")) {
    1256                         err = parse_page_index(val, nr_pages, &lo, &hi);
    1257                         if (err) {
    1258                                 ret = err;
    1259                                 goto release_init_lock;
    1260                         }
    1261 
    1262                         scan_slots_for_writeback(zram, mode, lo, hi, pp_ctl);
    1263                         continue;
    1264                 }
    1265 
    1266                 if (!strcmp(param, "page_indexes")) {
    1267                         err = parse_page_indexes(val, nr_pages, &lo, &hi);
    1268                         if (err) {
    1269                                 ret = err;
    1270                                 goto release_init_lock;
    1271                         }
    1272 
    1273                         scan_slots_for_writeback(zram, mode, lo, hi, pp_ctl);
    1274                         continue;
    1275                 }
    1276         }
    1277 
    1278         err = zram_writeback_slots(zram, pp_ctl, wb_ctl);
    1279         if (err)
    1280                 ret = err;
    1281 
    1282 release_init_lock:
    1283         release_pp_ctl(zram, pp_ctl);
--> 1284         release_wb_ctl(wb_ctl);
                                ^^^^^^
Dead.

    1285         atomic_set(&zram->pp_in_progress, 0);
    1286         up_read(&zram->init_lock);
    1287 
    1288         return ret;
    1289 }

regards,
dan carpenter
