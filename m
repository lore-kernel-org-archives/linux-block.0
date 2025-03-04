Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2311E2836BE
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102734; cv=none; b=EMVJiV9bmeWkTFWZXu1vp3K2Ub61RvwpyrsSJqnRyXRhpBWqVXbz5BSdVqN5bDGONdahzUD261wp5C+hoWHxXK/97G3XKaU+JBxXbRGzs05psqGbRNpV12h4w7O6ueySl1QGqJ3/aJt42kyM7hnX5QVW1EV2Ei2W878UAejEmuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102734; c=relaxed/simple;
	bh=7wYWG9ZVBBfm6qGUhQl1CLl2MgF3R1Q5kOXcuHck6Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LuE4cOh6UWfppiPgK5+otAJhwcYW4h8VAhCka7aEx+9dp3yZSTWFpW8ULUJUOqrLKcd83dRbhA0iAiO05itw4TOO7zgI0FxU8hN4fHGcm5n+GzgrKTOTMfRNgVYiqsIZFQkHPcyyM72AKfBwLOivSv0XrKn5CKNEXHKrjgzA1Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KXppXQkD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KXppXQkD"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-439846bc7eeso37419735e9.3
        for <linux-block@vger.kernel.org>; Tue, 04 Mar 2025 07:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741102729; x=1741707529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3wpAZuZ4KSnXLbNZ2vVh3tj9jZngNuo0DCz+MLkfDs=;
        b=KXppXQkDk92JQzy4v8GmbTtE/SQwvZcjp9mxH5CnBZD0Ct1HgT8D6MfFKmyp9bNVvn
         bCd2aQtt8D0SjeXq0Oc5MLpuq3g1LieVC/EBNfKgcA59dBAJKVYJXwQd+f6/GAIm9/m0
         rwOyD/nWBci8Vdb67QEUsZ3nnXTatRKAvBfHDt6shbRGUKtS3yq6PjkUVw8vy7cfKH1S
         gobZTYmTgBK0hjnyJ935+55kW3goVuJYaCtFNtxc3yCehR83a4NKnRf26R0fnhpeImEF
         /F+GtfKR+7dp296RxtwxL0wmTtrWhviygtM91yL9hFO5ju+DKY+olPXolzXKg1FNyq4/
         Ujxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102729; x=1741707529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3wpAZuZ4KSnXLbNZ2vVh3tj9jZngNuo0DCz+MLkfDs=;
        b=IMcVbFOoeu7dITW4uf8HKYgSOlTmzjrlfjgJNrNiWsPAOrygtVkUxtKH7m9mA52oJU
         e+052fqxWrg6IkmDQMEH7ygGu8eS4hwOX1n21tRz3xSqmHIrzWMSBe5bxqKIFXJEhpte
         ApUeXScwGYBWktdCUP/qZOsoymGO7fQkTyVkrGwM5mVG5ISuueGQ5cs3Qq5KdNTapR2h
         Z8+Llxb5h4bOVtYT8DorOeI2LyGHVqbg1fey1OE7QipZu3zbJl4+GJM4Vrj+GTYrWxM6
         FKbvD/4Irz37vp9ss6GOF1KPy3wBxqC4qRHt+9piddd1rCHwf8yABMdz/QaY6FthO+QF
         37LA==
X-Forwarded-Encrypted: i=1; AJvYcCXA+16XvWxniT0k2Da92ypCSS4g++c9PaiERjhkL+6kdRPtZQTuX0D1SojEVcd3NMdlqwGa86OTZEfDcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHv8l/raCC19hQqlRxm4fjCJSITOgUVCFNGeVkoY+v5f1YhkdO
	CCOAezAOeFxoHEr8epEwvetEbNx++4MKgWeWrNzNIuOIfjIy8zYkvaRFdSCqYX4=
X-Gm-Gg: ASbGnct7ktNMTTi5Tb3DoDfcEzBsGz77U94+HZCDge0FEbzktrBsBEnCRAtK567sC8s
	x3QDUnADUAn1XWqt0Y+FBhA+K3GRihEJupcem7qsc406eQnn3NjMO13vlC2BTLMRtzn7+fcGde3
	ioKJLWJ8+XeRlQnNqSgxkklqpdovvV6Rgr6W2YRVGMoKpILWQ1/whP1MjES5aBcZD0EpD0hdn6M
	VaIUXlARGL5ei+M26wfpDjqjYc7YX2rxbzO8ahwtONBuKnBAzpbSVJnkckDH6haFepuqG7nWda4
	SMDs4jYeM7oxGjZ33lkZiofOTAf1HhhACVtOx+/QSWCtbgs=
X-Google-Smtp-Source: AGHT+IGuIQECszQqXO1I3O177p66zxaZAZdsZPbssWdo0WGLgBAu3ofXHTqWUVYSmtGpaEjf12Uqqw==
X-Received: by 2002:a05:600c:19cd:b0:439:8346:505f with SMTP id 5b1f17b1804b1-43ba6747836mr136899675e9.20.1741102729333;
        Tue, 04 Mar 2025 07:38:49 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm238670625e9.26.2025.03.04.07.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:38:49 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 3/9] cgroup/blkio: Add deprecation warnings to reset_stats
Date: Tue,  4 Mar 2025 16:37:55 +0100
Message-ID: <20250304153801.597907-4-mkoutny@suse.com>
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

It is difficult to sync with stat updaters, stats are (should be)
monotonic so users can calculate differences from a reference.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 block/blk-cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 9ed93d91d754a..b77219dd8b061 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -659,6 +659,7 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 	struct blkcg_gq *blkg;
 	int i;
 
+	pr_warn_once("blkio.%s is deprecated\n", cftype->name);
 	mutex_lock(&blkcg_pol_mutex);
 	spin_lock_irq(&blkcg->lock);
 
-- 
2.48.1

