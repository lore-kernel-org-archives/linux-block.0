Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F3C49BD91
	for <linux-block@vger.kernel.org>; Tue,  6 Oct 2026 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301648; cv=none; b=rDH4jBFAPgrr7gXTdV9TNHZkuEUA38Q4Soilv8iZOjzyhNyVJUuKEpm7FeiN4BHXBk28j4fC22JiopZvHFQnckKCm63YTMJvEuO2EAQhRqzWwB69WycArXry8MfORoQmb93ac0ceh8GSEmhfYOLw8aCxZUOjYnygHqTMB8z1LSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301648; c=relaxed/simple;
	bh=WQgo3gi3KAogDGueOlvmgGly9rIsGOBFx1w+r5ob4TM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCUJ16lr6BOs0NLa78kDIjSY1FKQgEBvlukWA3fQhhrBcNYxmFehe3P/19Jkn/Ygc3owV1TSD9La8a/nI2I4aZ2UBenFF7L/nCI84lGCpiwnsZ3MtVghgpYdvNsRDwLIkGlGfwEbnevmJtulEYSj3J0AWFzwx48eCt7joyYgAtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b=GLbwmj3B; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.b="GLbwmj3B"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a022fee0caso9588935e9.1
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2026 08:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1791301634; x=1791906434; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8OrE7D9wgxOgfXoLfMaem3xj7KYquRVAqPRjESEqerc=;
        b=GLbwmj3BiorrlaEuk9/CYZ3IWQ0VtKCWU6sRGd2CgF6ZEiHxdmaMj8NTuxUFYWzySS
         Jkqv1dD86hEqeZgsLVonNMydCDhke/LAovTninfIEV+LPu45EF/PTL3JrTfRVBYl7FUX
         JPEUph3C7loydpv3ZSIhJgim0Wd84iAqqfznR8ddJ93zkyQzlC63VwDjHD24DVc+Zba4
         2QtZ4XNo+yIcEKabzJld3KjRfLZjXW9WOV/6kwz3Erp8LlMgyp7vk5KbSIgYgbUc1n5q
         inGps0qUc1VPYjHd45e0BUCGzhr+7BHRrYqdXNTxgrDLBkxdDgsegiqlctnsSGdkubUs
         EyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791301634; x=1791906434;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8OrE7D9wgxOgfXoLfMaem3xj7KYquRVAqPRjESEqerc=;
        b=YwVD+IHGw6qJuC0RKUteLCPsgg3My4Xi38Q9s/UFl8okiEumDp6Y+gl0nwnwZMmRIV
         yEvFr+kZxpQUXCbZNApX1lavDjYingWmr3khBk89CUdYflsDEnFBA3uVKdcAt7GMFbfy
         HzvHcWIQQcmDdsJ6Ga4xkQk1CFjaSgqWoiWczwsXocY8bkSxlCPLJROzi7PsmREnSmq1
         +4MaCFbb971rPS8ja/1YKdaI2otxTV8vbxDc5aDjFURojQ4aWuF1t+47fwMKYzgc7mNp
         NK7CwYbCjUAr0mGBl6+AllbRN3bnv8ukJhfuFOoODQp/QFcNbNhEIomLeKu/qIFaHh3q
         UPhg==
X-Forwarded-Encrypted: i=1; AKwUvBwEdK9Z2PDLcopnIxVneSCu1U0CkpBNDp1EQEprLvXsQ0pEU5ZGcS0IXdlBh4cKjLXXYGT70CxuTPmFZg==@vger.kernel.org
X-Gm-Message-State: AFuF++lIq2CSUJ/oQAWeUJfBKZ/Ak6EWgp4TVG8EoLlz89jLdoRjdtSl
	avKPAXAgD5c7CBszAw5bFmjOEb4AOejNBoC06ZDUFhZXUb2CYOmCSS1t8F0w2HgUaQ4/lcrv+k8
	Dsy6CUj4=
X-Gm-Gg: AYBFou3L3uz0Crt8c9n/+hp7GmzPQ4CA5Mff+97XsfmD0vn0DKUSyZ1LFlx0rJFnsdo
	HnoNAqN728mec39f/GlP9P0I9sIlogXGRoOZ+AdCCQXLfWwcl1Cpxr/VNIu0yLTgM81UBpbkjgi
	yvQlbXk2S7BOgLifgva84D4krJqOee36BArSFDZk+xzyTeesMzr9VrfVyK+PQ9ffLIyCGH6yj9e
	8EhuHIfsw2ECEK9AFcOboFJ/W9MH8FUUR642BqAxuJo7Ima61pheFWyNzF55qe7toWuYojwTDCj
	wHweCFtcuhSx3xi3s33X7elXj2wyx0pJvY+M0877XZA5Xt2WKLzRrkxmk1VMmJPyuMLweXTM2QL
	roGZHaHDxQP+gNUeoESXvcE1Ja2F5jK9H3g+13V+gsdA4BPZ+IulOp5L3pLLNQ9pV0Ri2hx1zSW
	iFPKXB5sp+LaFdW8lxr2y7wg11+aL7J/z2om4gfGQ8zMpU77m6mCrTNGSH76ZPJmvyyHjqtQ44r
	nxkVFMYF9+fODV88/kXue5ChmoBhA+x
X-Received: by 2002:a05:600d:82c2:b0:49c:cee0:f383 with SMTP id 5b1f17b1804b1-4a17b54978cmr36665195e9.16.1791301634297;
        Tue, 06 Oct 2026 08:47:14 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bc9:b00f:d376:7c33:9a50:ef33:f391])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178c5b9d6sm72087205e9.13.2026.10.06.08.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 08:47:13 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH v2 20/20] drbd: remove BROKEN for DRBD
Date: Tue,  6 Oct 2026 17:46:07 +0200
Message-ID: <20261006154607.3936501-21-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006154607.3936501-1-christoph.boehmwalder@linbit.com>
References: <20261006154607.3936501-1-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove the BROKEN dependency now that the DRBD 9 rework is complete
and the driver compiles cleanly again.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/drbd/Kconfig b/drivers/block/drbd/Kconfig
index 261965d7b054..06be6ce164f5 100644
--- a/drivers/block/drbd/Kconfig
+++ b/drivers/block/drbd/Kconfig
@@ -9,7 +9,6 @@ comment "DRBD disabled because PROC_FS or INET not selected"
 config BLK_DEV_DRBD
 	tristate "DRBD Distributed Replicated Block Device support"
 	depends on PROC_FS && INET
-	depends on BROKEN
 	select LRU_CACHE
 	select CRC32
 	help
-- 
2.55.0

