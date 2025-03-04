Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226CB28FFC3
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102742; cv=none; b=Wf6LxLVdLztvU/xx8wTbHKofPnqWPmsiznP9W/FD15Qc4DcaHY/EAwOwkeixkkJxob2zhQzhtIoBznz1g6lJ2r2S9hzT6olKQRgi7d36bb0HLYJBTi8YEVNWU1vBjfa3tQSkxkuC/bD2JzsHqbFG6KDVJuqswMPXQcjZbZigtVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102742; c=relaxed/simple;
	bh=MdgvuPV/x8WhlRRCw7Trx9k9ojx5GfL3R2IFVSBLDBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FSVk5FiV7ZqTwwa/v/777baE/nMc1i5QX4wHZgwRMmgFbWeTt08SvMd6UWdNbK1r0WpxaseHbaxkT2niDdZoRJA319myutNMu3CX2g+dQV5Tf/IeEz+n6p5qkg5IaYn8AVMW+KcieXOVeP8y0i8WbeQo7iiXSWsNvwn70bBHXCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VsTqcrWL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VsTqcrWL"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-439ac3216dcso39812925e9.1
        for <linux-block@vger.kernel.org>; Tue, 04 Mar 2025 07:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741102738; x=1741707538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgXxWXRYbTk04GQd58ITj+iG+NER5RZZsNgCYR7jvUU=;
        b=VsTqcrWLiRztdJqD+hckVkKPe1yjJ76YHIAWTRnEf737KnahCd6bqo1dAMJhSD/VSq
         4DqQnPNAKhRzX3Aiuw2/i0mBSgSDxhHYlcFJE1hAEabP7ANQgTGDT0PO1kYBuR48XpPR
         AS77lJoAKkkEL4LWLzf5vY9QXoEGyrZrV9bTL2apQMJJZN1DjVsNg2IW1h2XvQ4Jz8IS
         uUQMzvihGsce8JQ79fkjhCOLS4Sivt0c82bu8seSHuRQI6SqLzXJbnuf+iHkWSwa0kyJ
         RHuOVB+bgpMcJqNyaPTYocI+uPnPQ/trxh2ggCGW8iwzNejTjizmJuIi0Z/9Z8iPtyow
         hZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102738; x=1741707538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgXxWXRYbTk04GQd58ITj+iG+NER5RZZsNgCYR7jvUU=;
        b=YP31q/O0BJCfEnYOX0v5hGEeP+AHkNLTD+JS6EmigGcBtHAopbH18oFZsRE25G7VUh
         68+U2CBOOmo784REr4kLzVueLcEf0H/VUnLvzwyzSzdLzx5MzJYeFliDKaXwTIUEhzt6
         i05XtqMe7XqHs1CBmIZ56tK8oOYOIv9K4S5EYMvB8dTo3ZpWwMUNrFYDlLSruCPZbYs9
         4Ottcusb/HSkJFvvj2D8e6qQTcE34amjqHr9z13PNchzp/B5xzb6D8Y39j1AqjgeRLXH
         vXPnVbvnFcfSgScul0bdbkYubK9d6XFJfGNqVOY2SVXLBOGtjpXQvhtpFXewCwAGHrbx
         3CGA==
X-Forwarded-Encrypted: i=1; AJvYcCXhbncAZOFDnFEMCaJ0BpMB/HjUk1T55PSs7T5/OXWObycvabgTcleZZX1PviNj59/QEgF0L+PGlkCGhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGwfGAe7RZITdfRQSYhTsnbENam3vhL2r5Qxp4/eLPbt81IxNQ
	v52qOxP6yeV4M1Wc0EXQl1f2MMvR612Y+Gq5+FEemqYecsKCvrh5UeyByqLLb7M=
X-Gm-Gg: ASbGncvC0lnNwkAPv5cXBtctkughnckbzpaJkffuBiuv8fNTLDbuAGjYDuqoFsESaFI
	Mj7OWj3PIitAG1Z2wp3pM36KPiHOFz+Mgf/+ACjr+EmEpma54JvxlRavCOLrOJCW5Q3UZ+Cb1sr
	uQcPN72E8Er2v7tVN79RY6Lfr1yCWc2b8AE86GdLGPxCXvqEorwQHTAjMsrP2LfCfzwQK5YxNhG
	BS2DLGgPoy5gl5MN3MUUI+Vk7VQcJDdYtfCUYWgI2kY7NqtVQYpxaBeOguDZjyxqnxChiMmzmQj
	lbdyx3VywlIjkuE2zazcpIEHrigE7z6N19fURz76zIOAHUU=
X-Google-Smtp-Source: AGHT+IGFdMgALKsPh/yOBcPEpPtHnNxwQeHrF4SOqKDJXo/p70nI+zMPXEdR7SegUyRy3tSFD06IsQ==
X-Received: by 2002:a05:6000:2ce:b0:38d:d9bd:18a6 with SMTP id ffacd0b85a97d-390eca07164mr13871828f8f.42.1741102738265;
        Tue, 04 Mar 2025 07:38:58 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm238670625e9.26.2025.03.04.07.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:38:58 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>,
	Paul Jackson <pj@sgi.com>
Subject: [PATCH 6/9] RFC cgroup/cpuset-v1: Add deprecation warnings to memory_migrate
Date: Tue,  4 Mar 2025 16:37:58 +0100
Message-ID: <20250304153801.597907-7-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304153801.597907-1-mkoutny@suse.com>
References: <20250304153801.597907-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Memory migration (between cgroups) was given up in v2 due to performance
reasons of its implementation. Migration between NUMA nodes within one
memcg may still make sense to modify affinity at runtime though.

Cc: Paul Jackson <pj@sgi.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cpuset-v1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 05d3622ea41e5..6155d890f10a4 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -436,6 +436,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 		retval = cpuset_update_flag(CS_SCHED_LOAD_BALANCE, cs, val);
 		break;
 	case FILE_MEMORY_MIGRATE:
+		pr_warn_once("cpuset.%s is deprecated\n", cft->name);
 		retval = cpuset_update_flag(CS_MEMORY_MIGRATE, cs, val);
 		break;
 	case FILE_MEMORY_PRESSURE_ENABLED:
-- 
2.48.1

