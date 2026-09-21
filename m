Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FBA37BE6B
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 19:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018336; cv=none; b=AuRETEHHokDmSjh2Z1dV8D4VuqDdj6b3NAem9P+/JuUM9t80yKntbQWumaaP+170p9R0bdYvnnnlJk0Bph982iiJc4RHoxktu0AmfgkMUXaKiThNRziJPRPUT4vNvrIPabj9yrrth/ktHuoeLeb+8IPyfhp044NIhyzCO6cP8Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018336; c=relaxed/simple;
	bh=SqR+r8Lr00Rp3Hfbjj6yCMcVv9qvSkDLcKIebqYOdcM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RR4a4HSRZAC/AYkAN5qissU1zUd0NFQWTb4PneXDM4Hut+r5cnSgWSlugI6yqCsXSmudWGyh1XdQu5F5ucGIHhpRBanvgHDULz9+lHeulX/yZbtV8mhem/odR5rsvmz6MYXrnoMhZH0vkzBDznzEXWbbjW+j7fupVzYIxryCRCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIQ6N1rj; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIQ6N1rj"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6b885ef8so18735415e9.1
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 12:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790018333; x=1790623133; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fxnzRUipIvU5hbEis2mzNW2MVxNqcQwtIKSVpz0TPYk=;
        b=XIQ6N1rjkH9YkBmUBhiSzz+4giTY8AcM66sIuLNOE1sgiiR03Q1++MLMF+RZ+POmHL
         ZAipdZuluAJQh4rZHurBjEeC+5ui7lIaQVEhbFw3DqIFYOUUjciNwAmQc8eK0VENMKVt
         Jd8TEoCMBtntv3cqVPiBTHgIW1U4oPokSGHJdFvaQ160qoDUKdd592DH/8vg6/n/cigs
         LEbAfF5pmzfPyQH0WQyYJSSQWeteWTmKJKyT2mpNs21CyzbBo0G19ZuCKoHd0UvOAr06
         EK+3eghZnZN03YtT4XdhZYZgvsqmpGmRPYGtV0r5x9eQkBRsAtxcvru31+vrbAS9BlqH
         Y5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790018333; x=1790623133;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fxnzRUipIvU5hbEis2mzNW2MVxNqcQwtIKSVpz0TPYk=;
        b=pyrrn+i9nRwfYDZ0A4CHcV/Eod3uCAGm3xCAjKJDCzKeTUKbnduwdcSzm8vCPy1L/C
         b/tkhV6hvLsBeb+ie/dtIE+boSMuS2Ky557HBcxGku4RWwUbQPPifmWtsSlEKykosx7T
         QYS44tKT92u4ZXyP3cStde3QfT/nDLME7pNuxJC65u4MZJf0ertX3q6ZlhTbXB9S6iNf
         MXCKqaKnY7IcA4F+foC/agzOle1nhjnM0QFhpiY7ErMdUZiBht3B3ahtn/wms6XOdgza
         zad2WSFTOVuxSWqH/9y5JeTlNAfyx3DiS8JErfG0JVg8Wq9G+1NrcfSRL3cm6YNSruq/
         p/2A==
X-Gm-Message-State: AFuF++mIEze4lP2E0A5x+1YllvY/ZHobEXgf5mHjbn8jLPNb9fmLNO5V
	t1zABk9rMGQHsJNbUr77FyGaZ4r4ZavhVSAYDaX1efpTSUEv/HvPQ7PO
X-Gm-Gg: AYBFou0AUr+nxFbJiwspq7JU5Y7EgcBJK2zAPhPQk3Hx3N0oVuTpzUVXeTvQSg4PyZ5
	CLvQ/SRkyERGqN3xfDBVpI5S0oIAsOxxhQ1Up4iMRCKnkkWKP61aNSMLqtaE33sLbiaNM9SghdU
	NeefDxIgn88+YkVvM0T9NoplPOm/WI5L3I/OkGgualvzPifRJ3aR0IYBOA5PP8H7s5rfE+AKr/S
	5JaOTc7m2aIycckn1RpP9Wrgpox9ScgiHvphX4Wo93FyWcyAr+poCj4HjXjb0lUlPhXSwWkwGiL
	6wsBfPBoNYDAeBu0Rs7zJ2L/X0/BBR16lDfqDe39wQv9IjObD8MoAxd4o2V32zxeQ3Oid0Gz+RC
	14qg6GKabgl++/q3tERGgb+6GDxJciTwbqmDllGFT4LpdYRnit22jUw22IGBRIHXVJiIcNF0Czg
	zlhWRvFRSTt0jWRjG4oqFGsbMVYZMA8aDjW9QMhacDqGPOKauIfaacJeTgC0Oil2HjadQ=
X-Received: by 2002:a05:600c:3f07:b0:49e:7caa:e7b2 with SMTP id 5b1f17b1804b1-49fc5756f60mr153732025e9.29.1790018332729;
        Mon, 21 Sep 2026 12:18:52 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724562aebsm26906638f8f.14.2026.09.21.12.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 12:18:51 -0700 (PDT)
Date: Mon, 21 Sep 2026 22:18:47 +0300
From: Dan Carpenter <error27@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-block@vger.kernel.org, ZHOU Jiaxiang <me@fxti.xyz>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [bug report] Merge branch 'for-next' of
 https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git
Message-ID: <arGDF5byCiew-pqQ@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Mark Brown,

Commit a9ce2250a714 ("Merge branch 'for-next' of
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git")
from Sep 18, 2026 (linux-next), leads to the following Smatch static
checker warning:

	block/blk-zoned.c:2200 disk_init_revalidate_args()
	warn: impossible condition '(args->nr_zones > (~0)) => (0-u32max > u32max)'

block/blk-zoned.c
    2195 static int disk_init_revalidate_args(struct gendisk *disk,
    2196                                      struct blk_revalidate_zone_args *args)
    2197 {
    2198         args->disk = disk;
    2199         args->nr_zones = disk_get_nr_zones(disk, args->capacity);
--> 2200         if (args->nr_zones > UINT_MAX)
                     ^^^^^^^^^^^^^^^^^^^^^^^^^

The linux-next merge for linux-block went a bit sideways and
commit 7c431d61b69a ("scsi: block: Fix zones_cond out-of-bounds write on
zone report") needs to be re-done.

    2201                 return -EINVAL;
    2202 
    2203         /* Cached zone conditions: 1 byte per zone */
    2204         args->zones_state = kzalloc(args->nr_zones, GFP_NOIO);
    2205         if (!args->zones_state)
    2206                 return -ENOMEM;
    2207 
    2208         return 0;
    2209 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
